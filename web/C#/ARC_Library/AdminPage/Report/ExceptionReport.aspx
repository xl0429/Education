<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ExceptionReport.aspx.cs" Inherits="ARC_Library.ExceptionReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Exception Report</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:LinqDataSource ID="dsPenaltyLoan" runat="server" OnSelecting="dsPenaltyLoan_Selecting"></asp:LinqDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <h3>Exception Report</h3>
    <p>
        <a href="DetailReport.aspx" title="Detail Report">Report 1</a> |
        <a href="ExceptionReport.aspx" title="Exception Report">Report 2</a> |
        <a href="SummaryReport1.aspx" title="Summary Report 1">Report 3</a> |
        <a href="SummaryReport2.aspx" title="Summary Report 2">Report 4</a>
    </p>
   
    <asp:Literal ID="litTotalCount" runat="server">Total Exemption Penalty Records :</asp:Literal>
    <br />
    <br />
    <table>
        <tr>
            <td><b>Staff: </b></td>
            <td>
                <asp:DropDownList ID="ddlFilter" runat="server" AppendDataBoundItems="true" AutoPostBack="True" Width="200px" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                    <asp:ListItem Text="--Select One--" Value="0"></asp:ListItem>
                   
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><b>Year: </b></td>
            <td> 
                <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" Width="200px">    
                </asp:DropDownList>
            </td>
        </tr>
    </table>
   <br>
    <p><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></p>
    <br />
    <p><asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Visible="false" /></p>

    <rsweb:ReportViewer ID="rvException" runat="server" BackColor=""  
     ClientIDMode="AutoID" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" 
             InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px"
             ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" 
             ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" 
             Height="12in" Width="7.2in" BorderStyle="Solid" BorderWidth="1px" ZoomMode="PageWidth">
        <LocalReport ReportPath="AdminPage\Report\rptException.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="dsPenaltyLoan" Name="PenaltyLoan" />
              
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
</asp:Content>
