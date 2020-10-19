<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DeleteExercise.aspx.cs" Inherits="LearnEnglish.AdminPage.DeleteExercise" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Delete Exercise</title>
    <style>
        .table{
            border:1px solid grey;
            width:40%;
        }
        .table td{
            border:1px solid grey;
       }        
        .table tr:nth-child(2n){
            background-color:#efefef;
        }
        .table tr:first-child{
            background-color:white;
            font-weight:bold;
        }
        .table td:first-child{
            font-weight:bold;
            
        }

    </style>
        <link href="../../css/StyleSheet1.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div>
            <h1 class="center">DELETE</h1>
        </div>
            <p align="center" >
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Exercise.aspx">Exercise</asp:HyperLink> |
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="InsertExercise.aspx">Set Question</asp:HyperLink>
            </p>

            <table class="table" align="center">
                <tr><td colspan="2">Delete the following record?</td></tr>
                <tr>
                    <td>Question Id</td>
                    <td><asp:Label ID="lblId" runat="server"></asp:Label></td>
                </tr>
                 <tr>
                    <td>Topic</td>
                    <td><asp:Label ID="lblTopic" runat="server"></asp:Label></td>
                </tr>
                 <tr>
                    <td>Level</td>
                    <td><asp:Label ID="lblLevel" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Question</td>
                    <td><asp:Label ID="lblQuestion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Option A</td>
                    <td><asp:Label ID="lblOptionA" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Option B</td>
                    <td><asp:Label ID="lblOptionB" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Option C</td>
                    <td><asp:Label ID="lblOptionC" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Option D</td>
                    <td><asp:Label ID="lblOptionD" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Answer</td>
                    <td><asp:Label ID="lblAnswer" runat="server"></asp:Label></td>
                </tr>
            </table>
      
      
        <p class="center" style="padding-top:20px">
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
            <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" />
        </p>
</asp:Content>

