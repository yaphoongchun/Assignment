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
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Main CSS File -->
    <link href="assets/css/main.css" rel="stylesheet">

    <style>
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url('assets/img/background.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .login-form {
            background: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            transition: all 0.3s ease-in-out;
        }

        .login-form:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }

        .login-form h2 {
            margin-bottom: 1.5rem;
            font-size: 1.75rem;
            text-align: center;
            color: #333;
        }

        .login-form .form-group {
            margin-bottom: 1rem;
        }

        .login-form .form-control {
            border-radius: 4px;
            border: 2px solid #007bff;
            padding: 0.75rem 1.25rem;
            transition: border-color 0.3s;
        }

        .login-form .form-control:focus {
            border-color: #0056b3;
            box-shadow: none;
        }

        .login-form button {
            width: 100%;
            border-radius: 4px;
            padding: 0.75rem;
            background-color: #007bff;
            border: none;
            color: white;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        .login-form button:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }

        .login-form .alert {
            margin-top: 1rem;
            font-size: 0.875rem;
        }

        .login-form .form-label {
            color: #333;
            font-weight: 600;
        }

        .login-form .form-text {
            font-size: 0.8rem;
            color: #6c757d;
        }

        .login-form .login-options {
            margin-top: 1rem;
            text-align: center;
        }

        .login-form .login-options a {
            color: #007bff;
            font-size: 0.9rem;
            text-decoration: none;
        }

        .login-form .login-options a:hover {
            text-decoration: underline;
        }
    </style>
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
                <div class="login-container">
                    <div class="login-form">
                        <h2>Login to Blockchain</h2>
                        
                        <!-- Error message -->
                        <div id="error-message" class="alert alert-danger d-none" role="alert">
                            Invalid credentials, please try again.
                        </div>

                        <form id="login-form" action="/login" method="POST">
                            <div class="form-group">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username" required>
                            </div>
                            <div class="form-group">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                            </div>
                            <button type="submit">Login</button>
                        </form>

                        <!-- Additional Options -->
                        <div class="login-options">
                            <a href="/forgot-password">Forgot Password?</a> | <a href="signUp.php">Don't have an account? Sign up</a>
                        </div>
                    </div>
                </div>
            </div>
        </section><!-- /Hero Section -->

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

    <!-- Inline JavaScript for Form Handling -->
    <script>
        document.getElementById('login-form').addEventListener('submit', function(event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            // Basic validation (additional server-side validation needed)
            if (!username || !password) {
                document.getElementById('error-message').classList.remove('d-none');
                return;
            }

            // Perform authentication (placeholder)
            // Replace with actual authentication logic
            fetch('/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username: username,
                    password: password
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Redirect to the main application
                    window.location.href = '/dashboard';
                } else {
                    // Show error message
                    document.getElementById('error-message').classList.remove('d-none');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('error-message').classList.remove('d-none');
            });
        });
    </script>

</body>

</html>
