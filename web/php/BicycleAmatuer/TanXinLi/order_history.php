<?php
include '_config.php';
$page->authorize('member');

$pdo = $page->pdo();

// TODO (1): Read orders
$stm = $pdo->prepare("SELECT * FROM `order` WHERE username = ? ORDER BY id DESC ");
$stm->execute([$page->user->name]);
$orders = $stm->fetchAll();


// UI --------------------------------------------------------------------------
$page->title = 'Order History';
$page->header();
?>
<!-- IF: ORDER NOT EMPTY ---------------------------------------------->
<?php if ($orders): ?>
<table class="table">
    <tr>
        <th>Id</th>
        <th>Date</th>
        <th>Payment</th>
        <th></th>
    </tr>
    
    <?php foreach ($orders as $o) : ?>
        <tr>
            <td><?= $o->id      ?></td>
            <td><?= $html->fixdate($o->date)    ?></td>
            <td><?= $o->payment ?></td>
            <td>
                <a href="order.php?id=<?= $o->id ?>">Details</a>
            </td>
        </tr>
    <?php endforeach; ?>
</table>
<!-- ELSE: ORDER EMPTY ------------------------------------------------>
<?php else: ?>
<p class="warning">You have no order before.</p>
<button data-get="/" >Return to Shop</button>
<?php endif; ?>
<!-- END IF ------------------------------------------------------------------->
<?php
$page->footer();
?>