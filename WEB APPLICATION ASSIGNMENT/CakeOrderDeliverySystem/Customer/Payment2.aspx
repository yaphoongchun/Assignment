<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master"  AutoEventWireup="true" CodeBehind="Payment2.aspx.cs" Inherits="CakeOrderDeliverySystem.Payment2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">


        <!--================End Main Header Area =================-->
        <section class="banner_area" style="margin-top: 100px;">
            <div class="container">
                <div class="banner_text">
                    <h3>Credit Card Payments</h3>
                    <br />
                </div>
            </div>
        </section>

        <!--================End Main Header Area =================-->
        <div style="margin-top: 30px;" class="container main_title">
            <h2>Billing Details</h2>
        </div>
        <div class="container d-flex justify-content-center mt-5 mb-5">
            <div class="row g-3">
                <!-- Payment Method Section -->
                <div class="col-md-6" >
                    <span style="color: black">Payment Method</span>
                    <div class="card">
                        <div class="accordion" id="accordionExample">
                            <div class="card">
                                <div class="card-header p-0">
                                    <h2 class="mb-0">
                                        <button class="btn btn-light btn-block text-left p-3 rounded-0" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                            <div class="d-flex align-items-center justify-content-between">
                                                <span>Credit card</span>
                                                <div class="icons">
                                                    <img src="../img/W1vtnOV.png" width="30">
                                                    <img src="../img/35tC99g.png" width="30">
                                                    <img src="../img/2ISgYja.png" width="30">
                                                </div>
                                            </div>
                                        </button>
                                    </h2>
                                </div>
                                <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                                    <div class="card-body payment-card-body">
                                        <span class="font-weight-normal card-text" style="color: black">Card Number</span>
                                        <asp:RequiredFieldValidator ID="rfvCardNo" runat="server" ErrorMessage="Must fill in card number!" ControlToValidate="txtCreditCard" ForeColor="Red">*</asp:RequiredFieldValidator>
                                        <div class="input">
                                            <i class="fa fa-credit-card"></i>
                                            <asp:TextBox ID="txtCreditCard" runat="server" MaxLength="19" CssClass="form-control" placeholder="0000 0000 0000 0000" oninput="formatCreditCard()"></asp:TextBox>
                                        </div>
                                        <div class="row mt-3 mb-3">
                                            <div class="col-md-6">
                                                <span class="font-weight-normal card-text" style="color: black">Expiry Date</span>
                                                <asp:RequiredFieldValidator ID="rfvExpiredDate" runat="server" ErrorMessage="Must fill in expired date!" ControlToValidate="txtExpirationDate" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                <div class="input">
                                                    <i class="fa fa-calendar"></i>
                                                    <asp:TextBox ID="txtExpirationDate" runat="server" MaxLength="5" CssClass="form-control" placeholder="MM/YY" oninput="formatExpirationDate()"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <span class="font-weight-normal card-text" style="color: black">CVC/CVV</span>
                                                <asp:RequiredFieldValidator ID="rfvCvv" runat="server" ErrorMessage="Must fill in CVV!" ControlToValidate="txtCVV" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                <div class="input">
                                                    <i class="fa fa-lock"></i>
                                                    <asp:TextBox ID="txtCVV" runat="server" MaxLength="3" CssClass="form-control" placeholder="000" onkeypress="restrictToNumeric(event)" oninput="validateCVV()"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <span class="text-muted certificate-text"><i class="fa fa-lock"></i>Your transaction is secured with SSL certificate</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Payment Method Section -->
                <!-- Summary Section -->
                <div class="col-md-6" >
                    <span style="color: black">Summary</span>
                    <div class="card">
                        <div class="col-lg-12">
                            <div class="order_box_price">
                                <div class="payment_list">
                                    <div class="price_single_cost">
                                        <h5>Product
                                            <asp:Label ID="lblProductName" runat="server"></asp:Label><span>Total</span></h5>
                                        <h5></h5>
                                        <br />
                                        <h4>Subtotal <span>
                                            <asp:Label ID="labelSubtotal" runat="server"></asp:Label></span></h4>
                                        <h5>Discount <span class="text_f">
                                            <asp:Label ID="lblDiscount" runat="server"></asp:Label></span></h5>
                                        <h4>Total Amount:
                                            <asp:Label ID="lblTotalAmount" runat="server"></asp:Label></h4>

                                    </div>
                                    <asp:Button ID="btnPay" runat="server" Text="Pay" class="btn btn-primary btn-block free-button" OnClick="btnPay_Click" />

                                    <br />
                                </div>
                                <br />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Summary Section -->
            </div>
        </div>
    </form>
    <script>
        function formatCreditCard() {
            var creditCardInput = document.getElementById('<%= txtCreditCard.ClientID %>');

            var inputText = creditCardInput.value.replace(/\D/g, '');
            inputText = inputText.substring(0, 16); // Limit to 16 digits
            inputText = inputText.replace(/(\d{4})(?=\d)/g, '$1 ');

            creditCardInput.value = inputText;
        }

        function formatExpirationDate() {
            var expirationDateInput = document.getElementById('<%= txtExpirationDate.ClientID %>');

            var inputText = expirationDateInput.value.replace(/\D/g, '');

            // Allow MM/YY format
            if (inputText.length > 2) {
                // Extract MM and YY separately
                var month = inputText.substring(0, 2);
                var year = inputText.substring(2);

                // Ensure the month is between 01 and 12
                month = Math.min(12, Math.max(1, parseInt(month, 10))).toString().padStart(2, '0');

                // Combine MM and YY with '/'
                inputText = month + '/' + year.substring(0, 2); // Limit to 2 digits for the year
            }

            // Update the input value
            expirationDateInput.value = inputText.substring(0, 5); // Limit to MM/YY format
        }

        function validateCVV() {
            var cvvInput = document.getElementById('<%= txtCVV.ClientID %>');
            var cvvValue = cvvInput.value.trim();

            // Remove non-numeric characters
            var numericCVV = cvvValue.replace(/\D/g, '');

            // CVV should be a numeric value with exactly 3 digits
            var isValidCVV = /^\d{0,3}$/.test(numericCVV);

            if (!isValidCVV) {
                alert('Please enter a valid CVV (up to 3 digits).');
                cvvInput.value = numericCVV.substring(0, 3); // Limit to 3 digits
            }
        }

        function restrictToNumeric(event) {
            var charCode = (event.which) ? event.which : event.keyCode;

            // Allow only digits (0-9)
            if (charCode < 48 || charCode > 57) {
                event.preventDefault();
            }
        }
    </script>
</asp:Content>
