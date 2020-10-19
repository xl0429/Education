<?php
include '../_config.php';
$page->authorize();

$password = $new = $confirm = '';
$err = [];

if ($page->is_post()) {
    $password = $page->post('password');
    $new      = $page->post('new');
    $confirm  = $page->post('confirm');
    
    if ($password == '') {
        $err['password'] = 'Password is required.';
    }
    
    if ($new == '') {
        $err['new'] = 'New Password is required.';
    }
    else if (strlen($new) < 6) {
        $err['new'] = 'New Password must more than 6 characters.';
    }
    else if (!preg_match('/^\S+$/', $new)) {
        $err['new'] = 'New Password should not contain spaces.';
    }

    if ($confirm == '') {
        $err['confirm'] = 'Confirm Password is required.';
    }
    else if ($confirm != $new) {
        $err['confirm'] = 'Confirm Password and New Password not matched.';
    }
    
    if (!$err) {
        $pdo = $page->pdo();
        $stm = $pdo->prepare("SELECT * FROM user WHERE username = ?");
        $stm->execute([$page->user->name]);
        $user = $stm->fetch();
        
        if ($user != null && password_verify($password, $user->hash)) {       
            $table = $user->role;
            $hash = password_hash($new, PASSWORD_DEFAULT);
            $stm = $pdo->prepare("UPDATE $table SET hash = ? WHERE username = ?");
            $stm->execute([$hash, $page->user->name]);
            
            $page->temp('success', 'Password changed.');
            $page->redirect('/');
        }
        else {
            $err['password'] = 'Password not matched.';
        }
    }
}

$page->title = 'Change Password';
$page->header();
?>
<style>
    .form{
        
    }
    .form label{
        width:20px;
    }
    .form  .pass{
        width: 50px;
    }
    form > button{
        margin: 10px 3px;  
    }
 
</style>

<form method="post">
    <div class="form">
        <div>
            <label for="password">Password</label>
            <div class='pass'><?php $html->password('password', $password) ?></div>
            <?php $html->error($err, 'password') ?>
        </div>
        
       
        <div>
            <label for="new">New Password</label>
            <div class='pass'><?php $html->password('new', $new) ?></div>
            <?php $html->error($err, 'new') ?>
        </div>
        <div>
            <label for="confirm">Confirm Password</label>
            <div class='pass'><?php $html->password('confirm', $confirm) ?></div>
            <?php $html->error($err, 'confirm') ?>
        </div>
    </div>
    
    <button>Change Password</button>
    <button type="reset">Reset</button>
</form>

<?php
$html->focus('password', $err);
$page->footer();
?>