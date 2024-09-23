<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="menuCustomer.aspx.cs" Inherits="CakeOrderDeliverySystem.Customer.menuCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
    <!--================End Main Header Area =================-->
	<section class="banner_area">
   		<div class="container">
      			<div class="banner_text">
      				<h3>Menu</h3>
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

	<!--================Recipe Menu list Area =================-->
	<section class="price_list_area p_100">
        <div class="container">
            <div class="price_list_inner">
                <div class="single_pest_title">
                    <h2>Our Price List</h2>
                    <p>
                        Savor the exquisite flavors of our premium baked goods, meticulously crafted with the finest ingredients. At CakeBakery Confectionery Shop, we are committed to making delightful desserts accessible to all. Delight in affordable luxury with our thoughtfully curated assortment of cakes, pastries, and more. Explore our offerings in the price list provided below.
                    </p>
                </div>
                <div class="row">
                    <div class="col-lg-10">
                        <div class="discover_item_inner" style="margin-left:20%;">
                            <asp:Repeater ID="ProductRepeater" runat="server">
                                <ItemTemplate>
                                    <div class="discover_item" style="max-width:1500px;">
                                        <h4><%# Eval("productName") %></h4>
                                        <p><%# Eval("ingredient") %> <span>$<%# Eval("price", "{0:N2}") %></span></p>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                <div class="row our_bakery_image">
                    <div class="col-md-4 col-6">
                        <img class="img-fluid" src="img/our-bakery/bakery-1.jpg" alt="">
                    </div>
                    <div class="col-md-4 col-6">
                        <img class="img-fluid" src="img/our-bakery/bakery-2.jpg" alt="">
                    </div>
                    <div class="col-md-4 col-6">
                        <img class="img-fluid" src="img/our-bakery/bakery-3.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>
	<!--================End Main Header Area =================-->
        </form>
</asp:Content>
