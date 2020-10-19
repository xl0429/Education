<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Log.aspx.cs" Inherits="ARC_Library.Account.Log" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Login</title>

    <link href="../css/site.css" rel="stylesheet" />
    <link href="../css/account.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">

    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//code.jquery.com/jquery-1.3.2.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
    <script src="../js/account.js"></script>
 
    <script src="../js/jquery3.3.1.min.js"></script>
    <script src="../js/site.js"></script>
    <script src="../js/jquery2.1.1.min.js"></script>
     <!--caplock detect-->
    <script>
        $(document).ready(function () {

            //add url param on load
            var q = window.location.href;
            if (!q.includes("?")) {
                window.history.pushState("object or string", "Title", window.location.href + "?log=Login");
            }

            if (getUrlParameter('log').includes("ForgetPassword")) {
                toggleResetPswd();
            } else if (getUrlParameter('log').includes("SignUp")) {
                toggleSignUp();
            } else {
                window.href.location = window.href.location.split('?')[0] + "?log=Login";
            }
          
        });

        //toggle to sign up follow param
        var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = window.location.search.substring(1),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;
            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
                }
            }
        };

        function toggleResetPswd(e) {
            $('#logreg-forms .form-signin').toggle() // display:block or none
            $('#logreg-forms .form-reset').toggle() // display:block or none
            $('[id*=txtEmail]').focus();
            document.title = "Forget Password";
        }

        function toggleSignUp(e) {
            $('#logreg-forms .form-signin').toggle(); // display:block or none
            $('#logreg-forms .form-signup').toggle(); // display:block or none
            $('[id*=txtSUusername]').focus();
            document.title = "Sign Up";
        }

        $(() => {
            // Login Register Form
            $('#logreg-forms #forgot_pswd').click(toggleResetPswd);
            $('#logreg-forms #cancel_reset').click(toggleResetPswd);
            $('#logreg-forms #btn-signup').click(toggleSignUp);
            $('#logreg-forms #cancel_signup').click(toggleSignUp);
        })


    </script>
    <style>
       #caps {display:none;color:red}
    </style>
     
    <!--CapLock Detect-->
     <script>
       var capsLockEnabled = null;

        function getChar(e) {

            if (e.which == null) {
                return String.fromCharCode(e.keyCode); // IE
            }
            if (e.which != 0 && e.charCode != 0) {
                return String.fromCharCode(e.which); // rest
            }

            return null;
        }

        document.onkeydown = function (e) {
            e = e || event;

            if (e.keyCode == 20 && capsLockEnabled !== null) {
                capsLockEnabled = !capsLockEnabled;
            }
        }

        document.onkeypress = function (e) {
            e = e || event;

            var chr = getChar(e);
            if (!chr) return; // special key

            if (chr.toLowerCase() == chr.toUpperCase()) {
                // caseless symbol, like whitespace 
                // can't use it to detect Caps Lock
                return;
            }

            capsLockEnabled = (chr.toLowerCase() == chr && e.shiftKey) || (chr.toUpperCase() == chr && !e.shiftKey);
        }

        /* Check caps lock  */
        function checkCapsWarning() {
            document.getElementById('caps').style.display = capsLockEnabled ? 'block' : 'none';
        }

        function removeCapsWarning() {
             document.getElementById('caps').style.display = 'none';
        }
    </script>
  
    <!--Google Recaptcha script-->  
    <script src="https://www.google.com/recaptcha/api.js?render=reCAPTCHA_site_key"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="logreg-forms">
        <div class="form-signin"><!--SignIn form-->
            <h1 class="h3 mb-3 " > Sign in</h1>
            <p style="text-align:center">OR</p>
            <div align="center"><button class="btn google-btn social-btn" type="button" runat="server" onserverclick="btnGoogle_Click"><span><i class="fab fa-google-plus-g"></i> Sign in with Google</span> </button></div>
            <div style="height:60px; padding:10px">
                <asp:CustomValidator ID="cvNotMatch" runat="server" ValidationGroup="vgSignIn" ForeColor="Red" Display="Dynamic" ErrorMessage="[Username or email] and [Password] not match"></asp:CustomValidator>
                <asp:CustomValidator ID="cvAccStatus" runat="server" ValidationGroup="vgSignIn" ForeColor="Red" Display="Dynamic" OnServerValidate="cvAccStatus_ServerValidate" ></asp:CustomValidator>
                <asp:CustomValidator ID="cvOverDue" runat="server" ValidationGroup="vgSignIn" ControlToValidate="txtUsername" Display="Dynamic" ForeColor="Red" ErrorMessage="[Username] is blocking please activate at library counter" OnServerValidate="cvOverDue_ServerValidate1"></asp:CustomValidator>
            </div>
            <asp:TextBox ID="txtUsername" Autofocus="true" ClientIDMode="AutoID" runat="server" CssClass="form-control" Placeholder="Username or Email"></asp:TextBox>
            <span class="red"> <asp:RequiredFieldValidator ValidationGroup="vgSignIn" ID="RequiredFieldValidator2" ControlToValidate="txtUsername" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Username/ Email] is required" ></asp:RequiredFieldValidator></span>

            <asp:TextBox ID="txtPassword" onkeyup="checkCapsWarning(event)" onfocus="checkCapsWarning(event)" onblur="removeCapsWarning()"  TextMode="Password" runat="server" CssClass="form-control password" Placeholder="Password"></asp:TextBox>
            <span class="red"> <asp:RequiredFieldValidator ValidationGroup="vgSignIn" ID="RequiredFieldValidator1"   ControlToValidate="txtPassword" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Password] is required"></asp:RequiredFieldValidator></span>
             <div id="caps">
                <asp:Image ID="Image1" Width="18px" Height="18px" src="../img/caution.png" runat="server" />
                Warning! Cap Lock is ON.
            </div>
            <p><asp:CheckBox ID="chkShowPass1" runat="server" CssClass="chkShowPass" /> Show password </p>

            <div class="g-recaptcha" name="g-recaptcha" runat="server" data-sitekey="<%$ AppSettings: RecaptchaSiteKey %>" ></div>
            <asp:CustomValidator ID="cvGoogleRecaptcha" runat="server" ErrorMessage="[Recaptcha] is required" Display="Dynamic" ForeColor="#990000"></asp:CustomValidator>
            <p style="padding-top:10px" >
                <asp:CheckBox ID="chkRememberMe" runat="server" Checked="true" Text="remember me" />
            </p>
            <button class="btn btn-success btn-block" ValidationGroup="vgSignIn" type="submit" runat="server" onserverclick="btnSignIn_Click" ><i class="fas fa-sign-in-alt"></i> Sign in</button>

            <a href="Log.aspx?log=ForgetPassword" id="forgot_pswd">Forgot password?</a>
            <hr>
            <button class="btn btn-primary btn-block" type="button" onclick="window.location.href='Log.aspx?log=SignUp'" id="btn-signup"><i class="fas fa-user-plus"></i> Sign up New Account</button>

        </div>
         <div class="form-reset"><!--Forget Password form-->
            <h1 class="h3 mb-3 ">Forget Password</h1>

            <asp:TextBox ID="txtEmail"  class="form-control" runat="server" Placeholder="Email Address"></asp:TextBox>
            <span class="red"> <asp:RequiredFieldValidator ValidationGroup="vgResetPassword" ID="RequiredFieldValidator3"   ControlToValidate="txtEmail" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Email] is required"></asp:RequiredFieldValidator></span>
            <span class="red"><asp:CustomValidator ValidationGroup="vgResetPassword" ID="cvCheckEmail" runat="server" ErrorMessage="[Email] is not exist" Display="Dynamic" CssClass="error" ></asp:CustomValidator></span>
            <button class="btn btn-primary btn-block" ValidationGroup="vgResetPassword" type="submit" runat="server" onserverclick="btnReset_Click">Reset Password</button>
            <a href="Log.aspx?log=Login" id="cancel_reset" class="cancel" ><i class="fas fa-angle-left"></i> Back</a>
        </div>

        <div class="form-signup" ><!--SignUp form-->
                <h1 class="h3 mb-3 ">Sign Up</h1>
                <div class="social-login">
                    <button class="btn google-btn social-btn" type="button" runat="server" onserverclick="btnGoogle_Click"><span><i class="fab fa-google-plus-g"></i> Sign in with Google</span> </button>
                </div>          
                <p style="text-align:center">OR</p> 
                <span class="red" style="display:block"><asp:CustomValidator ID="cvEmailExist" runat="server" ValidationGroup="vgSignUp" ErrorMessage="[Email] is existed" Display="Dynamic" CssClass="error" ControlToValidate="txtSUemail" OnServerValidate="cvEmailExist_ServerValidate" ></asp:CustomValidator></span>
                <span class="red"><asp:CustomValidator ID="cvUsernameExist" runat="server" ValidationGroup="vgSignUp" ErrorMessage="[Username] is existed" Display="Dynamic" CssClass="error" ControlToValidate="txtSUusername" OnServerValidate="cvUsernameExist_ServerValidate" ></asp:CustomValidator></span>
             
                <asp:TextBox ID="txtSUusername" class="form-control" placeholder="Username" runat="server" MaxLength="50"></asp:TextBox>
                <span class="red"> <asp:RequiredFieldValidator ValidationGroup="vgSignUp" ID="RequiredFieldValidator4"   ControlToValidate="txtSUusername" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Username] is required"></asp:RequiredFieldValidator></span>              
                <span class="red"> <asp:RegularExpressionValidator ValidationGroup="vgSignUp" ID="RegularExpressionValidator2"   ControlToValidate="txtSUusername" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Username] only contains letters, numbers, @, _,~ ,# with length > 6" ValidationExpression="[a-zA-Z0-9_@~#]{6,}"></asp:RegularExpressionValidator></span>              

                <asp:TextBox ID="txtSUemail" class="form-control" placeholder="Email" runat="server" MaxLength="50"></asp:TextBox>
                <span class="red"> <asp:RequiredFieldValidator ValidationGroup="vgSignUp" ID="RequiredFieldValidator5"   ControlToValidate="txtSUemail" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Email] is required"></asp:RequiredFieldValidator></span>              
                <span class="red"> <asp:RegularExpressionValidator ValidationGroup="vgSignUp" ID="RequiredFieldValidator9"   ControlToValidate="txtSUemail" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Email] format is invalid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></span>              
                
                <asp:TextBox ID="txtSUcontactNo" class="form-control" placeholder="Contact Number eg. 012-3456789" runat="server" MaxLength="12"></asp:TextBox>
                <span class="red"> <asp:RequiredFieldValidator ValidationGroup="vgSignUp" ID="RequiredFieldValidator6"   ControlToValidate="txtSUcontactNo" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Contact No] is required"></asp:RequiredFieldValidator></span>              
                <span class="red"><asp:RegularExpressionValidator ValidationGroup="vgSignUp" ID="RegularExpressionValidator1" runat="server" ErrorMessage="[Contact Number] format is invalid" ControlToValidate="txtSUcontactNo" Display="Dynamic" CssClass="error" ValidationExpression="01[0-9]-[0-9]{7,8}"></asp:RegularExpressionValidator></span>              
                
                <asp:TextBox ID="txtSUpassword" oncopy="return false;"  oncut="return false;" onkeyup="checkPasswordStrength();" TextMode="Password" class="form-control password passStrength" placeholder="Password" runat="server"  MaxLength="50"></asp:TextBox>
                 <div id="password-strength-status" ></div><!--Password strength-->
                <span class="red"><asp:RequiredFieldValidator ValidationGroup="vgSignUp" ID="RequiredFieldValidator7"   ControlToValidate="txtSUpassword" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Password] is required"></asp:RequiredFieldValidator></span>              
                <span class="red"><asp:RegularExpressionValidator  ValidationGroup="vgSignUp"  ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtSUpassword" CssClass="error" Display="Dynamic" ErrorMessage="[Password] only contains letters, numbers, @, _,~ ,# with length > 6" ValidationExpression="[a-zA-Z0-9_@~#]{6,}"></asp:RegularExpressionValidator></span>              
                
                <asp:TextBox ID="txtSUcPassword" onpaste="return false;"  ClientIDMode="AutoID" TextMode="Password" class="form-control password"  placeholder="Confirm Password" runat="server"  MaxLength="50"></asp:TextBox>
                <span class="red"> <asp:RequiredFieldValidator ValidationGroup="vgSignUp" ID="RequiredFieldValidator8"   ControlToValidate="txtSUcPassword" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Confirmation Password] is required"></asp:RequiredFieldValidator></span>              
                <span class="red"><asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtSUpassword" ControlToValidate="txtSUcPassword" CultureInvariantValues="True" Display="Dynamic" ErrorMessage="[Confirm Password] and [Password] unmatch" CssClass="error"></asp:CompareValidator></span>              
                <p><asp:CheckBox ID="chkPass2" runat="server" CssClass="chkShowPass"/> Show password </p>

                <button class="btn btn-primary btn-block" ValidationGroup="vgSignUp" type="submit" runat="server" onserverclick="btnSignUp_Click"><i class="fas fa-user-plus"></i> Sign Up</button>
                <a href="Log.aspx?log=Login" id="cancel_signup" class="cancel" ><i class="fas fa-angle-left"></i> Back</a>
            </div>
        
    </div>
</asp:Content>
