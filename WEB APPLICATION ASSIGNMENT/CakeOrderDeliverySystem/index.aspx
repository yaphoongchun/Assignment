﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="CakeOrderDeliverySystem.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
    function showError(message) {
        alert(message); 
        return false;
    }

    function showSuccess(message) {
        alert(message); 
        return false;
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="index" runat="server">
    <!--================Slider Area =================-->
        <section class="main_slider_area">
            <div id="main_slider" class="rev_slider" data-version="5.3.1.6">
                <ul>
                    <li data-index="rs-1587" data-transition="fade" data-slotamount="default" data-hideafterloop="0" data-hideslideonmobile="off"  data-easein="default" data-easeout="default" data-masterspeed="300"  data-thumb="img/home-slider/slider-1.jpg"  data-rotate="0"  data-saveperformance="off"  data-title="Creative" data-param1="01" data-param2="" data-param3="" data-param4="" data-param5="" data-param6="" data-param7="" data-param8="" data-param9="" data-param10="" data-description="">
                    <!-- MAIN IMAGE -->
                    <img src="img/home-slider/slider-1.jpg"  alt="" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="5" class="rev-slidebg" data-no-retina>

                        <!-- LAYER NR. 1 -->
                        <div class="slider_text_box">
                            <div class="tp-caption tp-resizeme first_text" 
                            data-x="['left','left','left','15','15']" data-hoffset="['0','0','0','0']" 
                            data-y="['top','top','top','top']" data-voffset="['175','175','125','165','160']" 
                            data-fontsize="['65','65','65','40','30']"
                            data-lineheight="['80','80','80','50','40']"
                            data-width="['800','800','800','500']"
                            data-height="none"
                            data-whitespace="normal"
                            data-type="text" 
                            data-responsive_offset="on" 
                            data-frames="[{&quot;delay&quot;:10,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;0&quot;,&quot;from&quot;:&quot;y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;&quot;,&quot;mask&quot;:&quot;x:0px;y:0px;s:inherit;e:inherit;&quot;,&quot;to&quot;:&quot;o:1;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;},{&quot;delay&quot;:&quot;wait&quot;,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;999&quot;,&quot;to&quot;:&quot;y:[175%];&quot;,&quot;mask&quot;:&quot;x:inherit;y:inherit;s:inherit;e:inherit;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;}]"
                            data-textAlign="['left','left','left','left']">Quality Cake ... <br /> with sweet, eggs & breads</div>
                            
                            <div class="tp-caption tp-resizeme secand_text" 
                                data-x="['left','left','left','15','15']" data-hoffset="['0','0','0','0']" 
                                data-y="['top','top','top','top']" data-voffset="['345','345','300','300','250']"  
                                data-fontsize="['20','20','20','20','16']"
                                data-lineheight="['28','28','28','28']"
                                data-width="['640','640','640','640','350']"
                                data-height="none"
                                data-whitespace="normal"
                                data-type="text" 
                                data-responsive_offset="on"
                                data-transform_idle="o:1;"
                                data-frames="[{&quot;delay&quot;:10,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;0&quot;,&quot;from&quot;:&quot;y:[100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0;&quot;,&quot;mask&quot;:&quot;x:0px;y:[100%];s:inherit;e:inherit;&quot;,&quot;to&quot;:&quot;o:1;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;},{&quot;delay&quot;:&quot;wait&quot;,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;999&quot;,&quot;to&quot;:&quot;y:[175%];&quot;,&quot;mask&quot;:&quot;x:inherit;y:inherit;s:inherit;e:inherit;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;}]">Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit quia consequuntur magni dolores eos qui ratione
                            </div>
                            
                            <div class="tp-caption tp-resizeme slider_button" 
                                data-x="['left','left','left','15','15']" data-hoffset="['0','0','0','0']" 
                                data-y="['top','top','top','top']" data-voffset="['435','435','390','390','360']" 
                                data-fontsize="['14','14','14','14']"
                                data-lineheight="['46','46','46','46']"
                                data-width="none"
                                data-height="none"
                                data-whitespace="nowrap"
                                data-type="text" 
                                data-responsive_offset="on" 
                                data-frames="[{&quot;delay&quot;:10,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;0&quot;,&quot;from&quot;:&quot;y:[100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0;&quot;,&quot;mask&quot;:&quot;x:0px;y:[100%];s:inherit;e:inherit;&quot;,&quot;to&quot;:&quot;o:1;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;},{&quot;delay&quot;:&quot;wait&quot;,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;999&quot;,&quot;to&quot;:&quot;y:[175%];&quot;,&quot;mask&quot;:&quot;x:inherit;y:inherit;s:inherit;e:inherit;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;}]">
                                <a class="main_btn" href="menu.aspx">View the menu</a>
                            </div>
                        </div>
                    </li>
                    <li data-index="rs-1588" data-transition="fade" data-slotamount="default" data-hideafterloop="0" data-hideslideonmobile="off"  data-easein="default" data-easeout="default" data-masterspeed="300"  data-thumb="img/home-slider/slider-2.jpg"  data-rotate="0"  data-saveperformance="off"  data-title="Creative" data-param1="01" data-param2="" data-param3="" data-param4="" data-param5="" data-param6="" data-param7="" data-param8="" data-param9="" data-param10="" data-description="">
                    <!-- MAIN IMAGE -->
                    <img src="img/home-slider/slider-2.jpg"  alt="" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="5" class="rev-slidebg" data-no-retina>
                    <!-- LAYERS -->
                        <!-- LAYERS -->

                        <!-- LAYER NR. 1 -->
                        <div class="slider_text_box">
                            <div class="tp-caption tp-resizeme first_text" 
                            data-x="['left','left','left','15','15']" data-hoffset="['0','0','0','0']" 
                            data-y="['top','top','top','top']" data-voffset="['175','175','125','165','160']" 
                            data-fontsize="['65','65','65','40','30']"
                            data-lineheight="['80','80','80','50','40']"
                            data-width="['800','800','800','500']"
                            data-height="none"
                            data-whitespace="normal"
                            data-type="text" 
                            data-responsive_offset="on" 
                            data-frames="[{&quot;delay&quot;:10,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;0&quot;,&quot;from&quot;:&quot;y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;&quot;,&quot;mask&quot;:&quot;x:0px;y:0px;s:inherit;e:inherit;&quot;,&quot;to&quot;:&quot;o:1;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;},{&quot;delay&quot;:&quot;wait&quot;,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;999&quot;,&quot;to&quot;:&quot;y:[175%];&quot;,&quot;mask&quot;:&quot;x:inherit;y:inherit;s:inherit;e:inherit;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;}]"
                            data-textAlign="['left','left','left','left']">Cake Bakery ... <br /> make delicious products</div>
                            
                            <div class="tp-caption tp-resizeme secand_text" 
                                data-x="['left','left','left','15','15']" data-hoffset="['0','0','0','0']" 
                                data-y="['top','top','top','top']" data-voffset="['345','345','300','300','250']"  
                                data-fontsize="['20','20','20','20','16']"
                                data-lineheight="['28','28','28','28']"
                                data-width="['640','640','640','640','350']"
                                data-height="none"
                                data-whitespace="normal"
                                data-type="text" 
                                data-responsive_offset="on"
                                data-transform_idle="o:1;"
                                data-frames="[{&quot;delay&quot;:10,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;0&quot;,&quot;from&quot;:&quot;y:[100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0;&quot;,&quot;mask&quot;:&quot;x:0px;y:[100%];s:inherit;e:inherit;&quot;,&quot;to&quot;:&quot;o:1;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;},{&quot;delay&quot;:&quot;wait&quot;,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;999&quot;,&quot;to&quot;:&quot;y:[175%];&quot;,&quot;mask&quot;:&quot;x:inherit;y:inherit;s:inherit;e:inherit;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;}]">Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit quia consequuntur magni dolores eos qui ratione
                            </div>
                            
                            <div class="tp-caption tp-resizeme slider_button" 
                                data-x="['left','left','left','15','15']" data-hoffset="['0','0','0','0']" 
                                data-y="['top','top','top','top']" data-voffset="['435','435','390','390','360']" 
                                data-fontsize="['14','14','14','14']"
                                data-lineheight="['46','46','46','46']"
                                data-width="none"
                                data-height="none"
                                data-whitespace="nowrap"
                                data-type="text" 
                                data-responsive_offset="on" 
                                data-frames="[{&quot;delay&quot;:10,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;0&quot;,&quot;from&quot;:&quot;y:[100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0;&quot;,&quot;mask&quot;:&quot;x:0px;y:[100%];s:inherit;e:inherit;&quot;,&quot;to&quot;:&quot;o:1;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;},{&quot;delay&quot;:&quot;wait&quot;,&quot;speed&quot;:1500,&quot;frame&quot;:&quot;999&quot;,&quot;to&quot;:&quot;y:[175%];&quot;,&quot;mask&quot;:&quot;x:inherit;y:inherit;s:inherit;e:inherit;&quot;,&quot;ease&quot;:&quot;Power2.easeInOut&quot;}]">
                                <a class="main_btn" href="menu.aspx">View the menu</a>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </section>
        <!--================End Slider Area =================-->
        
        <!--================Welcome Area =================-->
        <section class="welcome_bakery_area">
        	<div class="container">
        		<div class="welcome_bakery_inner p_100">
        			<div class="row">
        				<div class="col-lg-6">
        					<div class="main_title">
								<h2>Welcome to our Bakery</h2>
								<p>Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur uis autem vel eum.</p>
							</div>
        					<div class="welcome_left_text">
        						<p>Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise.</p>
        						<a class="pink_btn" href="about-us.aspx">Know more about us</a>
        					</div>
        				</div>
        				<div class="col-lg-6">
        					<div class="welcome_img">
        						<img class="img-fluid" src="img/cake-feature/welcome-right.jpg" alt="">
        					</div>
        				</div>
        			</div>
        		</div>
        		<div class="cake_feature_inner">
        			<div class="main_title">
						<h2>Our Featured Cakes</h2>
						<h5> Seldolor sit amet consect etur</h5>
					</div>
       				<div class="cake_feature_slider owl-carousel">
       					<div class="item">
       						<div class="cake_feature_item">
       							<div class="cake_img">
       								<img src="img/cake-feature/c-feature-1.jpg" alt="">
       							</div>
       							<div class="cake_text">
       								<h4>$29</h4>
       								<h3>Strawberry Cupcakes</h3>
       								<a class="pest_btn" href="#">Add to cart</a>
       							</div>
       						</div>
       					</div>
       					<div class="item">
       						<div class="cake_feature_item">
       							<div class="cake_img">
       								<img src="img/cake-feature/c-feature-2.jpg" alt="">
       							</div>
       							<div class="cake_text">
       								<h4>$29</h4>
       								<h3>Strawberry Cupcakes</h3>
       								<a class="pest_btn" href="#">Add to cart</a>
       							</div>
       						</div>
       					</div>
       					<div class="item">
       						<div class="cake_feature_item">
       							<div class="cake_img">
       								<img src="img/cake-feature/c-feature-3.jpg" alt="">
       							</div>
       							<div class="cake_text">
       								<h4>$29</h4>
       								<h3>Strawberry Cupcakes</h3>
       								<a class="pest_btn" href="#">Add to cart</a>
       							</div>
       						</div>
       					</div>
       					<div class="item">
       						<div class="cake_feature_item">
       							<div class="cake_img">
       								<img src="img/cake-feature/c-feature-4.jpg" alt="">
       							</div>
       							<div class="cake_text">
       								<h4>$29</h4>
       								<h3>Strawberry Cupcakes</h3>
       								<a class="pest_btn" href="#">Add to cart</a>
       							</div>
       						</div>
       					</div>
       				</div>
        		</div>
        	</div>
        </section>
        <!--================End Welcome Area =================-->
        
        <!--================Special Recipe Area =================-->
        <section class="special_recipe_area">
        	<div class="container">
        		<div class="special_recipe_slider owl-carousel">
        			<div class="item">
        				<div class="media">
        					<div class="d-flex">
        						<img src="img/recipe/recipe-1.png" alt="">
        					</div>
        					<div class="media-body">
        						<h4>Special Recipe</h4>
        						<p>Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi equatur uis autem vel eum.</p>
        						<a class="w_view_btn" href="#">View Details</a>
        					</div>
        				</div>
        			</div>
        			<div class="item">
        				<div class="media">
        					<div class="d-flex">
        						<img src="img/recipe/recipe-1.png" alt="">
        					</div>
        					<div class="media-body">
        						<h4>Special Recipe</h4>
        						<p>Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi equatur uis autem vel eum.</p>
        						<a class="w_view_btn" href="#">View Details</a>
        					</div>
        				</div>
        			</div>
        			<div class="item">
        				<div class="media">
        					<div class="d-flex">
        						<img src="img/recipe/recipe-1.png" alt="">
        					</div>
        					<div class="media-body">
        						<h4>Special Recipe</h4>
        						<p>Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi equatur uis autem vel eum.</p>
        						<a class="w_view_btn" href="#">View Details</a>
        					</div>
        				</div>
        			</div>
        			<div class="item">
        				<div class="media">
        					<div class="d-flex">
        						<img src="img/recipe/recipe-1.png" alt="">
        					</div>
        					<div class="media-body">
        						<h4>Special Recipe</h4>
        						<p>Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi equatur uis autem vel eum.</p>
        						<a class="w_view_btn" href="#">View Details</a>
        					</div>
        				</div>
        			</div>
        		</div>
        	</div>
        </section>
        <!--================End Special Recipe Area =================-->
        
        <!--================Service Area =================-->
        <section class="service_area">
        	<div class="container">
        		<div class="single_w_title">
        			<h2>Main Services We Provide</h2>
        		</div>
        		<div class="row service_inner">
        			<div class="col-lg-4 col-6">
        				<div class="service_item">
        					<i class="flaticon-food-2"></i>
        					<h4>Celebration Cakes</h4>
        					<p>Duis aute irure dolor in reprehenderit in volup tate velit esse cillum dolore.</p>
        				</div>
        			</div>
        			<div class="col-lg-4 col-6">
        				<div class="service_item">
        					<i class="flaticon-food-1"></i>
        					<h4>Celebration Cakes</h4>
        					<p>Duis aute irure dolor in reprehenderit in volup tate velit esse cillum dolore.</p>
        				</div>
        			</div>
        			<div class="col-lg-4 col-6">
        				<div class="service_item">
        					<i class="flaticon-food"></i>
        					<h4>Celebration Cakes</h4>
        					<p>Duis aute irure dolor in reprehenderit in volup tate velit esse cillum dolore.</p>
        				</div>
        			</div>
        		</div>
        	</div>
        </section>
        <!--================End Service Area =================-->
        
        <!--================Discover Menu Area =================-->
        <section class="discover_menu_area">
        	<div class="discover_menu_inner">
        		<div class="container">
        			<div class="main_title">
						<h2>Discover Menu</h2>
						<h5>Duis aute irure dolor in reprehenderit voluptate</h5>
					</div>
       				<div class="row">
       					<div class="col-lg-6">
       						<div class="discover_item_inner">
       							<div class="discover_item">
									<h4>Double Chocolate Pie</h4>
									<p>Chocolate puding, vanilla, fruite rasberry jam milk <span>$8.99</span></p>
								</div>
       							<div class="discover_item">
									<h4>Double Chocolate Pie</h4>
									<p>Chocolate puding, vanilla, fruite rasberry jam milk <span>$8.99</span></p>
								</div>
       							<div class="discover_item">
									<h4>Double Chocolate Pie</h4>
									<p>Chocolate puding, vanilla, fruite rasberry jam milk <span>$8.99</span></p>
								</div>
       							<div class="discover_item">
									<h4>Double Chocolate Pie</h4>
									<p>Chocolate puding, vanilla, fruite rasberry jam milk <span>$8.99</span></p>
								</div>
       						</div>
       					</div>
       					<div class="col-lg-6">
       						<div class="discover_item_inner">
       							<div class="discover_item">
									<h4>Double Chocolate Pie</h4>
									<p>Chocolate puding, vanilla, fruite rasberry jam milk <span>$8.99</span></p>
								</div>
       							<div class="discover_item">
									<h4>Double Chocolate Pie</h4>
									<p>Chocolate puding, vanilla, fruite rasberry jam milk <span>$8.99</span></p>
								</div>
       							<div class="discover_item">
									<h4>Double Chocolate Pie</h4>
									<p>Chocolate puding, vanilla, fruite rasberry jam milk <span>$8.99</span></p>
								</div>
       							<div class="discover_item">
									<h4>Double Chocolate Pie</h4>
									<p>Chocolate puding, vanilla, fruite rasberry jam milk <span>$8.99</span></p>
								</div>
       						</div>
       					</div>
       				</div>
        		</div>
        	</div>
        </section>
        <!--================End Discover Menu Area =================-->
        
        <!--================Client Says Area =================-->
        <section class="client_says_area p_100">
        	<div class="container">
        		<div class="client_says_inner">
        			<div class="c_says_title">
        				<h2>What Our Client Says</h2>
        			</div>
        			<div class="client_says_slider owl-carousel">
        				<div class="item">
        					<div class="media">
        						<div class="d-flex">
        							<img src="img/client/client-1.png" alt="">
        							<h3>“</h3>
        						</div>
        						<div class="media-body">
        							<p>Osed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci sed quia non numquam qui ratione voluptatem sequi nesciunt. Neque porro quisquam est.</p>
        							<h5>- Robert joe</h5>
        						</div>
        					</div>
        				</div>
        				<div class="item">
        					<div class="media">
        						<div class="d-flex">
        							<img src="img/client/client-1.png" alt="">
        						</div>
        						<div class="media-body">
        							<p>Osed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci sed quia non numquam qui ratione voluptatem sequi nesciunt. Neque porro quisquam est.</p>
        							<h5>- Robert joe</h5>
        						</div>
        					</div>
        				</div>
        				<div class="item">
        					<div class="media">
        						<div class="d-flex">
        							<img src="img/client/client-1.png" alt="">
        						</div>
        						<div class="media-body">
        							<p>Osed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci sed quia non numquam qui ratione voluptatem sequi nesciunt. Neque porro quisquam est.</p>
        							<h5>- Robert joe</h5>
        						</div>
        					</div>
        				</div>
        			</div>
        		</div>
        	</div>
        </section>
        <!--================End Client Says Area =================-->
        
        <!--================End Client Says Area =================-->
        <section class="our_chef_area p_100">
        	<div class="container">
        		<div class="row our_chef_inner">
        			<div class="col-lg-3 col-6">
        				<div class="chef_text_item">
        					<div class="main_title">
								<h2>Our Chefs</h2>
								<p>Lorem ipsum dolor sit amet, cons ectetur elit. Vestibulum nec odios Suspe ndisse cursus mal suada faci lisis. Lorem ipsum dolor sit ametion.</p>
							</div>
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
        		</div>
        	</div>
        </section>
        <!--================End Client Says Area =================-->
    
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
						            <asp:TextBox ID="EmailTextBox" runat="server" placeholder="Enter your email address" CssClass="form-control"></asp:TextBox>
						            <div class="input-group-append">
							            <asp:Button ID="SubscribeButton" runat="server" Text="Subscribe Now" CssClass="btn btn-outline-secondary" OnClick="SubscribeButton_Click" />
						            </div>
					            </div>
					            <asp:Label ID="ErrorMessageLabel" runat="server" CssClass="text-danger" Text=""></asp:Label>
					            <asp:Label ID="SuccessMessageLabel" runat="server" CssClass="text-success" Text=""></asp:Label>
				            </div>
			            </div>
		            </div>
	            </div>
            </section>
           <!--================End Newsletter Area =================--> 
        </form>
        

</asp:Content>
