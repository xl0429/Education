<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SummaryReport1.aspx.cs" Inherits="ARC_Library.AdminPage.Report.SummaryReport1" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Summary Report1</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Summary Report1</h3>
       <p>
        <a href="DetailReport.aspx" title="Detail Report">Report 1</a> |
        <a href="ExceptionReport.aspx" title="Exception Report">Report 2</a> |
        <a href="SummaryReport1.aspx" title="Summary Report 1">Report 3</a> |
        <a href="SummaryReport2.aspx" title="Summary Report 2">Report 4</a>
    </p>
    Total login users: <asp:Literal ID="litCount" runat="server"></asp:Literal>
    <br />
    <br />
    <table>
        <tr>
            <td><b>Year: </b></td>
            <td>
                <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" >
                </asp:DropDownList>
            </td>
        </tr>
    </table>

    <br />
    <asp:Label ID="Label1" runat="server"></asp:Label>
    <br />
    <p>
        <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Visible="false" />
    </p>
    <asp:LinqDataSource ID="dsSummary" runat="server"  OnSelecting="dsSummary_Selecting" ></asp:LinqDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:reportviewer runat="server" ID="rvSummary" BackColor="" ClientIDMode="AutoID"
            InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" 
             InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px"
             ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" 
             ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" 
             Height="8in" Width="7.2in" BorderStyle="Solid" BorderWidth="1px" ZoomMode="PageWidth" ShowToolBar="True"
            >
            <LocalReport ReportPath="AdminPage\Report\rptSumamry1.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="dsSummary" Name="LoginInfo" />
                </DataSources>
            </LocalReport>
            
        </rsweb:reportviewer>
   
    <br />

</asp:Content>
