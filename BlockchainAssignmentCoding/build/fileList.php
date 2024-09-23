<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Blockchain Demo</title>
    <meta name="description" content="">
    <meta name="keywords" content="">

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon">
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Main CSS File -->
    <link href="assets/css/main.css" rel="stylesheet">

</head>

<body class="index-page">

    <header id="header" class="header d-flex align-items-center fixed-top">
        <?php include 'assets/includes/header.php'; ?>
    </header>

    <main class="main">
         <!-- Hero Section -->
    <section id="hero" class="hero section dark-background">

<img src="assets/img/world-dotted-map.png" alt="" class="hero-bg" data-aos="fade-in">

<div class="container">
  <div class="row gy-4 d-flex justify-content-between">
    <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
      <h2 data-aos="fade-up">File List</h2>
      <p data-aos="fade-up" data-aos-delay="100">Current file list</p>
    </div>
  </div>
</div>

</section><!-- /Hero Section -->
<!-- Content Section -->
<section id="featured-services" class="featured-services section">
            <div class="container">
                <div class="row gy-4">
                    <!-- Filters and Search Bar -->
                    <div class="col-12 mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <form class="d-flex">
                                <input class="form-control me-2" type="search" placeholder="Search files" aria-label="Search">
                                <button class="btn btn-primary" type="submit">Search</button>
                            </form>
                            <div>
                                <button class="btn btn-success">Upload File</button>
                            </div>
                        </div>
                    </div>

                    <!-- File List Table -->
                    <div class="col-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>File Name</th>
                                        <th>File Type</th>
                                        <th>Size</th>
                                        <th>Upload Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Example Rows -->
                                    <tr>
                                        <td>1</td>
                                        <td>blockchain-data.json</td>
                                        <td>JSON</td>
                                        <td>1.2 MB</td>
                                        <td>2024-08-25</td>
                                        <td>
                                            <a href="#" class="btn btn-info btn-sm">View</a>
                                            <a href="#" class="btn btn-primary btn-sm">Download</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>transaction-log.csv</td>
                                        <td>CSV</td>
                                        <td>800 KB</td>
                                        <td>2024-08-24</td>
                                        <td>
                                            <a href="#" class="btn btn-info btn-sm">View</a>
                                            <a href="#" class="btn btn-primary btn-sm">Download</a>
                                        </td>
                                    </tr>
                                    <!-- Add more rows as needed -->
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <div class="col-12 mt-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <span class="page-link">Previous</span>
                                </li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </section><!-- /Content Section -->

    </main>

    <footer id="footer" class="footer dark-background">

        <?php include 'assets/includes/footer.php'; ?>

    </footer>

    <!-- Scroll Top -->
    <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

    <!-- Preloader -->
    <div id="preloader"></div>

    <!-- Vendor JS Files -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
    <script src="assets/vendor/aos/aos.js"></script>
    <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
    <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

    <!-- Main JS File -->
    <script src="assets/js/main.js"></script>
</body>

</html>