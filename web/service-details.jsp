<%-- 
    Document   : service-details
    Created on : Feb 2, 2025, 4:27:16 PM
    Author     : Nvtai
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            .instructor-author {
                width: 100px; /* Bạn có thể thay đổi kích thước này */
                height: 100px; /* Đảm bảo chiều cao và chiều rộng bằng nhau để tạo khối tròn */
                overflow: hidden;
                border-radius: 50%; /* Tạo khối tròn */
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .instructor-author img {
                width: 100%;
                height: 100%;
                object-fit: cover; /* Đảm bảo ảnh chiếm đầy khối tròn mà không bị méo */
            }
            .pagination-bx {
                margin-top: 20px;
            }

            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
            }

            .pagination li {
                margin: 0 5px;
            }

            .pagination li a {
                padding: 8px 12px;
                border: 1px solid #ddd;
                text-decoration: none;
                border-radius: 4px;
                color: #333;
            }

            .pagination li.active a {
                background-color: #4c1864;
                color: white;
                border-color: #4c1864;
            }

            .pagination li.disabled a {
                color: #aaa;
                cursor: not-allowed;
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
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner3.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Service Details</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="/app"><i class="fa fa-home"></i> Home</a></li>
                            <li><a href="services">Services</a></li>
                            <li>Service Details</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row d-flex flex-row-reverse">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="course-detail-bx" style="width: 400px">
                                        <div class="course-price">
                                            <del>$${requestScope.s.price}</del>
                                            <h4 class="price">$${requestScope.s.price * (1 - requestScope.s.discount / 100)}</h4>
                                        </div>	

                                        <div class="course-buy-now text-center">

                                            <c:if  test="${sessionScope.account.role.id == 15 || sessionScope.account.role.id == 16}">
                                                <div class="row mb-1">
                                                    <div class="col-6">
                                                        <button type="button" class="btn btn-success mb-2 w-100" onclick="addToWishlist(${requestScope.s.id})">
                                                            Add Appointment
                                                        </button>
                                                    </div>

                                                    <div class="col-6">
                                                        <button type="button" class="btn btn-success mb-2 w-100" onclick="bookNow(${requestScope.s.id})">
                                                            Book Now
                                                        </button>
                                                    </div>
                                                </div>
                                            </c:if>

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

                                        <div class="cours-more-info">
                                            <div class="review">
                                                <span>${requestScope.feedbacks.size()} Review</span>
                                                <ul class="cours-star">
                                                    <c:forEach begin="1" end="${requestScope.average}">
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        </c:forEach>

                                                    <c:forEach begin="1" end="${5 - requestScope.average}">
                                                        <li><i class="fa fa-star"></i></li>
                                                        </c:forEach>
                                                </ul>
                                            </div>
                                            <div class="price categories">
                                                <span>Category</span>
                                                <h5 class="text-primary">${requestScope.s.category.name}</h5>
                                            </div>
                                        </div>
                                        <div class="course-info-list scroll-page">
                                            <ul class="navbar">
                                                <li><a class="nav-link" href="#overview"><i class="ti-comments"></i>Reviews</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="courses-post">
                                        <div class="ttr-post-media media-effect">
                                            <a href="#"><img src="${requestScope.s.thumbnail}" alt="${requestScope.s.name}"></a>
                                        </div>
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title">${requestScope.s.name}</h2>
                                            </div>
                                            <div class="ttr-post-text">
                                                <p>${requestScope.s.briefInfo}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="courese-overview" id="overview">
                                        <h4>Overview</h4>
                                        <p>${requestScope.s.description}</p>
                                    </div>


                                    <div class="" id="reviews">
                                        <h4>Reviews</h4>

                                        <div class="review-bx">
                                            <div class="all-review">
                                                <h2 class="rating-type">5</h2>
                                                <ul class="cours-star">
                                                    <c:forEach begin="1" end="${requestScope.average}">
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        </c:forEach>

                                                    <c:forEach begin="1" end="${5 - requestScope.average}">
                                                        <li><i class="fa fa-star"></i></li>
                                                        </c:forEach>
                                                </ul>
                                                <span>${requestScope.feedbacks.size()} Rating</span>
                                            </div>
                                            <div class="review-bar">
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>5 star</div>
                                                    </div>
                                                    <div class="middle">
                                                        <div class="bar-container">
                                                            <div class="bar-5" style="width: ${requestScope.fives.size() / requestScope.feedbacks.size() * 100}%;"></div>
                                                        </div>
                                                    </div>
                                                    <div class="side right">
                                                        <div>${requestScope.fives.size()}</div>
                                                    </div>

                                                </div>
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>4 star</div>
                                                    </div>
                                                    <div class="middle">
                                                        <div class="bar-container">
                                                            <div class="bar-5" style="width: ${requestScope.fours.size() / requestScope.feedbacks.size() * 100}%;"></div>
                                                        </div>
                                                    </div>
                                                    <div class="side right">
                                                        <div>${requestScope.fours.size()}</div>
                                                    </div>
                                                </div>
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>3 star</div>
                                                    </div>
                                                    <div class="middle">
                                                        <div class="bar-container">
                                                            <div class="bar-5" style="width: ${requestScope.threes.size() / requestScope.feedbacks.size() * 100}%;"></div>
                                                        </div>
                                                    </div>
                                                    <div class="side right">
                                                        <div>${requestScope.threes.size()}</div>
                                                    </div>
                                                </div>
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>2 star</div>
                                                    </div>
                                                    <div class="middle">
                                                        <div class="bar-container">
                                                            <div class="bar-5" style="width: ${requestScope.twos.size() / requestScope.feedbacks.size() * 100}%;"></div>
                                                        </div>
                                                    </div>
                                                    <div class="side right">
                                                        <div>${requestScope.twos.size()}</div>
                                                    </div>
                                                </div>
                                                <div class="bar-bx">
                                                    <div class="side">
                                                        <div>1 star</div>
                                                    </div>
                                                    <div class="middle">
                                                        <div class="bar-container">
                                                            <div class="bar-5" style="width: ${requestScope.ones.size() / requestScope.feedbacks.size() * 100}%;"></div>
                                                        </div>
                                                    </div>
                                                    <div class="side right">
                                                        <div>${requestScope.ones.size()}</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <!-- HTML ban đầu giữ nguyên, chỉ thêm container để chứa nút phân trang -->
                                    <div class="" id="instructor">
                                        <c:forEach items="${requestScope.feedbacks}" var="f">
                                            <div class="instructor-bx feedback-item">
                                                <div class="instructor-author">
                                                    <img src="${f.reservationDetail.reservation.customer.profile.avatar}" alt="">
                                                </div>
                                                <div class="instructor-info">
                                                    <h6>${f.reservationDetail.reservation.customer.profile.firstName} ${f.reservationDetail.reservation.customer.profile.lastName}</h6>
                                                    <!--<span>Professor</span>-->
                                                    <ul class="cours-star">
                                                        <c:forEach begin="1" end="${f.rating}">
                                                            <li class="active"><i class="fa fa-star"></i></li>
                                                            </c:forEach>
                                                            <c:forEach begin="1" end="${5 - f.rating}">
                                                            <li><i class="fa fa-star"></i></li>
                                                            </c:forEach>
                                                    </ul>
                                                    <p class="m-b0">${f.comment}</p>
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <!-- Container cho phân trang -->
                                        <div id="pagination-container" class="pagination-bx rounded-sm gray clearfix mt-3">
                                            <ul class="pagination" id="pagination-controls">
                                                <!-- Nút phân trang sẽ được tạo bằng JavaScript -->
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- JavaScript cho phân trang -->
                                    <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            // Cấu hình phân trang
                                            const itemsPerPage = 5;
                                            const feedbackItems = document.querySelectorAll('.feedback-item');
                                            const totalItems = feedbackItems.length;
                                            const totalPages = Math.ceil(totalItems / itemsPerPage);
                                            let currentPage = 1;

                                            // Hàm hiển thị các items dựa trên trang hiện tại
                                            function displayItems(page) {
                                                // Ẩn tất cả items
                                                feedbackItems.forEach(item => {
                                                    item.style.display = 'none';
                                                });

                                                // Tính toán items sẽ hiển thị trên trang hiện tại
                                                const startIndex = (page - 1) * itemsPerPage;
                                                const endIndex = Math.min(startIndex + itemsPerPage - 1, totalItems - 1);

                                                // Hiển thị items của trang hiện tại
                                                for (let i = startIndex; i <= endIndex; i++) {
                                                    if (feedbackItems[i]) {
                                                        feedbackItems[i].style.display = 'flex';
                                                    }
                                                }

                                                // Cập nhật UI phân trang
                                                updatePagination();
                                            }

                                            // Hàm tạo và cập nhật UI phân trang
                                            function updatePagination() {
                                                const paginationControls = document.getElementById('pagination-controls');
                                                paginationControls.innerHTML = '';

                                                // Chỉ hiển thị phân trang nếu có nhiều hơn 1 trang
                                                if (totalPages <= 1) {
                                                    document.getElementById('pagination-container').style.display = 'none';
                                                    return;
                                                } else {
                                                    document.getElementById('pagination-container').style.display = 'block';
                                                }

                                                // Nút Previous
                                                const prevButton = document.createElement('li');
                                                prevButton.className = currentPage === 1 ? 'previous disabled' : 'previous';
                                                prevButton.innerHTML = `<a href="javascript:void(0);"><i class="ti-arrow-left"></i> Prev</a>`;
                                                if (currentPage > 1) {
                                                    prevButton.addEventListener('click', function () {
                                                        currentPage--;
                                                        displayItems(currentPage);
                                                    });
                                                }
                                                paginationControls.appendChild(prevButton);

                                                // Nút số trang
//                                                for (let i = 1; i <= totalPages; i++) {
//                                                    const pageButton = document.createElement('li');
//                                                    pageButton.className = i === currentPage ? 'active' : '';
//                                                    pageButton.innerHTML = `<a href="javascript:void(0);">${i}</a>`;
//                                                    pageButton.addEventListener('click', function () {
//                                                        currentPage = i;
//                                                        displayItems(currentPage);
//                                                    });
//                                                    paginationControls.appendChild(pageButton);
//                                                }


                                                // Nút số trang
                                                for (let i = 1; i <= totalPages; i++) {
                                                    const pageButton = document.createElement('li');
                                                    pageButton.className = i === currentPage ? 'active' : '';

                                                    // Tạo thẻ a riêng biệt
                                                    const aTag = document.createElement('a');
                                                    aTag.href = "javascript:void(0);";
                                                    aTag.textContent = i; // Sử dụng textContent thay vì innerHTML

                                                    pageButton.appendChild(aTag);
                                                    pageButton.addEventListener('click', function () {
                                                        currentPage = i;
                                                        displayItems(currentPage);
                                                    });
                                                    paginationControls.appendChild(pageButton);
                                                }

                                                // Nút Next
                                                const nextButton = document.createElement('li');
                                                nextButton.className = currentPage === totalPages ? 'next disabled' : 'next';
                                                nextButton.innerHTML = `<a href="javascript:void(0);">Next <i class="ti-arrow-right"></i></a>`;
                                                if (currentPage < totalPages) {
                                                    nextButton.addEventListener('click', function () {
                                                        currentPage++;
                                                        displayItems(currentPage);
                                                    });
                                                }
                                                paginationControls.appendChild(nextButton);
                                            }

                                            // Khởi tạo phân trang khi trang được tải
                                            displayItems(currentPage);
                                        });
                                    </script>

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
            <button class="back-to-top fa fa-chevron-up" ></button>
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
        <script src="assets/js/jquery.scroller.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>

</html>
