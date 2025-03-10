<!DOCTYPE html>
<html lang="en">

    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="Children Care" />

        <!-- OG -->
        <meta property="og:title" content="Children Care" />
        <meta property="og:description" content="Children Care" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Children Care </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

    </head>

    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <div class="account-form">
                <div class="account-head" style="background-image:url(assets/images/background/bg1.jpg);">
                    <a href="/app"><img src="assets/images/logo.png" alt=""></a>
                </div>
                <div class="account-form-inner">
                    <div class="account-container">
                        <div class="heading-bx left">
                            <h2 class="title-head">Reset <span>Password</span></h2>
                        </div>    
                        <form action="reset" method="POST" class="contact-bx">
                            <div class="row placeani">
                                <div class="col-lg-12">
                                    <input type="hidden" name="token" value="${token}" />
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label for="password">New Password</label>
                                            <input type="password" id="password" name="password" required class="form-control" />
                                            <small id="passwordError" style="color:red;"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label for="confirmPassword">Confirm New Password</label>
                                            <input type="password" id="confirmPassword" name="confirmPassword" required class="form-control" />
                                            <small id="confirmPasswordError" style="color:red;"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 m-b30">
                                    <button type="submit" class="btn button-md">Confirm</button>
                                </div>
                                <c:if test="${not empty errorMessage}">
                                    <p style="color:red;">${errorMessage}</p>
                                </c:if>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- External JavaScripts -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
    <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
    <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
    <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
    <script src="assets/vendors/counter/waypoints-min.js"></script>
    <script src="assets/vendors/counter/counterup.min.js"></script>
    <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
    <script src="assets/vendors/masonry/masonry.js"></script>
    <script src="assets/vendors/masonry/filter.js"></script>
    <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
    <script src="assets/js/functions.js"></script>
    <script src="assets/js/contact.js"></script>
    <script src='assets/vendors/switcher/switcher.js'></script>

    <script>
        $(document).ready(function () {
            // Validate password format
            $("#password").on("input", function () {
                var password = $(this).val();
                var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,15}$/;
                if (!passwordRegex.test(password)) {
                    $("#passwordError").text("Password must be 8-15 characters with at least one uppercase letter, one lowercase letter, and one number.");
                } else {
                    $("#passwordError").text("");
                }
            });

            // Confirm password match
            $("#confirmPassword").on("input", function () {
                var password = $("#password").val();
                var confirmPassword = $(this).val();
                if (password !== confirmPassword) {
                    $("#confirmPasswordError").text("Passwords do not match!");
                } else {
                    $("#confirmPasswordError").text("");
                }
            });
        });
    </script>
</body>

</html>
