<%-- 
    Document   : services_public
    Created on : Jan 25, 2025, 11:38:51 PM
    Author     : Nvtai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        <style>
            .fixed-size-img {
                width: 200px;  /* Thay đổi kích thước theo nhu cầu */
                height: 100px; /* Thay đổi kích thước theo nhu cầu */
                object-fit: cover; /* Đảm bảo hình ảnh không bị méo */
            }
        </style>


    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <jsp:include page="header.jsp"/>
            <!-- header END ==== -->

            <!-- Content -->
            <div class="page-content bg-white">
                <div class="content-block">
                    <div class="section-area">
                        <div class="container">
                            <div class="breadcrumb-row">
                                <div class="container">
                                    <ul class="list-inline">
                                        <li><a href="/app"><i class="fa fa-home"></i> Home</a></li>
                                        <li><a href="/app/history">History</a></li>
                                        <li>Reservation Info</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="row justify-content-center mt-2">

                                <div class="container confirmation-container">
                                    <div class="card p-4 mb-2">
                                        <div class="section-header">
                                            <h4 class="text-dark font-weight-bold">Personal Information</h4>
                                        </div>
                                        <div class="card-body">
                                            <dl class="row mb-0">
                                                <dt class="col-sm-4">Full Name:</dt>
                                                <dd class="col-sm-8">${requestScope.r.lastName} ${requestScope.r.firstName}</dd>

                                                <dt class="col-sm-4">Phone:</dt>
                                                <dd class="col-sm-8">${requestScope.r.phone}</dd>

                                                <dt class="col-sm-4">Email:</dt>
                                                <dd class="col-sm-8">${requestScope.r.email}</dd>

                                                <dt class="col-sm-4">Reservation Date:</dt>
                                                <dd class="col-sm-8">${requestScope.r.reverseDate.toLocalTime()}  ${requestScope.r.reverseDate.toLocalDate()}</dd>

                                                <dt class="col-sm-4">Payment: </dt>
                                                <dd class="col-sm-8">${requestScope.r.banking ? 'Online Banking' : 'Cash on Arrival'}</dd>

                                                <dt class="col-sm-4">Note:</dt>
                                                <dd class="col-sm-8">${requestScope.r.note}</dd>

                                            </dl>
                                        </div>
                                    </div>

                                    <!-- Services Section -->
                                    <div class="card p-4 mb-2">
                                        <table class="table table-hover">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th>Service</th>
                                                    <th>Unit Price</th>
                                                    <th>Quantity</th>
                                                    <th>Sum</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requestScope.r.details}" var="i">
                                                    <tr class="item-row">
                                                        <td class="align-middle">
                                                            <div class="d-flex">
                                                                <img src="${i.service.thumbnail}" class="img-fluid fixed-size-img mr-2" style="width: 150px; height: 100px;">
                                                                <div>
                                                                    <h6 class="text-muted">${i.service.category.name}</h6>
                                                                    <h5 class="font-weight-bold">${i.service.name}</h5>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="font-weight-bold align-middle">
                                                            $${i.price}
                                                        </td>
                                                        <td class="align-middle font-weight-bold">${i.quantity}</td>
                                                        <td class="font-weight-bold total-price align-middle">$${i.price * i.quantity}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="3" class="text-right align-middle">
                                                        <strong>Total Amount:</strong>
                                                    </td>
                                                    <td class="align-middle"><strong>$${requestScope.total}</strong></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                                
                                        <!--Redirect section-->
                                        <div>
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <button type="button" class="btn btn-danger btn-block red">
                                                        Back
                                                    </button>
                                                </div>
                                                <div class="col-md-6">
                                                    <button type="submit" id="submitButton" class="btn btn-success btn-block green">
                                                        Edit
                                                    </button>
                                                </div>
                                            </div>
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
