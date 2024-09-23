<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master"  AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="CakeOrderDeliverySystem.cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Add a form tag here -->
    <form id="form1" runat="server">
        <!--================Main Header Area =================-->
        <section class="banner_area">
            <div class="container">
                <div class="banner_text">
                    <h3>Cart</h3>
                    <ul>
                        <li><a href="index.aspx">Home</a></li>
                        <li><a href="cart.aspx">Cart</a></li>
                    </ul>
                </div>
            </div>
        </section>
        <!--================End Main Header Area =================-->

        <!--================Cart Table Area =================-->
        <section class="cart_table_area p_100">
            <div class="container">
                <div class="table-responsive">
                    <table class="table" runat="server" id="cartTable">
                        <thead>
                            <tr>
                                <th scope="col">Preview</th>
                                <th scope="col">Product</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Amount</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div class="row cart_total_inner">
                    <div class="col-lg-7"></div>
                    <div class="col-lg-5">
                        <div class="cart_total_text">
                            <div class="cart_head">
                                Cart Total
                            </div>
                            <div class="sub_total">
                                <h5>Sub Total <span><asp:Label ID="lblSubtotal" runat="server" Text=""></asp:Label></span></h5>
                            </div>
                            <div class="sub_total">
                                <h5>Discount <span><asp:Label ID="lblDiscount" runat="server" Text=""></asp:Label></span></h5>
                            </div>
                            <div class="total">
                                <h4>Total <span><asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></span></h4>
                            </div>
                            <div class="cart_footer">
                                <a class="pest_btn" href="checkout.aspx">Proceed to Checkout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================End Cart Table Area =================-->
    </form>
    <!-- End of form tag -->
</asp:Content>