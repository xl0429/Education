<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InsertBook.aspx.cs" Inherits="ARC_Library.InsertBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Insert Book</title>
    <link href="../../css/book.css" rel="stylesheet" />
    <link href="../../css/site.css" rel="stylesheet" />
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function showpreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgpreview').css('visibility', 'visible');
                    $('#imgpreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <style>
        .tbInsertBook td:first-child{
            vertical-align:top
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:LinqDataSource ID="dsCategory" runat="server" ContextTypeName="ARC_Library.ARCLibraryDataContext" EntityTypeName="" OrderBy="CategoryName" Select="new (CategoryName, Remark)" TableName="Categories"></asp:LinqDataSource>
    <div class="divInsertBook">      
        <table class="tbInsertBook">
        <tr>
            <td>Quantity</td>
            <td><asp:DropDownList AutoPostBack="true" ID="ddlQuantity"  runat="server" OnSelectedIndexChanged="ddlQuantity_SelectedIndexChanged"></asp:DropDownList></td>
            <td></td>
        </tr>
        <tr>
            <td>Book Id</td>
            <td><asp:Label ID="lblBookId" runat="server" Text="Label"></asp:Label></td>
            <td></td>       
        </tr>
         <tr>
            <td>Register Date</td>
            <td><asp:Label ID="lblRegisterDate" runat="server" Text="Label"></asp:Label></td>
            <td></td>
        </tr>
        <tr>
            <td>ISBN</td>           
            <td><asp:TextBox ID="txtISBN" runat="server" autofocus="true" MaxLength="13"></asp:TextBox>
                <br/><asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtISBN" runat="server" ErrorMessage="[ISBN] is required" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtISBN"  ErrorMessage="[ISBN] contains 13 digits" Display="Dynamic" CssClass="error" ValidationExpression="[0-9]{13}"></asp:RegularExpressionValidator>
            </td>
        </tr>
            
        <tr>
            <td>Category</td>
            <td><asp:DropDownList ID="ddlCategory" AppendDataBoundItems="true" runat="server" Width="200px" Height="35"  >
                <asp:ListItem Value="0" Text="--Select One--" Selected="True"></asp:ListItem>
                </asp:DropDownList><br /><asp:RequiredFieldValidator ID="RequiredFieldValidator2" InitialValue="0" ControlToValidate="ddlCategory" runat="server" ErrorMessage="[Category] is required" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td>Title</td>
            <td><asp:TextBox ID="txtTile" runat="server"  MaxLength="50"></asp:TextBox>
                <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtTile" runat="server" ErrorMessage="[Title] is required" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td>Author</td>
            <td><asp:TextBox ID="txtAuthor" runat="server"  MaxLength="50"></asp:TextBox>
                <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtAuthor" runat="server" ErrorMessage="[Author] is required" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td>Pulisher</td>
            <td><asp:TextBox ID="txtPublisher" runat="server" MaxLength="50"></asp:TextBox> 
                <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtPublisher" runat="server" ErrorMessage="[Pulisher] is required" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td>Publish Year</td>
            <td><asp:TextBox ID="txtPublishYear" runat="server" MaxLength="4"></asp:TextBox>
                <br />
                <asp:RangeValidator ID="RangeValidatorYear" runat="server" ControlToValidate="txtPublishYear" Display="Dynamic" CssClass="error"></asp:RangeValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtPublishYear" runat="server" ErrorMessage="[Publish Year] is required" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator></td>      
        </tr> 
        <tr>    
            <td>Price</td>
            <td><asp:TextBox ID="txtPrice" runat="server" MaxLength="7"></asp:TextBox>
                <br />
                <asp:RangeValidator ID="RangeValidator1"  ControlToValidate="txtPrice" Type="Double" runat="server" Display="Dynamic" CssClass="error" ErrorMessage="[Price] is between <br/>   0 - 9999.99" MinimumValue="0" MaximumValue="9999.99"></asp:RangeValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtPrice" runat="server" ErrorMessage="[Price] is required" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator></td>
        </tr> 
        <tr>
            <td>Image</td>
            <td><asp:FileUpload ID="fuImage" runat="server" onchange="showpreview(this);" />
                 <div style="padding:5px">
                    <img id="imgpreview" height="200" src=""  width="150"  style="border-width: 0px; visibility: hidden;" />
                </div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="fuImage" CssClass="error" Display="Dynamic" 
                        ErrorMessage="Only JPG and PNG are allowed for [Photo]" ValidationExpression=".+\.(jpg|png)"></asp:RegularExpressionValidator>
            </td>
        </tr> 
     </table>
    </div>
    <p style="padding-top:20px">
        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
        <asp:Button ID="btnInsert" runat="server" Text="Insert" OnClick="btnInsert_Click" />

    </p>
</asp:Content>
