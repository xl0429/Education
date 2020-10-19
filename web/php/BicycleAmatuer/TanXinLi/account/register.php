<?php
include '../_config.php';

$username = $password = $confirm = $name = $email = $phone = ''; 
$err = [];
$pdo = $page->pdo();

if ($page->is_post()) {
    $username = $page->post('username');
    $password = $page->post('password');    
    $confirm  = $page->post('confirm');
    $name     = $page->post('name');
    $email    = $page->post('email');
    $phone    = $page->post('phone');
    $file     = $_FILES['file']; // Photo
    
    if ($username == '') {
        $err['username'] = 'Username is required.';
    }
    else if (strlen($username) > 20) {
        $err['username'] = 'Username must not more than 20 characters.';
    }
    else {
        // TODO: Check if username is duplicated
        $stm = $pdo->prepare("SELECT COUNT(*) FROM user WHERE username=?");
        $stm->execute([$username]);
        $count = $stm->fetchColumn(); // count only 1(found) and 0(not found), username is primary key
        
        if ($count > 0) {
            $err['username'] = 'Username duplicated. Try another.';
        }
    }
    
    if ($password == '') {
        $err['password'] = 'Password is required.';
    }
    else if (strlen($password) < 6) {
        $err['password'] = 'Password must more than 6 characters.';
    }
    else if (!preg_match('/^\S+$/', $password)) {
        $err['password'] = 'Password should not contain spaces.';
    }   
    
    if ($confirm == '') {
        $err['confirm'] = 'Confirm Password is required.';
    }
    else if ($confirm != $password) {
        $err['confirm'] = 'Confirm Password and Password not matched.';
    }
    
    if ($name == '') {
        $err['name'] = 'Name is required.';
    }
    else if (strlen($name) > 100) {
        $err['name'] = 'Name must not more than 100 characters.';
    }
    
    if ($email == '') {
        $err['email'] = 'Email is required.';
    }
    else if (strlen($email) > 100) {
        $err['email'] = 'Email must not more than 100 characters.';
    }
    else if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
        $err['email'] = 'Email format invalid.';
    }
    
    if ($phone == '') {
        $err['phone'] = 'Phone is required.';
    }
    else if (!preg_match('/^01\d-\d{7,8}$/', $phone)) {
        $err['phone'] = 'Phone format invalid.';
    }
    
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
    
    if (!$err) {
        // TODO: Insert member record
        // (1) Password hash
        $hash = password_hash($password, PASSWORD_DEFAULT);
        
        // (2) Photo
        $photo = uniqid() . '.jpg';
        
        $img = new SimpleImage();
        
        $img->fromFile($file['tmp_name'])
            ->thumbnail(150, 150) //
            ->toFile("../photo/$photo", 'image/jpeg');
        
        // (3) Insert member record
        $stm = $pdo->prepare("
           INSERT INTO member(username, hash, name, email, phone, photo) 
           VALUES(?,?,?,?,?,?);
        ");
        $stm->execute([$username, $hash, $name, $email, $phone, $photo]);
        
        // (4) Send email
        $ok = $page->email($email, 'Password Reset', "
            <p>Dear $name,</p>
                <p>Thank you for your registration.</p>
                <p>Please <a href='http://localhost:8000/account/login.php'>login</a></p>
                <p>From Admin</p>
            ");
                        
            if ($ok) {
                $page->temp('success', 'Password reset. Please check your email.');
                $page->redirect();
            }
            else {
                $err['email'] = 'Failed to send email.';    
            }    
        
        $page->temp('success', 'Account registered. Please login.');
        $page->redirect('login.php');
    }
}

$page->title = 'Sign Up';
$page->header();
?>

<style>
    #file {
        display: none;
    }
    
    #prev {
        width: 150px; height: 150px;
        display: block;
        border: 1px solid #999;
        object-fit: cover;
    }
    
    form button{
        margin:5px;
        font-size: 15px;
        
    }
    
</style>

<form method="post" enctype="multipart/form-data">
    <div class="form">
        <div>
            <label for="username">Username</label>
            <?php $html->text('username', $username, 20, 'autofocus') ?>
            <?php $html->error($err, 'username') ?>
        </div>
        <div>
            <label for="password">Password</label>
            <?php $html->password('password', $password, 20) ?>
            <?php $html->error($err, 'password') ?>
        </div>
        <div>
            <label for="confirm">Confirm Password</label>
            <?php $html->password('confirm', $confirm, 20) ?>
            <?php $html->error($err, 'confirm') ?>
        </div>
        <div>
            <label for="name">Name</label>
            <?php $html->text('name', $name, 100) ?>
            <?php $html->error($err, 'name') ?>
        </div>
        <div>
            <label for="email">Email</label>
            <?php $html->text('email', $email, 100) ?>
            <?php $html->error($err, 'email') ?>
        </div>
        <div>
            <label for="phone">Phone</label>
            <?php $html->text('phone', $phone, 12) ?>
            <?php $html->error($err, 'phone') ?>
        </div>
        <div>
            <label for="file">Photo</label>
            <label>
                <input type="file" id="file" name="file" accept="image/*">
                <div>Select photo...</div>
                
                <img id="prev" src="/image/no-photo.png">
            </label>
                <?php $html->error($err, 'file') ?>
        </div>
    </div>
    <div style='margin-left: 100px '>
    <button>Register</button>
    <button type="reset">Reset</button>
    </div>
</form>

<script>
    var img = $("#prev")[0];
    var src = img.src;
    
    img.onerror = function (e) {
        img.src = src;
        $("#file").val("");
    };
    
    $("#file").change(function (e) {
       var f = this.files[0] || new Blob();
       img.src = URL.createObjectURL(f);
    });
</script>

<?php
$html->focus('username', $err);
$page->footer();
?>