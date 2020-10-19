<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="ARC_Library.BookDetails1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .detailView{
            padding:20px;  
        }
        .detailView td:first-child{
            font-weight:bold;
        }
        .detailView tr:not(:first-child) td:nth-child(2){
            padding-left:8px;
        }
       
    </style>
    <title ID="title" runat="server"></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 ID="h3" runat="server"></h3>
    <hr />
    <asp:LinqDataSource ID="dsBookDetails" runat="server" ContextTypeName="ARC_Library.ARCLibraryDataContext" EntityTypeName="" Where="@BookId==BookId || @BookId==null" Select="new (BookId, Title, Author, Publisher, Price, Image, Status, Category)" TableName="Books">
        <WhereParameters>
            <asp:QueryStringParameter Name="BookId" QueryStringField="BookId" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:DetailsView ID="dvBookDetails" CssClass="detailView"  runat="server" Height="50px" Width="125px" DataSourceID="dsBookDetails" AutoGenerateRows="False" OnDataBound="dvBookDetails_DataBound">
        <Fields>
            <asp:TemplateField><ItemTemplate>
            <asp:Image runat="server"  ImageUrl='<%#  Eval("Image", "~/img/Books/{0}.jpg") %>'  AlternateText="No cover found" ControlStyle-height="200px" ControlStyle-Width="150px">
            </asp:Image>
                </ItemTemplate></asp:TemplateField>
            <asp:BoundField DataField="BookId" HeaderText="Book Id" />
            <asp:BoundField DataField="title" HeaderText="Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" />
            <asp:BoundField DataField="Publisher" HeaderText="Publisher" />
            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString = "RM {0}"/>
            <asp:BoundField DataField="Category.CategoryName" HeaderText="Category" />
        </Fields>
    </asp:DetailsView>
    <div style="padding-top:20px;"><asp:Button ID="btnReserve" runat="server" Text="Reserve" OnClick="btnReserve_Click"  Visible="false "/></div>
   <hr />    
    <div style="padding-top:20px;"><asp:Button ID="btnBack" runat="server" Text="Home" OnClick="btnBack_Click" /></div>
</asp:Content>
