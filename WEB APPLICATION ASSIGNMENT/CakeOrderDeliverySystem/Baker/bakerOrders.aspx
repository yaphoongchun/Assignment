<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="bakerOrders.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.bakerOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        .order-container {
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
            margin-bottom: 10px;
        }

        .product-description {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 10px;
        }

        .product-status {
            font-size: 16px;
            color: #343a40;
            margin-bottom: 10px;
        }

        .product-amount {
            font-size: 16px;
            font-weight: bold;
            color: #007bff;
            margin-top: 10px;
        }

        .product-shipping-address {
            font-size: 14px;
            color: #6c757d;
        }

        .change-status-button {
            margin-top: 20px;
        }

        .change-status-button .btn {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 8px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .change-status-button .btn:hover {
            background-color: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2>Baker Orders</h2>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-10">
                <form id="orderForm" runat="server">
                    <asp:Repeater ID="RepeaterOrders" runat="server">
                        <ItemTemplate>
                            <div class="order-container">
                                <h3>Order ID: <%# Eval("OrderID") %></h3>
                                <asp:Repeater runat="server" DataSource='<%# Eval("Orders") %>'>
                                    <ItemTemplate>
                                        <div class="product-container">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <img class="product-image" src='<%# ResolveUrl(Eval("productImage").ToString()) %>' />
                                                </div>
                                                <div class="col-md-9 product-details">
                                                    <div class="product-name"><%# Eval("productName") %></div>
                                                    <div class="product-description">
                                                        <%# Eval("custName") %>'s Order on <%# Eval("orderDate", "{0:MM/dd/yyyy}") %>
                                                    </div>
                                                    <div class="product-status">
                                                        Shipping Status:
                                                        <asp:Label ID="ShippingStatusLabel" runat="server" Text='<%# GetShippingStatusText(Eval("shippingStatus")) %>' CssClass='<%# GetShippingStatusCssClass(Eval("shippingStatus")) %>'></asp:Label><br />
                                                        Is Order Completed:
                                                        <asp:Label ID="OrderCompletedLabel" runat="server" Text='<%# GetOrderCompletedText(Eval("isOrderCompleted")) %>' CssClass='<%# GetOrderCompletedCssClass(Eval("isOrderCompleted")) %>'></asp:Label>
                                                    </div>
                                                    <div class="product-amount">
                                                        Amount: <%# Eval("amount") %>
                                                    </div>
                                                    <div class="product-shipping-address">
                                                        Shipped Address: <%# Eval("shippedAddress") %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div class="change-status-button">
                                    <asp:Button ID="ChangeStatusButton" runat="server" Text="Change Status" OnClick="ChangeStatusButton_Click" CommandArgument='<%# Eval("OrderID") %>' CssClass="btn" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
