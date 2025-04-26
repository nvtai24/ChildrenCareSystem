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

        <!-- DataTables CSS -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">

        <style>
            #reservationTable thead th {
                text-align: center !important;
                vertical-align: middle !important;
            }
            .fade-out {
                opacity: 1;
                transition: opacity 1s ease-out;
            }

            .fade-out.hidden {
                opacity: 0;
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
                                        <li>History</li>
                                    </ul>
                                </div>
                            </div>

                            <c:if test="${sessionScope.successMessage != null}">
                                <div id="successMessage" class="alert alert-success">${sessionScope.successMessage}</div>
                            </c:if>

                            <c:if test="${sessionScope.errorMessage != null}">
                                <div id="errorMessage" class="alert alert-danger">${sessionScope.errorMessage}</div>
                            </c:if>

                            <!-- Xóa messages khỏi session sau khi hiển thị -->
                            <c:remove var="successMessage" scope="session"/>
                            <c:remove var="errorMessage" scope="session"/>

                            <div class="toolbar mt-2">
                                <form>
                                    <div class="form-row align-items-center">
                                        <!-- Lọc theo Status -->
                                        <div class="col-auto">
                                            <div class="input-group mb-2">
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">Status</div>
                                                </div>
                                                <select id="statusFilter">
                                                    <option value="">All</option>
                                                    <c:forEach items="${requestScope.stt}" var="stt">
                                                        <option value="${stt.statusName}">${stt.statusName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- Lọc theo Date -->
                                        <div class="col-auto">
                                            <div class="input-group mb-2">
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">Date</div>
                                                </div>
                                                <input type="date" class="form-control" id="dateFilter">
                                            </div>
                                        </div>

                                        <!-- Ô tìm kiếm -->
                                        <div class="col-auto d-flex">
                                            <input type="text" id="keywordFilter" class="form-control mb-2" placeholder="Type anything..." value="${requestScope.keyword != null ? requestScope.keyword : ''}">
                                            <button type="submit" class="btn btn-primary mb-2">
                                                <i class="fa fa-search" aria-hidden="true"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>


                            <table id="reservationTable" class="table table-hover">
                                <thead class="thead-light">
                                    <tr class="text-center align-middle">
                                        <th scope="col" class="align-middle">#</th>
                                        <th scope="col" class="align-middle">Date</th>
                                        <th scope="col" class="align-middle">Reserved Date</th>
                                        <th scope="col" class="align-middle">Quantity</th>
                                        <th scope="col" class="align-middle">Total Price</th>
                                        <th scope="col" class="align-middle">Status</th>
                                        <th scope="col" class="align-middle">Action</th>
                                    </tr>
                                </thead>

                                <tbody class="text-center">
                                    <c:forEach items="${requestScope.r}" var="r" varStatus="status">
                                        <tr>
                                            <th scope="row"  class="align-middle">${status.index + 1}</th>
                                            <td class="align-middle">${r.createdDate.toLocalTime()} ${r.createdDate.toLocalDate()}</td>
                                            <td class="align-middle">${r.reverseDate.toLocalTime()} ${r.reverseDate.toLocalDate()}</td>
                                            <td class="align-middle">
                                                <fmt:formatNumber value="${r.totalQuantity}" type="number" pattern="#"/>
                                            </td>
                                            <td class="align-middle">$${r.totalPrice}</td>
                                            <td class="align-middle">
                                                <c:if test="${r.status.id == 1}">
                                                    <span class="badge badge-secondary">Pending</span>
                                                </c:if>

                                                <c:if test="${r.status.id == 2}">
                                                    <span class="badge badge-success">Confirmed</span>
                                                </c:if>

                                                <c:if test="${r.status.id == 3}">
                                                    <span class="badge badge-primary">Completed</span>
                                                </c:if>

                                                <c:if test="${r.status.id == 4}">
                                                    <span class="badge badge-danger">Cancelled</span>
                                                </c:if>
                                                <c:if test="${r.status.id == 5}">
                                                    <span class="badge badge-warning text-white">Refunding</span>
                                                </c:if>
                                            </td>
                                            <td class="align-middle">
                                                <form action="/app/reservation/info" method="post">
                                            <input type="hidden" name="id" value="${r.id}"/>
                                            <input type="submit" value="View" class="btn btn-primary">
                                            </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <div class="col-lg-12 m-b20">
                                <div class="pagination-bx rounded-sm gray clearfix">
                                    <!-- Phân trang sẽ được cập nhật tự động ở đây -->
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp"/>
        </div>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                function fadeOutMessage(id) {
                    let message = document.getElementById(id);
                    if (message) {
                        setTimeout(function () {
                            message.classList.add("hidden"); // Kích hoạt hiệu ứng mờ dần
                            setTimeout(() => message.style.display = "none", 1000); // Ẩn hoàn toàn sau hiệu ứng
                        }, 3000);
                    }
                }

                // Gọi hàm cho cả hai loại thông báo
                fadeOutMessage("successMessage");
                fadeOutMessage("errorMessage");
            });
        </script>

        <script>
            $(document).ready(function () {
                var table = $('#reservationTable').DataTable({
                    "paging": true,
                    "lengthMenu": [10],
                    "searching": true,
                    "ordering": true,
                    "info": false,
                    "dom": "t", // Ẩn pagination mặc định
                    "columnDefs": [
                        {"orderable": false, "targets": [6]}, // Tắt sắp xếp cột Actions
                        {"searchable": false, "targets": [6]} // Tắt tìm kiếm cột Actions
                    ],
                    "drawCallback": function () {
                        updatePagination(this.api()); // Cập nhật giao diện phân trang
                    }
                });

                // Lọc theo Status
                $('#statusFilter').on('change', function () {
                    var status = $(this).val();
                    table.column(5).search(status).draw();
                });

                // Lọc theo Date
                $('#dateFilter').on('change', function () {
                    var date = $(this).val();
                    table.column(1).search(date).draw();
                });

                // Lọc theo Keyword
                $('#keywordFilter').on('keyup', function () {
                    table.search(this.value).draw();
                });

                // Chặn form submit mặc định
                $('.toolbar').on('submit', function (e) {
                    e.preventDefault();
                });

                // Hàm cập nhật pagination tùy chỉnh
                function updatePagination(api) {
                    var pageInfo = api.page.info();
                    var paginationHTML = '<ul class="pagination">';

                    // Nút Previous
                    if (pageInfo.page > 0) {
                        paginationHTML += '<li class="previous"><a href="#" data-page="' + (pageInfo.page - 1) + '"><i class="ti-arrow-left"></i> Prev</a></li>';
                    } else {
                        paginationHTML += '<li class="previous disabled"><a href="#"><i class="ti-arrow-left"></i> Prev</a></li>';
                    }

                    // Số trang
                    for (var i = 0; i < pageInfo.pages; i++) {
                        paginationHTML += '<li class="' + (pageInfo.page === i ? 'active' : '') + '"><a href="#" data-page="' + i + '">' + (i + 1) + '</a></li>';
                    }

                    // Nút Next
                    if (pageInfo.page < pageInfo.pages - 1) {
                        paginationHTML += '<li class="next"><a href="#" data-page="' + (pageInfo.page + 1) + '">Next <i class="ti-arrow-right"></i></a></li>';
                    } else {
                        paginationHTML += '<li class="next disabled"><a href="#">Next <i class="ti-arrow-right"></i></a></li>';
                    }

                    paginationHTML += '</ul>';

                    // Cập nhật pagination vào giao diện
                    $('.pagination-bx').html(paginationHTML);

                    // Thêm sự kiện click cho pagination tùy chỉnh
                    $('.pagination a').on('click', function (e) {
                        e.preventDefault();
                        var page = $(this).data('page');
                        if (page !== undefined) {
                            table.page(page).draw('page');
                        }
                    });
                }
            });

        </script>




        <!-- External JavaScripts -->
        <!--<script src="assets/js/jquery.min.js"></script>-->
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
