<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="LearnEnglish.Account.ResetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Reset Password</title>
     <style>
        
        h2{
            padding-bottom:30px;
        }

        .tbReset td{
            padding:6px;
            min-width:180px;
            border:1px black dashed;
            border-radius: 15px;
        }
        .tbReset tr:nth-child(even) {
            background-color:#ddecf3;   
        }
        .tbReset tr:nth-child(odd){
            background-color:#aad8ff;
        }
        .tbReset td:nth-child(3){
           border:none;
            background-color:white;
            position:absolute;
        }
        .tbReset td:first-child{
            font-weight:bold;
        }
    </style>
    <link href="../css/StyleSheet1.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 align="center">Reset Password</h2>
    <table class="tbReset" align="center">
        <tr>
            <td>Current Password </td>
            <td> <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="signUpInput" Autofocus="autofocus"></asp:TextBox>
                 </td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Current password is required" ControlToValidate="txtCurrentPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="cvNotMatch" runat="server" ErrorMessage="Password and username not matched" ControlToValidate="txtCurrentPassword" CssClass="error" ></asp:CustomValidator>
            </td>
        </tr>
        <tr>
                <td><asp:Label ID="lblPassword" runat="server" Text="Password" AssociatedControlID="txtPassword"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="signUpInput" Autofocus="autofocus"></asp:TextBox>
                 </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtPassword" CssClass="error" Display="Dynamic" ErrorMessage="6-20 characters that only contains letter, number, @, _ can be used" ValidationExpression="[a-zA-Z0-9_@]{6,20}"></asp:RegularExpressionValidator>  
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtCurrentPassword"  Display="Dynamic" ErrorMessage="Current password and new password are same" CssClass="error" Operator="NotEqual"></asp:CompareValidator>

                </td>    
            </tr>
            <tr>
                <td><asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password" AssociatedControlID="txtConfirmPassword"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="signUpInput"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Confirm Password is required" ControlToValidate="txtConfirmPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"  Display="Dynamic" ErrorMessage="Confirm password and password unmatch" CssClass="error"></asp:CompareValidator>

                </td>    
            </tr>
            <tr>
                <td colspan="2" align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
            </tr>
    </table>
</asp:Content>
