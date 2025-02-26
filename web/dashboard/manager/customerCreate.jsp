<%-- 
    Document   : customerCreate
    Created on : Feb 19, 2025, 10:56:02 PM
    Author     : milo9
--%>


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
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="${pageContext.request.contextPath}/assets/images/logo.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Children Care</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/assets.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/style.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/color/color-1.css">
        <style>
            .form-container {
                max-width: 450px;
                margin: auto;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 1px solid #ccc;
            }

            .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .form-control {
                border-radius: 5px;
            }

            .btn-block {
                width: 100%;
            }

            .error-text {
                color: red;
                font-size: 13px;
            }

            .success-text {
                color: green;
                font-weight: bold;
            }
        </style>

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <jsp:include page="../../dashboard/header.jsp"/>         
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <jsp:include page="../../dashboard/left-sidebar.jsp"/>                           
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Create customer <i class="fa fa-user-o" aria-hidden="true"></i></h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="../customers"><i class="fa fa-home"></i>Customer List</a></li>
                        <li>Add </li>
                    </ul>
                </div>    

                <form class="contact-bx" action="../customer/add" method="POST" onsubmit="return validateForm()">
                    <div class="form-container">
                        <h4 class="text-center">Create customer</h4>

                        <!-- Username -->
                        <div class="form-group">
                            <label for="username">User Name</label>
                            <input name="dzName" type="text" class="form-control" id="username" required>
                            <small id="usernameError" class="error-text"></small>
                        </div>

                        <!-- Email -->
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input name="dzEmail" type="email" class="form-control" id="email" required>
                            <small id="emailError" class="error-text"></small>
                        </div>


                        <!-- Password -->
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input name="dzPassword" type="password" class="form-control" id="password" required>
                            <small id="passwordError" class="error-text"></small>
                        </div>

                        <!-- Confirm Password -->
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" required>
                            <small id="confirmPasswordError" class="error-text"></small>
                        </div>

                        <!-- Submit Button -->
                        <button name="submit" type="submit" value="Submit" class="btn btn-success btn-block" >Create customer <i class="fa fa-plus-circle" aria-hidden="true"></i></button>


                    </div>
                </form>
            </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="${pageContext.request.contextPath}/assets2/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/counter/waypoints-min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/counter/counterup.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/masonry/masonry.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/masonry/filter.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='${pageContext.request.contextPath}/assets2/vendors/scroll/scrollbar.min.js'></script>
        <script src="${pageContext.request.contextPath}/assets2/js/functions.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/chart/chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/js/admin.js"></script>
        <script src='${pageContext.request.contextPath}/assets2/vendors/switcher/switcher.js'></script>
        <script>
                    $(document).ready(function () {
                        var isValid = true;

                        $("#username").on("input", function () {
                            var username = $(this).val();
                            var usernameRegex = /^[A-Za-z0-9]{5,30}$/;
                            if (!usernameRegex.test(username)) {
                                $("#usernameError").text("Username must be 5-30 characters and cannot contain spaces.");
                                isValid = false;
                            } else {
                                $("#usernameError").text("");
                                $.ajax({
                                    url: "../customer/add",
                                    type: "GET", // Thay vì POST
                                    data: {action: "checkUsername", username: username},
                                    success: function (response) {
                                        if (response === "exists") {
                                            $("#usernameError").text("Username already exists.");
                                            isValid = false;
                                        } else {
                                            $("#usernameError").text("");
                                            isValid = true;
                                        }
                                    },
                                    error: function () {
                                        $("#usernameError").text("Error checking username.");
                                        isValid = false;
                                    }
                                });
                            }
                        });

                        $("#email").on("input", function () {
                            var email = $(this).val();
                            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                            if (!emailRegex.test(email)) {
                                $("#emailError").text("Invalid email format.");
                                isValid = false;
                            } else {
                                $("#emailError").text("");
                                $.ajax({
                                    url: "../customer/add",
                                    type: "GET", // Thay vì POST
                                    data: {action: "checkEmail", email: email},
                                    success: function (response) {
                                        if (response === "exists") {
                                            $("#emailError").text("Email already exists.");
                                            isValid = false;
                                        } else {
                                            $("#emailError").text("");
                                            isValid = true;
                                        }
                                    },
                                    error: function () {
                                        $("#emailError").text("Error checking email.");
                                        isValid = false;
                                    }
                                });
                            }
                        });


                        $("#password").on("input", function () {
                            var password = $(this).val();
                            var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,15}$/;
                            if (!passwordRegex.test(password)) {
                                $("#passwordError").text("Password must be 8-15 characters with at least one uppercase letter, one lowercase letter, and one number.");
                                isValid = false;
                            } else {
                                $("#passwordError").text("");
                                isValid = true;
                            }


                            validateConfirmPassword();
                        });

                        $("#confirmPassword").on("input", function () {
                            validateConfirmPassword();
                        });

                        function validateConfirmPassword() {
                            var password = $("#password").val();
                            var confirmPassword = $("#confirmPassword").val();
                            if (password !== confirmPassword) {
                                $("#confirmPasswordError").text("Passwords do not match!");
                                isValid = false;
                            } else {
                                $("#confirmPasswordError").text("");
                                isValid = true;
                            }
                        }

                        $("form").on("submit", function (e) {
                            isValid = true;

                            if ($("#usernameError").text() !== "" ||
                                    $("#emailError").text() !== "" ||
                                    $("#passwordError").text() !== "" ||
                                    $("#confirmPasswordError").text() !== "") {
                                isValid = false;
                            }

                            if (!isValid) {
                                e.preventDefault();
                                alert("Please correct the errors before submitting.");
                            }
                        });
                    });


        </script>
    </body>
</html>
