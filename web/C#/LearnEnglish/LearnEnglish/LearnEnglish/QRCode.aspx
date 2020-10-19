<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QRCode.aspx.cs" Inherits="LearnEnglish.QRCode" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <title>QR Code</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 59%;
            height: 81px;
            margin-right: 0px;
        }
        .auto-style3 {
            width: 104px;
            height: 44px;
        }
        .auto-style4 {
            width: 104px;
            height: 52px;
        }
        .auto-style5 {
            height: 52px;
        }
        .auto-style6 {
            height: 44px;
        }
    </style>

    <h1>Generate QR Code</h1>
      
            <table class="auto-style1">
                <tr>
                    <td class="auto-style4">Enter URL</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="TxtUrl" runat="server" Height="34px" Width="457px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style6">
                        <asp:Button ID="BtnGenerate" runat="server" BackColor="#CCFFFF" BorderColor="Black" Height="33px" Text="Generate" Width="84px" OnClick="Button1_Click" />
                    </td>
                </tr>
            </table>
    <div>
        <asp:Label ID="LblQR" runat="server" Text="QR Code Created" ForeColor="#CC0000" Visible="False"></asp:Label>
        <br />
        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
    </div>
</asp:Content>
