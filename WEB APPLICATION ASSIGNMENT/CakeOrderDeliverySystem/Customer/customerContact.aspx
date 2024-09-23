<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="customerContact.aspx.cs" Inherits="CakeOrderDeliverySystem.Customer.customerContact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<section class="banner_area">
	<div class="container">
		<div class="banner_text">
			<h3>Contact Us</h3>
			<ul>
				<li><a href="index.aspx">Home</a></li>
				<li><a href="single-blog.aspx">Contact Us</a></li>
			</ul>
		</div>
	</div>
</section>
<!--================End Main Header Area =================-->

<!--================Contact Form Area =================-->
<section class="contact_form_area p_100">
	<div class="container">
		<div class="main_title">
			<h2>Get In Touch</h2>
			<h5>Do you want to contact us kindly find us .</h5>
		</div>
		<div class="row">
			<div class="col-lg-7">
				<div class="mapouter">
					<div class="gmap_canvas"><iframe
							src="https://maps.google.com/maps?q=Tunku%20Abdul%20Rahman%20University%20of%20Management%20and%20Technology%20(TAR%20UMT)&amp;t=&amp;z=13&amp;ie=UTF8&amp;iwloc=&amp;output=embed"
							frameborder="0" scrolling="no" style="width: 680px; height: 530px;"></iframe>
						<style>
							.mapouter {
								position: relative;
								height: 530px;
								width: 680px;
								background: #fff;
							}

							.maprouter a {
								color: #fff !important;
								position: absolute !important;
								top: 0 !important;
								z-index: 0 !important;
							}
						</style><a href="https://blooketjoin.org/blooket-play/">blooket play</a>
						<style>
							.gmap_canvas {
								overflow: hidden;
								height: 530px;
								width: 680px
							}

							.gmap_canvas iframe {
								position: relative;
								z-index: 2
							}
						</style>
					</div>
				</div>

			</div>
			<div class="col-lg-4 offset-md-1">
				<div class="contact_details">
					<div class="contact_d_item">
						<h3>Address :</h3>
						<p>54B, Tailstoi Town 5238 <br /> La city, IA 522364</p>
					</div>
					<div class="contact_d_item">
						<h5>Phone : <a href="tell:+309653200">30-9653200</a></h5>
						<h5>Email : <a href="mailto:cakedelivery@gmail.com">interestingcakedelivery@gmail.com</a></h5>
					</div>
					<div class="contact_d_item">
						<h3>Opening Hours :</h3>
						<p>8:00 AM – 10:00 PM</p>
						<p>Monday – Sunday</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Contact Form Area =================-->
</asp:Content>

