<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="shop.aspx.cs" Inherits="CakeOrderDeliverySystem.shop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Icon css link -->
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="vendors/linearicons/style.css" rel="stylesheet">
    <link href="vendors/flat-icon/flaticon.css" rel="stylesheet">
    <link href="vendors/stroke-icon/style.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Rev slider css -->
    <link href="vendors/revolution/css/settings.css" rel="stylesheet">
    <link href="vendors/revolution/css/layers.css" rel="stylesheet">
    <link href="vendors/revolution/css/navigation.css" rel="stylesheet">
    <link href="vendors/animate-css/animate.css" rel="stylesheet">

    <!-- Extra plugin css -->
    <link href="vendors/owl-carousel/owl.carousel.min.css" rel="stylesheet">
    <link href="vendors/magnifc-popup/magnific-popup.css" rel="stylesheet">
    <link href="vendors/jquery-ui/jquery-ui.min.css" rel="stylesheet">
    <link href="vendors/nice-select/css/nice-select.css" rel="stylesheet">

    <link href="css/style.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">

    <style>
        .product-item {
    height: 400px; /* Adjust as needed */
    margin-bottom:20px;
}

.cake_feature_item {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    border: 1px solid #eaeaea;
    border-radius: 5px;
    overflow: hidden;
}

.cake_img {
    flex-grow: 1;
}

.cake_text {
    padding: 15px;
    background-color: #fff;
}

.product-image {
    
    width: 100%;
    height: auto;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <section class="product_area p_100">
            <div class="container">
                <div class="row product_inner_row">
                    <!-- Product Categories Sidebar -->
                    <div class="col-lg-3" style="margin-top: 210px;">
                        <div class="product_left_sidebar">
                            <aside class="left_sidebar p_catgories_widget">
                                <div class="p_w_title">
                                    <h3>Product Categories</h3>
                                </div>
                                <ul class="list_style">
                                    <li>
                                        <a>
                                            <asp:Button ID="btnBirthdayCake" runat="server" Text="Birthday Cake" CssClass="category-button" OnClick="FilterProducts_Click" CommandArgument="Birthday Cakes" />
                                    <li>
                                        <a>
                                            <asp:Button ID="btnCupcake" runat="server" Text="Cupcake" CssClass="category-button" OnClick="FilterProducts_Click" CommandArgument="Cupcake" /></a></li>
                                    <li>
                                    <li>
                                        <a>
                                            <asp:Button ID="btnChocolate" runat="server" Text="Chocolate" CssClass="category-button" OnClick="FilterProducts_Click" CommandArgument="Chocolate" /></a></li>
                                    <li>
                                        <a>
                                            <asp:Button ID="btnCelebration" runat="server" Text="Celebration" CssClass="category-button" OnClick="FilterProducts_Click" CommandArgument="Celebration" /></a></li>
                                </ul>
                            </aside>

                        </div>
                    </div>

                    <!-- Product Items -->
                    <div class="col-lg-9">
                        <!-- Product Task Bar -->
                        <div class="row m0 product_task_bar" style="margin-top: 80px;">
                            <!-- Sorting and Display Options -->
                            <div class="product_task_inner">
                                <div class="float-left">
                                    <a class="active" href="#"><i class="fa fa-th-large" aria-hidden="true"></i></a>
                                    <a href="#"><i class="fa fa-th-list" aria-hidden="true"></i></a>
                                    <span>
                                        <asp:Label ID="productCountLabel" runat="server"></asp:Label></span>
                                </div>
                                <div class="float-right">
                                    <h4>Sort by :</h4>
                                    <asp:DropDownList ID="sortSelect" runat="server" CssClass="short" AutoPostBack="true" OnSelectedIndexChanged="SortProducts">
                                        <asp:ListItem Value="nameAZ">Name (A-Z)</asp:ListItem>
                                        <asp:ListItem Value="priceLowToHigh">Price (Low to High)</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Button ID="btnSort" runat="server" Text="Sort" OnClick="SortProducts" Style="display: none;" />
                                </div>
                            </div>
                        </div>

                        <!-- Product Items Placeholder -->
                        <div class="row product_inner_row" id="">
                            <!-- Product items will be dynamically added here -->
                            <asp:Repeater ID="ProductRepeater" runat="server">
                                <ItemTemplate>
                                    <div class="col-lg-4 col-md-4 col-6 product-item">
                                        <br />
                                        <div class="cake_feature_item">
                                            <div class="cake_img">
                                                <img class="product-image img-fluid" src='<%# ResolveUrl(Eval("productImage").ToString()) %>' alt='<%# Eval("ProductName") %>' />
                                            </div>
                                            <div class="cake_text">
                                                <h4>$<%# Eval("Price") %></h4>
                                                <h3><%# Eval("ProductName") %></h3>
                                                <asp:Button ID="addToCartButton" runat="server" CssClass="pest_btn" Text="Add to cart" OnClick="AddToCartButton_Click" CommandArgument='<%# Eval("ProductId") %>' />
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </form>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- Rev slider js -->
    <script src="vendors/revolution/js/jquery.themepunch.tools.min.js"></script>
    <script src="vendors/revolution/js/jquery.themepunch.revolution.min.js"></script>
    <script src="vendors/revolution/js/extensions/revolution.extension.actions.min.js"></script>
    <script src="vendors/revolution/js/extensions/revolution.extension.video.min.js"></script>
    <script src="vendors/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
    <script src="vendors/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
    <script src="vendors/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
    <!-- Extra plugin js -->
    <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
    <script src="vendors/magnifc-popup/jquery.magnific-popup.min.js"></script>
    <script src="vendors/isotope/imagesloaded.pkgd.min.js"></script>
    <script src="vendors/isotope/isotope.pkgd.min.js"></script>
    <script src="vendors/datetime-picker/js/moment.min.js"></script>
    <script src="vendors/datetime-picker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="vendors/nice-select/js/jquery.nice-select.min.js"></script>
    <script src="vendors/jquery-ui/jquery-ui.min.js"></script>
    <script src="vendors/lightbox/simpleLightbox.min.js"></script>
    <script src="js/theme.js"></script>

</asp:Content>

