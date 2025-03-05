<%-- 
    Document   : UserDetail
    Created on : Jan 23, 2025, 11:43:25 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                justify-content: center;
                align-items: flex-start;
                gap: 40px;
                margin-top: 30px;
                width: 100%;
            }

            .profile-left, .profile-right {
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                border: 1px solid #ddd;
                background-color: #fff;
            }

            .profile-left {
                width: 35%;
                text-align: center;
            }

            .profile-right {
                width: 60%;
            }

            .profile-left img {
                width: 150px;
                height: 150px;
                object-fit: cover;
                border-radius: 50%;
                border: 5px solid #f5f5f5;
            }

            .form-control {
                height: 45px;
                font-size: 16px;
                padding: 10px;
            }

            .btn-update {
                width: 100%;
                height: 50px;
                font-size: 18px;
            }

            .form-group label {
                font-weight: bold;
                font-size: 16px;
            }

            @media (max-width: 992px) {
                .container {
                    flex-direction: column;
                    align-items: center;
                }

                .profile-left, .profile-right {
                    width: 90%;
                }
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
                    <h4 class="breadcrumb-title">User Detail</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="../users"><i class="fa fa-home"></i>User List</a></li>
                        <li>Edit</li>
                    </ul>
                </div>    
                <form action="../users/update" method="POST" enctype="multipart/form-data">
                    <div class="container">
                        <!-- Left Side: Profile Info and Avatar -->

                        <input type="hidden" name="oldAvatar" value="${user.profile.avatar}"/>
                        <div class="profile-left">
                            <img id="avatarPreview" src="<c:choose>
                                     <c:when test="${not empty user.profile.avatar}">
                                         ${pageContext.request.contextPath}/${user.profile.avatar}
                                     </c:when>
                                     <c:otherwise>
                                         ${pageContext.request.contextPath}/assets/images/profile/default.jpg
                                     </c:otherwise>
                                 </c:choose>
                                 " alt="Profile Image">
                            <h3>User profile</h3>
                            <input type="hidden" value="${user.id}" name="id"/>
                            <p><strong>Username:</strong> ${user.username}</p>
                            <p><strong>Email:</strong> ${user.email}</p>
                            <!-- Button to trigger file input -->
                            <button type="button" class="btn btn-info" onclick="document.getElementById('avatarInput').click();">
                                <i class="fa fa-picture-o" aria-hidden="true"></i> Change Avatar
                            </button> 

                            <!-- Hidden File Input -->
                            <input type="file" id="avatarInput" name="avatar" accept="image/*" style="display: none;" onchange="previewAvatar(event)">                            
                            <p><strong>Role </strong>
                                <select name="role">
                                    <c:forEach items="${roles}" var="r">
                                        <option value="${r.id}" ${user.role.id == r.id ? 'selected' : ''}>${r.roleName}</option>                                      
                                    </c:forEach>
                                </select>
                            </p>

                        </div>

                        <!-- Right Side: Edit User Details and Change Password -->
                        <div class="profile-right">
                            <!-- Edit Details -->
                            <div class="form-group">
                                <label for="FirstName">First name</label>
                                <input type="text" class="form-control" id="firstName" name="firstname" value="${user.profile.firstName}">
                                <small id="firstNameError" class="error-text text-danger"></small>
                            </div>

                            <div class="form-group">
                                <label for="LastName">Last name</label>
                                <input type="text" class="form-control" id="lastName" name="lastname" value="${user.profile.lastName}">
                                <small id="lastNameError" class="error-text text-danger"></small>
                            </div>

                            <div class="form-group">
                                <label for="gender">Gender</label> 
                                <input type="radio" name="gender" value="1" ${user.profile.gender  ? "checked" : ""}> Male <i class="fa fa-male" aria-hidden="true"></i>
                                <input type="radio" name="gender" value="0" ${!user.profile.gender  ? "checked" : ""}> Female <i class="fa fa-female" aria-hidden="true"></i>
                            </div>

                            <div class="form-group">
                                <label for="dob">Date of Birth</label>
                                <input class="form-control" type="date" id="dob" name="dob" value="${user.profile.dob}">
                                <small id="dobError" class="error-text text-danger"></small>
                            </div>

                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" name="address" value="${user.profile.address}">
                                <small id="addressError" class="error-text text-danger"></small>
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="${user.profile.phone}">
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        <c:if test="${not empty notification}">
            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    Swal.fire({
                                        title: "<c:out value='${notification eq "successfull" ? "Success!" : "Oops..."}' />",
                                        text: "<c:out value='${notification eq "successfull" ? "User has been created successfully." : "User cannot update please try again!"}' />",
                                        icon: "<c:out value='${notification eq "successfull" ? "success" : "error"}' />",
                                        confirmButtonText: "OK",
                                        didOpen: () => {
                                            document.querySelector(".swal2-select")?.remove();
                                        }
                                    });
                                });
            </script>
        </c:if>
        <script>
            $(document).ready(function () {
                function validateForm() {
                    var isValid = true;

                    // Validate First Name
                    var firstName = $("#firstName").val().trim();
                    if (firstName === "") {
                        $("#firstNameError").text("First name cannot be empty.");
                        isValid = false;
                    } else {
                        $("#firstNameError").text("");
                    }

                    // Validate Last Name
                    var lastName = $("#lastName").val().trim();
                    if (lastName === "") {
                        $("#lastNameError").text("Last name cannot be empty.");
                        isValid = false;
                    } else {
                        $("#lastNameError").text("");
                    }

                    // Validate Date of Birth (must be before today)
                    var dob = $("#dob").val();

                    if (dob === "") {
                        $("#dobError").text("Date of birth cannot be empty");
                        isValid = false;
                    } else {
                        $("#dobError").text("");
                    }

                    // Validate Address
                    var address = $("#address").val().trim();
                    if (address === "") {
                        $("#addressError").text("Address cannot be empty.");
                        isValid = false;
                    } else {
                        $("#addressError").text("");
                    }

                    // Validate Phone Number (7-15 digits, can include "-")
                    var phone = $("#phone").val().trim();
                    var phoneRegex = /^(?!-)(?!.*--)[0-9-]{7,15}(?<!-)$/;
                    if (!phoneRegex.test(phone)) {
                        $("#phoneError").text("Phone number must be 7-15 digits and can contain '-' (not consecutive).");
                        isValid = false;
                    } else {
                        $("#phoneError").text("");
                    }

                    return isValid;
                }

                // Validate on input change
                $("#firstName, #lastName, #dob, #address, #phone").on("input change", function () {
                    validateForm();
                });

                // Prevent form submission if validation fails
                $("form").on("submit", function (e) {
                    if (!validateForm()) {
                        e.preventDefault();
                        Swal.fire({
                            title: 'Oops...',
                            text: 'Please check form again!',
                            icon: 'error',
                            confirmButtonText: 'Try Again'
                        });
                    }
                });
            });

            function previewAvatar(event) {
                var input = event.target;
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#avatarPreview").attr("src", e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
    </body>
</html>
