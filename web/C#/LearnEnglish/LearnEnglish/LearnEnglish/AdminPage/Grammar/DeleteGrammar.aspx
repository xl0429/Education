<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DeleteGrammar.aspx.cs" Inherits="LearnEnglish.AdminPage.DeleteGrammar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Delete Grammar</title>
    <link href="../../css/StyleSheet1.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<link href="css/StyleSheet1.css" rel="stylesheet" />
     <h1 class="header">Delete Grammar</h1>
            <div>
                <asp:HyperLink ID="edition" runat="server" NavigateUrl="Grammar.aspx" Font-Size="Large">Edition</asp:HyperLink> | 
                <asp:HyperLink ID="insert" runat="server" NavigateUrl="InsertGrammar.aspx" Font-Size="Large">Insert</asp:HyperLink>
            </div>
        <table class="detailsView">
                <tr>
                    <td>Grammar Code : </td>
                    <td>
                        <asp:Label ID="lblCode" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Title :</td>
                    <td>
                        <asp:Label ID="lblTitle" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            <tr>
                    <td>Grammar Level :</td>
                    <td>
                        <asp:Label ID="lblLevel" runat="server" Text="Label"></asp:Label>
                       </td>
                </tr>
                <tr>
                    <td>Description :</td>
                    <td class="desc">
                        <script src="../../ckeditor/ckeditor.js"></script>
                        <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" ClientIDMode="Static" Height="200px" Width="200px"></asp:TextBox>
                            <script>
                                    CKEDITOR.replace("txtDesc");
                            </script>
                    </td>
                </tr>
               
            </table>
        <p style="text-align:center; padding-top:20px">
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
        </p>
</asp:Content>
