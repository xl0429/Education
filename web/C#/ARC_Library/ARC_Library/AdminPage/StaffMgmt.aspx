<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StaffMgmt.aspx.cs" Inherits="ARC_Library.AdminPage.StaffMgmt" %>
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
            <td><asp:ImageButton ID="imgBtnSearch" CssClass="imgBtnSearch" runat="server" ImageUrl="~/img/search.png"  CausesValidation="false"/></td>
        </tr>
    </table>
    
    <div style="height:40px">
        <div runat="server" ID="banner" ClientID="banner" class="info" visible="false"></div>
    </div>        

    <asp:ValidationSummary ID="ValidationSummary1" runat="server"  Width="50%" ForeColor="Red" BorderColor="Red" BackColor="#FFCCCC" BorderStyle="Solid" BorderWidth="1px" DisplayMode="List"  />
    <asp:ValidationSummary ID="ValidationSummary2" display="dynamic" ValidationGroup="vsInsert" runat="server" Width="50%" ForeColor="Red" BorderColor="Red" BackColor="#FFCCCC" BorderStyle="Solid" BorderWidth="1px" DisplayMode="List"  />
    </div>
    <asp:GridView ID="gvStaff" runat="server" CssClass="gridview" AutoGenerateColumns="False" AllowPaging="True"  Width="95%" 
        DataKeyNames="StaffId" OnRowEditing="gvStaff_RowEditing" OnPageIndexChanging="gvStaff_PageIndexChanging" OnRowCancelingEdit="gvStaff_RowCancelingEdit" OnRowDeleting="gvStaff_RowDeleting"
        OnRowUpdating="gvStaff_RowUpdating" OnRowCommand="gvStaff_RowCommand" OnRowDataBound="gvStaff_RowDataBound">
          <Columns >
           <asp:TemplateField>
                <ItemTemplate>
                 <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("StaffId") %>'></asp:Label>
              </ItemTemplate>
              <HeaderTemplate >
                <p>Staff Id</p> 
                <div><asp:Button ID="btnInsert" runat="server" CommandName="ADD" Text="Insert" ></asp:Button></div>
              </HeaderTemplate>
              <ItemStyle Width="10%" HorizontalAlign="Center"></ItemStyle>
           </asp:TemplateField>

            <asp:TemplateField>
                <EditItemTemplate>
                        <asp:TextBox ID="txtUsername" ClientIDMode="AutoID"  Autofocus="True" Width="78%" runat="server" MaxLength="50" Text='<%# Eval("Username") %>'  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ErrorMessage="[Username] is required" Title="[Username] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1"  ControlToValidate="txtUsername" Display="Dynamic" CssClass="error" runat="server" ErrorMessage="[Username] only contains letters, numbers, @, _,~ ,# with length > 6" ValidationExpression="[a-zA-Z0-9_@~#]{6,}">*</asp:RegularExpressionValidator>        

                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblUsername" runat="server" Text='<%# Eval("Username") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderTemplate>
                      <p>Username</p> 
                     <asp:TextBox ID="txt_Username" Width="78%" MaxLength="50" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator2" runat="server"  Display="Dynamic" ControlToValidate="txt_Username" ErrorMessage="[Username] is required" Title="[Username] is required"  CssClass="error">*</asp:RequiredFieldValidator>
                     <asp:CustomValidator ID="cvUserNameExist" runat="server"  ControlToValidate="txt_Username" ErrorMessage="[Username] is existed" Title="[Username] is existed" Display="Dynamic" CssClass="error" OnServerValidate="cvUserNameExist_ServerValidate">*</asp:CustomValidator>                   
                   </HeaderTemplate>
                    <ItemStyle Width="14%"></ItemStyle>
            </asp:TemplateField> 

            <asp:TemplateField>
                <EditItemTemplate>
                        <asp:TextBox ID="txtPassword" TextMode="Password" Width="83%" runat="server"  MaxLength="100" Text='<%# Eval("Hash") %>' ></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtPassword"  ID="RequiredFieldValidator3" runat="server" ErrorMessage="[Password] is required"  Title="[Password] is required"  Display="Dynamic" CssClass="error" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rePassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="[Password]  only contains letters, numbers, @, _,~ ,# with length > 6" Title="[Password]  only contains letters, numbers, @, _,~ ,# with length > 6" Display="Dynamic" CssClass="error" ValidationExpression="[a-zA-Z0-9_@~#]{6,}">*</asp:RegularExpressionValidator>    
                </EditItemTemplate>
                
                    <ItemTemplate>
                        <asp:Label ID="lblPassword" runat="server" Text=' --- '></asp:Label>
                    </ItemTemplate>
                    <HeaderTemplate>
                      <p>Password</p> 
                     <asp:TextBox ID="txt_Password" TextMode="Password" Width="83%" runat="server"   MaxLength="100" ></asp:TextBox>
                     <asp:RequiredFieldValidator ValidationGroup="vsInsert" ControlToValidate="txt_Password"  ID="RequiredFieldValidator4" runat="server" ErrorMessage="[Password] is required"  Title="[Password] is required"  Display="Dynamic" CssClass="error" >*</asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="rePassword2" ValidationGroup="vsInsert" runat="server" ControlToValidate="txt_Password" ErrorMessage="[Password]  only contains letters, numbers, @, _,~ ,# with length > 6" Title="[Password]  only contains letters, numbers, @, _,~ ,# with length > 6" Display="Dynamic" CssClass="error" ValidationExpression="[a-zA-Z0-9_@~#]{6,}">*</asp:RegularExpressionValidator>    
                   </HeaderTemplate>
					<ItemStyle Width="18%" HorizontalAlign="Center"></ItemStyle>
            </asp:TemplateField>

            <asp:TemplateField>
                <EditItemTemplate>
                        <asp:TextBox ID="txtEmail"  Width="85%"  runat="server" MaxLength="50" Text='<%# Eval("Email") %>'></asp:TextBox>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEmail" Title='[Email] is required' ErrorMessage="[Email] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator  ID="reEmail" runat="server"  ControlToValidate="txtEmail" Title='[Email] format is invalid eg. abc@gmail.com' ErrorMessage="[Email] format is invalid eg. abc@gmail.com" Display="Dynamic" CssClass="error"  ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                    </ItemTemplate>
                     <HeaderTemplate>
                      <p>Email</p> 
                     <asp:TextBox ID="txt_Email" Width="85%" MaxLength="50" runat="server"></asp:TextBox>
                         <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ControlToValidate="txt_Email" ErrorMessage="[Email] is required" Title="[Email] is required" CssClass="error upper">*</asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator ValidationGroup="vsInsert" ID="re_Email" runat="server"  ControlToValidate="txt_Email" Title='[Email] format is invalid eg. abc@gmail.com' ErrorMessage="[Email] format is invalid eg. abc@gmail.com" Display="Dynamic" CssClass="error"  ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator></EditItemTemplate>
                     </HeaderTemplate>
                    <ItemStyle Width="20%"></ItemStyle>

            </asp:TemplateField>
            <asp:TemplateField>
                <EditItemTemplate>
                        <asp:TextBox ID="txtContactNo"  Width="80%"  runat="server" MaxLength="12" Text='<%# Eval("ContactNo") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtContactNo" Title='[Email] is required' ErrorMessage="[Email] is required" Display="Dynamic" CssClass="error">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator  ID="reContactNo" runat="server"  ControlToValidate="txtContactNo" Title='[Contact No]format is invalid eg. 012-1234567' ErrorMessage="[Contact No] format is invalid eg. 012-1234567" Display="Dynamic" CssClass="error"  ValidationExpression="01[0-9]-[0-9]{7,8}">*</asp:RegularExpressionValidator>
                </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblContactNo" runat="server" Text='<%# Eval("ContactNo") %>'></asp:Label>
                    </ItemTemplate>
                     <HeaderTemplate>
                      <p>Contact No</p> 
                     <asp:TextBox ID="txt_ContactNo" Width="80%" MaxLength="12" runat="server"></asp:TextBox>
                      <asp:RequiredFieldValidator ValidationGroup="vsInsert" ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ControlToValidate="txt_ContactNo" ErrorMessage="[Email] is required" Title="[Email] is required" CssClass="error upper">*</asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ValidationGroup="vsInsert" ID="re_ContactNo" runat="server"  ControlToValidate="txt_ContactNo" Title='[Contact No] format is invalid eg. 012-1234567' ErrorMessage="[Contact No] format is invalid eg. 012-1234567" Display="Dynamic" CssClass="error" ValidationExpression="01[0-9]-[0-9]{7,8}">*</asp:RegularExpressionValidator></EditItemTemplate>
                     
                     </HeaderTemplate>
                    <ItemStyle Width="16%"></ItemStyle>

            </asp:TemplateField>
          
          
            <asp:CommandField ShowEditButton="true" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="14%" />

            <asp:TemplateField> 
                <ItemTemplate >   
                    <asp:LinkButton ID="lbtnDelete" runat="server" OnClientClick="return confirm('A0002 will be replaced to handle all loans by this staff, confirm to Delete ?');" CommandName="Delete">
                        <img src="../img/delete.png" style="height:16px; width:16px;" />Delete 
                    </asp:LinkButton> 

                </ItemTemplate> 
                <ItemStyle HorizontalAlign="Center" Width="3%"></ItemStyle>
            </asp:TemplateField>
            
        </Columns>
        <PagerStyle CssClass="pager" HorizontalAlign="Center" />
        <RowStyle />
    </asp:GridView>


   
    <asp:Label ID="Label1" runat="server" Text="No record is found." Visible="false"></asp:Label>
    <p style="padding-top:30px"><asp:Button ID="btnRefresh" runat="server" Text="Refresh" OnClick="btnRefresh_Click" CausesValidation="False" /></p>
</asp:Content>