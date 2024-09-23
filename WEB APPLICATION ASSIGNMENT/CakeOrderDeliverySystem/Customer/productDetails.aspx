<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="productDetails.aspx.cs" Inherits="CakeOrderDeliverySystem.productDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <!-- Banner Area -->
        <section class="banner_area">
            <div class="container">
                <div class="banner_text">
                    <h3>Product Details</h3>
                    <ul>
                        <li><a href="index.html">Home</a></li>
                        <li><a href="product-details.html">Product Details</a></li>
                    </ul>
                </div>
            </div>
        </section>
        <!-- End Banner Area -->

        <!-- Product Details Area -->
        <section class="product_details_area p_100">
            <div class="container">
                <div class="row product_d_price">
                    <div class="col-lg-6">
                        <div class="product_img">
                            <asp:Image ID="productImage" runat="server" CssClass="img-fluid" />
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="product_details_text">
                            <h4>
                                <asp:Label ID="categoryNameLabel" runat="server" /></h4>
                            <h2>
                                <asp:Label ID="productNameLabel" runat="server" /></h2>
                            <p>
                                <asp:Label ID="descriptionLabel" runat="server" /></p>
                            <h5>Price :<span><asp:Label ID="priceLabel" runat="server" /></span></h5>
                            <h5>Product Size :<span><asp:Label ID="productSizeLabel" runat="server" /></span></h5>
                            <h5>Allergens :<span><asp:Label ID="allergensLabel" runat="server" /></span></h5>
                            <div class="quantity_box">
                                <label for="quantity">Quantity :</label>
                                <asp:TextBox ID="quantityTextBox" runat="server" type="number" min="1" max="10" placeholder="1" />
                            </div>
                            <asp:Button ID="addToCartButton" runat="server" CssClass="pink_more" Text="Add to Cart" OnClick="AddToCartButton_Click" />
                        </div>
                    </div>
                </div>
                <div class="product_tab_area">
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Description</a>
                            <!-- Add more tabs if needed -->
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            <p>
                                <asp:Label ID="ingredientLabel" runat="server" /></p>
                            <!-- Add more tab content if needed -->
                        </div>
                        <!-- Add more tab panes if needed -->
                    </div>
                </div>
            </div>
        </section>
        <!-- End Product Details Area -->
    </form>
</asp:Content>
