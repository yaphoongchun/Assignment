<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="CakeOrderDeliverySystem.checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Add any CSS or JavaScript references here -->
    <style>
        /* Add custom CSS styles here */
        .main_title {
            margin-bottom: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }

        .billing_details_area {
            margin-top: 50px;
        }

        .billing_form_area {
            margin-top: 30px;
        }

        .billing_form .form-group {
            margin-bottom: 20px;
        }

        .order_box_price {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .payment_list .price_single_cost {
            margin-bottom: 20px;
        }

        .payment_list h5, .payment_list h4, .payment_list h3 {
            margin-bottom: 10px;
            font-weight: bold;
        }

            .payment_list h5 span, .payment_list h4 span, .payment_list h3 span {
                float: right;
            }

        .accordion_area .card {
            margin-bottom: 20px;
            border: none;
            box-shadow: none;
        }

        .accordion_area .card-header {
            background-color: #f9f9f9;
            border: none;
        }

            .accordion_area .card-header button {
                color: #333;
                font-weight: bold;
            }

        .accordion_area .card-body {
            background-color: #fff;
            border: 1px solid #f9f9f9;
            border-top: none;
            border-radius: 0 0 10px 10px;
            padding: 20px;
        }

        .pest_btn {
            background-color: #ff6b6b;
            color: #fff;
            border: none;
            padding: 10px 30px;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
            display: block;
            margin: 20px auto;
        }

            .pest_btn:hover {
                background-color: #ff8b8b;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="formCheckout" runat="server">
        <section class="billing_details_area p_100">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="main_title">
                            <h2>Billing Details</h2>
                        </div>
                        <div class="billing_form_area">
                            <asp:Panel ID="pnlBillingDetails" runat="server" CssClass="billing_form row">
                                <div class="form-group col-md-6">
                                    <label for="first">Customer Name *</label>
                                    <asp:TextBox ID="first" runat="server" CssClass="form-control" Style="color: black;" onfocus="this.style.borderColor='';"
                                        onblur="this.style.borderColor='#000';" placeholder="First Name"></asp:TextBox>
                                </div>
                                <div class="form-group col-md-12">
                                    <label for="address">Address *</label>
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Style="color: black;" onfocus="this.style.borderColor='';"
                                        onblur="this.style.borderColor='#000';" placeholder="Street Address"></asp:TextBox>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="email">Email Address *</label>
                                    <asp:TextBox ID="emailField" runat="server" CssClass="form-control" Style="color: black;" onfocus="this.style.borderColor='';"
                                        onblur="this.style.borderColor='#000';" placeholder="Email Address"></asp:TextBox>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="phone">Phone *</label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Style="color: black;" onfocus="this.style.borderColor='';"
                                        onblur="this.style.borderColor='#000';" placeholder="Phone"></asp:TextBox>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="order_box_price">
                            <div class="main_title">
                                <h2>Your Order</h2>
                            </div>
                            <div class="payment_list">
                                <div class="price_single_cost">
                                    <h5>Total Product
                                        <asp:Label ID="lblProductName" runat="server" />
                                        <span>
                                            <asp:Label ID="lblTotal" runat="server" /></span>
                                    </h5>

                                    <h5>Product Details
                                        <asp:Label ID="lblProductDetails" runat="server" />
                                    </h5>
                                    <h4>Subtotal <span>
                                        <asp:Label ID="lblSubtotal" runat="server" /></span>
                                    </h4>
                                    <h5>Shipping And Handling<span class="text_f">Free Shipping</span></h5>
                                    <h3>Total <span>
                                        <asp:Label ID="lblGrandTotal" runat="server" /></span>
                                    </h3>
                                </div>
                                <div id="accordion" class="accordion_area">
                                    <div class="card">
                                        <div class="card-header" id="headingOne">
                                            <h5 class="mb-0">
                                                <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                    Direct Bank Transfer
                                                </button>
                                            </h5>
                                        </div>
                                        <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                                            <div class="card-body">
                                                Make your payment directly into our bank account. Please use your Order ID as the payment reference. Your order won’t be shipped until the funds have cleared in our account.
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Add other payment options here -->
                                </div>
                                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn pest_btn" OnClick="btnPlaceOrder_Click" OnClientClick="return validateForm();" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function validateForm() {
                var isValid = true;

                // Validate Customer Name
                var customerName = document.getElementById('<%= first.ClientID %>').value.trim();
                if (customerName === '' || !/^[a-zA-Z\s]*$/.test(customerName)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid Customer Name',
                        text: 'Please enter a valid customer name without numbers or special characters.'
                    });
                    isValid = false;
                    return isValid;
                }

                // Validate Address
                var address = document.getElementById('<%= txtAddress.ClientID %>').value.trim();
                if (address === '') {
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid Address',
                        text: 'Please enter a valid address.'
                    });
                    isValid = false;
                    return isValid;
                }

                // Validate Email Address
                var email = document.getElementById('<%= emailField.ClientID %>').value.trim();
                if (email === '' || !isValidEmail(email)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid Email Address',
                        text: 'Please enter a valid email address.'
                    });
                    isValid = false;
                    return isValid;
                }

                // Validate Phone Number
                var phone = document.getElementById('<%= txtPhone.ClientID %>').value.trim();
                if (phone === '' || !/^(0|\+?60)(\d{9,10})$/.test(phone)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid Phone Number',
                        text: 'Please enter a valid phone number starting with 0 and containing 10-11 digits.'
                    });
                    isValid = false;
                    return isValid;
                }

                return isValid;
            }

            function isValidEmail(email) {
                // Regular expression for validating email address
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailRegex.test(email);
            }
        </script>
    </form>
    <!--================End Billing Details Area =================-->
</asp:Content>
