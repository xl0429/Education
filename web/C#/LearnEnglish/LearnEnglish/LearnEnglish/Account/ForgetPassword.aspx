<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="LearnEnglish.Account.ForgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/StyleSheet1.css" rel="stylesheet" />
    <title>Forget Password</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 style="padding-bottom: 20px">Forget your Password?</h1>
    <table>
        <tr>
            <td>Email Address : </td>
            <td><asp:TextBox ID="txtEmail" runat="server" Width="250px"></asp:TextBox></td>
            <td>  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
        <td><p style="padding-top: 30px"><span><u>Security Question</u></span></p></td>
          </tr>
            <tr>
                <td><asp:Label ID="lblCountries" runat="server" Text="Country" AssociatedControlID="ddlCountries"></asp:Label></td>
                <td><span class="select-holder">
                    <asp:DropDownList ID="ddlCountries" runat="server" AppendDataBoundItems="true" CssClass="signUpInput" Width="250px">
                        <asp:ListItem Text="--Select Country--" Value="0" />
                    </asp:DropDownList>
                    </span>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please select your country" InitialValue="0" ControlToValidate="ddlCountries" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td><asp:Label ID="lblBirthday" runat="server" Text="Birthday" AssociatedControlID="txtBirthday"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtBirthday" runat="server" TextMode="Date" CssClass="signUpInput" Width="250px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please select your birthday" ControlToValidate="txtBirthday" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
      
        <tr>
            <td colspan="2" align="center" style="padding-top: 10px">
                <asp:CustomValidator ID="cvNotMatched" runat="server" ErrorMessage="This email address has not registered yet." CssClass="error" Display="Dynamic"></asp:CustomValidator>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Security question(s) incorrect" ForeColor="Red" Font-Bold="True" Font-Italic="True"></asp:CustomValidator>
            </td>
        </tr>
        
    </table>
    <p style="padding-left:150px; padding-top:20px"><asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click1" /></p>
</asp:Content>
