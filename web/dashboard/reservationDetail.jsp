<%-- 
    Document   : reservationDetail
    Created on : Mar 9, 2025, 2:05:28 PM
    Author     : Admin
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Admin Dashboard</title>
        <base href="${pageContext.request.contextPath}/">        

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">->

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
        <!-- DATA TABLES ============================================= -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <style>
            th {
                text-align: center;
            }
            div.dataTables_wrapper div.dataTables_paginate {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                padding: 15px 0;
                font-size: 14px;
            }


            .dt-paging {
                text-align: center;
                margin-top: 0;
                padding-top: 10px;
            }


            .paginate_button {
                padding: 5px 10px;
                margin: 0 5px;
            }
            
            .reservation-detail{
                display: flex;
            }
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <jsp:include page="header.jsp"/>
        <!-- header end -->

        <!-- Left sidebar menu start -->
        <jsp:include page="left-sidebar.jsp"/>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Reservation List</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="reservations"><i class="fa fa-home"></i>List</a></li>
                        <li>Detail</li>
                    </ul>
                </div>	
                <div class="container">
                    <div class="reservation-detail">
                        

                        <div class="reservation-info">
                            <form action="" method="post">
                                <!-- Reservation Information -->
                                <label for="first-name">First Name</label>
                                <input type="text" id="first-name" name="first-name" value="Name" required>

                                <label for="last-name">Last Name</label>
                                <input type="text" id="last-name" name="last-name" value="LastName" required>

                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="Name" required>

                                <label for="phone">Phone</label>
                                <input type="text" id="phone" name="phone" value="Phone" required>

                                <label for="reserve-date">Reserve Date</label>
                                <input type="date" id="reserve-date" name="reserve-date" value="" required>

                                <label for="note">Note</label>
                                <textarea id="note" name="note"></textarea>

                                <label for="status">Status</label>
                                <select id="status" name="status">
                                    <option value="Pending" ${reservation.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="Confirmed" ${reservation.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                    <option value="Completed" ${reservation.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                    <option value="Cancelled" ${reservation.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                                <button type="submit" class="btn btn-primary">Change</button>
                            </form>
                        </div>

                        <div class="services-table">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Service</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Total</th>
                                        <th>Staff</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="service" items="${services}">
                                        <tr>
                                            <td>${service.name}</td>
                                            <td>${service.quantity}</td>
                                            <td>${service.price}</td>
                                            <td>${service.total}</td>
                                            <td>
                                                <select name="staff">
                                                    <option value="Staff A" ${service.staff == 'Staff A' ? 'selected' : ''}>Staff A</option>
                                                    <option value="Staff B" ${service.staff == 'Staff B' ? 'selected' : ''}>Staff B</option>
                                                    <option value="Staff C" ${service.staff == 'Staff C' ? 'selected' : ''}>Staff C</option>
                                                </select>
                                            </td>
                                            <td>
                                                <button class="btn btn-orange">Assign</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>





                <div class="col-lg-12 m-b20">
                    <div class="pagination-bx rounded-sm gray clearfix">
                        <!-- Phân trang sẽ được cập nhật tự động ở đây -->
                    </div>
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets2/js/jquery.min.js"></script>
        <script src="assets2/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets2/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets2/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets2/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets2/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets2/vendors/counter/waypoints-min.js"></script>
        <script src="assets2/vendors/counter/counterup.min.js"></script>
        <script src="assets2/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets2/vendors/masonry/masonry.js"></script>
        <script src="assets2/vendors/masonry/filter.js"></script>
        <script src="assets2/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='assets2/vendors/scroll/scrollbar.min.js'></script>
        <script src="assets2/js/functions.js"></script>
        <script src="assets2/vendors/chart/chart.min.js"></script>
        <script src="assets2/js/admin.js"></script>
        <script src='assets2/vendors/calendar/moment.min.js'></script>
        <script src='assets2/vendors/calendar/fullcalendar.js'></script>
        <!-- DataTables  -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>



        <script>
            $(document).ready(function () {
                var table = $('#reservationTable').DataTable({
                    paging: true,
                    lengthMenu: [10],
                    ordering: true,
                    searching: true,
                    info: false,
                    dom: "t",
                    columnDefs: [
                        {targets: [8, 9], orderable: false}, // Vô hiệu hóa sắp xếp ở cột Action
                    ],
                    drawCallback: function () {
                        updatePagination(this.api());
                    },
                });

                function applyFilters() {
                    var statusVal = $("#statusFilter").val(); // Giá trị status từ filter
                    var fromDate = $("#fromDate").val();
                    var toDate = $("#toDate").val();

                    $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
                        var statusColumn = data[8]; // Cột Status (index 8)
                        var dateColumn = data[3]; // Cột Reserved Date (index 3)

                        // Kiểm tra status match
                        var isStatusMatch = (statusVal === "-1" || statusColumn.includes(statusVal));

                        // Convert reserved date, fromDate và toDate thành kiểu Date để so sánh
                        var rowDate = new Date(dateColumn);
                        var startDate = new Date(fromDate);
                        var endDate = new Date(toDate);

                        var isDateMatch = true;
                        if (fromDate && rowDate < startDate) {
                            isDateMatch = false;
                        }
                        if (toDate && rowDate > endDate) {
                            isDateMatch = false;
                        }

                        // Đảm bảo toDate là hợp lệ khi bằng ngày trong cột reservedDate
                        if (toDate && rowDate.getTime() === endDate.getTime()) {
                            isDateMatch = true;
                        }

                        return isStatusMatch && isDateMatch;
                    });

                    table.draw();
                    $.fn.dataTable.ext.search.pop(); // Xóa bộ lọc sau khi vẽ
                }

                // Lọc khi thay đổi Status
                $("#statusFilter").on("change", function () {
                    applyFilters(); // Gọi hàm lọc kết hợp
                });

                // Lọc khi thay đổi From Date
                $("#fromDate").on("change", function () {
                    applyFilters(); // Gọi hàm lọc kết hợp
                });

                // Lọc khi thay đổi To Date
                $("#toDate").on("change", function () {
                    applyFilters(); // Gọi hàm lọc kết hợp
                });

                // Lọc theo Keyword
                $('input[name="keyword"]').on("keyup", function () {
                    table.search(this.value).draw(); // Lọc toàn bộ bảng theo từ khóa
                });

                function updatePagination(api) {
                    var pageInfo = api.page.info();
                    var paginationHTML = '<ul class="pagination">';

                    // Nút Previous
                    if (pageInfo.page > 0) {
                        paginationHTML +=
                                '<li class="previous"><a href="#" data-page="' +
                                (pageInfo.page - 1) +
                                '"><i class="ti-arrow-left"></i> Prev</a></li>';
                    } else {
                        paginationHTML +=
                                '<li class="previous disabled"><a href="#"><i class="ti-arrow-left"></i> Prev</a></li>';
                    }

                    // Số trang
                    for (var i = 0; i < pageInfo.pages; i++) {
                        paginationHTML +=
                                '<li class="' +
                                (pageInfo.page === i ? "active" : "") +
                                '"><a href="#" data-page="' +
                                i +
                                '">' +
                                (i + 1) +
                                "</a></li>";
                    }

                    // Nút Next
                    if (pageInfo.page < pageInfo.pages - 1) {
                        paginationHTML +=
                                '<li class="next"><a href="#" data-page="' +
                                (pageInfo.page + 1) +
                                '">Next <i class="ti-arrow-right"></i></a></li>';
                    } else {
                        paginationHTML +=
                                '<li class="next disabled"><a href="#">Next <i class="ti-arrow-right"></i></a></li>';
                    }

                    paginationHTML += "</ul>";

                    // Cập nhật pagination vào giao diện
                    $(".pagination-bx").html(paginationHTML);

                    // Thêm sự kiện click cho pagination tùy chỉnh
                    $(".pagination a").on("click", function (e) {
                        e.preventDefault();
                        var page = $(this).data("page");
                        if (page !== undefined) {
                            table.page(page).draw("page");
                        }
                    });
                }
            });


        </script>

    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/mailbox.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
