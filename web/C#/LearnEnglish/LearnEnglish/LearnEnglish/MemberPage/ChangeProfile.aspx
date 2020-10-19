<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangeProfile.aspx.cs" Inherits="LearnEnglish.Account.ChangeProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Change Profile</title>
    <style>
         h2{
            padding-bottom:30px;
        }

        .tbChangeProfile td{
            padding:6px;
            min-width:180px;
            border:1px solid black;
        }
        .tbChangeProfile tr:nth-child(even) {
            background-color:#f1efef;
            
        }
        .tbChangeProfile tr:nth-child(odd){
            background-color:#cecece;
        }
        .tbChangeProfile td:nth-child(3){
           border:none;
           background-color:white;
           position:absolute;
        }
        .tbChangeProfile td:first-child{
            font-weight:bold;
        }
    </style>
    <link href="../css/StyleSheet1.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
    <h2 align="center">Change Profile</h2>
        <p align="center"><span title=" Please insert user information below."><u>User Information</u></span></p>
        <table class="tbChangeProfile" align="center">
            <tr>
                <td><asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label></td>
                <td>
                    <asp:Label ID="lblUsername2" runat="server" MaxLength="25" ></asp:Label>
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="CustomValidator3" runat="server" ErrorMessage="Email is existed" ControlToValidate="txtEmail" Display="Dynamic" CssClass="error" ></asp:CustomValidator>
                    </td>
            </tr>
        </table>
        <p align="center" style="padding-top: 30px"><span title=" Please insert correct information below."><u>Security Question</u></span></p>
        <table align="center"class="tbChangeProfile">
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
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtBirthday" ErrorMessage="Are you sure this is your birthday?" CssClass="error" Display="Dynamic" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                </td>
            </tr>
            
        </table>
        <p align="center" style="padding-top:30px;">
            <asp:Button ID="btnReset" runat="server" Text="Reset" CausesValidation="False" OnClick="btnReset_Click" />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        </p>   
        
    </div>
</asp:Content>
