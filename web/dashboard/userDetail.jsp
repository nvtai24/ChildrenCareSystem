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
                    width: 100%;
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

                            <br>

                            <!-- Button to trigger file input -->
                            <button type="button" class="btn btn-info" onclick="document.getElementById('avatarInput').click();">
                                <i class="fa fa-picture-o" aria-hidden="true"></i> Change Avatar
                            </button> 

                            <!--<h3>User profile</h3>-->

                            <input type="hidden" value="${user.id}" name="id"/>
                            <p><strong>Username:</strong> ${user.username}</p>
                            <p><strong>Email:</strong> ${user.email}</p>


                            <input type="hidden" id="hiddenMail" value="${user.email}">
                            <input type="hidden" id="hiddenStatus" value="${user.status ? 1 : 0}">

                            <input type="file" id="avatarInput" name="avatar" accept="image/*" style="display: none;" onchange="previewAvatar(event)">                             


                            <div style="margin-top: 10px; display: flex; justify-content: center; align-items: center; gap: 10px" >
                                <button onclick="resetPasswordAjax()" type="button" class="btn btn-success green" style="width: 50%">Reset password</button>

                                <c:if test="${user.status == true}">
                                    <button  onclick="banUserAjax()" id="banButton" type="button" class="btn btn-danger red" style="width: 50%; ${user.role.roleName eq 'Admin' ? 'display: none;' : ''}">Ban</button>
                                </c:if>

                                <c:if test="${user.status == false}">
                                    <button  onclick="banUserAjax()" id="banButton" type="button" class="btn btn-success green" style="width: 50%">Unban</button>
                                </c:if>


                            </div>

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
                                <br>
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

                            <div class="form-group">
                                <label>Role</label>
                                <select name="role" style="width: 100%" class="form-control">
                                    <c:forEach items="${roles}" var="r">
                                        <option value="${r.id}" ${user.role.id == r.id ? 'selected' : ''}>${r.roleName}</option>                                      
                                    </c:forEach>
                                </select>
                            </div>


                            <div style="display: flex; gap: 10px; justify-content: center; width: 100%;">

                                <button type="submit" class="btn btn-success btn-update" style="flex: 1;">Save</button>
                            </div>
                        </div>

                    </div>
                </form>

            </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


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
            function validateField(fieldId, errorId, validationFunction) {
                const field = document.getElementById(fieldId);
                const errorElement = document.getElementById(errorId);
                const value = field.value.trim();

                const validationResult = validationFunction(value);

                if (validationResult !== true) {
                    errorElement.textContent = validationResult;
                    return false;
                } else {
                    errorElement.textContent = "";
                    return true;
                }
            }

            function validateFirstName(value) {
                if (value === "")
                    return "First name cannot be empty.";
                if (value.length > 70)
                    return "First name must be less than 70 characters.";
                return true;
            }

            function validateLastName(value) {
                if (value === "")
                    return "Last name cannot be empty.";
                if (value.length > 70)
                    return "Last name must be less than 70 characters.";
                return true;
            }

            function validateDob(value) {
                if (value === "")
                    return "Date of birth cannot be empty.";
                const today = new Date().toISOString().split("T")[0];
                if (value > today)
                    return "Date of birth cannot be in the future.";
                return true;
            }

            function validateAddress(value) {
                if (value === "")
                    return "Address cannot be empty.";
                return true;
            }

            function validatePhone(value) {
                const regex = /^(?!-)(?!.*--)[0-9-]{7,15}(?<!-)$/;
                if (!regex.test(value)) {
                    return "Phone number must be 7?15 digits and can include '-' (not at start/end or consecutive).";
                }
                return true;
            }

            function validateForm() {
                let isValid = true;

                isValid = validateField('firstName', 'firstNameError', validateFirstName) && isValid;
                isValid = validateField('lastName', 'lastNameError', validateLastName) && isValid;
                isValid = validateField('dob', 'dobError', validateDob) && isValid;
                isValid = validateField('address', 'addressError', validateAddress) && isValid;
                isValid = validateField('phone', 'phoneError', validatePhone) && isValid;

                return isValid;
            }

            $(document).ready(function () {
                // Validate on input/change
                $('#firstName').on('input', () => validateField('firstName', 'firstNameError', validateFirstName));
                $('#lastName').on('input', () => validateField('lastName', 'lastNameError', validateLastName));
                $('#dob').on('change', () => validateField('dob', 'dobError', validateDob));
                $('#address').on('input', () => validateField('address', 'addressError', validateAddress));
                $('#phone').on('input', () => validateField('phone', 'phoneError', validatePhone));

                // Final check on submit
                $('form').on('submit', function (e) {
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
                const input = event.target;
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        $('#avatarPreview').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>



        <script>

            var email = $('#hiddenMail').val();

            function resetPasswordAjax() {

                $.ajax({
                    url: "/app/reset-ajax",
                    type: "POST",
                    data: {email: email},
                    success: function (response) {
                        Swal.fire({
                            title: "Good job!",
                            text: "Reset password link sent successfully!",
                            icon: "success"
                        });

                    },
                    error: function (xhr, status, error) {
                        Swal.fire({
                            icon: "error",
                            title: "Oops...",
                            text: "Something went wrong!",
                            footer: '<a href="#">Why do I have this issue?</a>'
                        });
                    }
                });
            }


            function banUserAjax() {
                let status = $('#hiddenStatus').val();

                let msg = '';
                let contentBtn = '';
                let classBtn = '';
                let newStatus;


                if (status == 1) {
                    msg = 'User has been banned!';
                    contentBtn = 'Unban';
                    classBtn = 'btn btn-success green';
                    newStatus = 0;

                } else {
                    msg = 'Unban successfully!';
                    contentBtn = 'Ban';
                    classBtn = 'btn btn-danger red';
                    newStatus = 1;
                }

                $.ajax({
                    url: "/app/ban-ajax",
                    type: "POST",
                    data: {email: email},
                    success: function (response) {
                        Swal.fire({
                            title: "Done!",
                            text: msg,
                            icon: "success"
                        });

                        $('#banButton').html(contentBtn);
                        $('#banButton').attr('class', classBtn);
                        $('#hiddenStatus').val(newStatus);

                    },
                    error: function (xhr, status, error) {
                        Swal.fire({
                            icon: "error",
                            title: "Oops...",
                            text: "Something went wrong!",
                            footer: '<a href="#">Why do I have this issue?</a>'
                        });
                    }
                });

            }
        </script>

        <script src="assets2/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets2/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets2/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets2/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets2/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets2/vendors/counter/waypoints-min.js"></script>
        <script src="assets2/vendors/counter/counterup.min.js"></script>
        <script src="assets2/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets2/vendors/masonry/masonry.js"></script>
        <script src="assets2/vendors/masonry/filter.js"></script>
        <script src="assets2/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='assets2/vendors/scroll/scrollbar.min.js'></script>
        <script src="assets2/js/functions.js"></script>
        <script src="assets2/vendors/chart/chart.min.js"></script>
        <script src="assets2/js/admin.js"></script>
        <script src='assets2/vendors/calendar/moment.min.js'></script>
        <script src='assets2/vendors/calendar/fullcalendar.js'></script>
    </body>
</html>
