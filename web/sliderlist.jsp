<%-- 
    Document   : sliderlist
    Created on : Jan 26, 2025, 10:28:59 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <style>
        .filter-search-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px; /* Khoảng cách giữa hai form */
            margin-bottom: 20px;
        }

        /* Định dạng chung cho cả hai form */
        .form-search, .form-filter {
            display: flex;
            align-items: center;
            background: #f9f9f9;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            gap: 10px;
        }

        /* Ô nhập dữ liệu */
        .form-search input, .form-filter select {
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

        /* Dropdown filter */
        .form-filter select {
            width: 150px;
            cursor: pointer;
        }

        /* Hiệu ứng khi hover vào dropdown */
        .form-filter select:hover {
            border-color: #007bff;
        }

        /* Label của bộ lọc */
        .form-filter label {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        /* Nút chung cho cả Search & Filter */
        .form-search button, .form-filter button {
            background: #007bff;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        /* Hiệu ứng khi hover vào nút */
        .form-search button:hover, .form-filter button:hover {
            background: #0056b3;
        }
        .btn.update {
            background-color: green;
            color: white;
            border: none;
            padding: 5px 15px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn.delete {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 15px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn.disable {
            background-color: red;
            color: white;
            padding: 5px 15px;
            cursor: pointer;
            font-size: 14px;
        }


        .btn.enable {
            background-color: green;
            color: white;
            padding: 5px 15px;
            cursor: pointer;
            font-size: 14px;
        }


        .btn:hover {
            opacity: 0.8;
        }
        .wc-title h4 {

            font-weight: bold;
            text-transform: uppercase;
        }
        .form-search  {
            display: flex; /* Sử dụng Flexbox */
            justify-content: flex-end; /* Đẩy nút Search sang bên phải */
            align-items: center; /* Căn giữa theo chiều dọc */
            gap: 10px; /* Khoảng cách giữa ô input và nút button */
        }
        table {
            width: 100%;
            max-width: 1200px;
            border-collapse: collapse;
            margin: 20px auto;
            table-layout: fixed;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }
        img {
            max-width: 50px;
            height: auto;
        }


        td:first-child, th:first-child {
            width: 3%;
            text-align: center;
        }

        td:nth-child(2), th:nth-child(2) {
            width: 15%;
            text-align: center;
        }

        td:nth-child(3), th:nth-child(3) {
            width: 12%;
            text-align: center;
        }

        td:nth-child(4), th:nth-child(4) {
            width: 6%;
            text-align: center;
        }
        td:nth-child(5), th:nth-child(5) {
            width: 10%;
            text-align: center;
        }
        td:nth-child(6), th:nth-child(6) {
            width: 10%;
            text-align: center;
        }

        td:nth-child(7), th:nth-child(7) {
            width: 10%;
            text-align: center;
        }
        td:nth-child(8), th:nth-child(8) {
            width: 6%;
            text-align: center;
        }

        td:last-child, th:last-child {
            width: 6%;
            text-align: center;
        }
    </style>
    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:10:19 GMT -->
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
        <link rel="icon" href="../error-404.html" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logochildren.jpg" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>ChildrenCare </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets2/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets2/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets2/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets2/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets2/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets2/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets2/css/color/color-1.css">

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <!--sidebar menu toggler start -->
                <div class="ttr-toggle-sidebar ttr-material-button">
                    <i class="ti-close ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <!--sidebar menu toggler end -->
                <!--logo start -->
                <div class="ttr-logo-box">
                    <div>
                        <a href="/app" class="ttr-logo">

                            <img alt=""  src="assets/images/logochildren.jpg" width="70" height="10">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-menu">
                    <!-- header left menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="/app" class="ttr-material-button ttr-submenu-toggle">HOME</a>
                        </li>
                        <li>

                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="../courses.html">Our Courses</a></li>
                                    <li><a href="../event.html">New Event</a></li>
                                    <li><a href="../membership.html">Membership</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-search-toggle"><i class="fa fa-search"></i></a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><i class="fa fa-bell"></i></a>
                            <div class="ttr-header-submenu noti-menu">
                                <div class="ttr-notify-header">
                                    <span class="ttr-notify-text-top">9 New</span>
                                    <span class="ttr-notify-text">User Notifications</span>
                                </div>
                                <div class="noti-box-list">
                                    <ul>
                                        <li>
                                            <span class="notification-icon dashbg-gray">
                                                <i class="fa fa-check"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 02:14</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-yellow">
                                                <i class="fa fa-shopping-cart"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Your order is placed</a> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 7 Min</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-red">
                                                <i class="fa fa-bullhorn"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Your item is shipped</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 2 May</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-green">
                                                <i class="fa fa-comments-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Sneha Jogi</a> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 14 July</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-primary">
                                                <i class="fa fa-file-word-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 15 Min</span>
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="assets/images/testimonials/pic3.jpg" width="32" height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="user-profile.html">My profile</a></li>
                                    <li><a href="list-view-calendar.html">Activity</a></li>
                                    <li><a href="mailbox.html">Messages</a></li>
                                    <li><a href="../login.html">Logout</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="ttr-hide-on-mobile">
                            <a href="#" class="ttr-material-button"><i class="ti-layout-grid3-alt"></i></a>
                            <div class="ttr-header-submenu ttr-extra-menu">
                                <a href="#">
                                    <i class="fa fa-music"></i>
                                    <span>Musics</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-youtube-play"></i>
                                    <span>Videos</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-envelope"></i>
                                    <span>Emails</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-book"></i>
                                    <span>Reports</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-smile-o"></i>
                                    <span>Persons</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-picture-o"></i>
                                    <span>Pictures</span>
                                </a>
                            </div>
                        </li>
                    </ul>
                    <!-- header right menu end -->
                </div>
                <!--header search panel start -->
                <div class="ttr-search-bar">
                    <form class="ttr-search-form">
                        <div class="ttr-search-input-wrapper">
                            <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                            <button type="submit" name="search" class="ttr-search-submit"><i class="ti-arrow-right"></i></button>
                        </div>
                        <span class="ttr-search-close ttr-search-toggle">
                            <i class="ti-close"></i>
                        </span>
                    </form>
                </div>
                <!--header search panel end -->
            </div>

        </header>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a ><img alt="" src="assets/images/logochildren.jpg" width="70" height="17"></a>
                    <!-- <div class="ttr-sidebar-pin-button" title="Pin/Unpin Menu">
                            <i class="material-icons ttr-fixed-icon">gps_fixed</i>
                            <i class="material-icons ttr-not-fixed-icon">gps_not_fixed</i>
                    </div> -->
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <!-- side menu logo end -->
                <!-- sidebar menu start -->
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="index.html" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashborad</span>
                            </a>
                        </li>
                        <li>
                            <a href="/app/SliderListController" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-book"></i></span>
                                <span class="ttr-label">Sliders</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-email"></i></span>
                                <span class="ttr-label">Mailbox</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="mailbox.html" class="ttr-material-button"><span class="ttr-label">Mail Box</span></a>
                                </li>
                                <li>
                                    <a href="mailbox-compose.html" class="ttr-material-button"><span class="ttr-label">Compose</span></a>
                                </li>
                                <li>
                                    <a href="mailbox-read.html" class="ttr-material-button"><span class="ttr-label">Mail Read</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-calendar"></i></span>
                                <span class="ttr-label">Calendar</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="basic-calendar.html" class="ttr-material-button"><span class="ttr-label">Basic Calendar</span></a>
                                </li>
                                <li>
                                    <a href="list-view-calendar.html" class="ttr-material-button"><span class="ttr-label">List View</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="bookmark.html" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                                <span class="ttr-label">Bookmarks</span>
                            </a>
                        </li>
                        <li>
                            <a href="review.html" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">Review</span>
                            </a>
                        </li>
                        <li>
                            <a href="add-listing.html" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                                <span class="ttr-label">Add listing</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-user"></i></span>
                                <span class="ttr-label">My Profile</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="user-profile.html" class="ttr-material-button"><span class="ttr-label">User Profile</span></a>
                                </li>
                                <li>
                                    <a href="teacher-profile.html" class="ttr-material-button"><span class="ttr-label">Teacher Profile</span></a>
                                </li>
                            </ul>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                    <!-- sidebar menu end -->
                </nav>
                <!-- sidebar menu end -->
            </div>
        </div>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">

                    <h4 class="breadcrumb-title">SLIDERS</h4>

                </div>	
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Slider List</h4>
                                <c:if test="${sessionScope.MESSAGE != null}">
                                    <div class="alert alert-success">${sessionScope.MESSAGE}</div>
                                </c:if>
                                <!-- Xóa message khỏi session sau khi hiển thị -->
                                <c:remove var="MESSAGE" scope="session"/>
                            </div>
                            <!-- Container chứa cả 2 form -->
                            <div class="filter-search-container">

                                <!-- Form tìm kiếm -->
                                <form method="get" action="SliderListController" class="form-search">
                                    <input type="text" id="search" name="search" value="${param.search}" placeholder="Search by title">
                                    <button type="submit">Search</button>
                                </form>

                                <!-- Form lọc trạng thái -->
                                <form method="get" action="SliderListController" class="form-filter">
                                    <select name="status" id="status">
                                        <option value="" ${empty param.status ? "selected" : ""}>All</option>
                                        <option value="true" ${param.status == "true" ? "selected" : ""}>Active</option>
                                        <option value="false" ${param.status == "false" ? "selected" : ""}>Inactive</option>
                                    </select>
                                    <button type="submit">Apply</button>
                                </form>
                                <form class="form-filter">
                                    <button>           
                                        <a style="color: white" href="addslider.jsp">Add New Slider</a>
                                    </button>

                                </form>

                            </div>

                            <br><br>
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Title</th>
                                        <th>Image</th>
                                        <th>Status</th>
                                        <th>Created Date</th>
                                        <th>Updated Date</th>
                                        <th>Action</th>
                                        <th></th>
                                        <th></th>         

                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="slider" items="${SLIDERS}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${slider.title}</td>
                                            <td><img src="assets/images/slider/${slider.imageUrl}" alt=""/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${slider.status}">Active</c:when>
                                                    <c:otherwise>Inactive</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${slider.createdDate}</td>
                                            <td>
                                                <c:if test="${slider.updatedDate != null}">
                                                    ${slider.updatedDate}
                                                </c:if>
                                            </td>
                                            <td>
                                                <!-- Nút Enable/Disable -->
                                                <form method="post" action="SliderListController">
                                                    <input type="hidden" name="id" value="${slider.id}">
                                                    <input type="hidden" name="status" value="${slider.status ? 0 : 1}">
                                                    <button type="submit" 
                                                            class="btn ${slider.status ? 'disable' : 'enable'}">
                                                        ${slider.status ? 'Disable' : 'Enable'}
                                                    </button>
                                                </form>
                                            </td>
                                            <td>
                                                <form method="post" action="DeleteSlider" style="display:inline;">
                                                    <input type="hidden" name="id" value="${slider.id}">
                                                    <button type="submit" class="btn delete">
                                                        Delete
                                                    </button>
                                                </form>
                                            </td>
                                            <td>
                                                <form method="get" action="UpdateSliderController" style="display:inline;">
                                                    <input  type="hidden" name="id" value="${slider.id}">
                                                    <button type="submit" class="btn update" style="display:inline;">
                                                        Edit
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <div class="col-lg-12 m-b20">
                                <div class="pagination-bx rounded-sm gray clearfix">
                                    <ul class="pagination">
                                        <c:if test="${CURRENT_PAGE > 1}">
                                            <li class="previous">
                                                <a href="SliderListController?page=${CURRENT_PAGE - 1}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
                                                    <i class="ti-arrow-left"></i> Prev
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${TOTAL_PAGES}" var="i">
                                            <li class="${i == CURRENT_PAGE ? 'active' : ''}">
                                                <a href="SliderListController?page=${i}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
                                                    ${i}
                                                </a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${CURRENT_PAGE < TOTAL_PAGES}">
                                            <li class="next">
                                                <a href="SliderListController?page=${CURRENT_PAGE + 1}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
                                                    <i class="ti-arrow-right"></i> Next
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

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
        <script src='assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/vendors/chart/chart.min.js"></script>
        <script src="assets/js/admin.js"></script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
