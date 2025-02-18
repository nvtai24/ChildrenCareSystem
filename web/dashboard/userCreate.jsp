<%-- 
    Document   : userCreate
    Created on : Feb 18, 2025, 5:04:13 PM
    Author     : Admin
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
        <jsp:include page="header.jsp"/>         
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <jsp:include page="left-sidebar.jsp"/>                         
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Create user</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="../users"><i class="fa fa-home"></i>User List</a></li>
                        <li>Add</li>
                    </ul>
                </div>    

                <form class="contact-bx" action="../users/add" method="POST" onsubmit="return validateForm()">
                    <div class="form-container">
                        <h4 class="text-center">Create new user</h4>

                        <!-- Username -->
                        <div class="form-group">
                            <label for="username">Full Name</label>
                            <input name="dzName" type="text" class="form-control" id="username" required>
                            <small id="usernameError" class="error-text"></small>
                        </div>

                        <!-- Email -->
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input name="dzEmail" type="email" class="form-control" id="email" required>
                            <small id="emailError" class="error-text"></small>
                        </div>

                        <!-- Role -->
                        <div class="form-group">
                            <label for="email">Role</label>
                            <select name="role_id">
                                <c:forEach items="${roles}" var="r">
                                    <option value="${r.id}">${r.roleName}</option>
                                </c:forEach>
                            </select>                    
                        </div>

                        <!-- Password -->
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input name="dzPassword" type="password" class="form-control" id="password" required>
                        </div>

                        <!-- Confirm Password -->
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" required>
                            <small id="passwordError" class="error-text"></small>
                        </div>

                        <!-- Submit Button -->
                        <button name="submit" type="submit" value="Submit" class="btn btn-success btn-block" >Sign Up</button>

                        <div class="text-center mt-2">

                            <a class="btn btn-danger w-100 mt-2" href="#"><i class="fa fa-google-plus"></i> Sign Up with Google</a>
                        </div>
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
                    function validateForm() {
                        var password = document.getElementById("password").value;
                        var confirmPassword = document.getElementById("confirmPassword").value;
                        var error = document.getElementById("passwordError");

                        if (password !== confirmPassword) {
                            error.textContent = "Passwords do not match!";
                            return false;
                        }
                        error.textContent = "";
                        return true;
                    }
                    $(document).ready(function () {
                        $("#username").on("blur", function () {
                            var username = $(this).val();
                            $.ajax({
                                url: "../users/add",
                                type: "POST",
                                data: {action: "checkUsername", username: username},
                                success: function (response) {
                                    if (response === "exists") {
                                        $("#usernameError").text("Username already taken.");
                                    } else {
                                        $("#usernameError").text("");
                                    }
                                }
                            });
                        });

                        $("#email").on("blur", function () {
                            var email = $(this).val();
                            $.ajax({
                                url: "../users/add",
                                type: "POST",
                                data: {action: "checkEmail", email: email},
                                success: function (response) {
                                    if (response === "exists") {
                                        $("#emailError").text("Email already in use.");
                                    } else {
                                        $("#emailError").text("");
                                    }
                                }
                            });
                        });
                    });
        </script>
    </body>
</html>

