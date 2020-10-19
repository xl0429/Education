<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InsertTopic.aspx.cs" Inherits="LearnEnglish.AdminPage.InsertTopic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Insert Topic</title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .table1 td:nth-child(3){
            position:absolute;
        }
    </style>
    <link href="../../css/StyleSheet1.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div>
            <h1 class="auto-style1">TOPIC</h1>
        </div>
       
        <table align="center" class="table1">
            <tr>
                <td>Topic Id:</td>
                <td><asp:Label ID="lblTopic" runat="server"></asp:Label></td>
                
            </tr>
            <tr aria-grabbed="true">
                <td>Topic Name:</td>
                <td> <asp:TextBox ID="txtName" runat="server"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="[Topic Name] is required" ControlToValidate="txtName" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
            </tr>            
        </table>
       <br />
        <p class="auto-style1">
            <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
        </p>
</asp:Content>
