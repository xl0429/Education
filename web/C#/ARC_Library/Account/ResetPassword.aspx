<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="ARC_Library.Account.ResetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/site.css" rel="stylesheet" />

    <style>
        h3 {
            padding-bottom: 30px;
        }

        .tbAccount td {
            padding: 12px;
            min-width: 180px;
            border: 1px solid black;
        }

        .tbAccount tr:nth-child(even) {
            background-color: #f1efef;
        }

        .tbAccount tr:nth-child(odd) {
            background-color: #d8d1d1;
        }

        .tbAccount td:nth-child(3) {
            border: none;
            background-color: white;
            position: absolute;
        }

        .tbAccount td:first-child {
            font-weight: bold;
        }
    </style>
    <script src="../js/jquery3.3.1.min.js"></script>
    <script src="../js/site.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Reset Password</h3>
    <table class="tbAccount" >
        <tr>
            <td>Current Password </td>
            <td> <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="signUpInput password"  Autofocus="autofocus"></asp:TextBox>
                 </td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Current password is required" ControlToValidate="txtCurrentPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="cvNotMatch" runat="server" ErrorMessage="Password and username not matched" ControlToValidate="txtCurrentPassword" CssClass="error" ></asp:CustomValidator>
            </td>
        </tr>
        <tr>
                <td><asp:Label ID="lblPassword" runat="server" Text="Password" AssociatedControlID="txtPassword"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="signUpInput password"  Autofocus="autofocus"></asp:TextBox>
                 </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtPassword" CssClass="error" Display="Dynamic" ErrorMessage="[Password] only contains letters, numbers, @, _, ~, # with length > 6" ValidationExpression="[a-zA-Z0-9_@~#]{6,}"></asp:RegularExpressionValidator>  
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtCurrentPassword"  Display="Dynamic" ErrorMessage="Current password and new password are same" CssClass="error" Operator="NotEqual"></asp:CompareValidator>

                </td>    
            </tr>
            <tr>
                <td><asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password" AssociatedControlID="txtConfirmPassword"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password " CssClass="signUpInput password" ></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Confirm Password is required" ControlToValidate="txtConfirmPassword" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"  Display="Dynamic" ErrorMessage="Confirm password and password unmatch" CssClass="error"></asp:CompareValidator>

                </td>    
            </tr>
             <tr >
                <td colspan="3" style="text-align:center; vertical-align:central;">
                    <asp:CheckBox runat="server" CssClass="chkShowPass"/> Show password
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
            </tr>
    </table>
</asp:Content>
