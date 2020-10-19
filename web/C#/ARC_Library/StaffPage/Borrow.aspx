<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Borrow.aspx.cs" Inherits="ARC_Library.Borrow" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js">
</script>
 <script>
    $(document).ready(function(){
        
    });
    </script>
    <style>
        .block{
            display:block;
        }
    </style>
    <title>Borrow Book</title>
    <link href="../css/borrowReturn.css" rel="stylesheet" />
    <link href="../css/site.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Borrow</h3>

    <div ID="divMember" Visible="false" style="padding:20px" runat="server">
        <b>Username :</b> <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        <input type="submit" runat="server" ValidationGroup="vgCheckMember" Value="Copy" Title="Copy member id" ID="btnCopy" onserverclick="btnCopy_Click" CausesValidation="false" />
        <div>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ValidationGroup="vgCheckMember" Display="Dynamic" CssClass="error"  ErrorMessage="[Username] is required"></asp:RequiredFieldValidator>
             <asp:CustomValidator ValidationGroup="vgCheckMember" ControlToValidate="txtUsername" ID="cvNoUsername" runat="server" Display="Dynamic" CssClass="error" ErrorMessage="[Username] is not member username"></asp:CustomValidator>
        </div>
    </div>
    
    <div class="borrowReturn">
        <input type="button" ID="btnCheck" class="topRight" runat="server" Value="Check"  title="Check member id using username"  onserverclick="btnCheck_ServerClick"  />
        <div style="display:block">    
            <div><asp:CustomValidator ID="cvReservationExpired" runat="server" ErrorMessage="[Reservation Id] is expired" Display="Dynamic" CssClass="error"></asp:CustomValidator></div>
            <div><asp:RequiredFieldValidator ValidationGroup="vgBorrow" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtBookId"  Display="Dynamic" CssClass="error" ErrorMessage="[Book Id] is required" EnableViewState="False"></asp:RequiredFieldValidator></div>
            <div><asp:RequiredFieldValidator  ValidationGroup="vgBorrow" ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMemberId"  Display="Dynamic" CssClass="error" ErrorMessage="[Member Id] is required"></asp:RequiredFieldValidator></div>
            <div><asp:CustomValidator  ValidationGroup="vgBorrow" ID="cvBookFound" runat="server" ControlToValidate="txtBookId" Display="Dynamic" CssClass="error" ErrorMessage="[Book Id] is not found"></asp:CustomValidator></div>
            <div><asp:CustomValidator ValidationGroup="vgBorrow" ID="cvBookStatus" runat="server" ControlToValidate="txtBookId" Display="Dynamic" CssClass="error" ErrorMessage="[Book Id] is reserved" OnServerValidate="cvBookStatus_ServerValidate"></asp:CustomValidator></div>
            <div><asp:CustomValidator ValidationGroup="vgBorrow" ID="cvAccBlocked" ControlToValidate="txtMemberId" Display="Dynamic" CssClass="error"  runat="server" ErrorMessage="[Member Id] is blocked. Please reactivate this account" OnServerValidate="cvAccBlocked_ServerValidate1"></asp:CustomValidator></div>
            <div><asp:CustomValidator ValidationGroup="vgBorrow" ID="cvOverDue" runat="server" ControlToValidate="txtMemberId"  ErrorMessage="[Member Id] is being blocked, overdue return book is exist"  Display="Dynamic" CssClass="error" OnServerValidate="cvOverDue_ServerValidate"></asp:CustomValidator></div>
            <div><asp:CustomValidator ValidationGroup="vgBorrow" ID="cvExistMember" runat="server" ControlToValidate="txtMemberId"  ErrorMessage="[Member Id] is not a member"  Display="Dynamic" CssClass="error" OnServerValidate="cvExistMember_ServerValidate"></asp:CustomValidator></div>
            <div><asp:CustomValidator ValidationGroup="vgBorrow" ID="cvMaxBookCheck" runat="server" ControlToValidate="txtMemberId"  ErrorMessage="Member reachs maximum number of borrowed and reserved book"  Display="Dynamic" CssClass="error" OnServerValidate="cvMaxBookCheck_ServerValidate"></asp:CustomValidator></div>
        </div>
        <table class="tbBorrowReturn">
            <tr>    
                <th colspan="2" style="text-align:center"> <a href="Borrow.aspx" style="background-color:#042c75; color:white">Borrow</a>  |  <a href="Return.aspx">Return</a></th>
            </tr>
            <tr>
                <td>Book Id</td>
                <td><asp:TextBox ID="txtBookId"  runat="server" CssClass="upper" MaxLength="6" OnTextChanged="txtBookId_TextChanged" AutoPostBack="True"></asp:TextBox></td>
            </tr>
            <tr>   
                <td>Member Id</td>
                <td><asp:TextBox ID="txtMemberId" runat="server" CssClass="upper"  MaxLength="5"></asp:TextBox></td>
            </tr>
        
        </table>
   
        <div style="padding:20px;"> <asp:Button ID="btnBorrow" ValidationGroup="vgBorrow" CssClass="btnBorrow" runat="server" Text="Borrow" OnClick="btnBorrow_Click" CausesValidation="true" /></div>
            <asp:DetailsView ID="dvBooks" CssClass="tbBorrowReturn dvBooks" runat="server" Height="50px" Width="125px" AutoGenerateRows="False">
                <Fields>
                    <asp:ImageField DataImageUrlField="Image" HeaderText="Image" DataImageUrlFormatString="../img/Books/{0}.jpg" NullImageUrl="../img/Books/noBookCover.png" AlternateText="No Cover Found" ControlStyle-Width="150"  ControlStyle-Height="200"></asp:ImageField>
                    <asp:BoundField DataField="Title" HeaderText="Title" ReadOnly="True" SortExpression="Title" />
                    <asp:BoundField DataField="Author" HeaderText="Author" ReadOnly="True" SortExpression="Author" />
                    <asp:BoundField DataField="Publisher" HeaderText="Publisher" ReadOnly="True" SortExpression="Publisher" />
                    <asp:BoundField DataField="CategoryName" HeaderText="CategoryId" ReadOnly="True" SortExpression="CategoryId" />
                </Fields>
            </asp:DetailsView>
    </div>


</asp:Content>
