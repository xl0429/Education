<?php 
include '../_config.php';
$page->authorize('admin');

$pdo = $page->pdo();
$stm = $pdo->query("SELECT supplier_id, supplier_name FROM supplier");
$supplier  = $stm->fetchAll(PDO::FETCH_KEY_PAIR);

// Variables
    $prod_id = $prod_name = $prod_type = $price = $description = $imgs = $weight
      = $tires = $brakes =  $rims = '';
    $prod_code = $type_name = '';
    $supplier_id = $supplier_name = $origin = $supplier_desc = '';
     
    $err = [];

//POST request (INSERT) -----------------------------------------------
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

    $file = $_FILES['file']; 
    
    // Product Id
        if ($prod_id == '') {
        $err['prod_id'] = '[Product_Id] cannot empty.';
    } 
    else if (  !preg_match('/^[A-Z]{1}\d{3}$/', $prod_id)  ) {
        $err['prod_id'] = '[Product Id] format invalid.';
    }
    else {
        //Check for duplicated Id.
        $stm = $pdo->prepare("SELECT COUNT(*) FROM product WHERE prod_id = ?");
        $stm->execute([$prod_id]);
        $count = $stm->fetchColumn(); // Get 1 value
        if ($count > 0) {
            $err['prod_id'] = '[Product Id] duplicated. Use another.';
        }
    }

    //  Product Name
    if ($prod_name == '') {
        $err['prod_name'] = '[Product Name] cannot empty.';
    }
    else if (strlen($prod_name) > 50) {
        $err['prod_name'] = '[Product Name] cannot more than 50 characters.';
    }
    else if (!preg_match('/^[A-Za-z\d @,\'\.\-\/\"]+$/', $prod_name)) {
        $err['prod_name'] = '[Product Name] contains invalid characters.';
    }
    
    
    //  Price
    if ($price == ''){
        $err['price'] = '[Price] cannot empty.';
    }
    else if(filter_var($price, FILTER_VALIDATE_FLOAT)=== false){
        $err['price'] = '[Price] must be float.';
    }
    else if($price < 0){
        $err['price'] = '[Price] cannot be negative value.';
    }
    
    //  Description
    if ($description == ''){
        $err['description'] = '[Description] cannot empty.';
    } 
    else if (!preg_match('/^[A-Za-z\d @,\'\.\-\/\"]+$/', $description)) {
        $err['description'] = '[Description] contains invalid characters.';
    }
    
    // product image
    if ($file['error'] == UPLOAD_ERR_NO_FILE) {
        $err['file'] = 'Photo is required.';
    }
    else if ($file['error'] == UPLOAD_ERR_FORM_SIZE ||
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
    
    // Weight
    if ($weight == ''){
        $err['weight'] = '[Weight] cannot empty.';
    }
    else if(filter_var($weight, FILTER_VALIDATE_FLOAT)=== false){
        $err['weight'] = '[Weight] must be float.';
    }
    else if($price < 0){
        $err['weight'] = '[Weight] cannot be negative value.';
    }
    
    //  Tires
    if ($tires == ''){
        $err['tires'] = '[Tires] cannot empty.';
    } 
    else if (strlen($tires) > 100) {
        $err['tires'] = '[Tires] cannot more than 100 characters.';
    }
    else if (!preg_match('/^[A-Za-z\d @,\'\.\-\/\"]+$/', $tires)) {
        $err['tires'] = '[Tires] contains invalid characters.';
    }
    
    // Brakes
    if ($brakes == ''){
        $err['brakes'] = '[Brakes] cannot empty.';
    } 
    else if (strlen($brakes) > 100) {
        $err['brakes'] = '[Brakes] cannot more than 100 characters.';
    }
    else if (!preg_match('/^[A-Za-z\d @,\'\.\-\/\"]+$/', $brakes)){
         $err['tires'] = '[Brakes] contains invalid characters.';
    }
    
    //  Rims
    if ($rims == ''){
        $err['rims'] = '[Rims] cannot empty.';
    } 
    else if (strlen($tires) > 100) {
        $err['rims'] = '[Rims] cannot more than 100 characters.';
    }
    else if (!preg_match('/^[A-Za-z\d @,\'\.\-\/\"]+$/', $rims)){
         $err['rims'] = '[Rims] contains invalid characters.';
    }

    // ---------------------------------------------------------------------
    // Processing ----------------------------------------------------------
    // ---------------------------------------------------------------------

    if (!$err) {
         // (2) Photo
        $photo = uniqid() . '.jpg';
        
        $img = new SimpleImage();
        $img->fromFile($file['tmp_name'])
            ->thumbnail(500, 400)
            ->toFile("../imgs/$photo", 'image/jpeg');
              
        $imgs = $photo;
        
        $prod_code = strtoupper($type_name[0]);
        
        $stm = $pdo->prepare("
            INSERT INTO product (prod_id, prod_name, prod_type, price, 
              description, imgs, weight, tires, brakes, rims, supplier_id)
            VALUES (?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?);
        ");
        $stm->execute([$prod_id, $prod_name, $prod_type, $price, $description,
          $imgs, $weight, $tires, $brakes, $rims, $supplier_id]);
        
        $page->temp('success', 'Record updated.');
        $page->redirect('/');   
    }else{
        var_dump($err);
    }
        
  
}
    $page->title = 'Insert Product';
    $page->header();
?>

<link rel="stylesheet" href="/css/product.css">
<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/site.js"></script>

<form method="post" enctype="multipart/form-data" id='updateForm'>
    <style>
        #pType{
            display:block;
        }
        .error{
            display:block;
        }
        #prodName{
            margin-top:-10px;
        }
       #file {
        display: none;
    }
    
    #prev {
        width: 150px; height: 150px;
        display: block;
        border: 1px solid #999;
        object-fit: cover;
    }
    </style>
                           
    <fieldset>
        <legend>Product Information</legend>
        <label for="prod_type">Product Type</label>
        <?php $html->select('prod_type', $arr_type, $prod_type, true, 'required' ) ?>
       
        
        <label for="prod_id">Product ID</label>
        <?= $html->text('prod_id', $prod_id, 4, "data-upper placeholder='Product ID'")?>
        <?= $html->error($err, 'prod_id') ?>
                   
        <label for="prod_name">Product Name</label><br>
        <div style="margin-top:20px"><?= $html->text('prod_name', $prod_name, 50, "placeholder='Product Name'") ?>
        <?= $html->error($err, 'prod_name') ?>
        </div>
        
        
        
        
        <label for="price">Price (RM)</label>
        <?= $html->text('price', $price, 8, "placeholder='Price'" ) ?> 
        <?= $html->error($err, 'price') ?>
    </fieldset>          

    <fieldset>
        <legend>Details Information</legend>
        <label for="weight">Weight (kg) </label>
        <?= $html->text('weight', $weight, 8, "placeholder='Weight'" ) ?> 
        <?= $html->error($err, 'weight') ?>
        
        <label for="tires">Tires</label>
        <?= $html->text('tires', $tires,100,"placeholder='Tires'") ?> 
        <?= $html->error($err, 'tires') ?>
        
        <label for="brakes">Brakes</label>
        <?= $html->text('brakes', $brakes, 100,"placeholder='Brakes'") ?> 
        <?= $html->error($err, 'brakes') ?>
        
        <label for="rims">Rims</label>
        <?= $html->text('rims', $rims, 100,"placeholder='Rims'") ?> 
        <?= $html->error($err, 'rims') ?>     
        
        <label for="description">Description</label>
        <?= $html->textarea('description', $description, 800) ?> 
        <?= $html->error($err, 'description') ?>  
        
        <label for="supplier_id">Supplier Name</label>
        <?php $html->select('supplier_id', $supplier, $supplier_id, true,'required') ?>
        
        <div>
            <label>Photo</label>
            <label>
                <input type="file" id="file" name="file" accept="image/*" style="display: none">
                Click to select photo...
                <?= $html->error($err, 'file') ?>
                <img id="prev" src="/imgs/no-photo.png">
            </label>
            
        </div>
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
    $html->focus('prod_name', $err);
    $page->footer();
?>