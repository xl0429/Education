<?php 
include '../_config.php';
$page->authorize('admin');
$err = [];

// STEP 2: POST request (UPDATE) -----------------------------------------------
if ($page->is_post()) {
    $prod_id = $page->post('prod_id');
    $prod_name = $page->post('prod_name');
    $prod_type = $page->post('prod_type');
    $price = $page->post('price');
    $description = $page->post('description');
    $weight = $page->post('weight');
    $tires = $page->post('tires');
    $brakes = $page->post('brakes');
    $rims = $page->post('rims');
    $supplier_id = $page->post('supplier_id');
    $supplier_name = $page->post('supplier_name');
    $origin = $page->post('origin');
    $supplier_desc = $page->post('supplier_desc');
    
    $file  = $_FILES['file'];
    $stm = $pdo->prepare("SELECT imgs FROM product WHERE prod_id = ?");
    $stm->execute([$prod_id]);
    $imgs = $stm->fetchColumn();
    
    
    if ($file['name']) {
        if ($file['error'] == UPLOAD_ERR_FORM_SIZE ||
            $file['error'] == UPLOAD_ERR_INI_SIZE) {
            $err['file'] = 'Photo exceeds size allowed.';
        }
        else if ($file['error'] != UPLOAD_ERR_OK) {
            $err['file'] = 'Photo failed to upload.';
        }
        else {
            $mime = mime_content_type($file['tmp_name']);
            if ($mime != 'image/jpeg' && $mime != 'image/png') {
                $err['file'] = 'Only JPEG or PNG photo allowed.';
            }
        }
    }
    
     if (!$err) {
      
         if ($file['name']) {
            unlink("../imgs/$imgs");//delete photo

            $photo = uniqid() . '.jpg';
        
            $img = new SimpleImage();
            $img->fromFile($file['tmp_name'])
                ->thumbnail(500, 400)
                ->toFile("../imgs/$photo", 'image/jpeg');
            $imgs = $photo;
        }
        
        $pdo  = $page->pdo();  
        $stm = $pdo->prepare("
            UPDATE product p, supplier s
            SET p.prod_name=?, p.prod_type = ?, p.price=?, p.description=?, p.imgs=?, p.weight=?, p.tires=?, p.brakes=?, p.rims=?,
                s.supplier_name=?, s.origin=?, s.supplier_desc=?
            WHERE p.supplier_id = s.supplier_id AND
                  p.prod_id=? 
        ");
        
        $stm->execute([$prod_name, $prod_type, $price, $description, $imgs, $weight, $tires, $brakes, $rims
                       ,$supplier_name, $origin, $supplier_desc, $prod_id]);
        $page->temp('success', 'Information updated.');
        $page->redirect("/view_product.php?prod_id=$prod_id");
    }
}

// STEP 1: GET request (SELECT) ------------------------------------------------
if($page->is_get()){
    $prod_id = $page->get('prod_id');
    $pdo  = $page->pdo();
    $stm = $pdo->prepare("SELECT * FROM prod_supplier WHERE prod_id=?");
    $stm->execute([$prod_id]);
    $p = $stm->fetch();
    
    if($p == null){
       $page->redirect("/");
    }
    
    if($p->imgs ==null){
        $p->imgs = 'no-image-available.jpg';
    }
}


$page->title = "Update for ".$p->prod_name;
$page->header();
?>
<link rel="stylesheet" href="/css/product.css">
<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/site.js"></script>

<form method="post" enctype="multipart/form-data" id='updateForm'>
    
    <fieldset>
        <legend>Product Information</legend>
        <label for="prod_id">Product ID</label>
        <div class="updateId"><?= $p->prod_id ?></div>
        <?= $html->hidden('prod_id', $prod_id)?>
        
        <label for="prod_name">Product Name</label><br>
        <?= $html->text('prod_name', $p->prod_name) ?>
        
        
        <label for="price">Price (RM)</label>
        <?= $html->text('price', $p->price) ?> 
       
        <label for="prod_type">Product Type</label>
        <?php $html->select('prod_type', $arr_type, $p->prod_type,false) ?>
       
    </fieldset>          

    <fieldset>
        <legend>Details Information</legend>

        <label for="weight">Weight (Kg) </label>
        <?= $html->text('weight', $p->weight) ?> 
     
        <label for="tires">Tires</label>
        <?= $html->text('tires', $p->tires) ?> 
        
        <label for="brakes">Brakes</label>
        <?= $html->text('brakes', $p->brakes) ?> 
        
        <label for="rims">Rims</label>
        <?= $html->text('rims', $p->rims) ?> 
               
        <label for="description">Description</label>
        <?= $html->textarea('description', $p->description, 800) ?> 

        <label for="imgs">Product Image</label>

        <div>
            <input type="file" id="file" name="file" accept="image/*">        
            <img id="prev" src="/imgs/<?= $p->imgs ?>">
            <?php $html->error($err, 'file') ?>
        </div>
    </fieldset>
    
    <fieldset>
        <legend>Supplier Information</legend>
        <label for="supplier_id">Supplier ID</label>
        <div class="updateId"><?= $p->supplier_id ?></div>
        <?= $html->hidden('supplier_id', $p->supplier_id)?>
        
        <label for="supplier_name">Supplier Name</label>
        <?= $html->text('supplier_name', $p->supplier_name) ?> 
       
        <label for="origin">Origin</label>
        <?= $html->text('origin', $p->origin) ?> 

     
        <label for="supplier_desc">Supplier Description</label>
        <?= $html->textarea('supplier_desc', $p->supplier_desc, 800) ?> 
        
    </fieldset> 
    
    <div id="updateBtn">
        <button>Update Information</button>
        <button type="reset">Reset</button>
    </div>
</form>      
<script>
    var img = $("#prev")[0];
    img.onerror = function (e) {
        $("#file").val("");
        img.src = "/imgs/no-photo.png";
    };
    
    $("#file").change(function (e) {
        var f = this.files[0];
        img.src = URL.createObjectURL(f);
    });  
</script>

<?php
    $html->focus('prod_name' );
    $page->footer();
?>