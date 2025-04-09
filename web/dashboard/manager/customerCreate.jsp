<%-- 
    Document   : customerCreate
    Created on : Feb 19, 2025, 10:56:02 PM
    Author     : milo9
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
            /* Ensure table layout remains stable */
            .table-borderless {
                width: 100%;
                table-layout: fixed; /* Fix column widths to prevent shifting */
            }

            /* Ensure all table cells have the same vertical alignment */
            .table-borderless tbody tr td {
                vertical-align: top; /* Keep inputs aligned at the top */
                padding-bottom: 10px; /* Space between rows */
            }

            /* Prevent input fields from shifting due to small error messages */
            .form-group {
                position: relative;
                min-height: 65px; /* Ensures enough space for both input and error message */
            }

            /* Style input fields for consistency */
            .form-control {
                width: 100%;
                margin-bottom: 0; /* Prevent extra spacing */
            }

            /* Ensure error messages do not push elements */
            small.text-danger {
                display: block; /* Keeps it separate from input */
                font-size: 12px; /* Reduce size */
                color: red;
                height: 16px; /* Set a fixed height to prevent movement */
                margin-top: 3px; /* Adds spacing between input and message */
            }

            /* Keep the submit button aligned */
            .d-grid .btn {
                width: 100%;
                height: 40px; /* Ensure consistent height */
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
                    <table class="table table-borderless w-100">
                        <tbody>
                            <!-- Row 1: Username - First Name -->
                            <tr>
                                <td>
                                    <label for="username">User Name</label>
                                    <input name="dzName" type="text" class="form-control" id="username" >
                                    <small id="usernameError" class="text-danger"></small>
                                </td>
                                <td>
                                    <label for="password">Password</label>
                                    <input name="dzPassword" type="password" class="form-control" id="password" >
                                    <small id="passwordError" class="text-danger"></small>
                                </td>
                            </tr>

                            <!-- Row 2: Email - Last Name -->
                            <tr>
                                <td>
                                    <label for="email">Email Address</label>
                                    <input name="dzEmail" type="email" class="form-control" id="email" >
                                    <small id="emailError" class="text-danger"></small>
                                </td>
                                <td>
                                    <label for="confirmPassword">Confirm Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" >
                                    <small id="confirmPasswordError" class="text-danger"></small>
                                </td>
                            </tr>

                            <!-- Row 3: Role - Gender -->
                            <tr>
                                <td>
                                    <label for="role">Role</label>
                                    <select name="role_id" class="form-control">
                                        <option value="15">Customer</option>
                                    </select>
                                </td>
                                <td>
                                    <label for="gender">Gender</label>
                                    <div class="d-flex align-items-center">
                                        <input type="radio" name="gender" value="1" checked class="me-2" style="margin-right: 10px">Male<i class="fa fa-male" aria-hidden="true" style="margin: auto 10px"></i>  
                                        <input type="radio" name="gender" value="0" class="ms-3 me-2" style="margin-right: 10px"> Female<i class="fa fa-female" aria-hidden="true" style="margin: auto 10px"></i>
                                    </div>
                                </td>
                            </tr>

                            <!-- Row 4: Password - Date of Birth -->
                            <tr>
                                <td>
                                    <label for="firstName">First name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstname" >
                                    <small id="firstNameError" class="text-danger"></small>
                                </td>
                                <td>
                                    <label for="dob">Date of Birth</label>
                                    <input class="form-control" type="date" id="dob" name="dob" >
                                    <small id="dobError" class="text-danger"></small>
                                </td>
                            </tr>

                            <!-- Row 5: Confirm Password - Address -->
                            <tr>
                                <td>
                                    <label for="lastName">Last name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastname" >
                                    <small id="lastNameError" class="text-danger"></small>
                                </td>
                                <td>
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" >
                                    <small id="addressError" class="text-danger"></small>
                                </td>
                            </tr>

                            <!-- Row 6: Phone - Submit Button -->
                            <tr>
                                <td>
                                    <label for="phone">Phone Number</label>
                                    <input type="text" class="form-control" id="phone" name="phone" >
                                    <small id="phoneError" class="text-danger"></small>
                                </td>
                                <td>
                                    <div class="d-grid">
                                        <button name="submit" type="submit" value="Submit" class="btn btn-warning btn-lg w-100" style="margin-top: 34px">
                                            Create user <i class="fa fa-plus-circle"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
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
        <c:if test="${not empty notification}">
            <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        Swal.fire({
                            title: "<c:out value='${notification eq "successfull" ? "Success!" : "Oops..."}' />",
                            text: "<c:out value='${notification eq "successfull" ? "Customer has been created successfully." : "Customer cannot create please try again!"}' />",
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
                const result = validationFunction(value);
                if (result !== true) {
                    errorElement.textContent = result;
                    return false;
                } else {
                    errorElement.textContent = "";
                    return true;
                }
            }

            function validateUsername(value) {
                if (!/^[A-Za-z0-9]{5,30}$/.test(value))
                    return "Username must be 5-30 characters without spaces.";
                return true;
            }

            function validateEmail(value) {
                if (!/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(value))
                    return "Invalid email format.";
                return true;
            }

            function validatePassword(value) {
                const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}$/;
                if (!passwordRegex.test(value))
                    return "Password must be 8-15 chars with uppercase, lowercase & number.";
                return true;
            }

            function validateConfirmPassword(value) {
                const password = $("#password").val();
                if (value !== password)
                    return "Passwords do not match.";
                return true;
            }

            function validateName(value) {
                if (value === "")
                    return "This field cannot be empty.";
                if (!/^[A-Za-z\s]+$/.test(value))
                    return "Only letters are allowed.";
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
                const phoneRegex = /^(?!-)(?!.*--)[0-9-]{7,15}(?<!-)$/;
                if (!phoneRegex.test(value))
                    return "Phone must be 7-15 digits, allow '-' (not start/end or consecutive).";
                return true;
            }

            async function checkUsernameUnique(username) {
                return await $.ajax({
                    url: "../customer/add",
                    type: "GET",
                    data: {action: "checkUsername", username: username}
                }).then(res => res !== "exists");
            }

            async function checkEmailUnique(email) {
                return await $.ajax({
                    url: "../customer/add",
                    type: "GET",
                    data: {action: "checkEmail", email: email}
                }).then(res => res !== "exists");
            }

            async function validateForm() {
                let isValid = true;
                const username = $("#username").val().trim();
                const email = $("#email").val().trim();
                isValid = validateField('username', 'usernameError', validateUsername) && isValid;
                if (isValid && !(await checkUsernameUnique(username))) {
                    $("#usernameError").text("Username already exists.");
                    isValid = false;
                }

                isValid = validateField('email', 'emailError', validateEmail) && isValid;
                if (isValid && !(await checkEmailUnique(email))) {
                    $("#emailError").text("Email already exists.");
                    isValid = false;
                }

                isValid = validateField('password', 'passwordError', validatePassword) && isValid;
                isValid = validateField('confirmPassword', 'confirmPasswordError', validateConfirmPassword) && isValid;
                isValid = validateField('firstName', 'firstNameError', validateName) && isValid;
                isValid = validateField('lastName', 'lastNameError', validateName) && isValid;
                isValid = validateField('dob', 'dobError', validateDob) && isValid;
                isValid = validateField('address', 'addressError', validateAddress) && isValid;
                isValid = validateField('phone', 'phoneError', validatePhone) && isValid;
                return isValid;
            }

            $(document).ready(function () {
                $("#username").on("input", () => validateField("username", "usernameError", validateUsername));
                $("#email").on("input", () => validateField("email", "emailError", validateEmail));
                $("#password").on("input", () => validateField("password", "passwordError", validatePassword));
                $("#confirmPassword").on("input", () => validateField("confirmPassword", "confirmPasswordError", validateConfirmPassword));
                $("#firstName").on("input", () => validateField("firstName", "firstNameError", validateName));
                $("#lastName").on("input", () => validateField("lastName", "lastNameError", validateName));
                $("#dob").on("change", () => validateField("dob", "dobError", validateDob));
                $("#address").on("input", () => validateField("address", "addressError", validateAddress));
                $("#phone").on("input", () => validateField("phone", "phoneError", validatePhone));

                // Remove the onsubmit attribute from your form element in HTML
                $("form.contact-bx").removeAttr("onsubmit");

                // Then handle the submit event properly
                $("form.contact-bx").on("submit", async function (e) {
                    // Always prevent default first
                    e.preventDefault();

                    // Run validation and wait for it to complete
                    const isValid = await validateForm();

                    if (isValid) {
                        // If validation passed, submit the form
                        this.submit();
                    } else {
                        // Show error message
                        Swal.fire({
                            title: 'Oops...',
                            text: 'Please check form again!',
                            icon: 'error',
                            confirmButtonText: 'Try Again'
                        });
                    }
                });
            });
        </script>


    </body>
</html>
