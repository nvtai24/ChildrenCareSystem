<%-- 
    Document   : reservation-contact
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

                            <div class="row justify-content-center align-items-center mt-4 mb-4">

                                <div class="col-md-6 row justify-content-center">
                                    <div class="mb-5">
                                        <img src="./assets/images/success.png" class="rounded float-left" style="width: 150px; height: 150px">
                                    </div>

                                    <div class="text-justify">
                                        <h3 class="font-weight-bold">Booking confirmed successfully!</h3>
                                        <p >
                                            Thank you for choosing to book with Usecheckin! Your reservation
                                            is confirmed. If there’s anything you need before your arrival,
                                            please don’t hesitate to reach out to your host!
                                        </p>

                                        <div class="mt-5 d-flex justify-content-center">
                                            <a href="" class="btn btn-success mr-2"><i class="fa fa-home"></i> Home</a>
                                            <a href="" class="btn btn-primary"><i class="fa fa-calendar-check-o"></i> View Appointment</a>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${requestScope.form1 != null}">
                                    <div class="col-md-6">
                                        <div class="card p-4 shadow-sm">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h3 class="font-weight-bold">$549.99</h3>
                                                <span class="success-icon">✔️</span>
                                            </div>
                                            <p class="text-muted">Payment success!</p>

                                            <hr />

                                            <h5 class="font-weight-bold">Payment details</h5>

                                            <div>
                                                <p><strong>Date:</strong> Jul 25, 2023 05:07:03 AM</p>
                                                <p><strong>Reference number:</strong> 148979951</p>
                                                <p><strong>Amount:</strong> $549.99</p>
                                                <p><strong>Payment method:</strong> Credit Card</p>
                                                <p><strong>Payment status:</strong> ✅ Success</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${requestScope.form2 != null}">
                                    <div class="col-md-6">
                                        <div class="card p-4 shadow-sm">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h3 class="font-weight-bold">$549.99</h3>
                                                <span class="info-icon">📅</span>
                                            </div>
                                            <p class="text-muted">Payment at Clinic</p>
                                            <hr />

                                            <h5 class="font-weight-bold">Appointment Details</h5>
                                            <div>
                                                <p><strong>Date & Time:</strong> Jul 25, 2023 09:00 AM</p>
                                                <p><strong>Booking Reference:</strong> 148979951</p>
                                                <p><strong>Amount Due:</strong> $549.99</p>
                                                <p><strong>Payment Method:</strong> Pay at Clinic</p>
                                                <p><strong>Clinic Location:</strong> 123 Health Street, City Name</p>
                                                <p><strong>Appointment Status:</strong> 🕒 Confirmed</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp"/>
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

    </body>

</html>
