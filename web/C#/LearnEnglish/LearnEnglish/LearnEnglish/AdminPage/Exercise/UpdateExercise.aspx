<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateExercise.aspx.cs" Inherits="LearnEnglish.AdminPage.UpdateExercise" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Update Exercise</title>
    <style>
        .tbUpdateExercise td:nth-child(3){
            position:absolute;
            border:none;
        }
        .tbUpdateExercise td{
            padding:10px;
            border:1px dotted #4e1313;
        }
       .tbUpdateExercise td:first-child{
           font-weight:bold;
       }
       .tbUpdateExercise{
       }
    </style>
    <link href="../../css/StyleSheet1.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h1 class="center" >UPDATE</h1>
        </div>
        <p align="center">
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Exercise.aspx">Exercise</asp:HyperLink> |
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="InsertExercise.aspx">Set Question</asp:HyperLink>
        </p>
        <table align="center" class="tbUpdateExercise">
            <tr>
                <td>Question ID:</td>
                <td><asp:Label ID="lblId" runat="server" Text="Label"></asp:Label></td>
                <td></td>
            </tr>
            <tr>
                <td>Topic:</td>
                <td><asp:DropDownList ID="ddlTopic" runat="server" Width="160px"> </asp:DropDownList></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlTopic" ErrorMessage="Please select [Topic]" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>Level:</td>
                <td> <asp:DropDownList ID="ddlLevel" runat="server" Width="160px"> </asp:DropDownList></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ControlToValidate="ddlLevel" ErrorMessage="Please select [Level]" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td id="vertical">Question: </td>
                <td><asp:TextBox ID="txtQuestion" runat="server" TextMode="MultiLine" Height="80px" Width="160px"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQuestion" ErrorMessage="Please enter [Question]" CssClass="error" Display="Dynamic" ></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>Option A:</td>
                <td><asp:TextBox ID="txtOptionA" runat="server" CssClass="auto-style2" Width="160px"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtOptionA" ErrorMessage="Please enter [Option A]" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>Option B:</td>
                <td><asp:TextBox ID="txtOptionB" runat="server" Width="160px"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtOptionB" ErrorMessage="Please enter [Option B]" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
            </tr>           
            <tr>
                <td>Option C:</td>
                <td><asp:TextBox ID="txtOptionC" runat="server" Width="160px"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtOptionC" ErrorMessage="Please enter [Option C]" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
            </tr>   
            <tr>
                <td>Option D:</td>
                <td><asp:TextBox ID="txtOptionD" runat="server" Width="160px"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtOptionD" ErrorMessage="Please enter [Option D]" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>Answer:</td>
                <td><asp:TextBox ID="txtAnswer" runat="server" MaxLength="1" Width="160px"></asp:TextBox></td>
                <td>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAnswer" ErrorMessage="Invalid [Answer] Format" ValidationExpression="[A-Da-d]" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAnswer" ErrorMessage="Please enter [Answer]" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
         </table>
        <p class="center" style="padding-top:20px">
            <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" CausesValidation="False" />
            <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update" />
        </p>
</asp:Content>
