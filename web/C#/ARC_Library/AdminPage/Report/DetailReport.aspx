<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DetailReport.aspx.cs" Inherits="ARC_Library.AdminPage.Report.DetailReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Detail Report</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <asp:LinqDataSource ID="dsDetail" runat="server"  OnSelecting="dsDetail_Selecting" ></asp:LinqDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <h3>Detail Report</h3>
       <p>
        <a href="DetailReport.aspx" title="Detail Report">Report 1</a> |
        <a href="ExceptionReport.aspx" title="Exception Report">Report 2</a> |
        <a href="SummaryReport1.aspx" title="Summary Report 1">Report 3</a> |
        <a href="SummaryReport2.aspx" title="Summary Report 2">Report 4</a>
    </p>
   
    <asp:Literal ID="litTotalCount" runat="server">Total Book Entries :</asp:Literal>
    <br />
    <br />
    <table>
        <tr>
            <td><b>Filter: </b></td>
            <td>
                <asp:DropDownList ID="ddlFilter"  Width="200px" runat="server" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                    <asp:ListItem Text="--Select One--" Value="0"></asp:ListItem>
                   
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><b>Year: </b></td>
            <td> 
                <asp:DropDownList ID="ddlYear" Width="200px" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" >    
                </asp:DropDownList>
            </td>
        </tr>
    </table>
   <br>
    <p><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></p>
    <br />
    <p><asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Visible="false" /></p>

        <rsweb:reportviewer runat="server" ID="rvDetail" BackColor="" ClientIDMode="AutoID" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" 
             InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px"
             ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" 
             ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" 
             Height="12in" Width="7.2in" BorderStyle="Solid" BorderWidth="1px" ZoomMode="PageWidth" HighlightBackgroundColor="" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemHoverBackColor="">
            <LocalReport ReportPath="AdminPage\Report\rptDetail.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="dsDetail" Name="BookCategory" />
                </DataSources>
            </LocalReport>
            
        </rsweb:reportviewer>
</asp:Content>
