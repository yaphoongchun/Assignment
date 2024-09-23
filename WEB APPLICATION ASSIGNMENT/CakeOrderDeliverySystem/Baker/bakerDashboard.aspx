<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="bakerDashboard.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.bakerDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Vendor CSS Files -->
    <link href="../vendors/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="../vendors/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="../vendors/quill/quill.snow.css" rel="stylesheet">
    <link href="../vendors/quill/quill.bubble.css" rel="stylesheet">
    <link href="../vendors/remixicon/remixicon.css" rel="stylesheet">
    <link href="../vendors/simple-datatables/style.css" rel="stylesheet">
    <!-- Template Main CSS File -->
    <link href="../css/NiceAdminCss.css" rel="stylesheet">
    <style>
        /* Custom styles for the dashboard */
        .section.dashboard .card {
            margin-bottom: 20px;
        }

        .filter .icon {
            color: #6c757d;
        }

        .filter .dropdown-menu {
            border: none;
            border-radius: 0;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }

            .filter .dropdown-menu a {
                color: #6c757d;
                font-size: 14px;
            }

        .info-card .card-title {
            font-size: 18px;
            margin-bottom: 15px;
        }

        .info-card .card-icon {
            width: 50px;
            height: 50px;
            font-size: 24px;
            background-color: #f8f9fa;
            color: #495057;
            border-radius: 50%;
            margin-right: 15px;
        }

            .info-card .card-icon i {
                margin-top: 12px;
            }

        .dashboard .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .dashboard .col {
            flex-basis: calc(50% - 20px); /* Adjust the width as needed */
            margin-bottom: 20px;
        }

        .dashboard .card {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
    <form id="dashboardForm" runat="server">
        <section class="section dashboard">
            <div class="col-lg-8">
                <div class="row">
                    <!-- Customers Card -->
                    <div class="col-xxl-4 col-xl-12">
                        <div class="card info-card customers-card">
                            <div class="card-body">
                                <h5 class="card-title">Customers <span>| This Year</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6>
                                            <asp:Label ID="lblTotalCustomers" runat="server" Text=""></asp:Label></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Customers Card -->

                    <!-- Revenue Card -->
                    <div class="col-xxl-4 col-md-6">
                        <div class="card info-card revenue-card">
                            <div class="card-body">
                                <h5 class="card-title">Revenue <span>| This Year</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-currency-dollar"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6>
                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Revenue Card -->

                    <!-- Sales Card -->
                    <div class="col-xxl-4 col-md-6">
                        <div class="card info-card sales-card">
                            <div class="card-body">
                                <h5 class="card-title">Sales <span>| This Year</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-cart"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6>
                                            <asp:Label ID="lblTotalOrders" runat="server" Text=""></asp:Label></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Sales Card -->

                    <!-- Reports -->
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Sales Reports</h5>
                                <!-- Line Chart -->
                                <div id="salesChart"></div>
                                <script>
                                    document.addEventListener("DOMContentLoaded", () => {
                                        // Get total revenue data from server-side code
                                        var revenueData = <%= GetTotalRevenueByDateJson() %>;

                                        // Extract dates and revenue data from the object
                                        var dates = Object.keys(revenueData);
                                        var revenues = Object.values(revenueData);

                                        renderSalesChart(dates, revenues);
                                    });

                                    // Function to render sales chart
                                    function renderSalesChart(dates, revenues) {
                                        new ApexCharts(document.querySelector("#salesChart"), {
                                            series: [{
                                                name: 'Total Revenue',
                                                data: revenues
                                            }],
                                            xaxis: {
                                                categories: dates
                                            },
                                            chart: {
                                                height: 350,
                                                type: 'area',
                                                toolbar: {
                                                    show: false
                                                },
                                            },
                                            // Other chart options...
                                        }).render();
                                    }
                                </script>
                                <!-- End Line Chart -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Left side columns -->
            </div>
            <!-- End row -->
        </section>
    </form>
    <script src="../vendors/apexcharts/apexcharts.min.js"></script>
    <script src="../vendors/chart.js/chart.umd.js"></script>
    <script src="../vendors/echarts/echarts.min.js"></script>
    <script src="../vendors/quill/quill.min.js"></script>
    <script src="../vendors/simple-datatables/simple-datatables.js"></script>
    <script src="../vendors/tinymce/tinymce.min.js"></script>
    <script src="../vendors/php-email-form/validate.js"></script>
    <script src="../js/main.js"></script>
</asp:Content>
