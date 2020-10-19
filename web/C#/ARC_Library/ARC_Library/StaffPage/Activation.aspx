<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Activation.aspx.cs" Inherits="ARC_Library.StaffPage.Activation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Account Activation</title>
    <link href="../css/borrowReturn.css" rel="stylesheet" />
    <link href="../css/site.css" rel="stylesheet" />
    <style>
        .tbActivation{
            border-collapse:collapse;
            margin:30px;
        }
        .tbActivation td{
            background-color:#e2dcdc;
            padding:5px;
            font-weight:bold;
            border:2px dotted black;
        }
        .tbActivation td:nth-child(2){
            background-color:#808080;
           
        }
         .tbActivation td:nth-child(3){
            background-color:unset;
            border:unset;
            position:absolute;
        }
         .gridview td:first-child{
             font-weight:200;
         }
         .gridview td:nth-child(2), .gridview td:nth-child(7){
             text-align:center;
         }
         .gridview td:nth-child(7), td:nth-child(8){
             text-align:right;
         }
    </style>

    <style>
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Account Activation</h3>
    <div style="height:20px">
    </div>
    <table class="tbActivation">
        <tr>
            <td>Email or Member Id  </td>
            <td><asp:TextBox ID="txtEmail" runat="server" autofocus="true"></asp:TextBox></td>
            <td>
                <asp:CustomValidator ID="cvMemberBlocked" runat="server" ErrorMessage="[Email or Member Id] is not blocked" CssClass="error" Display="Dynamic"></asp:CustomValidator>
                <asp:CustomValidator ID="cvMemberExist" runat="server" ControlToValidate="txtEmail" ErrorMessage="[Email or Member Id] is not existed" CssClass="error" Display="Dynamic" OnServerValidate="cvMemberExist_ServerValidate1"></asp:CustomValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtEmail" runat="server" ErrorMessage="[Email or Member Id] is required"  CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator></td>
        </tr>
    </table>
    <asp:HiddenField ID="hfMemberId" runat="server" />
    <asp:HiddenField ID="hfBookId" runat="server" />
    <asp:Button ID="btnActivate" runat="server" Text="Activate" OnClick="btnActivate_Click" />
    
    <div class="paddingtop"></div>
     <div runat="server" id="divPenalty" style="display:none">
         <asp:GridView ID="gvPenalty" runat="server" CssClass="gridview" AutoGenerateColumns="false">
             <Columns>
                 <asp:BoundField DataField="LoanId" HeaderText="Loan Id" ControlStyle-Font-Bold="false"/>
                 <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" DataFormatString="{0:dd/MM/yyyy}"/>
                 <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" DataFormatString="{0:dd/MM/yyyy}"/>
                 <asp:BoundField DataField="BookId" HeaderText="Book Id"/>
                 <asp:BoundField DataField="Title" HeaderText="Title"/>
                 <asp:BoundField DataField="OverdueDays" HeaderText="Overdue Days"/>
                 <asp:BoundField DataField="penaltyRate" HeaderText="Rate (RM)" />
        
                 <asp:BoundField DataField="Price" HeaderText="Price  (RM)" DataFormatString="{0:0.00}"/>
                
             </Columns>
         </asp:GridView>
       <div style="padding-top:20px; font-weight:700">
           <span style="background-color:lightgrey; padding:3px;">Amount to pay : RM <asp:Label ID="lblPrice" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label></span>
       </div>
         <asp:Label ID="lblFound" runat="server"></asp:Label>
        <br />
        <asp:CheckBox ID="chkException" runat="server" Text="Penalty Exception" Font-Bold="True" />
        <div>
        <asp:Button ID="btnPenaltyPaid" runat="server" Text="Penalty Paid" OnClick="btnPenaltyPaid_Click" />
    </div> 

 </div>
</asp:Content>
