<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="customerWhatWeMake.aspx.cs" Inherits="CakeOrderDeliverySystem.Customer.customerWhatWeMake" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
    <!--================End Main Header Area =================-->
    <section class="banner_area">
   	    <div class="container">
      		    <div class="banner_text">
      			    <h3>What We Make</h3>
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

    <!--================Service Offer Area =================-->
    <section class="service_offer_area p_100">
   	    <div class="container">
      		    <div class="main_title">
      			    <h2>What We Offer</h2>
      			    <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
      		    </div>
      		    <div class="row service_main_item_inner">
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-1.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-2.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-3.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-4.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-5.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-6.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-1.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-2.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      			    <div class="col-lg-4 col-sm-6">
      				    <div class="service_m_item">
      					    <div class="service_img_inner">
						    <div class="service_img">
							    <img class="rounded-circle" src="../img/service/service-3.png" alt="">
						    </div>
      					    </div>
      					    <div class="service_text">
      						    <a href="#"><h4>Valentines Day Cakes</h4></a>
      					    </div>
      				    </div>
      			    </div>
      		    </div>
   	    </div>
    </section>
    <!--================End Service Offer Area =================-->

    <!--================Bakery Video Area =================-->
    <section class="bakery_video_area">
   	    <div class="container">
      		    <div class="video_inner">
      			    <h3>Real Taste</h3>
      			    <p>A light, sour wheat dough with roasted walnuts and freshly picked rosemary, thyme, poppy seeds, parsley and sage</p>
      			    <div class="media">
      				    <div class="d-flex">
      					    <a class="popup-youtube" href="https://www.youtube.com/watch?v=SKIcixYAGhk"><i class="flaticon-play-button"></i></a>
      				    </div>
      				    <div class="media-body">
      					    <h5>Watch intro video <br />about us</h5>
      				    </div>
      			    </div>
      		    </div>
   	    </div>
    </section>
    <!--================End Bakery Video Area =================-->
        </form>
</asp:Content>
