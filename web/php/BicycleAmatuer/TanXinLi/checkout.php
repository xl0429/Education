<?php
include '_config.php';

// TODO (1): Redirect to login page if not member
if (!$page->user || !$page->user->is_member) {
    $page->temp('warning', 'Please login with member acccount to proceed.');
    $page->redirect('/account/login.php?return=/checkout.php'); // after login then redirect to check out page
}

$card = $code = $recipient = $address = '';
$err = [];
$pdo = $page->pdo();

// TODO (2): Calculate total payment
$stm = $pdo->query("SELECT prod_id, price FROM product");
$prices = $stm -> fetchAll(PDO::FETCH_KEY_PAIR);

$payment = 0.00;
foreach($cart->items as $prod_id => $quantity){
    $payment += $quantity * $prices[$prod_id];
}


// POST request ----------------------------------------------------------------
if ($page->is_post()) {
    $card      = $page->post('card');//16-digit - should not store database in real life
    $code      = $page->post('code');//3-digit
    $recipient = $page->post('recipient');
    $address   = $page->post('address');//may automatically get from database, (last order address) 

    if ($card == '') {
        $err['card'] = 'Credit Card Number is required.';
    }
    else if (!preg_match('/^\d{16}$/', $card)) {
        $err['card'] = 'Credit Card Number format is invalid.';
    }
    
    if ($code == '') {
        $err['code'] = 'Card Security Code is required.';
    }
    else if (!preg_match('/^\d{3}$/', $code)) {
        $err['code'] = 'Card Security code format is invalid.';
    }

    if ($recipient == '') {
        $err['recipient'] = 'Delivery Recipient is required.';
    }
    else if (strlen($recipient) > 100) {
        $err['recipient'] = 'Delivery Recipient must less than 100 characters.';
    }
    
    if ($address == '') {
        $err['address'] = 'Delivery Address is required.';
    }
    else if (strlen($address) > 255) {
        $err['address'] = 'Delivery Address must less than 255 characters.';
    }
    
    if (!$err) {
        // Everything is OK --> Add order
        
        // TODO (3): Add order(parent class)
        $stm = $pdo->prepare("
            INSERT INTO `order` (username, date, payment, card, code, recipient, address)
            VALUES (?, ?, ?, ?, ?, ?, ?) 
        ");
        
        $stm->execute([$page->user->name, $page->date->format("Y-m-d"), $payment, $card, $code, $recipient, $address]);
        
        // TODO (4): Add orderlines
        $order_id = $pdo->lastInsertId(); // previously insert id
        $stm = $pdo->prepare("
            INSERT INTO orderline (order_id, prod_id, quantity, price)
            VALUES (?, ?, ?, ?)
        ");
        foreach($cart->items as $prod_id => $quantity){
             $stm->execute([ $order_id, $prod_id, $quantity, $prices[$prod_id] ]);
        }
        
        // TODO (5): Clear shopping cart
        $cart -> clear();
        
        $page->temp('success', 'Order added.'); // may send an electronic receipt after payment 
        $page->redirect("/order.php?id=$order_id");
    }
}

$page->title = 'Checkout';
$page->header();
?>

<style>
    .clearable-input:hover > [data-clear-input] {
        display:none;
    }
    textarea {
        width: 300px; height: 100px;
        resize: none;
    }
    button{
        margin: 5px;
    }
</style>

<form method="post">
    <div class="form">
        <div>
            <label>Payment</label>
            <b>RM <?= number_format($payment, 2) ?></b>
        </div>
        <div>
            <label for="card">Credit Card Number</label>
            <?php $html->text('card', $card, 16,  'autofocus') ?>
            <?php $html->error($err, 'card') ?>
        </div>
        <div>
            <label for="code">Card Security Code</label>
            <?php $html->text('code', $code, 3) ?>
            <?php $html->error($err, 'code') ?>
        </div>
        <div>
            <label for="recipient">Delivery Recipient</label>
            <?php $html->text('recipient', $recipient, 100) ?>
            <?php $html->error($err, 'recipient') ?>
        </div>
        <div>
            <label for="address">Delivery Address</label>
            <textarea id="address" name="address"><?= $address ?></textarea>
            <?php $html->error($err, 'address') ?>
        </div>
    </div>
    
    <button>Submit</button>
    <button type="reset">Reset</button>
</form>

<?php
$html->focus('card', $err);
$page->footer();
?>