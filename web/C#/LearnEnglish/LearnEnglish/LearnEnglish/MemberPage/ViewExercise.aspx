<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewExercise.aspx.cs" Inherits="LearnEnglish.MemberPage.ViewExercise" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>View Exercise</title>
    <style>
        .hideAnswer{
          
            display:none;
        }
        .gvExercise{
            width:45%;
        }
        .gvExercise td:first-child,.gvExercise td:nth-child(2){
            border:1px solid black;
        }
    </style>
    <link href="css/StyleSheet1.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div align="center">
            <h1 >Exercise</h1>
            <asp:Label ID="lblLevel" runat="server" Font-Size="Large"></asp:Label>
        </div>
        <div align="center" style="padding-bottom:20px">
            <asp:Label ID="Label1" runat="server"  Font-Bold="True" Font-Size="Large" ForeColor="Red" ></asp:Label>
            <asp:Label ID="lblCorrect" runat="server"  Font-Bold="True" ForeColor="Blue" Font-Size="Large"></asp:Label>
        </div>
        <asp:GridView ID="gvExercise" runat="server" AutoGenerateColumns="False"  ShowHeader="False" 
            CellPadding="4" ForeColor="#333333" align="center" CssClass="gvExercise" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField ItemStyle-VerticalAlign="top">
                    <ItemTemplate>
                         <%# Container.DataItemIndex + 1 %>   
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="hfQuesId" Value='<%# Eval ("QuesId") %>' runat="server" />
                        <div style="padding:7px">
                           <asp:Label runat="server" ID="lblQuestion" Text='<%# Eval ("Question") %>' /> <br />
                           <div style="padding:10px 10px 15px 10px">
                               <asp:Panel ID="pnlAnswer" runat="server" >
                                    <asp:HiddenField ID="hfRows" Value="<%# Container.DataItemIndex %> " runat="server" />
                                    <asp:RadioButton runat="server" GroupName="ans" ID="rbOptA" Text='<%# Eval ("OptA") %>' /> <br />  
                                    <asp:RadioButton runat="server" GroupName="ans" ID="rbOptB" Text='<%# Eval ("OptB") %>' /> <br />  
                                    <asp:RadioButton runat="server" GroupName="ans" ID="rbOptC" Text='<%# Eval ("OptC") %>' /> <br />  
                                    <asp:RadioButton runat="server" GroupName="ans" ID="rbOptD" Text='<%# Eval ("OptD") %>' /> <br />  
                                   <asp:CustomValidator ID="cvRequiredAnswer" runat="server" Display="dynamic" OnServerValidate="cvRequiredAnswer_ServerValidate"></asp:CustomValidator>
                               </asp:Panel>
                           </div>
                       </div>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate >
                        <asp:Label runat="server" Visible="true" ID="lblAnswer" Text='<%# Eval ("Answer") %>' CssClass="hideAnswer" /> <br />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:TemplateField>
                </Columns>
            </asp:GridView>
        <p>
            <table align="center">
                <tr>
                    <td><asp:Button ID="btnClear" runat="server"  Text="Clear" OnClick="btnClear_Click"  CausesValidation="False" /></td>
                    <td><asp:Button ID="btnCheckAnswer" runat="server"  Text="Check Answer" OnClick="btnCheckAnswer_Click" CausesValidation="True" /></td>
                </tr>
            </table>
        </p>
</asp:Content>
