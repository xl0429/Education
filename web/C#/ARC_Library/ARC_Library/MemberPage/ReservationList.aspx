<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReservationList.aspx.cs" Inherits="ARC_Library.ReservationList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Reservation List</title>
    <link href="../css/site.css" rel="stylesheet" />

    <style>
        .btnCancel{
            background-color:#f16262;
            font-weight:bolder;
        }
        .btnCancel:hover{
            font-weight:bold;
            background-color:#f68484;
        }
        .info {
            background-color: #ddefc9;
            width: 100%;
            margin: 20px 0;
        }

    </style>
    <script>
         processConfirm = function() {
            var result = confirm("Are you sure you want to delete this?");
            if (!result) {
                return false; //cancel postback
            }
            return true; //perform postback
        }
        
       setTimeout(function(){$('.info').animate({opacity:0});}, 3000);
  
    </script>
    <script src="../js/jquery2.1.1.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h3>Reservation List</h3>
    <asp:Label runat="server" ID="lblCount"></asp:Label>
    <div style="height:40px">
        <div runat="server" ID="banner" ClientID="banner" class="info" visible="false"></div>
    </div>
    <input type="hidden" runat="server" id="confirm_value" name="confirm_value"/>
    <asp:GridView AllowPaging="true" ID="gvReservation" runat="server" AutoGenerateColumns="False" CssClass="gridview" OnLoad="gvReservation_Load" OnRowDataBound="gvReservation_RowDataBound" OnRowDeleting="gvReservation_RowDeleting" OnPageIndexChanging="gvReservation_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="ReservationId" HeaderText="Reservation Id" />
            <asp:BoundField DataField="ReserveDate" HeaderText="Reservation Date" />
            <asp:BoundField DataField="ReserveTime" HeaderText="Reservation Time" />
            <asp:BoundField DataField="BookId" HeaderText="Book Id" />
            <asp:BoundField DataField="Title" HeaderText="Book Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" />
            <asp:BoundField  DataField="Status"  HeaderText="Status" />
                <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Button ID="btnCancel" CssClass="btnCancel" Text="Cancel" runat="server" Visible="false" OnClientClick="return processConfirm();" CommandName="Delete"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="hfTitle" runat="server" />
    <asp:Label ID="Label1" runat="server"></asp:Label>

</asp:Content>
