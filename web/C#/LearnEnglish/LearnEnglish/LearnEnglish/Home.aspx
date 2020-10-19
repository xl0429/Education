<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LearnEnglish.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>LearnEnglish Index</title>
    <style>
        h3{
            padding: 30px 5px 15px 0px;
        }
        .lblDesc{
            text-align:justify;

        }
        .bgSlider{
            border: 1px solid grey;
        }
        .liBanner{
            padding:2px;
            border: 1px solid black;

        }
        .liBanner:hover{
            background-color:red;
            padding:2px;
            border: 1px solid black;
        }
      
    </style>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators" >
          <li class="active liBanner" data-target="#carouselExampleIndicators" data-slide-to="0" ></li>
          <li class="liBanner"  data-target="#carouselExampleIndicators" data-slide-to="1" ></li>
          <li class="liBanner" data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner" role="listbox">
          <!-- Slide One - Set the background image for this slide in the line below -->
          <div onclick="window.location.href='About.aspx';" class="carousel-item active bgSlider" style="cursor: pointer; background-image: url(images/welcome.jpg); ">
            <div class="carousel-caption d-none d-md-block">
            </div>
          </div>
          <!-- Slide Two - Set the background image for this slide in the line below -->
          
            <div onclick="window.location.href='MemberPage/ViewExercise.aspx?Level=L01';" class="carousel-item bgSlider" style="cursor: pointer; background-image: url(images/grammar.jpg)">
              <div class="carousel-caption d-none d-md-block">
            </div>              
          </div>
              
          <!-- Slide Three - Set the background image for this slide in the line below -->
          <div onclick="window.location.href='GrammarList.aspx';" class="carousel-item bgSlider" style="cursor: pointer; background-image: url('images/exercise.jpg')">
              <div class="carousel-caption d-none d-md-block">
            </div>
          </div>
        </div>
        <a style="background-color:#efefef;  opacity: 0.4;" class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a style="background-color:#efefef;  opacity: 0.4;" class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only" >Next</span>
        </a>
      </div>
        <!-- Page Content -->

    <h1 class="my-4" style="text-align: center; color:darkblue; text-decoration:overline underline; font-weight:bold">Welcome to LearnEnglish</h1>
    <h3>Popular Grammar Article</h3>
      <!-- Portfolio Section -->
      <div class="row">
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title">
                  <asp:HyperLink ID="hlTop1" runat="server"></asp:HyperLink>
              </h4>
              <p class="card-text"><asp:Label ID="lblDesc1" runat="server" Text="Label" CssClass="lblDesc"></asp:Label></p>
            </div>
          </div>
        </div>
       
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title">
                  <asp:HyperLink ID="hlTop2" runat="server"></asp:HyperLink>
              </h4>
              <p class="card-text"><asp:Label ID="lblDesc2" runat="server" Text="Label" CssClass="lblDesc"></asp:Label></p>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-sm-6 portfolio-item">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title">
                  <asp:HyperLink ID="hlTop3" runat="server"></asp:HyperLink>
              </h4>
              <p class="card-text"><asp:Label ID="lblDesc3" runat="server" Text="Label" CssClass="lblDesc"></asp:Label></p>
            </div>
          </div>
        </div>
        
      <!-- /.row -->

      <hr>
    </div>
         <h3>Exercise</h3>

         <!-- Marketing Icons Section -->
      <div class="row">
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <h4 class="card-header">Beginner</h4>
            <div class="card-body">
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
            </div>
            <div class="card-footer">
              <a href="/MemberPage/ViewExercise.aspx?Level=l01"  class="btn btn-primary">Learn More</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <h4 class="card-header">Intermediate</h4>
            <div class="card-body">
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis ipsam eos, nam perspiciatis natus commodi similique totam consectetur praesentium </p>
            </div>
            <div class="card-footer">
              <a href="/MemberPage/ViewExercise.aspx?Level=l02"  class="btn btn-primary">Learn More</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <h4 class="card-header">Advanced</h4>
            <div class="card-body">
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente esse necessitatibus neque.</p>
            </div>
            <div class="card-footer">
              <a href="/MemberPage/ViewExercise.aspx?Level=l03" class="btn btn-primary">Learn More</a>
            </div>
          </div>
        </div>
      </div>
        <br/>
      <!-- /.row -->
    <!-- /.container -->
</asp:Content>
