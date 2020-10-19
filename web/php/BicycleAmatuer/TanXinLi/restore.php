<?php
include '_config.php';

//if ($page->is_post()) {
$sql = file_get_contents('import_db_product.sql');
$pdo = new PDO('mysql:host=localhost;port=3306', 'root', '');
$pdo->exec($sql);

$page->redirect('/');
?>