<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/adminHeader.Master" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="CakeOrderDeliverySystem.admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="adminContent" runat="server">
    <form id="form2" runat="server">
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->

        <div class="container-fluid">
            <br />
            <h1>Dashboard</h1>
            <!-- ============================================================== -->
            <!-- Email campaign chart -->
            <!-- ============================================================== -->
            <%-- <div class="row">
                    
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-1">Referral Earnings</h5>
                                <h3 class="font-light">$769.08</h3>
                                <div class="mt-3 text-center">
                                    <div id="earnings"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title mb-0">Users</h4>
                                <h2 class="font-light">35,658 <span class="font-16 text-success font-medium">+23%</span>
                                </h2>
                                <div class="mt-4">
                                    <div class="row text-center">
                                        <div class="col-6 border-right">
                                            <h4 class="mb-0">58%</h4>
                                            <span class="font-14 text-muted">New Users</span>
                                        </div>
                                        <div class="col-6">
                                            <h4 class="mb-0">42%</h4>
                                            <span class="font-14 text-muted">Repeat Users</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- Email campaign chart -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Ravenue - page-view-bounce rate -->
                <!-- ============================================================== -->
                <div class="row">
                    <!-- column -->
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Latest Sales</h4>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th class="border-top-0">NAME</th>
                                            <th class="border-top-0">STATUS</th>
                                            <th class="border-top-0">DATE</th>
                                            <th class="border-top-0">PRICE</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>

                                            <td class="txt-oflo">Elite admin</td>
                                            <td><span class="label label-success label-rounded">SALE</span> </td>
                                            <td class="txt-oflo">April 18, 2021</td>
                                            <td><span class="font-medium">$24</span></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">Real Homes WP Theme</td>
                                            <td><span class="label label-info label-rounded">EXTENDED</span></td>
                                            <td class="txt-oflo">April 19, 2021</td>
                                            <td><span class="font-medium">$1250</span></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">Ample Admin</td>
                                            <td><span class="label label-purple label-rounded">Tax</span></td>
                                            <td class="txt-oflo">April 19, 2021</td>
                                            <td><span class="font-medium">$1250</span></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">Medical Pro WP Theme</td>
                                            <td><span class="label label-success label-rounded">Sale</span></td>
                                            <td class="txt-oflo">April 20, 2021</td>
                                            <td><span class="font-medium">-$24</span></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">Hosting press html</td>
                                            <td><span class="label label-success label-rounded">SALE</span></td>
                                            <td class="txt-oflo">April 21, 2021</td>
                                            <td><span class="font-medium">$24</span></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">Digital Agency PSD</td>
                                            <td><span class="label label-danger label-rounded">Tax</span> </td>
                                            <td class="txt-oflo">April 23, 2021</td>
                                            <td><span class="font-medium">-$14</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>--%>


            <div class="row g-3 my-2">
                <div class="col-md-3">
                    <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                        <div>
                            <h3 class="fs-2">10</h3>
                            <p class="fs-5">Products</p>
                        </div>
                        <span class="fa-stack fa-2x">
                            <i style="color: lightpink;" class="fa fa-circle fa-stack-2x secondary-bg"></i>
                            <i style="color: white;" class="fa fa-gift fa-stack-1x primary-text"></i>
                        </span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                        <div>
                            <h3 class="fs-2">100</h3>
                            <p class="fs-5">Sales</p>
                        </div>
                        <span class="fa-stack fa-2x">
                            <i style="color: lightgreen;" class="fa fa-circle fa-stack-2x secondary-bg"></i>
                            <i style="color: white;" class="fa fa-money fa-stack-1x primary-text"></i>
                        </span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                        <div>
                            <h3 class="fs-2">1</h3>
                            <p class="fs-5">Delivery</p>
                        </div>
                        <span class="fa-stack fa-2x">
                            <i style="color: lightblue;" class="fa fa-circle fa-stack-2x secondary-bg"></i>
                            <i style="color: white;" class="fa fa-truck fa-stack-1x primary-text"></i>
                        </span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                        <div>
                            <h3 class="fs-2">5</h3>
                            <p class="fs-5">Number of User</p>
                        </div>
                        <span class="fa-stack fa-2x">
                            <i style="color: plum;" class="fa fa-circle fa-stack-2x secondary-bg"></i>
                            <i style="color: white;" class="fa fa-users fa-stack-1x primary-text"></i>
                        </span>
                    </div>
                </div>
            </div>

            <div class="row my-5">
                <h3 class="fs-4 mb-3">Recent Orders</h3>
                <div class="col">
                    <table class="table bg-white rounded shadow-sm  table-hover">
                        <thead>
                            <tr>
                                <th scope="col" width="50">#</th>
                                <th scope="col">Product</th>
                                <th scope="col">Customer</th>
                                <th scope="col">Price (RM)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td>Cupcake Blueberry Gold</td>
                                <td>Jonny</td>
                                <td>25</td>
                            </tr>
                            <tr>
                                <th scope="row">2</th>
                                <td>Chocolate Frost</td>
                                <td>Kenny</td>
                                <td>17</td>
                            </tr>
                            <tr>
                                <th scope="row">3</th>
                                <td>Lemon cake</td>
                                <td>Jenny</td>
                                <td>20</td>
                            </tr>
                            <tr>
                                <th scope="row">4</th>
                                <td>Cheese Cake</td>
                                <td>Killy</td>
                                <td>15</td>
                            </tr>
                            <tr>
                                <th scope="row">5</th>
                                <td>Macha Cupcake</td>
                                <td>Filly</td>
                                <td>12</td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>




            <!-- column -->

        </div>
    </form>
</asp:Content>
