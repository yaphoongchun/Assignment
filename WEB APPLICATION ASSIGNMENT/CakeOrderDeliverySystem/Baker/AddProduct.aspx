<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <link rel="stylesheet" href="../sweetalert2.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .btn-primary {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            color: #ffffff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

            .btn-primary:hover {
                background-color: #0056b3;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
    <div id="addProductFormContainer" class="container mt-5" style="display: none;">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="text-center mb-4">Add New Product</h2>
                <form id="formAddProduct" runat="server">
                    <div class="form-group">
                        <label for="txtProductID">Product Id</label>
                        <asp:TextBox ID="txtProductID" runat="server" CssClass="form-control" placeholder="Product ID" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtProductName">Product Name *</label>
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="Enter product name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="ddlProductSize">Product Size</label>
                        <asp:DropDownList ID="ddlProductSize" runat="server" CssClass="form-control" placeholder="Select product size">
                            <asp:ListItem Text="6 inches" Value="6"></asp:ListItem>
                            <asp:ListItem Text="8 inches" Value="8"></asp:ListItem>
                            <asp:ListItem Text="10 inches" Value="10"></asp:ListItem>
                            <asp:ListItem Text="12 inches" Value="12"></asp:ListItem>
                            <asp:ListItem Text="14 inches" Value="14"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="txtIngredient">Ingredient</label>
                        <asp:TextBox ID="txtIngredient" runat="server" CssClass="form-control" placeholder="Enter ingredient"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtAllegrens">Allergens</label>
                        <asp:TextBox ID="txtAllegrens" runat="server" CssClass="form-control" placeholder="Enter allergens"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtAvgRate">Average Rate</label>
                        <asp:TextBox ID="txtAvgRate" runat="server" CssClass="form-control" placeholder="Enter average rate"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblCategoryName" runat="server" Text=""></asp:Label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="txtDesc">Description</label>
                        <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter description"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtProdPrice">Price</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <asp:TextBox ID="txtProdPrice" runat="server" CssClass="form-control" type="number" step="0.01" placeholder="Enter price"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ddlProdStatus">Status</label>
                        <asp:DropDownList ID="ddlProdStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Available" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Not Available" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="fileProductImage">Product Image</label>
                        <asp:FileUpload ID="fileProductImage" runat="server" CssClass="form-control-file" />
                    </div>
                    <asp:Button ID="btnAddProduct" runat="server" CssClass="btn btn-primary btn-block" Text="Add Product" OnClick="btnAddProduct_Click" OnClientClick="return validateForm();" />
                </form>
            </div>
        </div>
    </div>
       <script src="../js/sweetalert2.all.min.js"></script>
    <script>
        // Show the add product form when the page is fully loaded
        window.onload = function () {
            document.getElementById("addProductFormContainer").style.display = "block";
        };

        function validateForm() {
            // Perform custom validation here
            var productName = document.getElementById("<%=txtProductName.ClientID%>").value;
            var productSize = document.getElementById("<%=ddlProductSize.ClientID%>").value;
            var ingredient = document.getElementById("<%=txtIngredient.ClientID%>").value;
            var allergens = document.getElementById("<%=txtAllegrens.ClientID%>").value;
            var avgRate = document.getElementById("<%=txtAvgRate.ClientID%>").value;
            var price = document.getElementById("<%=txtProdPrice.ClientID%>").value;

            // Check if required fields are filled
            if (productName === "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Please enter product name.'
                });
                return false;
            }

            if (productSize !== "6" && productSize !== "8" && productSize !== "10" && productSize !== "12" && productSize !== "14") {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Product size must be 6, 8, 10, 12, or 14 inches.'
                });
                return false;
            }

            if (ingredient === "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Please enter ingredient.'
                });
                return false;
            }

            if (allergens === "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Please enter allergens.'
                });
                return false;
            }

            if (isNaN(avgRate) || avgRate < 1 || avgRate > 5) {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Average rate must be a number between 1 and 5.'
                });
                return false;
            }

            if (isNaN(price) || price <= 0) {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Price must be a positive number.'
                });
                return false;
            }

            return true; // Return false if form submission should be stopped
        }
    </script>
</asp:Content>
