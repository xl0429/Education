<?php
include '_config.php';

//$cart->dump();
// POST request ----------------------------------------------------------------
if ($page->is_post()) {
    $action = $page->post('action');
    if($action == 'update'){
        $prod_id =$page->post('prod_id');
        $quantity = $page->post('quantity');
        $cart->set($prod_id, $quantity);
        $page->redirect();
    }
    if($action == 'clear'){
        $cart->clear();
        $page->redirect();
    }    
    
    if($action == 'checkout'){
        $page->redirect('checkout.php');
    }
    
   
}

// GET request -----------------------------------------------------------------

$ids = $cart->ids();
$in = '(' . str_repeat('?,', count($ids)) . '1)';

$pdo = $page->pdo();
$stm = $pdo->prepare("SELECT * FROM product WHERE prod_id IN $in");
$stm->execute($ids);
$products = $stm->fetchAll();

// UI --------------------------------------------------------------------------
$page->title = 'Cart';
$page->header();
?>

<style>
  
    td > a{
        text-decoration: none;
        color:#000;
        
    }
    
    .imgs {
        border: 1px solid #ccc;
        width: 100px; height: 100px;
        float:left;
    }
 
    table td:first-child{
        text-align: left;
        padding:10px;
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

<!-- IF: Shopping cart NOT EMPTY ---------------------------------------------->
<?php if ($cart->items): ?>

<table class="table">
    <tr>
        <th>Product</th>
        <th>Unit Price(RM)</th>
        <th>Quantity</th>
        <th>Subtotal (RM)</th>       
    </tr>
    
    <?php
    // TODO
    $total_quantity = 0;
    $total = 0.00;
    
    foreach ($products as $p) {
        $quantity = $cart->get($p->prod_id);
        $subtotal = $p->price * $quantity;  
        $total_quantity += $quantity;
        $total += $subtotal;
    ?>
        <tr>
            
            <td>
                <a href="view_product.php?prod_id=<?= $p->prod_id?>">
                    <div style="line-height: 20px; "><?= $p->prod_name ?></div>
                <img class="imgs" src="/imgs/<?= $p->imgs ?>">       
                
                </a> 
            </td>
            <td><?= $p->price ?></td>
            
            <td style="text-align: right;">
                <form method="post" class="inline">
                    <?php $html->select('quantity', range(0, 10), $quantity, false, 'onchange = "this.form.submit()"') ?>
                    <?php $html->hidden('prod_id', $p->prod_id) ?>
                    <?php $html->hidden('action', 'update') ?>
                </form>
            </td>
            
            <td><?=  number_format($subtotal,2 ) ?></td>
            
        </tr>
    <?php }  ?>
        
    <tr>
        <th colspan="2"></th>
        <th><?= $total_quantity ?></th>
        <th>RM <?= number_format($total,2 ) ?></th>
        
    </tr>
</table>

<p style="color: red">NOTE: Set quantity to 0 to remove item.</p>

<form method="post">
    <button name="action" value="clear">Clear</button> 
    <button name="action" value="checkout">Checkout</button>
    
</form>

<!-- ELSE: Shopping cart EMPTY ------------------------------------------------>
<?php else: ?>

<p class="warning">Your shopping cart is currently empty.</p>
<button data-get="/" >Return to Shop</button>
<?php endif; ?>
<!-- END IF ------------------------------------------------------------------->

<?php
$page->footer();
?>