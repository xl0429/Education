<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="LearnEnglish.Account.SignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Sign up</title>
    <link href="../css/account.css" rel="stylesheet" />
    <link href="../css/StyleSheet1.css" rel="stylesheet" />

    <style>
        h2{
            padding-bottom:30px;
        }

        .tbSignUp td{
            padding:6px;
            min-width:180px;
            border:1px solid black;
        }
        .tbSignUp tr:nth-child(even) {
            background-color:#f1efef;
            
        }
        .tbSignUp tr:nth-child(odd){
            background-color:#cecece;
        }
        .tbSignUp td:nth-child(3){
           border:none;
            background-color:white;
            position:absolute;
        }
        .tbSignUp td:first-child{
            font-weight:bold;
        }      
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 align="center">Sign up for your new account</h2>
  
        <p align="center"><span title="Please insert user information below."><u>User Information</u></span></p>
        <table class="tbSignUp" align="center">
            <tr>
                <td><asp:Label ID="lblUsername" runat="server" Text="Username" AssociatedControlID="txtUsername"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtUsername" runat="server" MaxLength="25" Autofocus="autofocus" CssClass="signUpInput" Width="250px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Username is required" ControlToValidate="txtUsername" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUsername" CssClass="error" Display="Dynamic" ErrorMessage="6-20 characters that only letter, number, @, _ can be used" ValidationExpression="[a-zA-Z0-9_@]{6,20}" style="left: 100%; top: -5px"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Username is existed" ControlToValidate="txtUsername" Display="Dynamic" CssClass="error" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td><asp:Label ID="lblPassword" runat="server" Text="Password" AssociatedControlID="txtPassword"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="signUpInput" Width="250px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtPassword" CssClass="error" Display="Dynamic" ErrorMessage="6-20 characters that only contains letter, number, @, _ can be used" ValidationExpression="[a-zA-Z0-9_@]{6,20}"></asp:RegularExpressionValidator>
                </td>    
            </tr>
            <tr>
                <td><asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password" AssociatedControlID="txtConfirmPassword"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="signUpInput" Width="250px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" EnableViewState="False" ErrorMessage="Confirm Password is required" ControlToValidate="txtConfirmPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" CultureInvariantValues="True" Display="Dynamic" ErrorMessage="Confirm password and password unmatch" CssClass="error"></asp:CompareValidator>
                </td>    
            </tr>
            <tr>
                <td><asp:Label ID="lblEmail" runat="server" Text="Email" AssociatedControlID="txtEmail" MaxLength="50"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="signUpInput" Width="250px"></asp:TextBox>
                    </td>
                    <td>  
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="CustomValidator3" runat="server" ErrorMessage="Email is existed" ControlToValidate="txtEmail" Display="Dynamic" CssClass="error" OnServerValidate="CustomValidator3_ServerValidate1" ></asp:CustomValidator>
                    </td>
            </tr>
        </table>
        <p align="center" style="padding-top: 30px"><span title=" Please insert correct information below."><u>Security Question</u></span></p>
        <table align="center" class="tbSignUp">
            <tr>
                <td><asp:Label ID="lblCountries" runat="server" Text="Country" AssociatedControlID="ddlCountries"></asp:Label></td>
                <td><span class="select-holder">
                    <asp:DropDownList ID="ddlCountries" runat="server" AppendDataBoundItems="true" CssClass="signUpInput" Width="250px">
                        <asp:ListItem Text="--Select Country--" Value="0" />
                    </asp:DropDownList>
                    </span>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please select your country" InitialValue="0" ControlToValidate="ddlCountries" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td><asp:Label ID="lblBirthday" runat="server" Text="Birthday" AssociatedControlID="txtBirthday"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtBirthday" runat="server" TextMode="Date" CssClass="signUpInput" Width="250px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please select your birthday" ControlToValidate="txtBirthday" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtBirthday" ErrorMessage="Are you sure this is your birthday?" OnServerValidate="CustomValidator1_ServerValidate" CssClass="error" Display="Dynamic"></asp:CustomValidator>
                </td>
            </tr>
            
        </table>
        <p align="center" style="padding-top:20px;">
            <asp:Button ID="btnReset" runat="server" Text="Reset"   CausesValidation="False"/>
            <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" OnClick="btnSignUp_Click" />
        </p>   
</asp:Content>
