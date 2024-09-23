<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="bakerReport.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.bakerReport" %>
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
    <form id="mainForm" runat="server">
        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Baker Reports</h5>
                            <!-- Table to display product data -->
                            <div class="table-responsive">
                                <table class="table datatable">
                                    <thead>
                                        <tr>
                                            <th>Product Name</th>
                                            <th>Price</th>
                                            <th>Amount</th>
                                            <th>Order Date</th>
                                            <th>Category Name</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Literal ID="litTableData" runat="server"></asp:Literal>
                                    </tbody>
                                </table>
                            </div>
                            <!-- End Table -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
    </form>
        <!-- Vendor JS Files -->
<script src="../vendors/apexcharts/apexcharts.min.js"></script>
<script src="../vendors/chart.js/chart.umd.js"></script>
<script src="../vendors/echarts/echarts.min.js"></script>
<script src="../vendors/quill/quill.min.js"></script>
<script src="../vendors/simple-datatables/simple-datatables.js"></script>
<script src="../vendors/tinymce/tinymce.min.js"></script>
<script src="../vendors/php-email-form/validate.js"></script>
<!-- Template Main JS File -->
<script src="../js/main.js"></script>
</asp:Content>