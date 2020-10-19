<!doctype html>
<html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="/image/favicon.png">
        <link rel="stylesheet" href="/css/site.css">
        <script src="/js/jquery-3.3.1.min.js"></script>
        <script src="/js/site.js"></script>
        <title><?= $this->title ?></title>
        <script>
            function clickable() {
                document.getElementById("ddown").classList.toggle("show");
            }

            window.onclick = function(event) {// Close the ddown if the user clicks outside of it
                if (!event.target.matches('.dbtn')) {
                    var ddowns = document.getElementsByClassName("ddown-content");
                    var i;
                    for (i = 0; i < ddowns.length; i++) {
                        var openddown = ddowns[i];
                        if (openddown.classList.contains('show')) {
                            openddown.classList.remove('show');
                        }
                    }
                }
            }
        </script> 
        
            
        <style>
            


.searchTerm {
  float: left;
  width: 100%;
  padding: 3px;
  height: 20px;
  border-radius: 2px;
  outline: 0;
  color: #9DBFAF;
}


.searchButton {
    outline:0;
  position: absolute;  
  right: -45px;
  width: 38px;
  height: 31px;
  background: #00B4CC;
  text-align: center;
  color: #fff;
  cursor: pointer;
  font-size: 20px;
}

/*Resize the wrap to see the search bar change!*/
.wrap{
  width: 30%;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
input[type="text"] {
outline-style: none;
}
        </style>
    </head>
  
    <body>
       
        <header  data-get="/index.php">
            <img src="../image/favicon.png" class = "clickable" title="Home">
            <h1 >Bicycle Amatuer</h1>
        </header>
             
        <div class="navbar">
            <div class="dropdown">  
                <button class="dropbtn">Category <div id="arrow"><i class="down"></i></div></button>
                
                <div class="dropdown-content">
                  <?php
                     foreach($arr_type as $key => $value) {    
                        echo " <a href='/index.php?prod_type=$key'>$value</a>";
                    }
                  ?>
 
                </div>
            </div> 
            
            
            <div style="float: right; padding-right: 50px" >   
                
                <?php
                    if ($this->user) {
                        echo "
                            <div class='ddown'>
                                <button onclick='clickable()' class='dbtn'>{$this->user->name} ";
                        if ($this->user->is_member) {
                            $img = $_SESSION['photo'];
                            echo "
                                <style>
                                    #loginPhoto{background-image: url('/photo/$img')}
                                    .dbtn{padding-left: 50px}  
                                </style>
                                <div id='loginPhoto' class='dbtn' ></div>
                                
                            ";
                        } 
                        
                        echo "  
                                </button>
                                <div id='ddown' class='ddown-content'>
                                    <a href='/account/change_password.php'>Change Password</a>
                        ";
                        if ($this->user->is_member) {
                            echo "  
                                    <a href='/account/change_profile.php'>Change Profile</a>
                                    <a href='/order_history.php'>Order History</a>
                                 ";
                        }
                        
                        echo"
                                   <a href='/account/logout.php'>Log Out</a>
                                </div>
                            </div>
                        ";  
                    
                        if($this->user->is_admin){
                            echo "
                                <a href='/admin/custOrderHistory.php'>Customer History</a>
                                <a href='/admin/insert_product.php'>Insert Product</a>
                            ";
                        }
                    }
                    
                    if(!($this->user) || $this->user->is_member){
                        echo" <a href='/cart.php' class='cart'><img src='/image/cart.png' id='cartImage'>";
                        global $cart;
                        if($cart->items){
                            $n= $cart->count();
                            echo "<div id='countCart'>$n</div></a>";
                        }
                        echo"</a>";
                    }   
                       
                    if (!$this->user) {
                        echo '<a href="/account/register.php">Register</a>';
                        echo '<a href="/account/login.php">Log In</a>';    
                    }
                ?>   
            </div>
        </div>
       
        
        <main>
           <h1><?= $this->title ?></h1>
            <div>
                <!-- MAIN: START -->
