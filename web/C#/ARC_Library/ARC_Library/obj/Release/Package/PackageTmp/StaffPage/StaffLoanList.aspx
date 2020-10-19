<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StaffLoanList.aspx.cs" Inherits="ARC_Library.StaffPage.StaffLoanList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Staff Loan List</title>
    <link href="../css/site.css" rel="stylesheet" />
    <style>
        .gridview{
            text-align:center;
        }
        .gridview td:nth-child(6) {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Staff Loan List</h3>
    <asp:Label runat="server" ID="lblCount"></asp:Label>
    <div style="height:40px">
        <div runat="server" ID="banner" ClientID="banner" class="info" visible="false"></div>
    </div>
    <table>
        <tr>
            <td style=" padding-right:0;" ><asp:TextBox ID="txtSearch" runat="server"  TextMode="Search" Placeholder="Search..." AutoPostBack="true" AutoFocus="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox></td>
            <td><asp:ImageButton ID="imgBtnSearch" CssClass="imgBtnSearch" runat="server" ImageUrl="~/img/search.png"  CausesValidation="false"  /></td>
        </tr>
    </table>
    <br />
    <asp:GridView ID="gvLoan" runat="server" AutoGenerateColumns="False" CssClass="gridview" AllowPaging="true" PageSize="15"  OnPageIndexChanging="gvBook_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="LoanId" HeaderText="LoanId" ReadOnly="True" />
            <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" ReadOnly="True" DataFormatString="{0: dd/MM/yyyy}" />
            <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" ReadOnly="True" DataFormatString="{0: dd/MM/yyyy}" />
            <asp:BoundField DataField="sName" HeaderText="Staff Id" ReadOnly="True" />
            <asp:BoundField DataField="BookId" HeaderText="Book Id" ReadOnly="True" />
            <asp:BoundField DataField="bTitle" HeaderText="Title" ReadOnly="True" />
            <asp:BoundField DataField="MemberId" HeaderText="Member Id" ReadOnly="True" />
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%# Eval("lStatus") %>' ItemStyle-ForeColor='<%# Eval("lStatus").ToString() == "Overdue" ? "Red" : "" %>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>


        <PagerStyle CssClass="pager" HorizontalAlign="Center" />

    </asp:GridView>
    <div runat="server" ID="divButton" style="display:none">
        <p><asp:Label ID="lblFound" runat="server"></asp:Label></p>
        <p><asp:Button ID="btnRefresh" runat="server" Text="Button" OnClick="btnRefresh_Click" /></p>
    </div>
</asp:Content>
