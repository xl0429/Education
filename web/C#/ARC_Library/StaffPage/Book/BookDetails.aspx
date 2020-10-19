<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="ARC_Library.BookDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        
        .dvBooks tr:nth-child(even){
            background-color:#f0f3f3;
        }
        .dvBooks td:first-child{
            font-weight:bold;
        }
        .dvBooks tr:not(:first-child) td:nth-child(2){
            padding-left:8px;
        }
    </style>
    <title>Book Details</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Book Details</h3>
    <hr /><br />
    <asp:LinqDataSource ID="dsBooks" runat="server" ContextTypeName="ARC_Library.ARCLibraryDataContext" EntityTypeName=""   Where="BookId==@BookId" Select="new (CategoryId, Status, Image, RegisterDate, BookId, Author, Title, Price, ISBN, Publisher, PublishYear)" TableName="Books">
         <WhereParameters>
            <asp:QueryStringParameter Name="BookId" QueryStringField="BookId" />
        </WhereParameters>
    </asp:LinqDataSource>
    <div>
    <asp:DetailsView ID="dvBooks" CssClass="dvBooks" runat="server" Height="50px" Width="125px" AutoGenerateRows="False">
        <Fields>
            <asp:TemplateField><ItemTemplate>
            <asp:Image runat="server"  ImageUrl='<%#  Eval("Image", "../../img/Books/{0}.jpg") %>'  AlternateText="No cover found" ControlStyle-height="200px" ControlStyle-Width="150px">
            </asp:Image>
                </ItemTemplate></asp:TemplateField>
            <asp:BoundField DataField="BookId" HeaderText="BookId" ReadOnly="True" />
            <asp:BoundField DataField="Category" HeaderText="Category" ReadOnly="True" />
            <asp:BoundField DataField="ISBN" HeaderText="ISBN" ReadOnly="True"/>
            <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" />
            <asp:BoundField DataField="Author" HeaderText="Author" ReadOnly="True"  />
            <asp:BoundField DataField="Title" HeaderText="Title" ReadOnly="True"/>
            <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" DataFormatString="RM {0}"/>
            <asp:BoundField DataField="Publisher" HeaderText="Publisher" ReadOnly="True"  />
            <asp:BoundField DataField="PublishYear" HeaderText="PublishYear" ReadOnly="True" />
            <asp:BoundField DataField="RegisterDate" HeaderText="Register Date" ReadOnly="True"  DataFormatString="{0:dd/MM/yyyy}" />

        </Fields>
    </asp:DetailsView>
        </div>
    <br>
    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
    <hr />
    <p>
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/StaffPage/Book/Book.aspx" >Back</asp:LinkButton>
    </p>
</asp:Content>
