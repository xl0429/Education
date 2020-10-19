<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AccountActivation.aspx.cs" Inherits="ARC_Library.Account.AccountActivation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        setTimeout(" location = 'Log.aspx?log=SignUp' ", 3000);
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label1" runat="server"></asp:Label>
    <asp:HyperLink ID="HyperLink1" runat="server" Visible="false" NavigateUrl="~/Account/SignUp.aspx">Sign Up</asp:HyperLink>
</asp:Content>
