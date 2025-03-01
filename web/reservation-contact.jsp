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
                            <div class="breadcrumb-row">
                                <div class="container">
                                    <ul class="list-inline">
                                        <li><a href="/app"><i class="fa fa-home"></i> Home</a></li>
                                        <li><a href="/app/reservation/detail"> Appointment</a></li>
                                        <li>Contact</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="row justify-content-center mt-2">
                                <div class="col-md-12">
                                    <div class="card p-4">
                                        <div class="card-body">
                                            <h4 class="text-dark font-weight-bold">Reservation Form</h4>
                                            <p class="text-muted">We will get in touch with you shortly</p>
                                            <form method="get" action="/app/reservation/confirm">
                                                <!-- Name Fields -->
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <label for="firstName">First Name</label>
                                                        <input
                                                            type="text"
                                                            class="form-control"
                                                            id="firstName"
                                                            name="firstname"
                                                            placeholder="First Name"
                                                            value="${sessionScope.r.firstName != null ? sessionScope.r.firstName : requestScope.p.firstName}"
                                                            required
                                                            />
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label for="firstName">Last Name</label>
                                                        <input
                                                            type="text"
                                                            class="form-control"
                                                            id="lastName"
                                                            name="lastname"
                                                            placeholder="Last Name"
                                                            value="${sessionScope.r.lastName != null ? sessionScope.r.lastName : requestScope.p.lastName}"
                                                            required
                                                            />
                                                    </div>
                                                </div>

                                                <form>
                                                    <!-- Name Fields -->
                                                    <div class="form-row">
                                                        <div class="form-group col-md-6">
                                                            <label for="date">Date</label>
                                                            <input
                                                                type="date"
                                                                class="form-control"
                                                                id="date"
                                                                name="date"
                                                                value="${sessionScope.r.reverseDate != null ? sessionScope.r.reverseDate.toLocalDate() : '2025-03-02'}"
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
                                                                value="${sessionScope.r.reverseDate != null ? sessionScope.r.reverseDate.toLocalTime() : '14:30'}"
                                                                required
                                                                />
                                                        </div>
                                                    </div>

                                                    <!-- Contact Fields -->
                                                    <div class="form-row">
                                                        <div class="form-group col-md-6">
                                                            <label for="phone">Phone Number</label>
                                                            <input
                                                                type="tel"
                                                                class="form-control"
                                                                id="phone"
                                                                name="phone"
                                                                placeholder="(000) 000-0000"
                                                                value="${sessionScope.r.phone != null ? sessionScope.r.phone : requestScope.p.phone}"
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
                                                                value="
                                                                ${sessionScope.r.email != null ? sessionScope.r.email : sessionScope.account.email}"
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
                                                            placeholder="Type your message here"
                                                            name="note"
                                                            style="resize: none"
                                                            value="${sessionScope.r.note != null ? sessionScope.r.note : ''}"
                                                            ></textarea>
                                                    </div>

                                                    <div class="form-row">
                                                        <div class="col-md-6">
                                                            <a href="/app/reservation/detail" class="btn btn-danger btn-block red text-white">Back</a>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <button type="submit" class="btn btn-success btn-block green">
                                                                Continue
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>
                                        </div>
                                    </div>
                                </div>
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
