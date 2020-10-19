<?php
include '../_config.php';
$page->authorize('admin');

$q = $page->get('q');
$pdo = $page->pdo();


$stm = $pdo->prepare("SELECT * FROM `order` WHERE id LIKE ? OR username LIKE ? OR date LIKE ? ORDER BY date DESC ");
$stm->execute(["%$q%", "%$q%", "%$q%"]);
$orders = $stm->fetchAll();



// UI --------------------------------------------------------------------------
$page->title = 'Customer Order History';
$page->header();
?>

<form autocomplete="off">
    <?php $html->text('q', $q, '', 'autofocus placeholder="searching items..."') ?>
</form>

<div id="target">
    <p><?= count($orders) ?> record(s)</p>
    <table class="table">
        <tr>
            <th>Order Id</th>
            <th>Username</th>
            <th>Date</th>
            <th>Payment (RM)</th>
            <th></th>
        </tr>

        <?php foreach ($orders as $o) : ?>
            <tr>
                <td><?= $o->id      ?></td>
                <td><?= $o->username?></td>
                <td><?= date('d-m-Y',strtotime($o->date));    ?></td>
                <td><?= $o->payment ?></td>
                <td>
                    <a href="/order.php?id=<?= $o->id ?>">Details</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>
</div>
<script>
    $("#q").on("input", function (e) {
        var q = encodeURIComponent(this.value);
        $("#target").load(`custOrderHistory.php?q=${q} #target`);
    });
</script>

<?php
    $page->footer();
?>