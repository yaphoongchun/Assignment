<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="ChangingStatus.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.ChangingStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Style for read-only label */
        .readonly-label {
            background-color: #f0f0f0; /* Grey background color */
            cursor: not-allowed; /* Show disabled cursor */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
     <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center">Change Order Status</h2>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="lblOrderID">Order ID:</label>
                        <asp:Label ID="lblOrderID" runat="server" CssClass="form-control readonly-label" Enabled="false"></asp:Label>
                    </div>
                    <div class="form-group">
                        <label for="ddlShippingStatus">Shipping Status:</label>
                        <asp:DropDownList ID="ddlShippingStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Not Shipped" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Shipped" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="ddlOrderCompleted">Order Completed:</label>
                        <asp:DropDownList ID="ddlOrderCompleted" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Not Completed" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Completed" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group text-center">
                        <asp:Button ID="btnSaveStatus" runat="server" Text="Save Status" OnClick="btnSaveStatus_Click" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
