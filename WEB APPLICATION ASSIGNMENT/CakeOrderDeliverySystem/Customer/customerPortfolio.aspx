﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="customerPortfolio.aspx.cs" Inherits="CakeOrderDeliverySystem.Customer.customerPortfolio" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
    <!--================End Main Header Area =================-->
    <section class="banner_area">
      	    <div class="container">
      		    <div class="banner_text">
      			    <h3>Portfolio</h3>
                       <asp:Repeater runat="server" ID="MenuRepeater">
                            <HeaderTemplate>
                                <ul>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li><asp:HyperLink runat="server" NavigateUrl='<%# Eval("Url") %>' Text='<%# Eval("Text") %>' /></li>
                            </ItemTemplate>
                            <FooterTemplate>
                                </ul>
                            </FooterTemplate>
                        </asp:Repeater>
      		    </div>
      	    </div>
    </section>

    <!--================End Main Header Area =================-->

    <!--================Portfolio Area Area =================-->
    <section class="portfolio_area p_100">
   	    <div class="container">
      		    <div class="portfolio_filter">
			    <ul class="list_style">
				    <li class="active" data-filter="*"><a href="#">All</a></li>
				    <li data-filter=".cake"><a href="#">Cakes</a></li>
				    <li data-filter=".bakery"><a href="#">Bakery</a></li>
				    <li data-filter=".past"><a href="#">Pastries</a></li>
				    <li data-filter=".choco"><a href="#">Chocolates</a></li>
				    <li data-filter=".bread"><a href="#">Breads</a></li>
				                                
			    </ul>
		    </div>
     			    <div class="row grid_portfolio_area imageGallery1">
     				    <div class="col-md-4 col-6 cake bakery bread">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-1.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-1.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     				    <div class="col-md-4 col-6 bakery choco">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-2.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-2.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     				    <div class="col-md-4 col-6 cake choco">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-3.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-3.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     				    <div class="col-md-4 col-6 cake choco">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-4.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-4.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     				    <div class="col-md-4 col-6 bakery past bread">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-5.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-5.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     				    <div class="col-md-4 col-6 past choco">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-6.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-6.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     				    <div class="col-md-4 col-6 bakery bread">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-7.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-7.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     				    <div class="col-md-4 col-6 past bread">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-8.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-8.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     				    <div class="col-md-4 col-6 bakery past bread">
     					    <div class="portfolio_item">
     						    <div class="portfolio_img">
     							    <a class="light" href="../img/portfolio/portfolio-9.jpg">
     								    <img class="img-fluid" src="../img/portfolio/portfolio-9.jpg" alt="">
     							    </a>
     						    </div>
     						    <div class="portfolio_text">
     							    <a href="#"><h4>Chocolate Pastry</h4></a>
     						    </div>
     					    </div>
     				    </div>
     			    </div>
   	    </div>
    </section>
    <!--================End Portfolio Area Area =================-->
        </form>
</asp:Content>
