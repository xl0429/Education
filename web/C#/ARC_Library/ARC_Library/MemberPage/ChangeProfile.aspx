<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ChangeProfile.aspx.cs" Inherits="ARC_Library.MemberPage.ChangeProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        h3 {
            padding-bottom: 30px;
        }

        .tbAccount td {
            padding: 6px;
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
    <link href="../css/site.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Change Profile</h3>
        <table class="tbAccount" align="center">
            <tr>
                <td><asp:Label ID="lblMemberId" runat="server" Text="Member Id"></asp:Label></td>
                <td>
                    <asp:Label ID="lblMemberId2" runat="server"></asp:Label>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td><asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label></td>
                <td>
                    <asp:Label ID="lblUsername2" runat="server"></asp:Label>
                </td>
                <td>
                </td>
            </tr>
            
            <tr>
                <td><asp:Label ID="lblEmail" runat="server" Text="Email" AssociatedControlID="txtEmail" MaxLength="50"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="signUpInput" AutoFocus="autofocus" Width="250px"></asp:TextBox>
                    </td>
                    <td>  
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="[Email] is required" ControlToValidate="txtEmail" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format eg. abc@gmail.com"  CssClass="error" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="CustomValidator3" runat="server" ErrorMessage="Email is existed" ControlToValidate="txtEmail" Display="Dynamic" CssClass="error" ></asp:CustomValidator>
                    </td>
                    
            </tr>
            <tr>
                <td><asp:Label ID="lblContactNo" runat="server" Text="Contact No" AssociatedControlID="txtEmail" MaxLength="11"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtContactNo" runat="server" maxlength="12" CssClass="signUpInput" AutoFocus="autofocus" Width="250px"></asp:TextBox>
                    </td>
                    <td>  
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="[Contact No] is required" ControlToValidate="txtEmail" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtContactNo" ErrorMessage="Invalid phone format eg.012-1234561" ValidationExpression="01\d-\d{7,8}" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="CustomValidator4" runat="server" ErrorMessage="[Contact No] is existed" ControlToValidate="txtContactNo" Display="Dynamic" CssClass="error" ></asp:CustomValidator>
                    </td>                   
            </tr>                
        </table>
        <p style="padding-top:20px;">
            <asp:Button ID="btnReset" runat="server" Text="Reset" CausesValidation="False" OnClick="btnReset_Click" />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        </p>   
</asp:Content>
