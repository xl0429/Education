<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Exercise.aspx.cs" Inherits="LearnEnglish.AdminPage.Exercise" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>Exercise</title>
    <style>
        .gridView{
            width:70%;
        }
        .gridView .pager table td{
            padding:0px;
        }

        .gridView .pager span{
            display:block;
            padding: 2px 5px;
            background-color: #190c87;
            color:#fff;
        }


        .gridView .pager a {
            display:block;
            padding:2px 5px;
            color:#190c87;
            text-decoration: none;
        }

        .gridView .pager span:hover{
            display:block;
            padding: 2px 5px;
            background-color: #2817bd;
            color:#fff;
        }
         .gridView .pager a:hover{
            display:block;
            padding:2px 5px;
            background-color: #79c4c4;
            color:#fff;
        }
       
    </style>
    <link href="../../css/StyleSheet1.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <asp:LinqDataSource ID="dsExercise" runat="server" ContextTypeName="LearnEnglish.LearnEnglishDataContext" EntityTypeName="" TableName="QuestionAnswers" Where="Level==@Level || @Level==null"> 
                <WhereParameters>
                    <asp:QueryStringParameter Name="Level" QueryStringField="Level" />
                </WhereParameters>
            </asp:LinqDataSource>
        <div>
            <h1 class="center">Exercise</h1>
            <p class="center" >
                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="?">All</asp:HyperLink> |
                <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="?Level=L01">Beginner</asp:HyperLink> |
                <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="?Level=L02">Intermediate</asp:HyperLink> |
                <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="?Level=L03">Advanced</asp:HyperLink>    
            </p>
            <p class="center" >
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Exercise.aspx">Exercise</asp:HyperLink> |
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="InsertExercise.aspx">Set Question</asp:HyperLink>
            </p>
            
          
            <div align="center">
            <asp:GridView ID="gvExercise" CssClass="gridView" runat="server" DataSourceID="dsExercise" ShowHeader="False" AllowPaging="True" 
                AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None" 
                BorderWidth="1px" CellPadding="4" PageSize="8" OnPageIndexChanging="gvExercise_PageIndexChanging1"  >
                <Columns>
                    <asp:BoundField  DataField="QuesId" HeaderText="Id" ReadOnly="True"  ItemStyle-VerticalAlign="Top">
                    <ItemStyle VerticalAlign="Top" Width="9%"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Answer" HeaderText="Answer" ReadOnly="True" ItemStyle-CssClass="visible" >
                    <ItemStyle CssClass="visible"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField>
                       <ItemTemplate> 
                            <div style="padding:10px">
                                <asp:Label runat="server" ID="lblQuestion" Text='<%# Eval ("Question") %>' /> <br />
                                <div style="padding:8px 10px">
                                    <asp:RadioButton runat="server" GroupName="ans" ID="rbOptA" Text='<%# Eval ("OptA") %>' /> <br />
                                    <asp:RadioButton runat="server" GroupName="ans" ID="rbOptB" Text='<%# Eval ("OptB") %>' /> <br />
                                    <asp:RadioButton runat="server" GroupName="ans" ID="rbOptC" Text='<%# Eval ("OptC") %>' /> <br />
                                    <asp:RadioButton runat="server" GroupName="ans" ID="rbOptD" Text='<%# Eval ("OptD") %>' /> <br />
                                </div>
                            </div>
                    </ItemTemplate>
                    </asp:TemplateField>
                   <asp:HyperLinkField DataNavigateUrlFields="QuesId" DataNavigateUrlFormatString="UpdateExercise.aspx?QuesId={0}" Text="Update" ItemStyle-HorizontalAlign="Center" >
                        <ItemStyle HorizontalAlign="Center" Width="15%"></ItemStyle>
                    </asp:HyperLinkField>
                    <asp:HyperLinkField DataNavigateUrlFields="QuesId" DataNavigateUrlFormatString="DeleteExercise.aspx?QuesId={0}" Text="Delete"  ItemStyle-HorizontalAlign="Center" >
                        <ItemStyle HorizontalAlign="Center" Width="15%"></ItemStyle>
                    </asp:HyperLinkField>
                </Columns>
                <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                <PagerStyle CssClass="pager" HorizontalAlign="center" BackColor="#FFFFCC" ForeColor="#330099" />
                <RowStyle BackColor="White" ForeColor="#330099" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                <SortedAscendingCellStyle BackColor="#FEFCEB" />
                <SortedAscendingHeaderStyle BackColor="#AF0101" />
                <SortedDescendingCellStyle BackColor="#F6F0C0" />
                <SortedDescendingHeaderStyle BackColor="#7E0000" />
            </asp:GridView>
            </div>
            <p class="center" style="padding-top:20px">
                <asp:Button ID="btnDone" runat="server" Text="Done" />
            </p>

        </div>
</asp:Content>
