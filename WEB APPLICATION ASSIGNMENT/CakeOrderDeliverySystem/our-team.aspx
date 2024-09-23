<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="our-team.aspx.cs" Inherits="CakeOrderDeliverySystem.out_team" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <form runat="server">

    <!--================End Main Header Area =================-->
    <section class="banner_area" style="margin-top: 100px;">
       	<div class="container">
       		<div class="banner_text">
       			<h3>Our Bakers</h3><br />
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
    
    <!--================End Client Says Area =================-->
    <section class="our_chef_area p_100">
       	<div class="container">
       		<div class="row our_chef_inner">
       			<div class="col-lg-3">
       				<div class="chef_text_item">
       					<div class="main_title">
							<h2>Our Bakers</h2>
                            <p>Meet our talented team of chefs who bring passion and expertise to every dish they create. With years of experience and a commitment to culinary excellence, our chefs are dedicated to delighting your taste buds.</p>						</div>
       				</div>
       			</div>
       			<div class="col-lg-3 col-6">
       				<div class="chef_item">
       					<div class="chef_img">
       						<img class="img-fluid" src="img/chef/chef-1.jpg" alt="">
       						<ul class="list_style">
       							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
       							<li><a href="#"><i class="fa fa-linkedin-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-facebook-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-skype"></i></a></li>
       						</ul>
       					</div>
       					<a href="#"><h4>Michale Joe</h4></a>
       					<h5>Expert in Cake Making</h5>
       				</div>
       			</div>
       			<div class="col-lg-3 col-6">
       				<div class="chef_item">
       					<div class="chef_img">
       						<img class="img-fluid" src="img/chef/chef-2.jpg" alt="">
       						<ul class="list_style">
       							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
       							<li><a href="#"><i class="fa fa-linkedin-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-facebook-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-skype"></i></a></li>
       						</ul>
       					</div>
       					<a href="#"><h4>Michale Joe</h4></a>
       					<h5>Expert in Cake Making</h5>
       				</div>
       			</div>
       			<div class="col-lg-3 col-6">
       				<div class="chef_item">
       					<div class="chef_img">
       						<img class="img-fluid" src="img/chef/chef-3.jpg" alt="">
       						<ul class="list_style">
       							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
       							<li><a href="#"><i class="fa fa-linkedin-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-facebook-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-skype"></i></a></li>
       						</ul>
       					</div>
       					<a href="#"><h4>Michale Joe</h4></a>
       					<h5>Expert in Cake Making</h5>
       				</div>
       			</div>
       			<div class="col-lg-3 hide">
       			</div>
       			<div class="col-lg-3 col-6">
       				<div class="chef_item">
       					<div class="chef_img">
       						<img class="img-fluid" src="img/chef/chef-1.jpg" alt="">
       						<ul class="list_style">
       							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
       							<li><a href="#"><i class="fa fa-linkedin-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-facebook-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-skype"></i></a></li>
       						</ul>
       					</div>
       					<a href="#"><h4>Michale Joe</h4></a>
       					<h5>Expert in Cake Making</h5>
       				</div>
       			</div>
       			<div class="col-lg-3 col-6">
       				<div class="chef_item">
       					<div class="chef_img">
       						<img class="img-fluid" src="img/chef/chef-2.jpg" alt="">
       						<ul class="list_style">
       							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
       							<li><a href="#"><i class="fa fa-linkedin-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-facebook-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-skype"></i></a></li>
       						</ul>
       					</div>
       					<a href="#"><h4>Michale Joe</h4></a>
       					<h5>Expert in Cake Making</h5>
       				</div>
       			</div>
       			<div class="col-lg-3 col-6">
       				<div class="chef_item">
       					<div class="chef_img">
       						<img class="img-fluid" src="img/chef/chef-3.jpg" alt="">
       						<ul class="list_style">
       							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
       							<li><a href="#"><i class="fa fa-linkedin-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-facebook-square"></i></a></li>
       							<li><a href="#"><i class="fa fa-skype"></i></a></li>
       						</ul>
       					</div>
       					<a href="#"><h4>Michale Joe</h4></a>
       					<h5>Expert in Cake Making</h5>
       				</div>
       			</div>
       		</div>
       	</div>
    </section>
    <!--================End Client Says Area =================-->
     </form>

</asp:Content>
