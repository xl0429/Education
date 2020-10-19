<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QRLogo.aspx.cs" Inherits="LearnEnglish.QRLogo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>QR Logo</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>  
    img {
            height:250px;
            width:250px;
            
        }
    </style>
    <h1>Generate QR Code with Logo</h1>
    <asp:TextBox ID="URL" runat="server"></asp:TextBox>
        <br /><br />
        <asp:FileUpload ID="LogoUpload" runat="server" />
        <br /><br />
        <asp:Button ID="CreateCode" runat="server" Text="Generate" OnClick="CreateCode_Onclick" />
        <br /><br />
        
        <asp:Image ID="imgQR" runat="server" />
</asp:Content>
