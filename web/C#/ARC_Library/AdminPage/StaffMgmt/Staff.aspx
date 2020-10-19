<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="ARC_Library.AdminPage.Staff.Staff" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="../../css/site.css" rel="stylesheet" />
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
    <script src="../../js/jquery2.1.1.min.js"></script>

    <title>Staff Management</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Staff Management</h3>
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
    
    <asp:GridView ID="gvStaff" CssClass="gridview" runat="server" AutoGenerateColumns="False" 
        AllowPaging="True"  Width="95%" RowStyle-Wrap="True" DataKeyNames="StaffId"
        OnRowEditing="gvStaff_RowEditing" OnPageIndexChanging="gvStaff_PageIndexChanging" OnRowCancelingEdit="gvStaff_RowCancelingEdit" OnRowDeleting="gvStaff_RowDeleting" 
        OnRowUpdating="gvStaff_RowUpdating" OnRowCommand="gvStaff_RowCommand" OnRowDataBound="gvStaff_RowDataBound">
        <Columns >
           <asp:TemplateField>
                <ItemTemplate>
                 <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("StaffId") %>'></asp:Label>
              </ItemTemplate>
              <HeaderTemplate >
                <p>CategoryId</p> 
                <div><asp:Button ID="btnInsert" runat="server" CommandName="ADD" Text="Insert" ></asp:Button></div>
              </HeaderTemplate>
              <ItemStyle Width="10%" HorizontalAlign="Center"></ItemStyle>
           </asp:TemplateField>

            <asp:TemplateField>
                <EditItemTemplate>
                        <asp:TextBox ID="txtUsername" ClientIDMode="AutoID"  Autofocus="True" Width="73%" runat="server" MaxLength="50" Text='<%# Eval("Username") %>'  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ErrorMessage="[Username] is required" Title="[Username] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2"  ControlToValidate="txtUsername" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Username] only contains letters, numbers, @, _,~ ,# with length > 6" ValidationExpression="[a-zA-Z0-9_@~#]{6,}"></asp:RegularExpressionValidator>        

                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblUsername" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderTemplate>
                      <p>Username</p> 
                     <asp:TextBox ID="txt_Username" Width="73%" MaxLength="50" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator5" runat="server"  Display="Dynamic" ControlToValidate="txt_Username" ErrorMessage="[Username] is required" Title="[Username] is required"  CssClass="error">*</asp:RequiredFieldValidator>
                     <asp:CustomValidator ID="cvUserNameExist" runat="server"  ControlToValidate="txt_Username" ErrorMessage="[Username] is existed" Title="[Username] is existed" Display="Dynamic" CssClass="error" OnServerValidate="cvUserNameExist_ServerValidate"></asp:CustomValidator>
                     <asp:RegularExpressionValidator ValidationGroup="vsInsert" ID="RegularExpressionValidator2"   ControlToValidate="txt_Username" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Username] only contains letters, numbers, @, _,~ ,# with length > 6" ValidationExpression="[a-zA-Z0-9_@~#]{6,}"></asp:RegularExpressionValidator>
                   </HeaderTemplate>
                    <ItemStyle Width="13%"></ItemStyle>
            </asp:TemplateField> 

            <asp:TemplateField>
                <EditItemTemplate>
                        <asp:TextBox ID="txtPassword" TextMode="Password" Width="88%" runat="server"  MaxLength="100" Text='<%# Eval("Password")  %>' ></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPassword" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderTemplate>
                      <p>Password</p> 
                     <asp:TextBox ID="txt_Password" TextMode="Password" Width="81%" runat="server"   MaxLength="100" ></asp:TextBox>
                   </HeaderTemplate>
					<ItemStyle Width="25%"></ItemStyle>
            </asp:TemplateField>

            <asp:TemplateField>
                <EditItemTemplate>
                        <asp:TextBox ID="txtEmail"  Width="67%"  runat="server" MaxLength="50" Text='<%# Eval("Email") %>'></asp:TextBox>
                        <span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" Title='[Email] is required' ErrorMessage="[Email] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator  ID="RegularExpressionValidator3" runat="server"  ControlToValidate="txtEmail" Title='[Email] format is invalid eg. abc@gmail.com' ErrorMessage="[Email] format is invalid eg. abc@gmail.com" Display="Dynamic" CssClass="error"  ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </span>
                </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                    </ItemTemplate>
                     <HeaderTemplate>
                      <p>Email</p> 
                     <asp:TextBox ID="txt_Email" Width="67%" MaxLength="50" runat="server"></asp:TextBox>
                     <span>
                         <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ControlToValidate="txt_Email" ErrorMessage="[Email] is required" Title="[Email] is required" CssClass="error upper">*</asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator ValidationGroup="vsInsert" ID="RegularExpressionValidator2" runat="server"  ControlToValidate="txt_Email" Title='[Email] format is invalid eg. abc@gmail.com' ErrorMessage="[Email] format is invalid eg. abc@gmail.com" Display="Dynamic" CssClass="error"  ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></EditItemTemplate>
                     </span>
                     </HeaderTemplate>
                    <ItemStyle Width="8%"></ItemStyle>

            </asp:TemplateField>
            <asp:TemplateField>
                <EditItemTemplate>
                        <asp:TextBox ID="txtContactNo"  Width="67%"  runat="server" MaxLength="50" Text='<%# Eval("Email") %>'></asp:TextBox>
                        <span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtContactNo" Title='[Email] is required' ErrorMessage="[Email] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator  ID="RegularExpressionValidator3" runat="server"  ControlToValidate="txtContactNo" Title='[Contact No]format is invalid eg. 012-1234567' ErrorMessage="[Contact No] format is invalid eg. 012-1234567" Display="Dynamic" CssClass="error"  ValidationExpression="01[0-9]-[0-9]{7,8}"></asp:RegularExpressionValidator>
                        </span>
                </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblContactNo" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                    </ItemTemplate>
                     <HeaderTemplate>
                      <p>Email</p> 
                     <asp:TextBox ID="txt_ContactNo" Width="67%" MaxLength="50" runat="server"></asp:TextBox>
                     <span>
                         <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ControlToValidate="txt_ContactNo" ErrorMessage="[Email] is required" Title="[Email] is required" CssClass="error upper">*</asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator ValidationGroup="vsInsert" ID="RegularExpressionValidator2" runat="server"  ControlToValidate="txt_ContactNo" Title='[Contact No] format is invalid eg. 012-1234567' ErrorMessage="[Contact No] format is invalid eg. 012-1234567" Display="Dynamic" CssClass="error" ValidationExpression="01[0-9]-[0-9]{7,8}"></asp:RegularExpressionValidator></EditItemTemplate>
                     </span>
                     </HeaderTemplate>
                    <ItemStyle Width="8%"></ItemStyle>

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
