<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ARC_Library.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home</title>
    <style>
    header.masthead {
      position: relative;
      background-color: #343a40;
      background: url("../img/library.jpg") no-repeat center center;
      background-size:cover;
      padding-top: 8rem;
      padding-bottom: 8rem;
      height: 110%;

    }

    header.masthead .overlay {
      position: absolute;
      background-color: #212529;
      height: 105%;
      width: 100%;
      top: 0;
      left: 0;
      opacity: 0.2;
    }

    header.masthead h1 {
      font-size: 2rem;
    }
    .outline{
        font-weight:700;
        text-shadow: -1px -1px 0 red, 3px -1px 0 red, -1px 3px 0 red, 3px 3px 0 red;
    }

    img.cover-100 {
        border: 1px solid #000;
        width: 180px;
        height: 200px;
    }

    .listView{
        min-width:230px;
        min-height:220px;
        display: inline-block;
        border: 1px solid #999;
        width:200px;
        padding:15px;
        margin: 0px 8px 8px 0px;
        text-align:center;
        text-decoration:none;
        background-color:#fffde1

    }

    .listView:hover{
        background-color:#fffba9;
        color:#fff;
    }

    .btnSearchForBook{
        padding:15px;
        color:white;
        background-color:darkblue;
        font-weight:bolder;
    }
    .btnSearchForBook:hover{
        background-color:darkslateblue;
    }
    .autocomplete-items {
      position: absolute;
      border: 1px solid #d4d4d4;
      border-bottom: none;
      border-top: none;
      z-index: 99;
      /*position the autocomplete items to be the same width as the container:*/
      top: 100%;
      left: 0;
      right: 0;
      width:100%;
    }

    .autocomplete-items div {
      padding: 10px;
      cursor: pointer;
      background-color: #fff; 
      border-bottom: 1px solid #d4d4d4;
      width:98%;
    }

    /*when hovering an item:*/
    .autocomplete-items div:hover {
      background-color: #e9e9e9; 
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Masthead -->
  <header class="masthead text-white text-center ">
    <div class="overlay"></div>
    <div class="container">
      <div class="row">
        <div class="col-xl-9 mx-auto">
          <h1 class="mb-5 outline">Welcome to ARC Library</h1>
        </div>
        <div class="col-md-10 col-lg-8 col-xl-7 mx-auto">
          
            <div class="form-row">
              <div class="col-12 col-md-9 mb-2 mb-md-0">
                  <div class="autocomplete" style="width:98%; text-align:center">
                  <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-lg" placeholder="Find a book..."></asp:TextBox>
              </div></div>
              <div class="col-12 col-md-3">
                <button type="submit" class="btn btn-block btn-lg btn-primary" runat="server" onserverclick="btnSearch_Click">Search</button>
              </div>
            </div>
        </div>
      </div>
    </div>
  </header>
    <div style="padding-top:100px">
        <h4 style="font-weight:bold">New Book Available:</h4>
        <hr />
        <asp:LinqDataSource ID="dsTopBook" runat="server" OnSelecting="dsTopBook_Selecting"></asp:LinqDataSource>
        <asp:ListView ID="lvBook"  runat="server" DataSourceID="dsTopBook" GroupItemCount="3">
            <LayoutTemplate>
                <div>
                    <asp:PlaceHolder ID="groupPlaceholder" runat="server" />
                </div>
           </LayoutTemplate>

            <GroupTemplate>
                <div>
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"/>
                </div>
            </GroupTemplate>
            <ItemTemplate>
                <a class="listView" href="BookDetails.aspx?BookId=<%# Eval("BookId") %>">
                    <img class="cover-100" src="<%# Eval("Image", "img/Books/{0}.jpg") %>" />

                </a>
            </ItemTemplate>
        </asp:ListView>
    </div>
    <div style="padding-top:80px"><h2 style="font-weight:900">Get Started</h2><asp:Button ID="btnSearchForBook" runat="server" Text="Search for Book" CssClass="btnSearchForBook" OnClick="Button1_Click"/></div>
</asp:Content>
