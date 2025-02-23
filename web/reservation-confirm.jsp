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
                                        <li>Appointment</li>
                                        <li>Contact</li>    
                                        <li>Confirmation</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="row justify-content-center mt-2">

                                <div class="container confirmation-container">
                                    <!--<h3 class="text-center mb-2 text-uppercase">Confirm Your Reservation</h3>-->

                                    <!-- Personal Information Section -->
                                    <div class="card p-4 mb-2">
                                        <div class="section-header">
                                            <h4 class="text-dark font-weight-bold">Personal Information</h4>
                                        </div>
                                        <div class="card-body">
                                            <dl class="row mb-0">
                                                <dt class="col-sm-4">Full Name:</dt>
                                                <dd class="col-sm-8">${sessionScope.r.lastName} ${sessionScope.r.firstName}</dd>

                                                <dt class="col-sm-4">Phone:</dt>
                                                <dd class="col-sm-8">${sessionScope.r.phone}</dd>

                                                <dt class="col-sm-4">Email:</dt>
                                                <dd class="col-sm-8">${sessionScope.r.email}</dd>

                                                <dt class="col-sm-4">Reservation Date:</dt>
                                                <dd class="col-sm-8">${sessionScope.r.reverseDate}</dd>

                                                <dt class="col-sm-4">Note:</dt>
                                                <dd class="col-sm-8">${sessionScope.r.note}</dd>
                                            </dl>
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
                                                    <c:forEach items="${sessionScope.r.details}" var="item">
                                                        <c:set var="lineTotal" value="${item.price * item.quantity}"/>
                                                        <tr>
                                                            <td>${item.service.name}</td>
                                                            <td>${item.quantity}</td>
                                                            <td>$${item.price}</td>
                                                            <td>$${item.price * item.quantity}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="3" class="text-right">
                                                            <strong>Total Amount:</strong>
                                                        </td>
                                                        <td><strong>$${sessionScope.amount}</strong></td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>

                                        <div class="section-header">
                                            <h4 class="text-dark font-weight-bold">Payment</h4>
                                        </div>
                                        <div class="card-body">
                                            <form action="/app/reservation/payment" id="submitForm" method="get">
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

                                                <input type="hidden" name="amount" value="${sessionScope.amount}">

                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <button type="button" class="btn btn-danger btn-block red">
                                                            Back
                                                        </button>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <button type="submit" id="submitButton" class="btn btn-success btn-block green">
                                                            Confirm
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
