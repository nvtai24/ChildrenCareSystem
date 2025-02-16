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
        .cours-bx {
            display: flex;
            flex-direction: column;
            height: 100%; /* Đảm bảo blog có chiều cao bằng nhau */
        }

        .action-box img {
            width: 100%;
            height: 180px; /* Đặt chiều cao cố định cho ảnh */
            object-fit: cover; /* Cắt ảnh phù hợp để không bị méo */
        }

        .info-bx {
            flex-grow: 1; /* Đảm bảo phần nội dung co giãn để các blog có cùng chiều cao */
            display: flex;
            flex-direction: column;
        }

        .info-bx h5 {
            min-height: 50px; /* Đặt chiều cao tối thiểu để căn tiêu đề */
        }

        .info-bx span {
            flex-grow: 1;
            display: -webkit-box;
            -webkit-line-clamp: 3; /* Giới hạn content hiển thị 3 dòng */
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
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

    </style>

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
                            <div class="row">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="widget courses-search-bx placeani">
                                        <!-- Form tìm kiếm -->
                                        <form method="get" action="blog" class="form-search">
                                            <div>
                                                <input type="text" id="search" name="search" value="${param.search}" placeholder="Search by title">
                                            </div>
                                            <div>
                                                <button type="submit">Search</button>
                                            </div>
                                        </form>                                    </div>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="row">
                                        <c:forEach var="post" items="${POSTS}">
                                            <div class="col-md-4 col-lg-4 col-sm-6 m-b30">
                                                <div class="cours-bx">
                                                    <div class="action-box">
                                                        <img src="${post.thumbnail}" alt="Blog Image">
                                                        <a href="blogdetail?id=${post.id}" class="btn">Read More</a>
                                                    </div>
                                                    <div class="info-bx text-center">
                                                        <h5><a href="blogdetail?id=${post.id}">${post.title}</a></h5>
                                                        <span>${post.content}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div class="col-lg-12 m-b20">
                                            <div class="pagination-bx rounded-sm gray clearfix">
                                                <ul class="pagination">
                                                    <c:if test="${CURRENT_PAGE > 1}">
                                                        <li class="previous">
                                                            <a href="blog?page=${CURRENT_PAGE - 1}&search=${param.search}"><i class="ti-arrow-left"></i> Prev</a>
                                                        </li>
                                                    </c:if>

                                                    <c:forEach begin="1" end="${TOTAL_PAGES}" var="i">
                                                        <li class="${i == CURRENT_PAGE ? 'active' : ''}">
                                                            <a href="blog?page=${i}&search=${param.search}">
                                                                ${i}
                                                            </a>
                                                        </li>
                                                    </c:forEach>

                                                    <c:if test="${CURRENT_PAGE < TOTAL_PAGES}">
                                                        <li class="previous">
                                                            <a href="blog?page=${CURRENT_PAGE + 1}&search=${param.search}"><i class="ti-arrow-right"></i> Next</a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div>
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
