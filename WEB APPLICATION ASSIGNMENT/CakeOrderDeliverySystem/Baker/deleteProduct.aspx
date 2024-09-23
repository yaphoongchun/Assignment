<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="deleteProduct.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.deleteProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #343a40;
        }

        p {
            text-align: center;
            color: #6c757d;
            margin-bottom: 20px;
        }

        .btn-container {
            text-align: center;
        }

        .btn {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #c82333;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
    <div class="container">
        <h1>Delete Product</h1>
        <p>Are you sure you want to delete this product?</p>
        <div class="btn-container">
            <form id="form1" runat="server">
                <asp:Button ID="btnConfirmDelete" runat="server" Text="Delete" CssClass="btn" OnClick="btnConfirmDelete_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click" />
            </form>
        </div>
    </div>
</asp:Content>
