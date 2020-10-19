<?php
include '_config.php';

// POST request ----------------------------------------------------------------
if ($page->is_post()) {
    // TODO
    $prod_id = $page->post('prod_id');
    $quantity = $page->post('quantity');
    $cart->set($prod_id, $quantity);
    
    $page->temp('success', 'Shopping cart updated.');
    $page->redirect();
}

// GET request -----------------------------------------------------------------
$prod_id = $page->get('prod_id');
$pdo = $page->pdo(); 

$stm = $pdo->prepare("SELECT * FROM prod_supplier WHERE prod_id = ?");
$stm->execute([$prod_id]);
$p = $stm->fetch();
if ($p == null) {
    $page->redirect('/'); 
}else{
    $p->prod_name =  ucwords(strtolower($p->prod_name ));
    //get the highest price in past order, calculate discount 

    $st = $pdo->prepare("SELECT MAX(price) as max_price FROM `orderline` WHERE prod_id = ?");
    $st->execute([$prod_id]);
    $max_price = $st->fetchColumn();  

    if($p->imgs ==null){
        $p->imgs = 'no-image-available.jpg';
    }
}
if($cart->get($p->prod_id) > 0){
    $v = $cart->get($p->prod_id);
}else{
    $v = 1;
}


// UI --------------------------------------------------------------------------
$page->title = $p->prod_name;
$page->header();

?>
<link rel="stylesheet" href="/css/product.css">
<script  src="/js/magnifier.js"></script>
<style>
    .form{
        display: none;      
        font-size:16px;
        width:55%;
        background: #bbb;
    }
    .form > div > div{
        padding:5px 7px;
        width:100%;
    }
    .form > div > label{
        padding:5px 7px;
        width:20%;
    }
    
    
    .form > div:nth-child(odd),
    .form > label:nth-child(odd){
        background: #ddd;
        padding:5px 7px;
     
    }
    .form > div:nth-child(even) > label,
    .form > div:nth-child(even){
        background: #fff;
        padding:5px 7px;
       
    }
  
    .fBtn{
        padding:10px;
        margin-bottom: 10px;    
    }

</style>

<div class="space">
    <div class="success hide"><?= $page->temp('success') ?></div>
</div>

 <div class="flex-container">
        <div class="box">
            <div class="magnify">	
                <div class="large"></div>
                <img class="small imgs" src="imgs/<?= $p->imgs ?>">
            </div>
         </div>
        
        <div class="box" style="width: 65%;">
            <div class="desc">
                <div class='price'>RM <?= $p->price ?></div>
                <?php
                    if($max_price > $p->price){
                        $discount = round(($max_price - $p->price)/$max_price * 100);
                        echo "<span id='discount'>RM $max_price</span> -$discount%";
                    }
                ?>
                <h2>Description: </h2>
                <?="<pre>$p->description</pre>"?>
            </div>
            
            <?php
            //non user and user except admin
            if($page->user && !$page->user->is_admin|| !$page->user ){
                echo"
                    <form method='post' style='text-align:center;' id='actionForm'> 
                        <div id='field1'>
                            <button type='button' id='sub' class='sub'>-</button>
                            <input  type='number' name='quantity' id='quantity' value='$v' min='1' max='10'>
                            <button type='button' id='add' class='add'>+</button> 
                        </div>

                        
                        <button class='cartBtn' name='action' value='addCart'>Add to Cart</button>
                    ";
                $html->hidden('prod_id', $p->prod_id);
                echo "</form>";
            }
            
            if($page->user){
                if($page->user->is_admin){
                echo"
                    <div style='text-align: center; padding-top: 20px;'>
                        <button class='cartBtn' data-get='/admin/update_product.php?prod_id=$prod_id'>Update</button>
                        <button class='cartBtn' id='delete' value='$prod_id' >Delete</button>
                    </div>
                ";
                }
            }
            ?>
        </div>
</div>

<div class="space"></div>
<h2>More Details: </h2>

<button class="fBtn">Product Details</button>
<button class="fBtn">Supplier Details</button>

<div class="form" style="display:table">
    <div>
        <label>Product Id</label>
        <div><?= $p->prod_id ?></div>
    </div>
    <div>
        <label>Product Name</label>
        <div><?= $p->prod_name ?></div>
    </div>
    <div>
        <label>Product Type</label>
        <div> <?= $arr_type[$p->prod_type] ?></div>
    </div>
    <div>
        <label>Weight</label>
        <div><?= $p->weight ?> kg</div>
    </div>
    <div>
        <label>Tires</label>
        <div><?= $p->tires ?></div>
    </div>
    <div>
        <label>Brakes</label>
        <div><?= $p->brakes ?></div>
    </div>
    <div>
        <label>Rims</label>
        <div><?= $p->rims ?></div>
    </div>
    
</div>

<div class="form">
    <div>
        <label>Supplier Name</label>
        <div><?= $p->supplier_name ?></div>
    </div>
    <div>
        <label>Supplier Description</label>
        <div><pre style="padding: 5px;text-align: justify; font-size: 14px"><?= $p->supplier_desc ?></pre></div>
    </div>
    <div>
        <label>Origin</label>
        <div> <?= $p->origin ?></div>
    </div>
    
    
    
    
</div>  
<p>
    <button data-get="/">Back</button>
</p>

<?php
       $page->footer();
?>