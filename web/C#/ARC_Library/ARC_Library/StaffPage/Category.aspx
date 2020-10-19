<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="ARC_Library.Category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/site.css" rel="stylesheet" />
    <style>
        .error{
            color:transparent;
            cursor:pointer;
        }
        .gridview th {
            vertical-align: top;
        }
        .gridview  tr:first-child  p{
            height:40px;
            text-align: center;

        }
        .gridview  tr:first-child  div{
            text-align: center;

        }
        .info {
            background-color: #ddefc9;
            width: 100%;
            margin: 20px 0;
        }
    </style>
    <script>setTimeout(function () { $('.info').animate({ opacity: 0 }); }, 3000);</script>
    <script src="../js/jquery2.1.1.min.js"></script>

    <title>Book Category</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Book Category</h3>
    <hr style="padding-bottom:15px;"/>
    <div style="padding-bottom:30px">

    <table >
        <tr>
            <td style=" padding-right:0;" ><asp:TextBox ID="txtSearch" runat="server"  TextMode="Search" Placeholder="Search..." AutoFocus="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox></td>
            <td><asp:ImageButton ID="imgBtnSearch" CssClass="imgBtnSearch" runat="server" ImageUrl="~/img/search.png" OnClick="imgBtnSearch_Click" CausesValidation="false"/></td>
        </tr>
    </table>
    
    <div style="height:40px">
        <div runat="server" ID="banner" ClientID="banner" class="info" visible="false"></div>
    </div>        

    <asp:ValidationSummary ID="ValidationSummary1" runat="server"  Width="50%" ForeColor="Red" BorderColor="Red" BackColor="#FFCCCC" BorderStyle="Solid" BorderWidth="1px" DisplayMode="List"  />
    <asp:ValidationSummary ID="ValidationSummary2" display="dynamic" ValidationGroup="vsInsert" runat="server" Width="50%" ForeColor="Red" BorderColor="Red" BackColor="#FFCCCC" BorderStyle="Solid" BorderWidth="1px" DisplayMode="List"  />
    </div>
    
    <asp:GridView ID="gvCategory" CssClass="gridview" runat="server" AutoGenerateColumns="False" 
        AllowPaging="True"  Width="95%" RowStyle-Wrap="True" DataKeyNames="CategoryId"
        OnRowEditing="gvCategory_RowEditing" OnPageIndexChanging="gvCategory_PageIndexChanging" OnRowCancelingEdit="gvCategory_RowCancelingEdit" OnRowDeleting="gvCategory_RowDeleting" 
        OnRowUpdating="gvCategory_RowUpdating" OnRowCommand="gvCategory_RowCommand" OnRowDataBound="gvCategory_RowDataBound">
        <Columns >
           <asp:TemplateField>
                <ItemTemplate>
                 <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("CategoryId") %>'></asp:Label>
              </ItemTemplate>
              <HeaderTemplate >
                <p>CategoryId</p> 
                <div><asp:Button ID="btnInsert" runat="server" CommandName="ADD" Text="Insert" ></asp:Button></div>
              </HeaderTemplate>
              <ItemStyle Width="10%" HorizontalAlign="Center"></ItemStyle>
           </asp:TemplateField>

            <asp:TemplateField SortExpression="CategoryName">
                <EditItemTemplate>
                        <asp:TextBox ID="txtCatName" ClientIDMode="AutoID"  Autofocus="True" Width="73%" runat="server" MaxLength="30" Text='<%# Eval("CategoryName") %>'  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCatName" ErrorMessage="[Category Name] is required" Title="[Category Name] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCatName" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderTemplate>
                      <p>Category</p> 
                     <asp:TextBox ID="txt_CatName" Width="73%" MaxLength="30" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator5" runat="server"  Display="Dynamic" ControlToValidate="txt_CatName" ErrorMessage="[Category Name] is required"  Title="[Category Name] is required"  CssClass="error">*</asp:RequiredFieldValidator>
                     <asp:CustomValidator ID="cvCatNameExist" runat="server"  ControlToValidate="txt_CatName" ErrorMessage="[Category Name] is existed" Title="[Category Name] is existed" Display="Dynamic" CssClass="error" OnServerValidate="cvCatNameExist_ServerValidate">*</asp:CustomValidator>
                   </HeaderTemplate>
                    <ItemStyle Width="13%"></ItemStyle>
            </asp:TemplateField> 

            <asp:TemplateField HeaderText="Remark" SortExpression="Remark">
                <EditItemTemplate>
                        <asp:TextBox ID="txtRemark" TextMode="MultiLine" CssClass="abc" Width="90%" runat="server"  MaxLength="100" Text='<%# Eval("Remark")  %>' ></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblRemark" runat="server" Text='<%# Eval("Remark") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderTemplate>
                      <p>Remark</p> 
                     <asp:TextBox ID="txt_Remark" TextMode="MultiLine" Width="90%" MaxLength="100" runat="server"></asp:TextBox>
                   </HeaderTemplate>
					<ItemStyle Width="25%"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Abbreviation" SortExpression="Abbreviation">
                <EditItemTemplate>
                        <asp:TextBox ID="txtAbbreviation"  Width="67%" CssClass="upper" runat="server" MaxLength="3" Text='<%# Eval("Abbreviation") %>'></asp:TextBox>
                        <span><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAbbreviation" Title='[Abbreviation] is required' ErrorMessage="[Abbreviation] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"  ControlToValidate="txtAbbreviation" Title='[Abbreviation] is only 3 characters allowed' ErrorMessage="[Abbreviation] only characters allowed " Display="Dynamic" CssClass="error" ValidationExpression="[A-Za-z]{3}">*</asp:RegularExpressionValidator>
                        </span>
                </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblAbbreviation" runat="server"  CssClass="upper" Text='<%# Eval("Abbreviation") %>'></asp:Label>
                    </ItemTemplate>
                     <HeaderTemplate>
                      <p>Abbreviation</p> 
                     <asp:TextBox ID="txt_Abbreviation" Width="67%" CssClass="upper" MaxLength="3" runat="server"></asp:TextBox>
                     <span><asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ControlToValidate="txt_Abbreviation" ErrorMessage="[Abbreviation] is required" CssClass="error upper">*</asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ValidationGroup="vsInsert" ID="RegularExpressionValidator2" runat="server"  ControlToValidate="txt_Abbreviation" Title='[Abbreviation] is only 3 characters allowed' ErrorMessage="[Abbreviation] only characters allowed " Display="Dynamic" CssClass="error" ValidationExpression="[A-Za-z]{3}">*</asp:RegularExpressionValidator></EditItemTemplate>
                         </span>
                     </HeaderTemplate>
                    <ItemStyle Width="8%"></ItemStyle>

            </asp:TemplateField>
            <asp:TemplateField HeaderText="Penalty Rate" SortExpression="Abbreviation" >
                <EditItemTemplate>
                   <span> 
                    <asp:TextBox ID="txtPenaltyRate"  Width="50%" runat="server" MaxLength="5" Text='<%# Eval("PenaltyRate") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtPenaltyRate" Title='[Penalty Rate] is required' ErrorMessage="[Return Days] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" Type="Double" ControlToValidate="txtPenaltyRate" ErrorMessage="[Penalty Rate] is between 1.0-10.0" Title='[Penalty Rate] is between 1.0-10.0' Display="Dynamic" CssClass="error" MaximumValue="10" MinimumValue="1">*</asp:RangeValidator>
                    </span>    
                </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPenaltyRate" runat="server" Text='<%# Eval("PenaltyRate") %>'></asp:Label>
                    </ItemTemplate>
                   <HeaderTemplate>
                      <p>Penalty Rate</p> 
                      <asp:TextBox ID="txt_PenaltyRate"  Width="50%" MaxLength="5" runat="server" Text="1.00"></asp:TextBox>
                       <span> 
                        <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator10" runat="server" Display="Dynamic" ControlToValidate="txt_PenaltyRate" ErrorMessage="[Penalty Rate] is required" CssClass="error">*</asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator2" Type="Double" ValidationGroup="vsInsert" runat="server" ControlToValidate="txt_PenaltyRate" ErrorMessage="[Penalty Rate] is between 1.0-10.0" Title='[Penalty Rate] is between 1.0-10.0' Display="Dynamic" CssClass="error" MaximumValue="10" MinimumValue="1">*</asp:RangeValidator>
                       </span> 
                   </HeaderTemplate>
                    <ItemStyle Width="12%" ></ItemStyle>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Return Days" SortExpression="Abbreviation" >
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlReturnDays" Width="70%" Height="30px" runat="server"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlReturnDays" Title='[Return Days] is required' ErrorMessage="[Return Days] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                        <asp:HiddenField ID="hfReturnDays" runat="server" Value='<%# Eval("ReturnDays") %>'></asp:HiddenField>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblReturnDays" runat="server" Text='<%# Eval("ReturnDays") %>'></asp:Label>
                    </ItemTemplate>
                   <HeaderTemplate>
                      <p>Return Days</p>
                       <asp:DropDownList ID="ddl_ReturnDays" Height="30px" runat="server" Width="70%" ></asp:DropDownList>
                      <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ControlToValidate="ddl_ReturnDays" ErrorMessage="[Return Days] is required" CssClass="error">*</asp:RequiredFieldValidator>
                    </HeaderTemplate>
                    <ItemStyle Width="12%" HorizontalAlign="center"></ItemStyle>

            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="14%" />

            <asp:TemplateField> 
                <ItemTemplate >   
                    <asp:LinkButton ID="lbtnDelete" runat="server" OnClientClick="return confirm('Book with this category will be null, confirm to Delete ?');" CommandName="Delete">
                        <img src="../img/delete.png" style="height:16px; width:16px;" />Delete 
                    </asp:LinkButton> 

                </ItemTemplate> 
                <ItemStyle HorizontalAlign="Center" Width="3%"></ItemStyle>
            </asp:TemplateField>
            
        </Columns>
        <PagerStyle CssClass="pager" HorizontalAlign="Center" />
        <RowStyle />
        

        <SortedAscendingHeaderStyle CssClass="sort-asc" />
        <SortedDescendingHeaderStyle CssClass="sort-desc" />
    </asp:GridView>
    <asp:Label ID="Label1" runat="server" Text="No record is found." Visible="false"></asp:Label>
    <p style="padding-top:30px"><asp:Button ID="btnRefresh" runat="server" Text="Refresh" OnClick="btnRefresh_Click" CausesValidation="False" /></p>
    </asp:Content>
