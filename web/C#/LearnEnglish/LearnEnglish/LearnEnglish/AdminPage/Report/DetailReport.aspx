<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetailReport.aspx.cs" Inherits="LearnEnglish.AdminPage.Report.DetailReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Detail Report</title>
    <link href="../../css/report.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Detail Report</h1>
    <p>
        <a href="DetailReport.aspx">Report 1</a> |
        <a href="ExceptionReport.aspx">Report 2</a> |
        <a href="SummaryReport.aspx">Report 3</a>
    </p>
   
    <asp:Literal ID="litTotalCount" runat="server">Total Admin's Edition :</asp:Literal>
    <br />
    <br />
    <table>
        <tr>
            <td><b>Filter: </b></td>
            <td>
                <asp:DropDownList ID="ddlFilter" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                    <asp:ListItem Text="--Select One--" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Insert" Value="Insert"></asp:ListItem>
                    <asp:ListItem Text="Update" Value="Update"></asp:ListItem>
                    <asp:ListItem Text="Delete" Value="Delete"></asp:ListItem>
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
    <p><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></p>
    <br />
    <p><asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Visible="false" /></p>

    <div align="center">
         <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
         <rsweb:ReportViewer ID="rvDetail" runat="server" BackColor="" ClientIDMode="AutoID" 
             InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" 
             InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px"
             ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" 
             ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" 
             Height="12in" Width="7.2in" BorderStyle="Solid" BorderWidth="1px" ZoomMode="PageWidth" ShowToolBar="True">
             <LocalReport ReportPath="AdminPage\Report\rptDetail.rdlc" >
                 <DataSources>
                     <rsweb:ReportDataSource DataSourceId="dsDetail" Name="Edition" />
                 </DataSources>
             </LocalReport>
        </rsweb:ReportViewer>
    </div>
    <asp:LinqDataSource ID="dsDetail" runat="server" ContextTypeName="LearnEnglish.LearnEnglishDataContext" EntityTypeName="" TableName="" OnSelecting="dsDetail_Selecting" >
    </asp:LinqDataSource>
</asp:Content>
