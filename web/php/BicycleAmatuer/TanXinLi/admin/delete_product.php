<?php
    include '../_config.php';
    $page->authorize('admin');

    // POST - Delete the record.
    $prod_id = $page->get('prod_id');
    $pdo = $page->pdo();
    $stm = $pdo->prepare("DELETE FROM product WHERE prod_id =?");
    $stm->execute([$prod_id]);
    $page->temp('output', 'Record deleted');
    $page->redirect('/');
?>

    