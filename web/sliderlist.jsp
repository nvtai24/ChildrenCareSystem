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


        .form-search, .form-filter, .form-add {
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
            border-color: #EFBB20;
        }

        /* Label của bộ lọc */
        .form-filter label {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        /* Nút chung cho cả Search & Filter */
        .form-search button, .form-filter button, .form-add button {
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
        .form-search button:hover, .form-filter button:hover, .form-add button:hover{
            background: #FFC321;
        }
        .btn.update {
            background-color: #17a2b8;
            color: white;
            border: none;
            padding: 5px 15px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn.delete {
            background-color: #17a2b8;
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
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
        }
        table {
            width: 100%;
            max-width: 1500px;
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
            width: 25%;
            text-align: center;
        }

        td:nth-child(3), th:nth-child(3) {
            width: 10%;
            text-align: center;
        }

        td:nth-child(4), th:nth-child(4) {
            width: 8%;
            text-align: center;
        }
        td:nth-child(5), th:nth-child(5) {
            width: 15%;
            text-align: center;
        }
        td:nth-child(6), th:nth-child(6) {
            width: 15%;
            text-align: center;
        }

        td:nth-child(7), th:nth-child(7) {
            width: 10%;
            text-align: center;
        }
        td:nth-child(8), th:nth-child(8) {
            width: 10%;
            text-align: center;
        }

        td:last-child, th:last-child {
            width: 13%;
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
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.png" />

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
        <jsp:include page="dashboard/header.jsp"/>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a ><img alt="" src="assets/images/logo.png" width="70" height="17"></a>
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
                            <a href="/app/sliders" class="ttr-material-button">
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
                                <form method="get" action="sliders" class="form-search">
                                    <input type="text" id="search" name="search" value="${param.search}" placeholder="Type anything...">
                                    <button type="submit">Search</button>
                                </form>

                                <!-- Form lọc trạng thái -->
                                <form method="get" action="sliders" class="form-filter">
                                    <select name="status" id="status">
                                        <option value="" ${empty param.status ? "selected" : ""}>All</option>
                                        <option value="true" ${param.status == "true" ? "selected" : ""}>Active</option>
                                        <option value="false" ${param.status == "false" ? "selected" : ""}>Inactive</option>
                                    </select>
                                    <button type="submit">Apply</button>
                                </form>
                                <form class="form-add">
                                        <button type="button" onclick="window.location.href = 'addslider.jsp';">
                                            <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                            Add New Slider
                                        </button>    
                                </form>

                            </div>

                            <br><br>
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Title</th>
                                        <th>BackLink</th>
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
                                            <td>${slider.backLink}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${slider.status}">
                                                        <span style="color: green;">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: red;">Inactive</span>
                                                    </c:otherwise>
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
                                                <form method="post" action="sliders">
                                                    <input type="hidden" name="id" value="${slider.id}">
                                                    <input type="hidden" name="status" value="${slider.status ? 0 : 1}">
                                                    <button type="submit" 
                                                            class="btn ${slider.status ? 'disable' : 'enable'}">
                                                        <i class="fa fa-refresh" aria-hidden="true"></i>
                                                        ${slider.status ? 'Hide' : 'Show'}
                                                    </button>
                                                </form>
                                            </td>
                                            <td>
                                                <form method="post" action="DeleteSlider" style="display:inline;">
                                                    <input type="hidden" name="id" value="${slider.id}">
                                                    <button type="submit" class="btn delete">
                                                        <i class="fa fa-times-circle" aria-hidden="true"></i>
                                                        Delete
                                                    </button>
                                                </form>
                                            </td>
                                            <td>
                                                <form method="get" action="sliders-update" style="display:inline;">
                                                    <input  type="hidden" name="id" value="${slider.id}">
                                                    <button type="submit" class="btn update" style="display:inline;">
                                                        <i class="fa fa-pencil" aria-hidden="true" ></i>
                                                        View Detail
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
                                                <a href="sliders?page=${CURRENT_PAGE - 1}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
                                                    <i class="ti-arrow-left"></i> Prev
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${TOTAL_PAGES}" var="i">
                                            <li class="${i == CURRENT_PAGE ? 'active' : ''}">
                                                <a href="sliders?page=${i}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
                                                    ${i}
                                                </a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${CURRENT_PAGE < TOTAL_PAGES}">
                                            <li class="next">
                                                <a href="sliders?page=${CURRENT_PAGE + 1}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
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
