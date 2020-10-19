<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Return.aspx.cs" Inherits="ARC_Library.Return" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/borrowReturn.css" rel="stylesheet" />
    <link href="../css/site.css" rel="stylesheet" />
    <title>Return Book</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Return</h3>
   <div ID="divMember" Visible="false" style="padding:20px" runat="server">
        <b>Username or Member Id :</b> <asp:TextBox ID="txtUnameId" MaxLength="50" runat="server"></asp:TextBox><asp:Button ID="btnSearch" runat="server" Text="Search" onClick="btnSearch_Click" ValidationGroup="vgMember" />
        <p>
        <asp:GridView ID="gvLoan" AutoGenerateColumns="False" runat="server" >
            <Columns>
                <asp:BoundField DataField="LoanId" HeaderText="Loan Id" ReadOnly="true"/>
                <asp:BoundField DataField="BorrowDate" DataFormatString="{0: dd/MM/yyyy}" HeaderText="Borrow Date" ReadOnly="true"/>
                <asp:BoundField DataField="ReturnDate"  DataFormatString="{0: dd/MM/yyyy}" HeaderText="Return Date" ReadOnly="true"/>
                <asp:BoundField DataField="BookId" HeaderText="Book Id" ReadOnly="true"/>
                <asp:BoundField DataField="bTitle" HeaderText="Book Title" ReadOnly="true"/>
                <asp:BoundField DataField="status" HeaderText="Status"  ReadOnly="true"/>
            </Columns>          
        </asp:GridView>
        </p>
        <span style="display:none"><asp:RequiredFieldValidator ValidationGroup="vgMember" ID="RequiredFieldValidator2" ControlToValidate="txtUnameId" runat="server" Display="Dynamic" CssClass="error" ErrorMessage="[Username or Member Id] is required"></asp:RequiredFieldValidator></span>
        <span style="display:none"><asp:CustomValidator ValidationGroup="vgMember" ID="cvNoUsername" runat="server" Display="Dynamic" CssClass="error" ErrorMessage="[Username] has no loan records"></asp:CustomValidator></span>
        <span style="display:none"><asp:CustomValidator ValidationGroup="vgMember" ID="cvNoMember" runat="server" Display="Dynamic" CssClass="error" ErrorMessage="[Member Id] has no overdue date book"></asp:CustomValidator></span>
    </div>

    <div class="borrowReturn">
         <div >
            <span style="display:block"><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtBookId"   Display="Dynamic" CssClass="error" ErrorMessage="[Book Id] is required"></asp:RequiredFieldValidator></span>
            <span style="display:block"><asp:CustomValidator ID="cvBookFound" ControlToValidate="txtBookId"   Display="Dynamic" CssClass="error" runat="server" OnServerValidate="cvBookFound_ServerValidate" ErrorMessage="[Book Id] is no found"></asp:CustomValidator></span>
            <span style="display:block"><asp:CustomValidator ID="cvLoanFound" Display="Dynamic" CssClass="error" ControlToValidate="txtBookId" runat="server" OnServerValidate="cvLoanFound_ServerValidate" ErrorMessage="[Loan] is no found on this book"></asp:CustomValidator></span>
        </div>
        <input type="button" runat="server" ID="btnCheck" value="Check" class="topRight"  title="Check overdue loan by username or member id" causesvalidation="false" onserverclick="btnCheck_Click" />
        <table class="tbBorrowReturn">
            <tr>    
                <th colspan="2" style="text-align:center"> <a href="Borrow.aspx">Borrow</a>  |  <a href="Return.aspx" style="background-color:#042c75; color:white">Return</a></th>
            </tr>
            <tr>
                <td>Book Id</td>
                <td><asp:TextBox ID="txtBookId" autofocus="true"  runat="server" MaxLength="6" ></asp:TextBox></td>
            </tr>
        </table>
        <asp:HiddenField ID="hfLoanId" runat="server" />
        
    <div style="padding:10px">
        <asp:Button ID="btnReturn" runat="server" Text="Return" OnClick="btnReturn_Click" /></div>
        <div runat="server" id="divPenalty" visible="false">

        <table class="tbBorrowReturn">
            <tr>
                <td>Penalty Id</td>
                <td><asp:Label ID="lblPenaltyId" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>Loan Id</td>
                <td><asp:Label ID="lblLoanId" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>Book Title</td>
                <td><asp:Label ID="lblBookTitle" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>Return Date</td>
                <td><asp:Label ID="lblReturnDate" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>Overdue Days</td>
                <td><asp:Label ID="lblOverdueDays" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>Penalty Rate</td>
                <td><asp:Label ID="lblPenaltyRate" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td>Penalty Price</td>
                <td><asp:Label ID="lblPrice" runat="server" Text="Label"></asp:Label></td>
            </tr>
        </table>
        <asp:Label ID="lblFound" runat="server"></asp:Label>
        <br />
        <asp:CheckBox ID="chkException" runat="server" Text="Penalty Exception" Font-Bold="True" />
        <div>
        <asp:Button ID="btnPenaltyPaid" runat="server" Text="Penalty Paid" OnClick="btnPenaltyPaid_Click" CausesValidation="false"/>
    </div>
    </div>
        </div>
    
</asp:Content>
