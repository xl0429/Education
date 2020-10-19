<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateGrammar.aspx.cs" Inherits="LearnEnglish.AdminPage.UpdateGrammar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Update Grammar</title>
    <link href="../../css/StyleSheet1.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="header">Update Grammar</h1>
    <div>
        <asp:HyperLink ID="edition" runat="server" NavigateUrl="Grammar.aspx" Font-Size="Large">Edition</asp:HyperLink> | 
        <asp:HyperLink ID="insert" runat="server" NavigateUrl="InsertGrammar.aspx" Font-Size="Large">Insert</asp:HyperLink>
    </div>
        
        <table class="detailsView">
            <tr>
                <td>Grammar Code</td>
                <td><asp:Label ID="lblCode" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>Title :<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></td>
                <td> 
                    <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle" CssClass="error" Display="Dynamic" ErrorMessage="Please enter [Title]" ForeColor="Red"></asp:RequiredFieldValidator> 
                </td>
            </tr>
            <tr>
                <td>Grammar Level :</td>
                <td>
                    <asp:DropDownList ID="ddlLevel" runat="server"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlLevel" CssClass="error" Display="Dynamic" ErrorMessage="Please enter [Grammar Level]" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="vertical-align:top">Description :</td>
                <td class="desc">
                    <script src="../../ckeditor/ckeditor.js"></script>
                        <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>
                    <script>CKEDITOR.replace("txtDesc");</script>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Please enter [Description]" ControlToValidate="txtDesc" CssClass="error" ForeColor="Red"></asp:CustomValidator>
                </td>
            </tr>
        </table>
        <p style="text-align:center; padding-top:20px">
           <asp:Button ID="btnCancel" runat="server" Text="Cancel" CausesValidation="False" OnClick="btnCancel_Click1" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
        </p>
</asp:Content>
