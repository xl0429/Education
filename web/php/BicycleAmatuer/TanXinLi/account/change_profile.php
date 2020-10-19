<?php
include '../_config.php';
$page->authorize('member');//only member can change profile

$err = [];
$pdo = $page->pdo();

// POST request (update) -------------------------------------------------------
if ($page->is_post()) {
    $name  = $page->post('name');
    $email = $page->post('email');
    $phone = $page->post('phone');
    $file  = $_FILES['file']; // Photo
    
    // TODO: Select photo
    $stm = $pdo->prepare("SELECT photo FROM member WHERE username = ?");
    $stm->execute([$page->user->name]);
    $photo = $stm->fetchColumn();
    
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

    // TODO: Validate file only if a file is uploaded 
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
        // TODO: Update member record
        
        // (1) Photo
        if ($file['name']) {
            // TODO: Delete old photo
            unlink("../photo/$photo");//delete photo
            
            
            $photo = uniqid() . '.jpg';
            $img = new SimpleImage();
            $img->fromFile($file['tmp_name'])
                ->thumbnail(150, 150)
                ->toFile("../photo/$photo", 'image/jpeg');
            
            // TODO: Update session
            $_SESSION['photo'] = $photo;
        }
        
        // (2) Update member record
        $stm = $pdo->prepare("
            UPDATE member
            SET name=?, email=?, phone=?,photo=?
            WHERE username=?
        ");
        $stm->execute([$name, $email, $phone, $photo, $page->user->name]);

        $page->temp('success', 'Profile changed.');
        $page->redirect('/');
    }
}

// GET request (select) --------------------------------------------------------
if ($page->is_get()) {
    $stm = $pdo->prepare("SELECT * FROM member WHERE username = ?");
    $stm->execute([$page->user->name]);
    $m = $stm->fetch();
            
    $name  = $m->name;
    $email = $m->email;
    $phone = $m->phone; 
    $photo = $m->photo;
}

$page->title = 'Change Profile';
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
</style>

<form method="post" enctype="multipart/form-data">
    <div class="form">
        <div>
            <label for="username">Username</label>
            <b><?= $page->user->name ?></b>
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
                <div>Select photo (optional)...</div>
                <img id="prev" src="/photo/<?= $photo?>">
            </label>
            <?php $html->error($err, 'file') ?>
        </div>
    </div>
    
    <button>Change Profile</button>
    <button type="reset">Reset</button>
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
$html->focus('name', $err);
$page->footer();
?>