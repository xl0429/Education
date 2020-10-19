    <%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SummaryReport2.aspx.cs" Inherits="ARC_Library.AdminPage.Report.SuummaryReport2" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Summary Report2</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Summary Report 2</h3>
   <p>
        <a href="DetailReport.aspx" title="Detail Report">Report 1</a> |
        <a href="ExceptionReport.aspx" title="Exception Report">Report 2</a> |
        <a href="SummaryReport1.aspx" title="Summary Report 1">Report 3</a> |
        <a href="SummaryReport2.aspx" title="Summary Report 2">Report 4</a>
    </p>
    <br />
        <asp:Literal ID="litTotalCount" runat="server">Total Loan Records :</asp:Literal>

    <br />
    <br />
    <table>
        <tr>
            <td><b>Top: </b></td>
            <td>
                <asp:DropDownList ID="ddlFilter" runat="server" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                    <asp:ListItem Text="--Select One--" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><b>Year: </b></td>
            <td> 
                <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" >    
                </asp:DropDownList>
            </td>
        </tr>
    </table>

   <br>

    <p><asp:Label ID="Label1" runat="server"></asp:Label></p>
    <br />
    <p><asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Visible="false" /></p>

    <rsweb:ReportViewer ID="rvSummary2" runat="server" BackColor="" ClientIDMode="AutoID"
            InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" 
             InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px"
             ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" 
             ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" 
             Height="8in" Width="7.2in" BorderStyle="Solid" BorderWidth="1px" ZoomMode="PageWidth" ShowToolBar="True"
            >
        <LocalReport ReportPath="AdminPage\Report\rptSummary2.rdlc">
               <DataSources>
                    <rsweb:ReportDataSource DataSourceId="dsSummary2" Name="BookLoan" />
                </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:LinqDataSource ID="dsSummary2" runat="server" OnSelecting="dsSummary2_Selecting"></asp:LinqDataSource>
  

</asp:Content>
