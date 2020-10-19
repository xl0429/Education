<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LoanList.aspx.cs" Inherits="ARC_Library.MemberPage.LoanList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Loan List</title>
    <link href="../css/site.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Loan List</h3>
    <asp:Label runat="server" ID="lblCount"></asp:Label>
     <div style="height:40px"></div>
    <asp:GridView AllowPaging="true" ID="gvLoan" runat="server" AutoGenerateColumns="False" CssClass="gridview" PageSize="10" OnPageIndexChanging="gvLoan_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="LoanId" HeaderText="Loan Id" ItemStyle-HorizontalAlign="center"/>
            <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="center"/>
            <asp:BoundField DataField="ReturnDate" HeaderText="Return Time" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="center" />
            <asp:BoundField DataField="BookId" HeaderText="Book Id"  ItemStyle-HorizontalAlign="center"/>
            <asp:BoundField DataField="Title" HeaderText="Book Title" />
            <asp:BoundField  DataField="Status"  HeaderText="Status" />
            </Columns>
                <PagerStyle CssClass="pager" HorizontalAlign="Center" />

    </asp:GridView>
</asp:Content>
