<?php
include '../_config.php';

$username = $email = '';
$err = [];

if ($page->is_post()) {
    $username = $page->post('username');
    $email    = $page->post('email');
    
    if ($username == '') {
        $err['username'] = 'Username is required.';
    }
    
    if ($email == '') {
        $err['email'] = 'Email is required.';
    }
    else if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
        $err['email'] = 'Email format invalid.';
    }
    
    if (!$err) {
        // TODO: Reset password (update database and send email)
        $pdo = $page->pdo();
        
        // (1) Verify if username and email matched
        $stm = $pdo->prepare("SELECT * FROM user WHERE username = ? AND email = ?");
        $stm->execute([$username, $email]);
        $user = $stm->fetch();
        
        if ($user){//if user has value
            // (2) Generate random password --> hash
            $password = $page->random_password();
            $hash = password_hash($password, PASSWORD_DEFAULT);
            
            // (3) Update member or admin record
            $table = $user->role;
            $stm = $pdo->prepare("UPDATE $table SET hash = ? WHERE username = ? ");
            $stm->execute([$hash, $username]);
            
            // (4) Send email
            $ok = $page->email($email, 'Password Reset', "
                <p>Dear $user->name,</p>
                <p>Your password has been reset to:</p>
                <h1>$password</h1>
                <p>Please <a href='http://localhost:8000/account/login.php'>login</a> using your new password.</p>
                <p>From Admin</p>
            ");
                        
            if ($ok) {
                $page->temp('success', 'Password reset. Please check your email.');
                $page->redirect();
            }
            else {
                $err['email'] = 'Failed to send email.';    
            }
        }
        else {
            $err['email'] = 'Username and Email not matched.'; // x find account
        }
    }
}

$page->title = 'Reset Password';
$page->header();
?>
<style>
    button{
        margin: 5px;
    }
</style>

<p class="success"><?= $page->temp('success') ?></p>

<form method="post">
    <div class="form">
        <div>
            <label for="username">Username</label>
            <?php $html->text('username', $username) ?>
            <?php $html->error($err, 'username') ?>
        </div>
        <div>
            <label for="email">Email</label>
            <?php $html->text('email', $email) ?>
            <?php $html->error($err, 'email') ?>
        </div>
    </div>
    
    <button>Reset Password</button>
    <button type="reset">Reset</button>
</form>

<?php
$html->focus('username', $err);
$page->footer();
?>