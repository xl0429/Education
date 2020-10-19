<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SummaryReport.aspx.cs" Inherits="LearnEnglish.AdminPage.Report.SummaryReport" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Summary Report</title>
    
    <link href="../../css/report.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    

    <h1>Summary Report</h1>
    <p>
        <a href="DetailReport.aspx">Report 1</a> |
        <a href="ExceptionReport.aspx">Report 2</a> |
        <a href="SummaryReport.aspx">Report 3</a>
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
     <asp:LinqDataSource ID="dsSummary" runat="server" ContextTypeName="LearnEnglish.LearnEnglishDataContext" EntityTypeName="" TableName=""  OnSelecting="dsSummary_Selecting" >
    </asp:LinqDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div align="center">
        <rsweb:reportviewer runat="server" ID="rvSummary" BackColor="" ClientIDMode="AutoID" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" 
             InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px"
             ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" 
             ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" 
             Height="12in" Width="7.2in" BorderStyle="Solid" BorderWidth="1px" ZoomMode="PageWidth" ShowToolBar="True">
            <localreport reportpath="AdminPage\Report\rptSummary.rdlc">
                <datasources>
                    <rsweb:ReportDataSource DataSourceId="dsSummary" Name="LoginInfo" />
                </datasources>
            </localreport>
        </rsweb:reportviewer>
    </div>
   
    <br />

  
</asp:Content>
