<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="bakerProductManage.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.bakerProductManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 800px;
            border-radius: 5px;
            position: relative;
        }

        .product-container {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            width: 100%;
            border-radius: 5px;
        }

        .product-details {
            margin-top: 10px;
        }

        .product-name {
            font-size: 18px;
            font-weight: bold;
            color: #343a40;
        }

        .product-rating {
            color: #ffc107;
            font-size: 16px;
            margin-bottom: 5px;
        }

        .product-description {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 16px;
            font-weight: bold;
            color: #007bff;
            margin-top: 10px;
        }

        .btn-edit {
            background-color: #28a745;
            color: #ffffff;
            border: none;
            padding: 5px 15px;
            margin-bottom:10px;
            font-size: 14px;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-edit:hover {
            background-color: #218838;
        }

        .btn-delete {
            background-color: #dc3545;
            color: #ffffff;
            border: none;
            padding: 5px 15px;
            margin-bottom:9px;
            font-size: 14px;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

    #editFormOverlay {
  
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black background */
    z-index: 9999; /* Ensure it's on top of other content */
}

#editFormContainer {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.close {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
    <div id="editFormOverlay" runat="server" style="display: block;">
        <form id="form1" runat="server">
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <div class="col-md-3 mb-4">
                            <asp:Button ID="btnAddProduct" runat="server" CssClass="btn btn-primary rounded-pill py-3 px-5" Text="Add Product" OnClick="btnAddProduct_Click" />
                        </div>
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <ItemTemplate>
                                <div class="product-container mb-4">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <img class="product-image" src='<%# ResolveUrl(Eval("productImage").ToString()) %>' />
                                        </div>
                                        <div class="col-md-8 product-details">
                                            <div class="product-name d-inline-block"><%# Eval("productName") %></div>
                                            <div class="text-right float-right mt-3">
                                                <div class="d-inline-block">
                                                    <asp:Button ID="EditButton" runat="server" CssClass="btn btn-edit" Text="Edit" OnClick="EditButton_Click" CommandArgument='<%# Eval("productID") %>' />
                                                </div>
                                                <div class="d-inline-block ml-2">
                                                    <asp:Button ID="DeleteButton" runat="server" CssClass="btn btn-delete" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("productID") %>' OnClick="DeleteButton_Click" />
                                                </div>
                                            </div>
                                            <div class="product-rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <div class="product-description mb-3">
                                                <%# Eval("description") %>
                                            </div>
                                            <div class='<%# (bool)Eval("availableStatus") ? "product-available-status text-success" : "product-available-status text-danger" %>'>
                                                <%# (bool)Eval("availableStatus") ? "Status: Available" : "Status: Not Available" %>
                                            </div>
                                            <div class="product-price mt-2">$<%# Eval("price") %></div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </form>
    </div>
</asp:Content>