<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Grammar.aspx.cs" Inherits="LearnEnglish.AdminPage.Grammar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Grammar Edition</title>
    <link href="../../css/StyleSheet1.css" rel="stylesheet" />
    <style>
        .gvGrammarRow .row:hover{
            background-color:red;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="header">Edition</h1>
        <div>
            <asp:HyperLink ID="edition" runat="server" NavigateUrl="Grammar.aspx" Font-Size="Large">Edition</asp:HyperLink> | 
            <asp:HyperLink ID="insert" runat="server" NavigateUrl="InsertGrammar.aspx" Font-Size="Large">Insert</asp:HyperLink>
       </div>
        <p class="para">
            <a href="?">All</a> |
            <a href="?Level=L01">Beginner</a> |
            <a href="?Level=L02">Intermediate</a> |
            <a href="?Level=L03">Advanced</a> 
        </p>
         <asp:GridView ID="gvGrammar" runat="server" AutoGenerateColumns="False" CssClass="gridview" AllowPaging="True" OnPageIndexChanging="gvGrammar_PageIndexChanging" PagerStyle-HorizontalAlign="Center">
            <Columns>   
                <asp:BoundField DataField="GrammarCode" HeaderText="Grammar Code" />
                <asp:BoundField DataField="Title" HeaderText="Title" ItemStyle-Width="50%" >
                <ItemStyle Width="50%"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Level" HeaderText="Grammar Level" ItemStyle-Width="18%">
                <ItemStyle Width="18%"></ItemStyle>
                </asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="GrammarCode" DataNavigateUrlFormatString="UpdateGrammar.aspx?GrammarCode={0}" Text="Update" ItemStyle-Width="8%" >
                <ItemStyle Width="8%"></ItemStyle>
                </asp:HyperLinkField>
                <asp:HyperLinkField DataNavigateUrlFields="GrammarCode" DataNavigateUrlFormatString="DeleteGrammar.aspx?GrammarCode={0}" Text="Delete" ItemStyle-Width="8%" >
                <ItemStyle Width="8%"></ItemStyle>
                </asp:HyperLinkField>
            </Columns>
             <RowStyle BackColor="#FCF1E2" Height="100px" Wrap="True" />
        </asp:GridView>
</asp:Content>
