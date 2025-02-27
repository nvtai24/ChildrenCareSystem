<%-- 
    Document   : customerDetail
    Created on : Feb 19, 2025, 10:55:48 PM
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
            .container {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }

            .profile-left, .profile-right {
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .profile-left {
                width: 30%;
                text-align: center;
                background-color: #fff;
            }

            .profile-right {
                width: 65%;
                padding-left: 20px;
                background-color: #fff;
            }

            .profile-left img {
                width: 120px;
                height: 120px;
                object-fit: cover;
                border-radius: 50%;
                border: 5px solid #f5f5f5;
            }

            .form-control:disabled {
                background-color: #f5f5f5;
            }

            .btn-update {
                width: 100%;
            }

            .form-group label {
                font-weight: bold;
            }

            .profile-info {
                margin-top: 20px;
            }

            .profile-info h3 {
                margin-bottom: 10px;
            }

            .profile-info p {
                font-size: 14px;
            }

            .profile-info .btn {
                margin-top: 10px;
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
                    <h4 class="breadcrumb-title">Customer Detail</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="customers"><i class="fa fa-home"></i>Customer List</a></li>
                        <li>Edit</li>
                    </ul>
                </div>    
                <form action="customer" method="POST" enctype="multipart/form-data">
                    <div class="container">
                        <!-- Left Side: Profile Info and Avatar -->

                        <input type="hidden" name="oldAvatar" value="${user.profile.avatar}"/>
                        <div class="profile-left">
                            <img id="avatarPreview" src="${pageContext.request.contextPath}/${user.profile.avatar}" alt="Profile Image">
                            <h3>User profile</h3>
                            <input type="hidden" value="${user.id}" name="id"/>
                            <p><strong>Username:</strong> ${user.username}</p>
                            <p><strong>Email:</strong> ${user.email}</p>
                            <!-- Button to trigger file input -->
                            <button type="button" class="btn btn-info" onclick="document.getElementById('avatarInput').click();">
                                <i class="fas fa-camera"></i> Change Avatar
                            </button> 

                            <!-- Hidden File Input -->
                            <input type="file" id="avatarInput" name="avatar" accept="image/*" style="display: none;" onchange="previewAvatar(event)">                            
                            <p><strong>Role </strong>
                                <select name="role" disabled>
                                    <c:forEach items="${roles}" var="r">
                                        <option value="${r.id}" ${user.role.id == r.id ? 'selected' : ''}>${r.roleName}</option>                                      
                                    </c:forEach>
                                </select>
                            </p>

                        </div>

                        <!-- Right Side: Edit User Details and Change Password -->
                        <div class="profile-right">
                            <!-- Edit Details -->
                            <!-- First Name -->
                            <div class="form-group">
                                <label for="FullName">First name</label>
                                <input type="text" class="form-control" id="FullName" name="firstname" value="${user.profile.firstName}">
                                <small id="firstNameError" class="error-text text-danger"></small>
                            </div>

                            <!-- Last Name -->
                            <div class="form-group">
                                <label for="LastName">Last name</label>
                                <input type="text" class="form-control" id="LastName" name="lastname" value="${user.profile.lastName}">
                                <small id="lastNameError" class="error-text text-danger"></small>
                            </div>
                            <div class="form-group">
                                <label for="gender">Gender</label> 
                                <input type="radio" name="gender" value="1" ${user.profile.gender  ? "checked" : ""}> Male
                                <input type="radio" name="gender" value="0" ${!user.profile.gender  ? "checked" : ""}> Female
                            </div>

                            <div class="form-group">
                                <label for="gender">Birthday </label> 
                                <input class="form-control" type="date" value="${user.profile.dob}" name="dob">
                            </div>

                            <!-- Address -->
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" name="address" value="${user.profile.address}">
                                <small id="addressError" class="error-text text-danger"></small>
                            </div>

                            <!-- Phone Number -->
                            <div class="form-group">
                                <label for="Phone">Phone number</label>
                                <input type="text" class="form-control" id="Phone" name="phone" value="${user.profile.phone}">
                                <small id="phoneError" class="error-text text-danger"></small>
                            </div>

                            <button type="submit" class="btn btn-success btn-update">Save</button>
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

                                function previewAvatar(event) {
                                    const input = event.target;
                                    if (input.files && input.files[0]) {
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            document.getElementById('avatarPreview').src = e.target.result;
                                        };
                                        reader.readAsDataURL(input.files[0]);
                                    }
                                }

                                $(document).ready(function () {
                                    function validateForm() {
                                        var isValid = true; 

                                        // check First Name
                                        var firstName = $("#FullName").val().trim();
                                        if (firstName === "") {
                                            $("#firstNameError").text("First name cannot be empty.");
                                            isValid = false;
                                        } else {
                                            $("#firstNameError").text("");
                                        }

                                        // check Last Name
                                        var lastName = $("#LastName").val().trim();
                                        if (lastName === "") {
                                            $("#lastNameError").text("Last name cannot be empty.");
                                            isValid = false;
                                        } else {
                                            $("#lastNameError").text("");
                                        }

                                        // check Address
                                        var address = $("input[name='address']").val().trim();
                                        if (address === "") {
                                            $("#addressError").text("Address cannot be empty.");
                                            isValid = false;
                                        } else {
                                            $("#addressError").text("");
                                        }

                                        // check Phone Number
                                        var phone = $("#Phone").val().trim();
                                        var phoneRegex = /^(?!-)(?!.*--)[0-9-]{7,15}(?<!-)$/;
                                        if (phone === "") {
                                            $("#phoneError").text("Phone number cannot be empty.");
                                            isValid = false;
                                        } else if (!phoneRegex.test(phone)) {
                                            $("#phoneError").text("Phone number must be 7-15 digits and can contain '-' (not consecutive).");
                                            isValid = false;
                                        } else {
                                            $("#phoneError").text("");
                                        }

                                        // check
                                        var dob = $("input[name='dob']").val();
                                       

                                        if (dob === "") {
                                            $("#dobError").text("Date of birth cannot be empty.");
                                            isValid = false;
                                        } else {
                                            $("#dobError").text("");
                                        }

                                        return isValid;
                                    }

                                    // Last check after submit
                                    $("#FullName, #LastName, input[name='address'], #Phone, input[name='dob']").on("input", function () {
                                        validateForm();
                                    });

                                    $("form").on("submit", function (e) {
                                        if (!validateForm()) {
                                            e.preventDefault(); // prevent if fail
                                            alert("Please fill in all required fields correctly before submitting.");
                                        }
                                    });
                                });

        </script>
    </body>
</html>
