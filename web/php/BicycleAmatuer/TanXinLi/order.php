<?php
include '_config.php';
$page->authorize('member,admin');

$id = $page->get('id');
$pdo = $page->pdo();

// TODO (1): Select order
$stm = $pdo->prepare("SELECT * FROM `order` WHERE id = ? OR username = ?");
$stm->execute([$id, $page->user->name]);
$order = $stm->fetch(); // fetch 1 record


if ($order ) {
    $stm = $pdo->prepare("
        SELECT p.prod_id, p.prod_name,p.imgs, 
               o.price, o.quantity, (o.price*o.quantity) AS subtotal
        FROM   product AS p, orderline AS o
        WHERE  p.prod_id = o.prod_id AND 
               o.order_id = ?
    ");
    $stm->execute([$id]);
    $items = $stm->fetchAll();
} else {
    $page->redirect('/order_history.php');
}

// UI --------------------------------------------------------------------------
$page->title = 'Order Details';
$page->header();
?>

<style>
    .imgs {
        border: 1px solid #ccc;
        width: 100px; height: 100px;
        float:left;
    }
 
    table td:first-child{text-align: left;}
    table td:nth-child(2){
        text-align: left;
        padding:5px;
    }
 
    table td{
        text-align: right;
    }
    
    table tfoot{
        font-weight: bold;
    }
    table{
        margin-bottom: 20px;
    }
</style>

<p class="success"><?= $page->temp('success') ?></p>

<div class="form">
    <div>
        <label>Id</label>
        <div><?= $order->id ?></div>
    </div>
    <div>
        <label>Date</label>
        <div><?= $html->fixdate($order->date); ?></div>
    </div>
    <div>
        <label>Payment</label>
        <div>RM <?= $order->payment ?></div>
    </div>
    <div>
        <label>Delivery Recipient</label>
        <div><?= $order->recipient ?></div>
    </div>
    <div>
        <label>Delivery Address</label>
        <div><?= $order->address ?></div>
    </div>    
</div>

<br>

<table class="table">
    <tr>
        <th>Product Id</th>
        <th>Product Name</th>
        <th>Price (RM)</th>
        <th>Quantity (Unit)</th>
        <th>Subtotal (RM)</th>
    </tr>
<?php foreach ($items as $item) : ?>
        <tr>
            <td><?= $item->prod_id ?></td>
            <td style='line-height:103px'>
                <?= $item->prod_name ?>
                <img class="imgs" src="/imgs/<?= $item->imgs ?>">
            </td>
            <td><?= $item->price ?></td>
            <td><?= $item->quantity ?></td>
            <td><?= $item->subtotal ?></td>
        </tr>
      
<?php endforeach; ?>
        <tfoot>
    <tr>
      <td></td>
      <td></td>
      <td></td>
      <td>Grant Total</td>
      <td>RM <?= $order->payment?></td>
    </tr>
  </tfoot>
</table>

<?php
    $page->footer();
?>