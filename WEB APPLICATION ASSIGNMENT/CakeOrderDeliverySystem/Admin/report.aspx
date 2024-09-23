<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/adminHeader.Master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="CakeOrderDeliverySystem.Admin.report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="adminContent" runat="server">
        <form id="form2" runat="server">
        <div class="container-fluid">
            <br />       
            <h1>Report</h1>
            <div class="row">
                <div class="col-lg-20">
                    <div class="card">
                        <div class="card-body">
            <div class="col-lg-7">
                <span class="auto-style1">Please select a year:</span>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" DataSourceID="sdsOrderYear" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True" OnSelectedIndexChanged="rblOrderYear_SelectedIndexChanged">
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadioButtonList1" ErrorMessage="Must select a year" ForeColor="Red">*Please select a year</asp:RequiredFieldValidator>

                <br />
                <br />
                <span class="auto-style1">Please select a month:</span>
                <asp:RadioButtonList ID="RadioButtonList2" runat="server" DataSourceID="sdsOrderMonth" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True">
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="RadioButtonList2" ErrorMessage="Must select a month" ForeColor="Red">*Please select a month</asp:RequiredFieldValidator>
                <br />
                <br />

                <asp:Button ID="Button1" runat="server" CssClass="adminbtn" OnClick="btnViewReport_Click" Text="View Report" />

                <br />
                <br />
                <br />

                
                <asp:SqlDataSource ID="sdsOrderYear" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCakeDeliverySystem %>"
    SelectCommand="SELECT DISTINCT YEAR(orderDate) FROM [Order] WHERE paymentStatus = 1">
</asp:SqlDataSource>
                
                <asp:SqlDataSource ID="sdsOrderMonth" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCakeDeliverySystem %>" 
    SelectCommand="SELECT DISTINCT MONTH(orderDate) FROM [Order] WHERE YEAR(orderDate) = @year And paymentStatus = 1">
    <SelectParameters>
        <asp:ControlParameter ControlID="RadioButtonList1" Name="year" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>

                <div id="divResult" style="margin:10px; padding:30px; border-style: solid; border-color:grey; background-color:azure;">
                <p style="text-align: center; font-size: x-large; text-decoration: underline">
                    <asp:Label ID="lblTitle" runat="server"></asp:Label>
                </p>
                <br />
                <asp:Label ID="lblTotalSales" runat="server"></asp:Label>
                <br />
                <asp:Label ID="lblTotalDiscount" runat="server"></asp:Label>
                <br />
                <asp:Label ID="lblGrandTotalSalesAmount" runat="server"></asp:Label>
                <br>
                <asp:Label ID="lblReportDateTime" runat="server"></asp:Label>
                <br />
                <br />
                <br />
                <p style="font-size: larger">
                    <asp:Label ID="lblProdInvolved" runat="server"></asp:Label></p>
                <asp:Repeater ID="result" runat="server">
                    <ItemTemplate>
                        <hr />
                        Product ID          : <%# Eval("productID") %><br />
                        Product Name        : <%# Eval("productName") %><br />
                        Total Quantity Sales: <%# Eval("totalQuantity") %><br />
                        Total Amount (RM)   : <%# Eval("totalAmount", "{0:#.00}") %><br />
                    </ItemTemplate>
                </asp:Repeater>
                <br />
                <asp:Label ID="lblErrorMessage" runat="server"></asp:Label>
                </div> 

                <%--button--%>
                <br />
                <br />

                <%--<asp:Button ID="print" runat="server" CssClass="adminbtn" Onclick="print_Click" Text="Print Report" />--%>

                <br />
                <br />
                <br />
                <%--button--%>




                              </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
        </form>
</asp:Content>
