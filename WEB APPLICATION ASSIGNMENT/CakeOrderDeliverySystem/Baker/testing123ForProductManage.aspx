<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing123ForProductManage.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.testing123ForProductManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <style>
      body{background:#eee}.ratings i{font-size: 16px;color: red}.strike-text{color: red;text-decoration: line-through}.product-image{width: 100%}.dot{height: 7px;width: 7px;margin-left: 6px;margin-right: 6px;margin-top: 3px;background-color: blue;border-radius: 50%;display: inline-block}.spec-1{color: #938787;font-size: 15px}h5{font-weight: 400}.para{font-size: 16px}
  </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource8" style="margin-top: 15px">
                <Columns>
                    <asp:BoundField DataField="orderID" HeaderText="orderID" SortExpression="orderID" />
                    <asp:BoundField DataField="custID" HeaderText="custID" SortExpression="custID" />
                    <asp:BoundField DataField="Expr1" HeaderText="Expr1" SortExpression="Expr1" />
                    <asp:BoundField DataField="Expr2" HeaderText="Expr2" SortExpression="Expr2" />
                    <asp:CheckBoxField DataField="paymentStatus" HeaderText="paymentStatus" SortExpression="paymentStatus" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCakeDeliverySystem %>" SelectCommand="SELECT [order].orderID, [order].custID, customer.custID AS Expr1, orderDetail.orderID AS Expr2, [order].paymentStatus FROM customer INNER JOIN [order] ON customer.custID = [order].custID INNER JOIN orderDetail ON [order].orderID = orderDetail.orderID"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource7" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCakeDeliverySystem %>" SelectCommand="SELECT [order].shippingStatus, [order].isOrderConfirm, [order].paymentStatus, [order].isOrderCompleted, orderDetail.amount, product.productName, product.description, product.price, product.productImage FROM [order] INNER JOIN orderDetail ON [order].orderID = orderDetail.orderID INNER JOIN product ON orderDetail.productID = product.productID"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource16" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource15" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource14" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource13" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource12" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCakeDeliverySystem %>" SelectCommand="SELECT orderDetail.orderID, orderDetail.productID, product.productID AS Expr1, [order].orderID AS Expr2 FROM [order] INNER JOIN orderDetail ON [order].orderID = orderDetail.orderID INNER JOIN product ON orderDetail.productID = product.productID"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server"></asp:SqlDataSource>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
