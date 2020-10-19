<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateBook.aspx.cs" Inherits="ARC_Library.UpdateBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../css/book.css" rel="stylesheet" />
    <style>
         .divInsertBook{
            background-image: linear-gradient(#e4ffde,#f9ffd1);
         }
    </style>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function showpreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgpreview.ClientID%>').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <title ID="title" runat="server"></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="divInsertBook">
    <table class="tbInsertBook">     
        <tr>
            <td>Book Id</td>
            <td><asp:Label ID="lblBookId" runat="server" Text="Label"></asp:Label></td>
            <td></td>
        </tr>
         <tr>
            <td>Register Date</td>
            <td><asp:TextBox ID="txtRegisterDate" runat="server"></asp:TextBox></td>
            <td></td>
        </tr>
        <tr>
            <td>ISBN</td>           
            <td><asp:TextBox ID="txtIsbn2" runat="server" autofocus="true"></asp:TextBox></td>
            <td></td>
        </tr>
        <tr>
            <td>Category</td>
            <td><asp:DropDownList ID="ddlCategory" runat="server" Width="200px" Height="35" AppendDataBoundItems="true">
                                <asp:ListItem Text="--Select One--" Value="0"></asp:ListItem>

                </asp:DropDownList></td>
            <td></td>
        </tr>
        <tr>
            <td>Title</td>
            <td><asp:TextBox ID="txtTitle" runat="server"></asp:TextBox></td>
            <td></td>
        </tr>
        <tr>
            <td>Author</td>
            <td><asp:TextBox ID="txtAuthor2" runat="server"></asp:TextBox></td>
            <td></td>
        </tr>
        <tr>
            <td>Pulisher</td>
            <td><asp:TextBox ID="txtPublisher2" runat="server"></asp:TextBox></td>
            <td></td>
        </tr>
        <tr>
            <td>Publish Year</td>
            <td><asp:TextBox ID="txtPublishYear" runat="server"></asp:TextBox></td>
            <td></td>
        </tr> 
        <tr>
            <td>Status</td> 
            <td><asp:DropDownList ID="ddlStatus" runat="server">
                <asp:ListItem Text="Available" Value="Available"></asp:ListItem>
                <asp:ListItem Text="Repair" Value="Repair"></asp:ListItem>
                </asp:DropDownList></td>
            <td></td>
        </tr> 
        <tr>
            <td>Image</td>
            
            <td>
            <asp:FileUpload ID="fuImage" runat="server" onchange="showpreview(this);"/>
                <div style="padding:5px">
                    <img id="imgpreview" height="200" src="" runat="server" width="150"  style="border-width: 0px;" />
                 </div>
            </td>
            <td></td>
        </tr> 
     </table>
    </div>

    <p style="padding-top:20px">
        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
        <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"/>
    </p>
    <hr />
    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>

</asp:Content>
