<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.EditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="sweetalert2.min.css">
    <style>
        /* Add custom CSS styles here */
        .container {
            margin-top: 50px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
    <form id="editProductForm" runat="server" enctype="multipart/form-data">
        <div class="container">
            <h2>Edit Product</h2>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="txtProductID">Product ID:</label>
                        <asp:TextBox ID="txtProductID" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtProductName">Product Name:</label>
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtDesc">Description:</label>
                        <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtProdPrice">Price:</label>
                        <asp:TextBox ID="txtProdPrice" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="ddlProdStatus">Available Status:</label>
                        <asp:DropDownList ID="ddlProdStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Available" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Not Available" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="imgProductImage">Product Image:</label>
                        <asp:Image ID="imgProductImage" runat="server" CssClass="img-fluid" />
                    </div>
                    <div class="form-group">
                        <label for="fileProductImage">Upload New Image:</label>
                        <asp:FileUpload ID="fileProductImage" runat="server" CssClass="form-control-file" />
                    </div>
                    <asp:Button ID="btnSaveEdit" runat="server" Text="Save" CssClass="btn btn-primary btn-block" OnClientClick="return validatePrice();" OnClick="btnSaveEdit_Click" />
                </div>
            </div>
        </div>
    </form>
    <script src="sweetalert2.all.min.js"></script>
    <script>
        function validatePrice() {
            var priceInput = document.getElementById('<%= txtProdPrice.ClientID %>').value;

            if (isNaN(priceInput) || parseFloat(priceInput) <= 0) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Price',
                    text: 'Please enter a valid decimal number for the price.',
                });
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
