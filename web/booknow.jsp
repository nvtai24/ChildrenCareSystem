<%-- 
    Document   : booknow
    Created on : Feb 19, 2025, 11:40:26 AM
    Author     : Nvtai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />


        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Children Care</title>
        <base href="${pageContext.request.contextPath}/">

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

            <!-- Header Top ==== -->
            <jsp:include page="header.jsp"/>
            <!-- header END ==== -->

            <!-- Content -->
            <div class="page-content bg-white">
                <div class="content-block mb-2">
                    <div class="section-area">
                        <div class="container">
                            <div class="breadcrumb-row">
                                <div class="container">
                                </div>
                            </div>

                            <div class="row justify-content-center mt-2">
                                <div class="container confirmation-container">

                                    <form action="book" method="post">
                                        <!-- Personal Information Section -->
                                        <div class="card p-4 mb-2">
                                            <div class="card-body">
                                                <h4 class="text-dark font-weight-bold">Reservation Form</h4>
                                                <p class="text-muted">We will get in touch with you shortly</p>

                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <label for="firstName">First Name</label>
                                                        <input
                                                            type="text"
                                                            class="form-control"
                                                            id="firstName"
                                                            name="firstname"
                                                            placeholder="First Name"
                                                            value="${p.firstName}"
                                                            required
                                                            />
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label for="lastName">Last Name</label>
                                                        <input
                                                            type="text"
                                                            class="form-control"
                                                            id="lastName"
                                                            name="lastname"
                                                            placeholder="Last Name"
                                                            value="${p.lastName}"
                                                            required
                                                            />
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <!-- Date and Time Fields -->
                                                    <div class="form-group col-md-6">
                                                        <label for="date">Date</label>
                                                        <input
                                                            type="date"
                                                            class="form-control"
                                                            id="date"
                                                            name="date"
                                                            value="${requestScope.tommorow}"
                                                            required
                                                            />
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label for="time">Time</label>
                                                        <input
                                                            type="time"
                                                            class="form-control"
                                                            id="time"
                                                            name="time"
                                                            value="7:30"
                                                            required
                                                            />
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <!-- Contact Fields -->
                                                    <div class="form-group col-md-6">
                                                        <label for="phone">Phone Number</label>
                                                        <input
                                                            type="tel"
                                                            class="form-control"
                                                            id="phone"
                                                            name="phone"
                                                            placeholder="0xxxxxxxxxx"
                                                            value="${p.phone}"
                                                            required
                                                            />
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="email">E-mail <small class="text-muted">(Optional)</small></label>
                                                        <input
                                                            type="email"
                                                            class="form-control"
                                                            id="email"
                                                            name="email"
                                                            placeholder="ex: myname@example.com"
                                                            value="${sessionScope.account.email}"
                                                            />
                                                    </div>
                                                </div>

                                                <!-- Message -->
                                                <div class="form-group">
                                                    <label for="message">Leave Your Message</label>
                                                    <textarea
                                                        class="form-control"
                                                        id="message"
                                                        rows="4"
                                                        maxlength="300"
                                                        placeholder="Type your message here"
                                                        name="note"
                                                        style="resize: none"
                                                        ></textarea>
                                                </div>

                                            </div>
                                        </div>

                                        <!-- Services Section -->
                                        <div class="card p-4 mb-2">
                                            <div class="section-header">
                                                <h4 class="text-dark font-weight-bold">Your Services</h4>
                                            </div>
                                            <div class="card-body">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Service</th>
                                                            <th>Quantity</th>
                                                            <th>Price</th>
                                                            <th>Total</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>${s.name}</td>
                                                            <td>1</td>
                                                            <td>$${sessionScope.s.price * (1 - sessionScope.s.discount / 100)}</td>
                                                            <td>$${sessionScope.s.price * (1 - sessionScope.s.discount / 100)}</td>
                                                        </tr>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="3" class="text-right">
                                                                <strong>Total Amount:</strong>
                                                            </td>
                                                            <td><strong>$${sessionScope.s.price * (1 - sessionScope.s.discount/100)}</strong></td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>

                                            <div class="section-header">
                                                <h4 class="text-dark font-weight-bold">Payment</h4>
                                            </div>
                                            <div class="card-body">
                                                <div class="form-check mb-3">
                                                    <input
                                                        class="form-check-input"
                                                        type="radio"
                                                        name="payment"
                                                        id="cash"
                                                        value="cash"
                                                        checked
                                                        />
                                                    <label class="form-check-label" for="cash">
                                                        Cash on Arrival
                                                    </label>
                                                </div>

                                                <div class="form-check mb-3">
                                                    <input
                                                        class="form-check-input"
                                                        type="radio"
                                                        name="payment"
                                                        id="banking"
                                                        value="banking"
                                                        />
                                                    <label class="form-check-label" for="banking">
                                                        Online Banking
                                                    </label>
                                                </div>

                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <a href="/app/services" class="btn btn-danger btn-block red">
                                                            Cancel
                                                        </a>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <button type="submit" id="submitButton" class="btn btn-success btn-block green">
                                                            Confirm
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp"/>
        </div>

        <!-- External JavaScripts -->
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

        <!-- Thêm jQuery vào trang -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>
            $(document).ready(function () {
                $("form").submit(function (event) {
                    // Xóa thông báo lỗi cũ
                    $(".text-danger").remove();

                    var isValid = true;

                    // Kiểm tra trường First Name
                    if ($("#firstName").val().trim() === "") {
                        isValid = false;
                        $("#firstName").after('<small class="text-danger">First Name is required.</small>');
                    }

                    // Kiểm tra trường Last Name
                    if ($("#lastName").val().trim() === "") {
                        isValid = false;
                        $("#lastName").after('<small class="text-danger">Last Name is required.</small>');
                    }

                    var phonePattern = /^(0\d{9}|(\+84)\d{9})$/;
                    if ($("#phone").val().trim() !== "" && !phonePattern.test($("#phone").val().trim())) {
                        isValid = false;
                        console.log('1');
                        $("#phone").after('<small class="text-danger">Phone number format should be 0xxxxxxxxx or +84xxxxxxxxx.</small>');
                    }

                    // Kiểm tra email (nếu có)
                    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    if ($("#email").val().trim() !== "" && !emailPattern.test($("#email").val().trim())) {
                        isValid = false;
                        console.log('2');
                        $("#email").after('<small class="text-danger">Email format is invalid.</small>');
                    }

                    var selectedDate = new Date($("#date").val() + 'T' + $("#time").val());
                    var today = new Date();

                    // Đặt thời gian của ngày hôm nay về 00:00:00
                    today.setHours(0, 0, 0, 0);

                    // Thêm 1 ngày vào ngày hôm nay
                    var tomorrow = new Date(today);
                    tomorrow.setDate(today.getDate() + 1);

                    // Kiểm tra xem ngày và giờ người dùng chọn có phải trước 1 ngày không
                    if (selectedDate < tomorrow) {
                        console.log('3');
                        isValid = false;
                        $("#date").after('<small class="text-danger">The date and time must be at least 1 day in the future.</small>');
                    }

                    console.log("Is valid: " + isValid); // Log xem isValid có đúng không

                    // Nếu form không hợp lệ thì ngừng submit
                    if (!isValid) {
                        event.preventDefault();
                    }
                });
            });

        </script>
    </body>

</html>
