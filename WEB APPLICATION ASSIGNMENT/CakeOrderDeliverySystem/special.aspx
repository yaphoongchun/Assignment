<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="special.aspx.cs" Inherits="CakeOrderDeliverySystem.special" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
    <!--================End Main Header Area =================-->
    <section class="banner_area">
   	    <div class="container">
      		    <div class="banner_text">
      			    <h3>Special</h3>
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

    <!--================Special Area =================-->
    <section class="special_area p_100">
   	    <div class="container">
      		    <div class="main_title">
      			    <h2>Special Item of our Bakery</h2>
      			    <h5>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</h5>
      		    </div>
      		    <div class="special_item_inner">
      			    <div class="specail_item">
				    <div class="row">
					    <div class="col-lg-4">
						    <div class="s_left_img">
							    <img class="img-fluid" src="img/special/special-1.png" alt="">
						    </div>
					    </div>
					    <div class="col-lg-8">
						    <div class="special_item_text">
							    <h4>Vanila Cake Cup</h4>
							    <p>Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi equatur uis autem vel eum.</p>
							    <a class="pink_btn" href="#">Purchase now</a>
						    </div>
					    </div>
				    </div>
      			    </div>
      			    <div class="specail_item">
				    <div class="row">
					    <div class="col-lg-6">
						    <div class="s_item_left">
							    <div class="main_title">
								    <h2>Ingredient in recipe</h2>
							    </div>
							    <ul class="list_style">
								    <li><a href="#">Chocolate puding  (50 gm)</a></li>
								    <li><a href="#">Vanilla  (30 gm)</a></li>
								    <li><a href="#">Fruite rasberry  (50 gm)</a></li>
								    <li><a href="#">Jam  (10 gm)</a></li>
								    <li><a href="#">Evporate milk (300 ml)</a></li>
							    </ul>
						    </div>
					    </div>
					    <div class="col-lg-6">
						    <div class="s_right_img">
							    <img class="img-fluid" src="img/special/special-2.png" alt="">
						    </div>
					    </div>
				    </div>
			    </div>
      		    </div>
   	    </div>
    </section>
    <!--================End Special Area =================-->

    <!--================Our Bakery Area =================-->
    <section class="our_bakery_area making_area">
   	    <div class="container">
      		    <div class="main_title">
      			    <h2>Process of Making</h2>
      			    <p>Podcasting operational change management inside of workflows to establish a framework. Taking seamless key performance indicators offline to maxi-mise the long tail. Keeping your eye on the ball while performing a deep dive on the start-up mentality to derive convergence on cross-platform integration.</p>
      			    <p>Collaboratively administrate empowered markets via plug-and-play networks. Dynamically procrastinate B2C users after installed base benefits. Dramatically visualize customer directed convergence without revolutionary ROI.</p>
      		    </div>
      		    <div class="row our_bakery_image">
      			    <div class="col-lg-4 col-6">
      				    <img class="img-fluid" src="img/our-bakery/bakery-1.jpg" alt="">
      			    </div>
      			    <div class="col-lg-4 col-6">
      				    <img class="img-fluid" src="img/our-bakery/bakery-2.jpg" alt="">
      			    </div>
      			    <div class="col-lg-4 col-6">
      				    <img class="img-fluid" src="img/our-bakery/bakery-3.jpg" alt="">
      			    </div>
      		    </div>
   	    </div>
    </section>
    <!--================End Our Bakery Area =================-->

    <!--================Newsletter Area =================-->
    <section class="newsletter_area">
   	    <div class="container">
      		    <div class="row newsletter_inner">
      			    <div class="col-lg-6">
      				    <div class="news_left_text">
      					    <h4>Join our Newsletter list to get all the latest offers, discounts and other benefits</h4>
      				    </div>
      			    </div>
      			    <div class="col-lg-6">
      				    <div class="newsletter_form">
					    <div class="input-group">
						    <input type="text" class="form-control" placeholder="Enter your email address">
						    <div class="input-group-append">
							    <button class="btn btn-outline-secondary" type="button">Subscribe Now</button>
						    </div>
					    </div>
      				    </div>
      			    </div>
      		    </div>
   	    </div>
    </section>
    <!--================End Newsletter Area =================-->
        </form>
</asp:Content>
