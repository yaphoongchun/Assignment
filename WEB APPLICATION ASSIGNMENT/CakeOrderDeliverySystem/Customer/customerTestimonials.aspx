<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="customerTestimonials.aspx.cs" Inherits="CakeOrderDeliverySystem.Customer.customerTestimonials" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<form runat="server">
    <!--================End Main Header Area =================-->
	<section class="banner_area">
   		<div class="container">
      			<div class="banner_text">
      				<h3>Testimonials</h3>
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

	<!--================Testimonials item Area =================-->
    <section class="testimonials_item_area p_100">
        <div class="container">
            <div class="testi_item_inner">
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-1.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>The pastries from your bakery are absolutely divine! Each bite is a little taste of heaven. Thank you for creating such delicious treats.</p>
                        <h5>- Sarah Johnson</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-2.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>Your cakes are works of art! Not only are they beautiful to look at, but they taste incredible too. You've made our special occasions even more memorable.</p>
                        <h5>- Michael and Emily</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-1.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>I can't resist stopping by your bakery whenever I'm in the area. The smell alone is enough to draw me in, and the pastries never disappoint!</p>
                        <h5>- Thomas Anderson</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-2.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>Your bread is the best I've ever tasted. It's always fresh and full of flavor. I look forward to my weekly visit to your bakery.</p>
                        <h5>- Jessica Lee</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-1.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>Thank you for catering our event! The assortment of pastries and cakes was a hit with our guests. We'll definitely be using your services again.</p>
                        <h5>- David and Rachel</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-2.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>Your chocolate croissants are to die for! I've never tasted anything like them before. Keep up the fantastic work!</p>
                        <h5>- Emily Thompson</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-1.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>My wedding cake was absolutely stunning! Not only was it visually breathtaking, but it was also the most delicious cake I've ever had. Thank you for making our day so special.</p>
                        <h5>- Samantha and Mark</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-2.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>I recently tried your gluten-free options, and I was blown away by how delicious they were! Thank you for providing options for those with dietary restrictions.</p>
                        <h5>- Rebecca Davis</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-1.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>Your customer service is exceptional! The staff at your bakery are always friendly and helpful, making each visit a pleasure.</p>
                        <h5>- Jason Wilson</h5>
                    </div>
                </div>
                <div class="media">
                    <div class="d-flex">
                        <img src="../img/client/client-2.png" alt="">
                        <h3>“</h3>
                    </div>
                    <div class="media-body">
                        <p>I ordered a custom cake for my daughter's birthday, and it exceeded my expectations! Not only was it beautifully decorated, but it was also incredibly delicious. Thank you for making her day extra special.</p>
                        <h5>- Jennifer Martinez</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Testimonials item Area =================-->
	<!--================End Testimonials item Area =================-->
		</form>
</asp:Content>
