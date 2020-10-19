<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookList.aspx.cs" Inherits="ARC_Library.BookList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/css/site.css" rel="stylesheet" />
    <title>Book List</title>
    <style>
        .gridview{
            width:60%;
        }
        .info {
            background-color: #ddefc9;
            width: 100%;
            margin: 20px 0;
        }
        
    </style>
    <script>       setTimeout(function(){$('.info').animate({opacity:0});}, 5000);</script>
    <script src="../js/jquery2.1.1.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3>Book List</h3>
    <hr />
    <div style="height:40px">
        <div runat="server" ID="banner" ClientID="banner" class="info" visible="false"></div>
    </div>
    <table>
        <tr>
            <td><b>Category :  </b></td>
            <td>
                <asp:DropDownList ID="ddlCategory" AppendDataBoundItems="true" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                    <asp:ListItem Text="--Select One--" Value="0"></asp:ListItem>
                </asp:DropDownList></td>
        </tr>
    </table>
    <br />
     <table >
        <tr>
            <td style=" padding-right:0;" ><asp:TextBox ID="txtSearch" runat="server"  TextMode="Search" Placeholder="Search..." AutoPostBack="true" AutoFocus="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox></td>
            <td><asp:ImageButton ID="imgBtnSearch" CssClass="imgBtnSearch" runat="server" ImageUrl="~/img/search.png"  CausesValidation="false"  /></td>
        </tr>
    </table>
    <br />
    
    <asp:GridView ID="gvBook" CssClass="gridview" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="gvBook_PageIndexChanging" OnLoad="gvBook_Load" OnRowDataBound="gvBook_RowDataBound" OnRowCommand="gvBook_RowCommand">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate >
<asp:Image runat="server"   AlternateText="No cover found" ControlStyle-height="200px" ControlStyle-Width="150px" ImageUrl='<%#  Eval("Image", "~/img/Books/{0}.jpg") %>' >
            </asp:Image>                    <br />
                    <b><asp:Label ID="lblBookId" runat="server" Text='<%# Eval("BookId") %>'></asp:Label> <br /></b>
                    <i><asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>'></asp:Label></i>
                 </ItemTemplate>
                <ItemStyle width="200px" HorizontalAlign="center"/>
            </asp:TemplateField>

            <asp:BoundField DataField="Author" HeaderText="Author" ReadOnly="True">
            <ItemStyle Width="30%" HorizontalAlign="Center"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Publisher" HeaderText="Publisher" ReadOnly="True">
            <ItemStyle Width="25%" HorizontalAlign="Center"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Category" HeaderText="Category" ReadOnly="True">
            <ItemStyle Width="15%" HorizontalAlign="Center"></ItemStyle>
            </asp:BoundField>
          
           <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="btnReserve" runat="server" Text="Reserve" CommandName="Reserve"></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle Width="10%" HorizontalAlign="Center"></ItemStyle>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="Status" Text='<%# Eval("Status") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            </Columns>
        <PagerStyle CssClass="pager" HorizontalAlign="center"/>
    </asp:GridView>
    <p><asp:Label ID="lblFound" runat="server" Text="Label"></asp:Label></p>
    <p><asp:Button ID="btnBack" runat="server" Text="Refresh" OnClick="btnBack_Click"/></p>
</asp:Content>
