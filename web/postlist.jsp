<%-- 
    Document   : postlist
    Created on : Feb 18, 2025, 9:07:45 PM
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
            max-width: 1600px;
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
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px; /* Khoảng cách giữa các button */
            align-items: center; /* Căn giữa theo chiều dọc */
        }


        td:first-child, th:first-child {
            width: 4%;
            text-align: center;
        }

        td:nth-child(2), th:nth-child(2) {
            width: 8%;
            text-align: center;
        }

        td:nth-child(3), th:nth-child(3) {
            width: 20%;
            text-align: center;
        }

        td:nth-child(4), th:nth-child(4) {
            width: 6%;
            text-align: center;
        }
        td:nth-child(5), th:nth-child(5) {
            width: 13%;
            text-align: center;
        }
        td:nth-child(6), th:nth-child(6) {
            width: 13%;
            text-align: center;
        }

        td:last-child, th:last-child {
            width: 25%;
            text-align: center;
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
        <jsp:include page="dashboard/left-sidebar.jsp"/>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">

                    <h4 class="breadcrumb-title">POSTS</h4>

                </div>	
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Post List</h4>
                                <c:if test="${sessionScope.MESSAGE != null}">
                                    <div class="alert alert-success">${sessionScope.MESSAGE}</div>
                                </c:if>
                                <!-- Xóa message khỏi session sau khi hiển thị -->
                                <c:remove var="MESSAGE" scope="session"/>
                            </div>
                            <!-- Container chứa cả 2 form -->
                            <div class="filter-search-container">

                                <!-- Form tìm kiếm -->
                                <form method="get" action="posts" class="form-search">
                                    <input type="text" id="search" name="search" value="${param.search}" placeholder="Type anything...">
                                    <button class="fa fa-search" type="submit"></button>
                                </form>

                                <!-- Form lọc trạng thái -->
                                <form method="get" action="posts" class="form-filter">
                                    <select name="status" id="status">
                                        <option value="" ${empty param.status ? "selected" : ""}>All</option>
                                        <option value="true" ${param.status == "true" ? "selected" : ""}>Active</option>
                                        <option value="false" ${param.status == "false" ? "selected" : ""}>Inactive</option>
                                    </select>
                                    <button class="fa fa-filter" type="submit"></button>
                                </form>
                                <form class="form-add">
                                    <button type="button" onclick="window.location.href = 'post-add.jsp';">
                                        <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                        Add New Post
                                    </button>    
                                </form>
                            </div>

                            <br><br>
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Author</th>
                                        <th>Title</th>
                                        <th>Status</th>
                                        <th>Created Date</th>
                                        <th>Updated Date</th>
                                        <th>Action</th>


                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="post" items="${POSTS}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${post.username}</td>
                                            <td>${post.title}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${post.status}">
                                                        <span style="color: green;">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: red;">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>${post.createdDate}</td>
                                            <td>
                                                <c:if test="${post.updatedDate != null}">
                                                    ${post.updatedDate}
                                                </c:if>
                                            </td>
                                            <td>
                                                <div class="button-group">
                                                    <!-- Nút Enable/Disable -->
                                                    <form method="post" action="posts">
                                                        <input type="hidden" name="id" value="${post.id}">
                                                        <input type="hidden" name="status" value="${post.status ? 0 : 1}">
                                                        <button type="submit" class="btn ${post.status ? 'disable' : 'enable'}"><i class="fa fa-refresh" aria-hidden="true"></i>
                                                            ${post.status ? 'Hide' : 'Show'}
                                                        </button>
                                                    </form>

                                                    <form id="deleteForm" style="display:inline;">
                                                        <input type="hidden" name="id" value="${post.id}">
                                                        <button type="button" class="btn delete" onclick="confirmDelete('${post.id}')">
                                                            <i class="fa fa-times-circle" aria-hidden="true"></i>
                                                            Delete
                                                        </button>
                                                    </form>

                                                    <form method="get" action="post" style="display:inline;">
                                                        <input  type="hidden" name="id" value="${post.id}">
                                                        <button type="submit" class="btn update" style="display:inline;">
                                                            <i class="fa fa-pencil" aria-hidden="true" ></i>
                                                            View Detail
                                                        </button>
                                                    </form>
                                                </div>
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
                                                <a href="posts?page=${CURRENT_PAGE - 1}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
                                                    <i class="ti-arrow-left"></i> Prev
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${TOTAL_PAGES}" var="i">
                                            <li class="${i == CURRENT_PAGE ? 'active' : ''}">
                                                <a href="posts?page=${i}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
                                                    ${i}
                                                </a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${CURRENT_PAGE < TOTAL_PAGES}">
                                            <li class="next">
                                                <a href="posts?page=${CURRENT_PAGE + 1}&pageSize=${PAGE_SIZE}&search=${param.search}&status=${param.status}">
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                                            function confirmDelete(postId) {
                                                                Swal.fire({
                                                                    title: "Are you sure?",
                                                                    text: "You won't be able to revert this!",
                                                                    icon: "warning",
                                                                    showCancelButton: true,
                                                                    confirmButtonColor: "#d33",
                                                                    cancelButtonColor: "#3085d6",
                                                                    confirmButtonText: "Yes, delete it!"
                                                                }).then((result) => {
                                                                    if (result.isConfirmed) {
                                                                        $.ajax({
                                                                            url: "posts/delete",
                                                                            type: "POST",
                                                                            data: {id: postId},
                                                                            success: function (response) {
                                                                                Swal.fire({
                                                                                    title: "Deleted!",
                                                                                    text: "Your post has been deleted.",
                                                                                    icon: "success",
                                                                                    timer: 1000,
                                                                                    showConfirmButton: false
                                                                                }).then(() => {
                                                                                    window.location.href = "/app/posts"; // Load lại trang /post
                                                                                });
                                                                            },
                                                                            error: function (xhr, status, error) {
                                                                                Swal.fire("Error!", "Something went wrong.", "error");
                                                                            }
                                                                        });
                                                                    }
                                                                });
                                                            }
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>

