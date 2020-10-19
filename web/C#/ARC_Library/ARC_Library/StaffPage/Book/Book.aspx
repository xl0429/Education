<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Book.aspx.cs" Inherits="ARC_Library.StaffPage.Book.Book" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Staff Book List</title>
    <link href="../../css/site.css" rel="stylesheet" />
    <style>
        .textOveflow{
                    overflow-wrap: break-word;
              word-wrap: break-word;
              hyphens: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Staff Book List</h3>
    <hr />
    <asp:LinqDataSource ID="dsBook" runat="server"  ContextTypeName="ARC_Library.ARCLibraryDataContext"  EntityTypeName="" Select="new (BookId, Title, Author, Publisher, Image)" OrderBy="RegisterDate Descending,BookId Descending" Where='Status!="Deleted"' TableName="Books" OnSelecting="dsBook_Selecting">
         <WhereParameters>
            <asp:QueryStringParameter Name="BookId" QueryStringField="BookId" />
        </WhereParameters>
    </asp:LinqDataSource>
    <table >
        <tr>
            <td style=" padding-right:0;" ><asp:TextBox ID="txtSearch" AutoPostBack="true" runat="server"  TextMode="Search" Placeholder="Search..." AutoFocus="true" OnTextChanged="txtSearch_TextChanged" MaxLength="50"></asp:TextBox></td>
            <td><asp:ImageButton ID="imgBtnSearch" CssClass="imgBtnSearch" runat="server" ImageUrl="~/img/search.png"  CausesValidation="false" OnClick="imgBtnSearch_Click"/></td>
        </tr>
    </table>

    <br />
        <asp:CheckBox ID="chkCategory" runat="server" Text="Select books with no category" Checked="false" OnCheckedChanged="chkCategory_CheckedChanged" AutoPostBack="true"/>

    <br />
    <asp:GridView ID="gvBook" Width="70%" CssClass="gridview" runat="server" AutoGenerateColumns="False" DataSourceID="dsBook" AllowPaging="True" PageSize="5" OnRowDataBound="gvBook_RowDataBound" OnPageIndexChanging="gvBook_PageIndexChanging">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate >
                    <asp:Image ID="Image2" runat="server" CssClass="cover-100 popup" Height="200px" Width="150px"  ImageUrl='<%# Eval("Image", "../../img/Books/{0}.jpg") %>' AlternateText="No cover found"  />
                    <br />
                    <b><asp:Label ID="Label1" runat="server" Text='<%# Eval("BookId") %>'></asp:Label> <br /></b>
                    <i><asp:Label ID="Label2"  width="40%" CssClass="textOveflow" runat="server" Text='<%# Eval("Title") %>'></asp:Label></i>
                 </ItemTemplate>
                <ItemStyle width="40%" HorizontalAlign="center"/>
            </asp:TemplateField>

            <asp:BoundField DataField="Author" HeaderText="Author" ReadOnly="True" SortExpression="Author" ItemStyle-HorizontalAlign="center" >
            <ItemStyle  CssClass="textOveflow" width="20%" HorizontalAlign="Center"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Publisher" HeaderText="Publisher" ReadOnly="True" SortExpression="Publisher" ItemStyle-HorizontalAlign="center" >
            <ItemStyle  CssClass="textOveflow" width="20%" HorizontalAlign="Center"></ItemStyle>
            </asp:BoundField>
            
            
            <asp:HyperLinkField DataNavigateUrlFields="BookId" DataNavigateUrlFormatString="UpdateBook.aspx?BookId={0}" Text="Update" ControlStyle-Width="3%" />
            <asp:HyperLinkField DataNavigateUrlFields="BookId" DataNavigateUrlFormatString="DeleteBook.aspx?BookId={0}" Text="Delete" ControlStyle-Width="3%" />
            <asp:HyperLinkField DataNavigateUrlFields="BookId" DataNavigateUrlFormatString="BookDetails.aspx?BookId={0}" Text="Details" ControlStyle-Width="3%" />
        </Columns>
        <PagerStyle CssClass="pager" HorizontalAlign="center"/>
    </asp:GridView>
    <p><asp:Label ID="lblFound" runat="server"></asp:Label></p>
    <p><asp:Button ID="btnBack" runat="server" Text="Refresh" OnClick="Back_Click" /></p>
</asp:Content>
