<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <div class="account-head" style="background-image:url(assets/images/background/bg2.jpg);">
                    <a href="/app"><img src="assets/images/logo.png" alt=""></a>
                </div>
                <div class="account-form-inner">
                    <div class="account-container">
                        <div class="heading-bx left">
                            <h2 class="title-head">Sign Up <span>Now</span></h2>
                            <p>Login Your Account <a href="login">Click here</a></p>
                        </div>	
                        <form class="contact-bx" action="register" method="POST">
                            <div class="row placeani">
                                <!-- Username Field -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label for="dzName">Username</label>
                                            <input name="dzName" type="text" required="" class="form-control" id="username">
                                            <small id="usernameError" style="color:red;"></small><br>
                                        </div>
                                    </div>
                                </div>

                                <!-- Email Field -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label for="dzEmail">Your Email Address</label>
                                            <input name="dzEmail" type="email" required="" class="form-control" id="email">
                                            <small id="emailError" style="color:red;"></small><br>
                                        </div>
                                    </div>
                                </div>

                                <!-- Password Field -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group"> 
                                            <label for="dzPassword">Your Password</label>
                                            <input name="dzPassword" type="password" class="form-control" required="" id="password">
                                            <small id="passwordError" style="color:red;"></small>
                                        </div>
                                    </div>
                                </div>

                                <!-- Confirm Password Field -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group"> 
                                            <label for="confirmPassword">Confirm Password</label>
                                            <input type="password" class="form-control" required id="confirmPassword">
                                            <small id="confirmPasswordError" style="color:red;"></small><br>
                                        </div>
                                    </div>
                                </div>

                                <!-- First Name -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group"> 
                                            <label for="firstname">First Name</label>
                                            <input type="text" name="firstname" class="form-control" required id="firstname">
                                        </div>
                                    </div>
                                </div>

                                <!-- Last Name -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group"> 
                                            <label for="lastname">Last Name</label>
                                            <input type="text" name="lastname" class="form-control" required id="lastname">
                                        </div>
                                    </div>
                                </div>
                                <!-- Gender -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label for="gender">Gender</label><br>
                                        <input type="radio" name="gender" value="1" checked="true" required> Male
                                        <input type="radio" name="gender" value="2"> Female
                                    </div>
                                </div>
                                <!-- Date of Birth -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label for="dob" class="dob-label">Date of Birth</label>
                                        <input type="date" name="dob" class="form-control" required id="dob">
                                        <small id="dobError" style="color:red;"></small><br>
                                    </div>
                                </div>
                                <!-- Address -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group"> 
                                            <label for="address">Address</label>
                                            <input type="text" name="address" class="form-control" required id="address">
                                        </div>
                                    </div>
                                </div>
                                <!-- Phone -->
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group"> 
                                            <label for="phone">Phone Number</label>
                                            <input type="text" name="phone" class="form-control" required id="phone">
                                        </div>
                                    </div>
                                </div>

                                <!-- Submit Button -->
                                <div class="col-lg-12 m-b30">
                                    <button name="submit" type="submit" value="Submit" class="btn button-md">Sign Up</button>
                                </div>
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success" style="color: green; font-size: 14px;">
                                        ${successMessage}
                                    </div>
                                </c:if>
                            </div>
                        </form>

                        <!-- CSS Styling for the DOB input label -->
                        <style>
                            .dob-label {
                                position: relative;
                                z-index: 2;
                            }

                            #dob:focus + .dob-label {
                                z-index: -1;
                                visibility: hidden;
                            }
                        </style>

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
    </body>
    <script>
        $(document).ready(function () {
            $("#username").on("input", function () {
                var username = $(this).val();
                var usernameRegex = /^[A-Za-z0-9]{5,30}$/;
                if (!usernameRegex.test(username)) {
                    $("#usernameError").text("Username must be 5-30 characters and cannot contain spaces.");
                } else {
                    $("#usernameError").text("");
                    $.ajax({
                        url: "register",
                        type: "POST",
                        data: {action: "checkUsername", username: username},
                        success: function (response) {
                            if (response === "exists") {
                                $("#usernameError").text("Username already exists.");
                            } else {
                                $("#usernameError").text("");
                            }
                        }
                    });
                }
            });

            $("#email").on("input", function () {
                var email = $(this).val();
                var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                if (!emailRegex.test(email)) {
                    $("#emailError").text("Invalid email format.");
                } else {
                    $("#emailError").text("");
                    $.ajax({
                        url: "register",
                        type: "POST",
                        data: {action: "checkEmail", email: email},
                        success: function (response) {
                            if (response === "exists") {
                                $("#emailError").text("Email already exists.");
                            } else {
                                $("#emailError").text("");
                            }
                        }
                    });
                }
            });

            $("#password").on("input", function () {
                var password = $(this).val();
                var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,15}$/;
                if (!passwordRegex.test(password)) {
                    $("#passwordError").text("Password must be 8-15 characters with at least one uppercase letter, one lowercase letter, and one number.");
                } else {
                    $("#passwordError").text("");
                }
            });

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
</html>
