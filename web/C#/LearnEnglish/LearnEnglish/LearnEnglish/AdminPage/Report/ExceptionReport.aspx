<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExceptionReport.aspx.cs" Inherits="LearnEnglish.AdminPage.Report.ExceptionReport" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .gridview{
            font: 13pt Calibri;

            border-collapse: collapse;
        }

        .gridview th{
            border: 1px solid #999;
            padding: 5px;
            text-align: center;
        }

        .gridview td {
            border: 1px solid #999;
            padding: 5px;
            text-align: left;
        }

        .gridview th {
            background-color: #7da0ba;
            color: #fff;
        }

        .gridview th a {
            display: block;
            color: #fff;
            text-decoration: none;
        }
    </style>
    <title>Exception Report</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Exception Report</h1>

        <p>
        <asp:LinqDataSource ID="Exception" runat="server" ContextTypeName="LearnEnglish.LearnEnglishDataContext" EntityTypeName="" TableName="GrammarTypes" Select="new (Title, Rating)" OrderBy="Rating">
        </asp:LinqDataSource>
      <p>
        <a href="DetailReport.aspx">Report 1</a> |
        <a href="ExceptionReport.aspx">Report 2</a> |
        <a href="SummaryReport.aspx">Report 3</a>
    </p>
       
   
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div align="center">
    <rsweb:reportviewer ID="ReportViewer1" runat="server" BackColor="" ClientIDMode="AutoID"
        InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" 
             InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px"
             ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" 
             ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" 
             Height="12in" Width="7.2in" BorderStyle="Solid" BorderWidth="1px" ZoomMode="PageWidth" ShowToolBar="True">
        <localreport reportpath="AdminPage\Report\rptException.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="dsException" Name="GrammarType" />
            </DataSources>
        </localreport>
        </rsweb:reportviewer>
    </div>>
    <asp:LinqDataSource ID="dsException" runat="server" ContextTypeName="LearnEnglish.LearnEnglishDataContext" OnSelecting="dsException_Selecting">
    </asp:LinqDataSource>
</asp:Content>
