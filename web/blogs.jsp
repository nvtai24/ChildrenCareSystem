<%-- 
    Document   : blogs
    Created on : Feb 6, 2025, 10:24:13 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <style>

        .form-search{
            display: flex;
            flex-direction: column;
            background: #f9f9f9;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            gap: 10px;
        }

        /* Ô nhập dữ liệu */
        .form-search input{
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            font-size: 16px;
            background: white;
        }

        /* Ô nhập tìm kiếm */
        .form-search input {
            width: 200px;
        }
        .form-search button{
            background: #EFBB20;
            color: black;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }
        /* Hiệu ứng khi hover vào nút */
        .form-search button:hover{
            background: #0056b3;
        }


        /* ----- Cấu trúc chung của blog ----- */
        .recent-news-carousel {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        /* ----- Mỗi bài blog ----- */
        .recent-news {
            width: 100%;
            max-width: 350px; /* Đảm bảo bài viết có chiều rộng cố định */
            height: 400px; /* Giữ cho các bài blog đồng nhất */
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform 0.3s ease-in-out;
        }

        .recent-news:hover {
            transform: translateY(-5px);
        }

        /* ----- Ảnh bài blog ----- */
        .recent-news .action-box {
            width: 100%;
            height: 200px; /* Giữ ảnh cố định */
            overflow: hidden;
        }

        .recent-news .action-box img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Đảm bảo ảnh không méo */
            transition: transform 0.3s ease-in-out;
        }

        .recent-news .action-box img:hover {
            transform: scale(1.05);
        }

        /* ----- Nội dung bài blog ----- */
        .recent-news .info-bx {
            padding: 15px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /* ----- Tiêu đề bài viết ----- */
        .recent-news .info-bx .post-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            text-decoration: none;
            margin-bottom: 10px;
            text-align: left;
        }

        /* ----- Mô tả bài viết ----- */
        .recent-news .info-bx p {
            font-size: 14px;
            color: #555;
            line-height: 1.6;
            text-overflow: ellipsis;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2; /* Giới hạn 2 dòng */
            -webkit-box-orient: vertical;
        }

        /* ----- Phần thông tin (ngày & tác giả) ----- */
        .media-post {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: #777;
        }

        .media-post li {
            display: flex;
            align-items: center;
        }

        .media-post li i {
            margin-right: 5px;
            color: #555;
        }

        /* ----- Button Read More ----- */
        .post-extra {
            margin-top: auto;
        }

        .post-extra a {
            font-size: 14px;
            font-weight: bold;
            color: #007BFF;
            text-decoration: none;
        }

        .post-extra a:hover {
            text-decoration: underline;
        }

        /* ----- Responsive trên màn hình nhỏ ----- */
        @media (max-width: 768px) {
            .recent-news {
                width: 100%; /* Bài viết sẽ chiếm toàn bộ chiều rộng */
                max-width: none;
            }
        }




    </style>

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
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logochildren.jpg" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>ChildrenCare</title>

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
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner3.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Our Blogs</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="/app">Home</a></li>
                            <li>Our Blogs</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->

                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                <div class="widget courses-search-bx placeani">

                                    <form method="get" action="blogs" class="form-search">
                                        <div>
                                            <input type="text" id="search" name="search" value="${param.search}" >
                                        </div>
                                        <div>
                                            <button type="submit">Search</button>
                                        </div>
                                    </form>                                    
                                </div>
                            </div>
                            <div class="ttr-blog-grid-3 row" id="masonry">
                                <c:forEach items="${POSTS}" var="post">
                                    <div class="post action-card col-lg-4 col-md-6 col-sm-12 col-xs-12 m-b40">
                                        <div class="recent-news">

                                            <div class="action-box">
                                                <a href="blog?id=${post.id}"><img src="${post.thumbnail}" alt=""></a>
                                            </div>
                                            <div class="info-bx">
                                                <ul class="media-post">
                                                    <li><a><i class="fa fa-calendar"></i>${post.createdDate}</a></li>    
                                                    <li><a><i class="fa fa-user"></i>By ${post.username}</a></li>
                                                </ul>
                                                <h5 class="post-title"><a href="blog?id=${post.id}">${post.title}</a></h5>
                                                <p>${post.content}</p>
                                                <div class="post-extra">
                                                    <a href="blog?id=${post.id}" class="btn-link">READ MORE</a>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </c:forEach>

                            </div>
                            <!-- Pagination ==== -->
                            <div class="pagination-bx rounded-sm gray clearfix">
                                <ul class="pagination">
                                    <c:if test="${CURRENT_PAGE > 1}">
                                        <li class="previous">
                                            <a href="blogs?page=${CURRENT_PAGE - 1}&search=${param.search}"><i class="ti-arrow-left"></i> Prev</a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${TOTAL_PAGES}" var="i">
                                        <li class="${i == CURRENT_PAGE ? 'active' : ''}">
                                            <a href="blogs?page=${i}&search=${param.search}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${CURRENT_PAGE < TOTAL_PAGES}">
                                        <li class="previous">
                                            <a href="blogs?page=${CURRENT_PAGE + 1}&search=${param.search}"><i class="ti-arrow-right"></i> Next</a>
                                        </li>
                                    </c:if>                                </ul>
                            </div>
                            <!-- Pagination END ==== -->
                        </div>
                    </div>
                </div>
                <!-- contact area END -->

            </div>
            <!-- Content END-->
            <!-- Footer ==== -->
            <footer>
                <div class="footer-top">
                    <div class="pt-exebar">
                        <div class="container">
                            <div class="d-flex align-items-stretch">
                                <div class="pt-logo mr-auto">
                                    <a href="index.html"><img src="assets/images/logo-white.png" alt=""/></a>
                                </div>
                                <div class="pt-social-link">
                                    <ul class="list-inline m-a0">
                                        <li><a href="#" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                    </ul>
                                </div>
                                <div class="pt-btn-join">
                                    <a href="#" class="btn ">Join Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-4 col-md-12 col-sm-12 footer-col-4">
                                <div class="widget">
                                    <h5 class="footer-title">Sign Up For A Newsletter</h5>
                                    <p class="text-capitalize m-b20">Weekly Breaking news analysis and cutting edge advices on job searching.</p>
                                    <div class="subscribe-form m-b20">
                                        <form class="subscription-form" action="http://educhamp.themetrades.com/demo/assets/script/mailchamp.php" method="post">
                                            <div class="ajax-message"></div>
                                            <div class="input-group">
                                                <input name="email" required="required"  class="form-control" placeholder="Your Email Address" type="email">
                                                <span class="input-group-btn">
                                                    <button name="submit" value="Submit" type="submit" class="btn"><i class="fa fa-arrow-right"></i></button>
                                                </span> 
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-lg-5 col-md-7 col-sm-12">
                                <div class="row">
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Company</h5>
                                            <ul>
                                                <li><a href="index.html">Home</a></li>
                                                <li><a href="about-1.html">About</a></li>
                                                <li><a href="faq-1.html">FAQs</a></li>
                                                <li><a href="contact-1.html">Contact</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Get In Touch</h5>
                                            <ul>
                                                <li><a href="http://educhamp.themetrades.com/admin/index.html">Dashboard</a></li>
                                                <li><a href="blog-classic-grid.html">Blog</a></li>
                                                <li><a href="portfolio.html">Portfolio</a></li>
                                                <li><a href="event.html">Event</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Courses</h5>
                                            <ul>
                                                <li><a href="courses.html">Courses</a></li>
                                                <li><a href="courses-details.html">Details</a></li>
                                                <li><a href="membership.html">Membership</a></li>
                                                <li><a href="profile.html">Profile</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-lg-3 col-md-5 col-sm-12 footer-col-4">
                                <div class="widget widget_gallery gallery-grid-4">
                                    <h5 class="footer-title">Our Gallery</h5>
                                    <ul class="magnific-image">
                                        <li><a href="assets/images/gallery/pic1.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic1.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic2.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic2.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic3.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic3.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic4.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic4.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic5.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic5.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic6.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic6.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic7.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic7.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic8.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic8.jpg" alt=""></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-center"> <a target="_blank" href="https://www.templateshub.net">Templates Hub</a></div>
                        </div>
                    </div>
                </div>
            </footer>
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
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>

    </body>

</html>
