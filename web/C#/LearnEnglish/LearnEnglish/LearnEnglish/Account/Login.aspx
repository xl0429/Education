<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearnEnglish.Account.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Login</title>
    <style>

        .tbLogin td{
            padding: 7px 5px;
        }
        h2{
            padding-bottom:20px;
        }
        #caps {
            display:none;
            color:red;
        }
        .error:hover{
            cursor:pointer;
        }

        .btnLogin{
            color:white;
            background-color:#0d277d;
            width:200px;
            border-radius:20px;
        }
        .btnLogin:hover{
            background-color:#394079;
        }
        .btnGoogle{
            background-image:url("../Images/google.png");
            background-repeat:no-repeat;
            background-position:20px;            
                
        }

    </style>

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

        document.onkeydown = function(e) {
          e = e || event;

          if (e.keyCode == 20 && capsLockEnabled !== null) {
            capsLockEnabled = !capsLockEnabled;
          }
        }

        document.onkeypress = function(e) {
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

        /**
         * Check caps lock 
         */
        function checkCapsWarning() {
          document.getElementById('caps').style.display = capsLockEnabled ? 'block' : 'none';
        }

        function removeCapsWarning() {
          document.getElementById('caps').style.display = 'none';
        }


       
    </script>
    <script src='https://www.google.com/recaptcha/api.js' type="text/javascript"></script></td>

    <link href="../css/StyleSheet1.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
        <h2 class="center">Login to LearnEnglish</h2>
        <div style="overflow-x:auto; margin: 0 auto; padding: 30px ; width:60%; border: 5px double #0d277d; border-radius:10px">
            <table class="tbLogin" align="center">
                <tr>
                    <td><b>Username</b></td>
                    <td><asp:TextBox ID="txtUsername" runat="server" AutoFocus="autofocus"></asp:TextBox> </td>
                    <td><asp:RequiredFieldValidator  ID="RequiredFieldValidator2" runat="server" title="Please enter username" ControlToValidate="txtUsername" Display="Dynamic" CssClass="error" ></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td><b>Password</b></td>
                    <td><asp:TextBox ID="txtPassword" runat="server" TextMode="Password" onkeyup="checkCapsWarning(event)" onfocus="checkCapsWarning(event)" onblur="removeCapsWarning()" ></asp:TextBox></td>
                    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" title="Please enter password" ControlToValidate="txtPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
                </tr>
                 <tr>
                    <td align="center" colspan="2">
                        <div id="caps">
                            <asp:Image ID="Image1" Width="25px" Height="25px" src="../Images/caution.png" runat="server" />
                            Warning! Cap Lock is ON.

                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan ="2" align="center"><span style="padding-top:10px"><asp:CheckBox ID="chkRememberMe" runat="server" />Remember me </span></td>    
                </tr>
                <tr>
                    <td align="left"><asp:HyperLink ID="hlSignUp"  runat="server" NavigateUrl="~/Account/SignUp.aspx">Create Account?</asp:HyperLink></td>
                    <td align="right"><asp:HyperLink ID="hlForgetPassword"  runat="server" NavigateUrl="~/Account/ForgetPassword.aspx">Forget Password?</asp:HyperLink></td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Please check your email for account activation" Display="Dynamic" CssClass="error"></asp:CustomValidator>
                        <asp:CustomValidator ID="cvNotMatched" runat="server" ErrorMessage="Username and Password mismatch" Display="Dynamic" CssClass="error"></asp:CustomValidator>
                   </td>
                </tr>
                <tr>
                    <td colspan="3" align="center"> 
                        <div class="g-recaptcha"  name="g-recaptcha" runat="server" data-sitekey="6Lfo1YgUAAAAAMfTmg9AlhnBcp2iJPs5mNtOfM2w" ></div>
                        <asp:CustomValidator ID="cvGoogleRecaptcha" runat="server" ErrorMessage="Recaptcha is required" Display="Dynamic" ForeColor="#990000" OnServerValidate="cvGoogleRecaptcha_ServerValidate"></asp:CustomValidator>
                </tr>
                
                <tr>
                    <td style="padding:20px;" align="center" colspan="3" ><asp:Button ID="btnLogin"  runat="server" Text="Login" CssClass="btnLogin" OnClick="btnLogin_Click" /></td>
                </tr>
                <tr>
                    <td style="padding:5px;" align="center" colspan="3"><asp:Button ID="btnGoogle" runat="server" Text="Google Login" CssClass="btnLogin btnGoogle" OnClick="btnGoogle_Click" CausesValidation="False" /></td>
                </tr>
               
            </table>
         </div>
</asp:Content>
