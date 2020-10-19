<?php
include '../_config.php';

$username = isset($_COOKIE["username"])? $_COOKIE["username"]: '';
$password = isset($_COOKIE["password"])?  $_COOKIE["password"]: '';
$err = [];

if ($page->is_post()) {
    $username = $page->post('username');
    $password = $page->post('password');
    
    if ($username == '') {
        $err['username'] = 'Username is required.';
    }
    
    if ($password == '') {
        $err['password'] = 'Password is required.';
    }
    
    if (!$err) {
        
        
        $pdo = $page->pdo();
        $stm = $pdo->prepare("SELECT * FROM user WHERE username = ?");
        $stm->execute([$username]);
        $user = $stm->fetch();
        
        if ($user != null && password_verify($password, $user->hash)) {
            /*set cookies - only during browsing session*/
            if(!empty($_POST["remember"])) {
                setcookie ("username",$_POST["username"],time()+ 3600); // store 1 hr
                setcookie ("password",$_POST["password"],time()+ 3600);
                $_COOKIE["username"] = $username;
            } else {
                setcookie("username",$_COOKIE["username"]);
                setcookie("password",$_COOKIE["password"]);
            }
            
            if ($user->role == 'member') {
                $stm = $pdo->prepare("SELECT photo FROM member WHERE username = ?");
                $stm->execute([$username]);
                $_SESSION['photo'] = $stm->fetchColumn();
            }
            $page->sign_in($user->username, $user->role);
        }
        else {
            $err['notMatch'] = 'Username and Password not matched.';
        }
        
        
    }
}

$page->title = 'Welcome! Please Log In';
$page->header();
?>
<style>
    #logInContainer{
           width: 60%;
           background-color: #fff;
           margin: 0 auto;
           padding: 20px;
           word-wrap: break-word;
           border-style: double;
           border-radius:5px;
           overflow: auto;
    }
    
    #logIn{
        table-layout: fixed;
    }
    
    #logIn td{
        height: 25px;
        padding: 3px 8px;
       
    }
    
    #logIn [type=text], #logIn [type=password]{
        width:220px;      
    }

    #logIn tr:nth-child(2) td:first-child,
    #logIn tr:nth-child(1) td:first-child{
        background-color: #eaecef;
        padding:4px 8px 0;
        vertical-align: text-top;
        font-size: 17px;
        font-weight:600;
        min-width: 20px;
      
    }
    
    #logIn  tr:nth-child(3) {background: none;}
    #remember{vertical-align:bottom}
    #registerReset{
        margin:8px auto;
        padding: 10px;
        width: 30vh;
        font-size: 12px;
    }
    #loginBtn{       
        text-align: center;
        padding:10px;
    }
    
    #loginBtn button{
        margin: 4px 6px;
        padding: 2px;
        width: 80px;
    }
    
    
</style>
<p class="success"><?= $page->temp('success') ?></p>
<div id="logInContainer">
<form method="post">
    <table id="logIn" align="center">
        <tr>
            <td>Username</td>
            <td>
                <?php $html->text('username', $username, 20,'autofocus');
                
                      $html->error($err, 'username'); 
                ?>
                
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td>
                <?php 
                    $html->password('password', $password);
                    $html->error($err, 'password');  
                ?>
            </td>
        <tr>
            <td></td>
            <td>
                <?php $html->error($err, 'notMatch') ?>
               
            </td>
        </tr>
    
        <tr>
            <td>Remember me <input type="checkbox" name="remember" id="remember"> </td>
        </tr>
        <tr>
          <td> <a href="register.php" style="float:left;">New Member?</a></td>
            <td>
               <a href="reset_password.php" style="float:right;">Forget Password?</a>
            </td>
        </tr>
    </table>
    
    
    <div id="loginBtn">
        <button>Log In</button>
        <button type="reset">Reset</button>
    </div>
</form>
</div>
<?php

$page->footer();
?>