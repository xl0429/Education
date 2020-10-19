<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GrammarDetail.aspx.cs" Inherits="LearnEnglish.GrammarDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title ID="title" runat="server"></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style type="text/css">
    .StarCss { 
        background-image: url(/Images/star.png);
        height:24px;
        width:24px;
    }
    .FilledStarCss {
        background-image: url(/Images/filledstar.png);
        height:24px;
        width:24px;
    }    
        .EmptyStarCss {
            background-image: url(/Images/star.png);
            height:24px;
            width:24px;
        }
        .WaitingStarCss {
            background-image: url(/Images/waitingstar.png);
            height:24px;
            width:24px;
        }

        #rateLink{
            text-decoration:none;
            display:block;
            color: black;
        }
        #rateLink:active{
            color:DarkBlue;
        }
        .lblDesc{
            padding:50px 10px;  
            text-align:justify;
        }
       
    </style>
    
    <div style="padding-bottom: 10px">
        <asp:Label ID="lblTitle" runat="server" Font-Size="XX-Large"></asp:Label>
    </div>
    <asp:ScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ScriptManager>
          <a href="#section2" id="rateLink">
                        <table>
                            <tr>
                                <td>
                                <asp:Label ID="lblCurrentRate" runat="server" Text="Label" Font-Bold="True" Font-Size="Large"></asp:Label>
     
                                </td>
                                <td onclick="document.location.href='#section2';">
                                     <cc1:Rating title="" ID="Rating2" runat="server" StarCssClass="StarCss" FilledStarCssClass="FilledStarCss" EmptyStarCssClass="EmptyStarCss" WaitingStarCssClass="WaitingStarCss" ReadOnly="True"></cc1:Rating>
                                </td>
                                <td><asp:Label ID="lblRateCount" runat="server" Text="Label" Font-Italic="True" Font-Size="Small"></asp:Label></td>
                            </tr>
                       </table>
                        </a>
         
        <asp:Label ID="lblDesc" CssClass="lblDesc" runat="server"></asp:Label>
        <br />
        <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Height="137px" Width="524px"></asp:TextBox>
        <br />
       
        <asp:ImageButton ID="btnSpeaker" runat="server" ImageUrl="~/Images/speaker.png" Height="35px" Width="39px" OnClick="btnSpeaker_Click"/>
        <br />       

        <div id="section2">
            <span><b>Rate :</b></span>
            <cc1:Rating ID="Rating1" padding-left="20px" runat="server" AutoPostBack="True" EmptyStarCssClass="EmptyStarCss" FilledStarCssClass="FilledStarCss" StarCssClass="StarCss" WaitingStarCssClass="WaitingStarCss" OnChanged="Rating1_Changed" CurrentRating="0"></cc1:Rating>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>    
        </div>
</asp:Content>
