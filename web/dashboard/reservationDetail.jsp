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
            /* Điều chỉnh container chính */
            .reservation-detail {
                display: flex;
                justify-content: space-between;  /* Đảm bảo các phần tử không bị chồng lên nhau */
                gap: 20px;  /* Thêm khoảng cách giữa các phần */
                margin-bottom: 20px;
            }

            /* Chỉnh sửa phần reservation-info */
            .reservation-info {
                flex: 1 1 30%;  /* Chiếm khoảng 50% không gian */
                box-sizing: border-box;
                border: 2px solid #ccc;  /* Thêm viền để dễ phân biệt */
                padding: 15px;
                border-radius: 5px;  /* Tạo góc bo tròn */
            }

            /* Chỉnh sửa phần services-table */
            .services-table {
                flex: 1 1 70%;  /* Chiếm khoảng 50% không gian */
                box-sizing: border-box;
                border: 2px solid #ccc;  /* Thêm viền để dễ phân biệt */
                padding: 15px;
                border-radius: 5px;  /* Tạo góc bo tròn */
            }

            /* Điều chỉnh cho màn hình nhỏ */
            @media screen and (max-width: 768px) {
                .reservation-info, .services-table {
                    flex: 1 1 100%;  /* Chiếm toàn bộ không gian trên màn hình nhỏ */
                }
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
                <div class="reservation-detail">
                    <div class="reservation-info">
                        <form action="" method="post">
                            <!-- Reservation Information -->
                            <div class="form-group">
                                <label for="first-name">First Name</label>
                                <input type="text" class="form-control" id="first-name" name="first-name" value="${r.firstName}" readonly>
                            </div>

                            <div class="form-group">
                                <label for="last-name">Last Name</label>
                                <input type="text" class="form-control" id="last-name" name="last-name" value="${r.lastName}" readonly>
                            </div>

                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${r.email}" readonly>
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="${r.phone}" readonly>
                            </div>

                            <div class="form-group">
                                <label for="reserve-date">Reserve Date</label>
                                <input type="datetime-local" class="form-control" id="reserve-date" value="${r.reverseDate}" readonly>
                            </div>

                            <div class="form-group">
                                <label for="note">Note</label>
                                <textarea class="form-control" id="note" name="note" readonly>${r.note}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="status">Status</label>
                                <select class="form-control" id="status" name="status">
                                    <option value="Pending" ${reservation.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="Confirmed" ${reservation.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                    <option value="Completed" ${reservation.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                    <option value="Cancelled" ${reservation.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-warning btn-block">Change</button>
                        </form>
                    </div>


                    <div class="services-table">
                        <table id="reservationdetailTable">
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
                                <c:forEach var="rd" items="${rdList}">
                                    <tr>
                                        <td>${rd.service.name}</td>
                                        <td>${rd.quantity}</td>
                                        <td>${rd.price}</td>
                                        <td>${rd.quantity*rd.price}$</td>
                                        <td>
                                            <select class="form-control" id="staff-select">
                                                <option value="1" >John Doe</option>
                                                <option value="2" >Jane Smith</option>
                                                <option value="3" >Michael Johnson</option>
                                            </select>
                                        </td>
                                        <td>
                                            <button class="btn btn-block">Assign</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="col-lg-12 m-b20" >
                            <div class="pagination-bx rounded-sm gray clearfix">
                                <!-- Phân trang sẽ được cập nhật tự động ở đây -->
                            </div>
                        </div>
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
                var table = $('#reservationdetailTable').DataTable({
                    paging: true,
                    lengthMenu: [2],
                    ordering: true,
                    searching: true,
                    info: false,
                    dom: "t",
                    columnDefs: [
                        {targets: [4, 5], orderable: false}, // Vô hiệu hóa sắp xếp ở cột Action
                    ],
                    drawCallback: function () {
                        updatePagination(this.api());
                        $('select').selectpicker('refresh');
                    },
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
