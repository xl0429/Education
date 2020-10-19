<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InsertGrammar.aspx.cs" Inherits="LearnEnglish.AdminPage.InsertGrammar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Insert Grammar</title>
    <style>
        .detailsView td:first-child{
            font-weight:bold;
        }
        .detailsView td{
            padding:3px;
        }
        .detailsView{
            width:100%;
        }
    </style>
    <link href="../../css/StyleSheet1.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="header">Insert Grammar</h1>
    <div>
        <asp:HyperLink ID="edition" runat="server" NavigateUrl="Grammar.aspx" Font-Size="Large">Edition</asp:HyperLink> | 
        <asp:HyperLink ID="insert" runat="server" NavigateUrl="InsertGrammar.aspx" Font-Size="Large">Insert</asp:HyperLink>
    </div>
    <br />
            <table class="detailsView">
                <tr>
                    <td>Grammar Code : </td>
                    <td>
                        <asp:Label ID="lblGrammarCode" runat="server" Text="Label"></asp:Label>
                       
                    </td>
                </tr>
                <tr>
                    <td>Title :</td>
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
                       <script>
                         CKEDITOR.replace("txtDesc");
                     </script> 
                        <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Please enter [Description]" ControlToValidate="txtDesc" CssClass="error" ForeColor="Red"></asp:CustomValidator>
                    </td>
               </tr>
                
            </table>
            <p style="padding-top:20px;text-align:center">
                <asp:Button ID="btnReset" runat="server" Text="Reset" CausesValidation="False"  />
                <asp:Button ID="btnInsert" runat="server" Text="Insert" OnClick="btnInsert_Click"/>
            </p>
</asp:Content>
