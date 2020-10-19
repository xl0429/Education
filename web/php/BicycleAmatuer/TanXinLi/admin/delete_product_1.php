<?php
    include '../_config.php';
    $page->authorize('admin');

    
    $page->title = 'Product Delete';
    $page->header();

    // -------------------------------------------------------------------------
    // GET request -------------------------------------------------------------
    // -------------------------------------------------------------------------
    if ($page->is_get()) {
        $prod_id = $page->get('prod_id');// Obtain Id from GET parameter.

        // Read product record.
        $pdo = $page->pdo();
        $stm = $pdo->prepare("SELECT * FROM product WHERE prod_id = ?");
        $stm->execute([$prod_id]);
        $p = $stm->fetch();
              

        // TODO: Redirect if product record not found.
        if($p == null){
            $page->redirect('index.php');
        
        
        // TODO: Build lookup array.
        $stm = $pdo->query("SELECT prod_id, prod_name FROM product");
        $arr_program = $stm->fetchAll(PDO::FETCH_KEY_PAIR);
        } 
    }
    
    // -------------------------------------------------------------------------
    // GET request -------------------------------------------------------------
    // -------------------------------------------------------------------------
    if ($page->is_post()) {
        // TODO: Delete the record.
        
        $prod_id = $page->get('prod_id');
        $pdo = $page->pdo();
        $stm = $pdo->prepare("DELETE FROM product WHERE prod_id =?");
        $stm->execute([$prod_id]);
        $page->temp('output', 'Record deleted');
        $page->redirect('index.php');
     }
?>

<p>
    [ <a href="/index.php">Index</a> ]
</p>

<?php $html->warning("Delete the following record?") ?>

<form method="post">
    <div class="form">
        <div>
            <label>Id</label>
            <b><?= $p->prod_id ?></b>
        </div>

        <div>
            <label>Product Name</label>
            <span><?= $p->prod_name ?></span>
        </div>

        <div>
            <label>Product Type</label>
            <span>
                <?= $arr_type[$p->prod_type]?>
            </span>
        </div>

        <div>
            <label>price</label>
            <span><?= $p->price ?></span>
        </div>

        
    </div>
    
    <button >Delete</button>
</form>

<?php
    $page->footer();
?>
