<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GrammarList.aspx.cs" Inherits="LearnEnglish.GrammarList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Grammar List</title>
    <style>
        .gridview{
            width:65%;
        }
    </style>
    <link href="../../css/StyleSheet1.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" >
    <div align="center">
    <asp:Label ID="lblHeader" runat="server" Font-Bold="True" Font-Size="XX-Large" ></asp:Label>
    <br />
    <br />
    <p>
        <asp:TextBox ID="txtSearch" PlaceHolder="Search for..." runat="server" ></asp:TextBox><asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click1" />
    </p>
        <br />

    <asp:GridView ID="gvLevel" runat="server" AutoGenerateColumns="False" CssClass="gridview" >
        <Columns>
            <asp:BoundField DataField="GrammarCode" HeaderText="Grammar Code" ItemStyle-Width="20%" />
            <asp:BoundField DataField="Title" HeaderText="Title"  />
            <asp:HyperLinkField DataNavigateUrlFields="GrammarCode" DataNavigateUrlFormatString="GrammarDetail.aspx?GrammarCode={0}" Text="Details" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center" />
        </Columns>
        <RowStyle BackColor="white" Height="100px" />
    </asp:GridView>
    <p>
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </p>   


    <p>
        <asp:Button ID="Button1" runat="server" Text="Back" OnClick="Button1_Click" />
    </p>   
        </div>
</asp:Content>
