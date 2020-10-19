<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DeleteBook.aspx.cs" Inherits="ARC_Library.DeleteBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
         #tbDeleteBook td{
            border:1px solid black;
        }
         #tbDeleteBook tr:nth-child(even){
            background-color:aliceblue;
        }
        #tbDeleteBook{
            border-collapse:separate;
            padding:10px 10px 20px 10px;
        }
        #tbDeleteBook td:first-child{
            font-weight:bold;
        }
    </style>
    <title ID="title" runat="server"></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <b>Delete the following record?
    </b>
    <table id="tbDeleteBook">
        <tr>
            <td>Image</td>
            <td align="center"><asp:Image ID="img" runat="server" AlternativeText="No cover found" Height="200px" Width="150px" /></td>
        </tr> 
        <tr>
            <td>Book Id</td>
            <td><asp:Label ID="lblBookId" runat="server" Text="Label"></asp:Label></td>
        </tr>
         <tr>
            <td>Register Date</td>
            <td><asp:Label ID="lblRegisterDate" runat="server" Text="Label"></asp:Label></td>
          
        </tr>
        <tr>
            <td>ISBN</td>           
            <td><asp:Label ID="lblISBN" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td>Category</td>
            <td><asp:Label ID="lblCategory" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td>Title</td>
            <td><asp:Label ID="lblTitle" runat="server" Text="Label"></asp:Label></td>
  
        </tr>
        <tr>
            <td>Author</td>
            <td><asp:Label ID="lblAuthor" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td>Pulisher</td>
            <td><asp:Label ID="lblPublisher" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td>Publish Year</td>
            <td><asp:Label ID="lblPublisYear" runat="server" Text="Label"></asp:Label></td>
        </tr> 
        <tr>
            <td>Price</td>
            <td>RM <asp:Label ID="lblPrice" runat="server" Text="Label"></asp:Label></td>
        </tr> 
     </table>
    <p>
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
    </p>

</asp:Content>
