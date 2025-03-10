<%-- 
    Document   : services_public
    Created on : Jan 25, 2025, 11:38:51 PM
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

        <style>
            html {
                position:inherit;
            }
        </style>


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
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Our Services</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="/app"><i class="fa fa-home"></i> Home</a></li>
                            <li><a href="services">Services</a></li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp4">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="widget courses-search-bx placeani">
                                        <div class="form-group">
                                            <form id="searchForm" action="services" method="GET" class="input-group">
                                                <input name="info" type="text" class="form-control" value="${requestScope.info}" placeholder="Search Services">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </form>

                                        </div>
                                    </div>
                                    <div class="widget widget_archive">
                                        <h5 class="widget-title style-1">
                                            <a href="services">All Services</a>
                                        </h5>
                                        <ul>
                                            <c:forEach items="${requestScope.categories}" var="c">
                                                    <!--<input type="submit" value="${c.name}"/>-->
                                                <li><a href="services?cid=${c.id}">${c.name}</a></li>
                                                </form>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <!--                                    <div class="widget">
                                                                            <a href="#"><img src="assets/images/adv/adv.jpg" alt=""/></a>
                                                                        </div>-->
                                    <div class="widget recent-posts-entry widget-courses">
                                        <h5 class="widget-title style-1">Recent Services</h5>

                                        <div class="widget-post-bx">
                                            <c:forEach items="${requestScope.recents}" var="r">
                                                <div class="widget-post clearfix" onclick="window.location.href = 'service?id=${r.id}'" style="cursor: pointer;">
                                                    <div class="ttr-post-media"> <img src="${r.thumbnail}" width="200" height="143" alt=""> </div>
                                                    <div class="ttr-post-info">
                                                        <div class="ttr-post-header">
                                                            <h6 class="post-title"><a href="#">${r.name}</a></h6>
                                                        </div>
                                                        <div class="ttr-post-meta">
                                                            <ul>
                                                                <li class="price">
                                                                    <del>$${r.price}</del>
                                                                    <h5 class="text-danger">$${r.price * (1 - r.discount / 100)}</h5>
                                                                </li>
                                                                <!--<li class="review">03 Review</li>-->
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="row">
                                        <c:forEach items="${requestScope.services}" var="s">
                                            <div class="col-md-6 col-lg-4 col-sm-6 mb-4">
                                                <div class="card h-100 shadow-sm">
                                                    <img src="${s.thumbnail}" class="card-img-top" alt="${s.name}" style="height: 200px; width: 100%; object-fit: cover;" onclick="window.location.href = 'service?id=${s.id}'" style="cursor: pointer;">
                                                    <div class="card-body d-flex flex-column">
                                                        <div style="height: 70px;">
                                                            <h5 class="card-title text-center" onclick="window.location.href = 'service?id=${s.id}'" style="cursor: pointer;">${s.name}</h5>
                                                        </div>
                                                        <p class="text-center text-muted">${s.category.name}</p>
                                                        <div class="mt-auto">
                                                            <p class="text-center">
                                                                <del class="text-muted">$${s.price}</del> 
                                                                <strong class="text-danger">$${s.price * (1 - s.discount / 100)}</strong>
                                                            </p>

                                                            <button type="button" class="btn btn-success w-100 mb-2" onclick="addToWishlist(${s.id})">
                                                                Add Appointment
                                                            </button>

                                                            <button type="button" class="btn btn-success w-100" onclick="bookNow(${s.id})">
                                                                Book Now
                                                            </button>

                                                            <script>
                                                                function addToWishlist(serviceId) {
                                                                    // Kiểm tra session nếu có attribute account
                                                                    $.ajax({
                                                                        url: '/app/checklogin', // URL kiểm tra session
                                                                        type: 'GET',
                                                                        success: function (response) {
                                                                            // Kiểm tra nếu người dùng chưa đăng nhập
                                                                            if (!response.isLoggedIn) {
                                                                                // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
                                                                                window.location.href = '/app/login';
                                                                                return; // Dừng thực hiện thêm vào wishlist
                                                                            }

                                                                            // Nếu đã đăng nhập, lấy userId từ response
                                                                            var userId = response.userId;

                                                                            // Tiếp tục thêm vào wishlist
                                                                            $.ajax({
                                                                                url: 'wishlist/add', // URL của API
                                                                                type: 'POST',
                                                                                data: {
                                                                                    sid: serviceId,
                                                                                    uid: userId
                                                                                }, // Gửi dữ liệu serviceId và userId
                                                                                success: function (response) {
                                                                                    Swal.fire({
                                                                                        title: "Success!",
                                                                                        text: "Added to wishlist successfully!",
                                                                                        icon: "success",
                                                                                        confirmButtonText: "OK",
                                                                                        timer: 2000,
                                                                                        backdrop: true,
                                                                                    });
                                                                                },
                                                                                error: function (xhr, status, error) {
                                                                                    Swal.fire({
                                                                                        title: "Error!",
                                                                                        text: "Failed to add to wishlist. Please try again!",
                                                                                        icon: "error",
                                                                                        confirmButtonText: "OK",
                                                                                        backdrop: true
                                                                                    });
                                                                                }
                                                                            });
                                                                        },
                                                                        error: function (xhr, status, error) {
                                                                            Swal.fire({
                                                                                title: "Error!",
                                                                                text: "An error occurred while checking session. Please try again!",
                                                                                icon: "error",
                                                                                confirmButtonText: "OK",
                                                                                backdrop: true
                                                                            });
                                                                        }
                                                                    });
                                                                }


                                                                function bookNow(serviceId) {
                                                                    // Kiểm tra session nếu có attribute account
                                                                    $.ajax({
                                                                        url: '/app/checklogin', // URL kiểm tra session
                                                                        type: 'GET',
                                                                        success: function (response) {
                                                                            // Kiểm tra nếu người dùng chưa đăng nhập
                                                                            if (!response.isLoggedIn) {
                                                                                // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
                                                                                window.location.href = '/app/login';
                                                                                return; // Dừng thực hiện thêm vào wishlist
                                                                            }

                                                                            // Nếu đã đăng nhập, lấy userId từ response
                                                                            var userId = response.userId;

                                                                            // Tiến hành điều hướng đến trang book (hoặc trang bạn muốn)
                                                                            window.location.href = '/app/book?id=' + serviceId;  // Chuyển hướng tới trang book với serviceId
                                                                        },
                                                                        error: function (xhr, status, error) {
                                                                            Swal.fire({
                                                                                title: "Error!",
                                                                                text: "An error occurred while checking session. Please try again!",
                                                                                icon: "error",
                                                                                confirmButtonText: "OK",
                                                                                backdrop: true
                                                                            });
                                                                        }
                                                                    });
                                                                }

                                                            </script>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <c:if test="${requestScope.cid == null && requestScope.info == null}">
                                            <div class="col-lg-12 m-b20">
                                                <div class="pagination-bx rounded-sm gray clearfix">
                                                    <ul class="pagination">
                                                        <c:if test="${requestScope.currentPage > 1}">
                                                            <li class="previous"><a href="services?page=${requestScope.currentPage -1}"><i class="ti-arrow-left"></i> Prev</a></li>
                                                            </c:if>
                                                        <li class="active"><a href="services?page=${requestScope.currentPage}">${requestScope.currentPage }</a></li>


                                                        <c:if test="${requestScope.currentPage + 1 <= requestScope.totalPages}">
                                                            <li><a href="services?page=${requestScope.currentPage + 1}">${requestScope.currentPage + 1}</a></li>
                                                            </c:if>

                                                        <c:if test="${requestScope.currentPage + 2 <= requestScope.totalPages}">
                                                            <li><a href="services?page=${requestScope.currentPage + 2}">${requestScope.currentPage + 2}</a></li>
                                                            <li class="next"><a href="services?page=${requestScope.currentPage + 1}">Next <i class="ti-arrow-right"></i></a></li>
                                                                </c:if>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:if>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- contact area END -->
            </div>
            <!-- Content END-->

            <!-- Footer ==== -->
            <jsp:include page="footer.jsp"/>
            <!-- Footer END ==== -->
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </body>

</html>
