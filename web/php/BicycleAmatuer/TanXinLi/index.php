<?php
include '_config.php';


$p = $page->get('p');
$prod_type = $page->get('prod_type');
$all = !array_key_exists($prod_type, $arr_type);
$pdo = $page->pdo();

if (filter_var($p, FILTER_VALIDATE_INT) === false) {
    $p = 1;
}
$size = 10; // 10 records in 1 page

$skip = ($p - 1) * $size;
$take = $size;

$pdo = $page->pdo();
$stm = $pdo->prepare("SELECT * FROM product WHERE prod_type = ? OR ? LIMIT ?,?");
$stm->execute([$prod_type, $all, $skip, $take]);
$products = $stm->fetchAll();

$stm = $pdo->query("SELECT COUNT(*) FROM product");
$count = $stm->fetchColumn(); // Read only 1 value
$last = ceil($count / $size); // Last page number

$prev = max([$p - 1, 1]);
$next = min([$p + 1, $last]);



// UI --------------------------------------------------------------------------
$page->title = 'Bicycle Amatuer';
$page->header();
?>

<style>
    .product {
        border: 1px solid #ccc;
        display: inline-block;
        margin: 0 10px 10px 0;
        width: 200px; height: 200px;
        position: relative;
        margin:50px 15px;
    }
    
    .product img {
        width: 100%; height: 100%;
    }
    
    .product > div{
        min-height: 20px;
    }
    
    .product{
        text-decoration: none;
        color:black;
    }
    
    
    
    
    .product {/* Hover transition effect */
        transition: 0.25s;
    }
    
    .product:hover {
        z-index: 999;
        transform: scale(1.05);
    }
    #p_type{
        color:#959ba5;
        font-size: 9pt;
    }
    #p_name{
        height: 40px;
        color:#122391;
        font-weight: bold;
        font-size: 11pt;
    }
    
    #p_price{
        
    }
    .price{
    font-size: 12pt;
    color:#c33;
    font-weight:bolder;
}

#discount{
    text-decoration:line-through;
    color:#999;
    font-size: 9pt;
}

</style>

<div class="space">
    <p class="success hide"><?= $page->temp('success') ?></p>
 </div>
<p>
    <a href="?">All</a> |
    <?php
        $count =0;
        foreach($arr_type as $key => $value) {    
            echo " <a href='?prod_type=$key'>$value</a>";
            $count++;
            if(sizeof($arr_type) != $count){
                echo " | ";
            }
        }
    ?>
</p>


<div style='margin: 5px 10px 15px 10px;'>  
<?php
foreach ($products as $p) {
    if($p->imgs == null){
        $p->imgs = 'no-image-available.jpg';
    }
    
    $st = $pdo->prepare("SELECT MAX(price) as max_price FROM `orderline` WHERE prod_id = ?");
    $st->execute([$p->prod_id]);
    $max_price = $st->fetchColumn(); 
    $type=$p->prod_type;
    echo "
        <a class='product' href='view_product.php?prod_id=$p->prod_id'>
            <img src='imgs/$p->imgs'>
            <div id='p_type'>$arr_type[$type]</div>
            <div id='p_name'>$p->prod_name</div>
            <div id='p_price'><span style='font-weight: bold'>RM $p->price</span>
        
    ";
    if($max_price > $p->price){
        $discount = round(($max_price - $p->price)/$max_price * 100);
        echo "<span id='discount' style='text-align: left'>RM $max_price</span>";
    }
    echo "</div></a>";
    
}
?>
</div>
<div class="pager" style="text-align:center">
    <?php
        echo "<a href='?p=1'> << </a>  ";
        echo "<a href='?p=$prev'> < </a>  ";
        echo "<a href='?p=$next'> > </a>  ";
        echo "<a href='?p=$last'> >> </a>  <br><br>";
        
        foreach (range(1, $last) as $n) {
            echo "<a href='?p=$n'>$n</a> ";
        }
    ?>
</div>


<?php
    $page->footer();
?>