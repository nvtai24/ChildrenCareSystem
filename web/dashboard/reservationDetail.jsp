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
        <meta name="viewport" content="width=device-width, initial-scale=1">

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
                        <form action="reservation" method="post" onsubmit="">
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
                                <label for="note">Pay method</label>
                                <div>
                                    <c:if test="${r.banking}"><i class="fa fa-credit-card" aria-hidden="true"></i> Banking online</c:if>
                                    <c:if test="${!r.banking}"><i class="fa fa-money" aria-hidden="true"></i> Cash Payment</c:if>
                                    </div>

                                </div>

                            </form>
                            <div style="display: flex; align-content: center; justify-content: center; gap: 10px;">
                            <c:if test="${manager && r.status.statusName eq 'Pending'}">

                                <form action="reservation" method="POST" onsubmit="confirmChangeStatus(event)">
                                    <input type="hidden" name="reservation_id" value="${r.id}" />
                                    <input type="hidden" name="action" value="confirm" />
                                    <button type="submit" class="btn blue mb-2">
                                        <i class="fa fa-check" aria-hidden="true"></i> Confirm
                                    </button>
                                </form>                                

                                <form action="reservation" method="POST" onsubmit="confirmChangeStatusCancel(event)">
                                    <input type="hidden" name="reservation_id" value="${r.id}" />
                                    <input type="hidden" name="action" value="cancel" />
                                    <button type="submit" class="btn red mb-2">
                                        <i class="fa fa-times" aria-hidden="true"></i> Cancel
                                    </button>
                                </form>

                            </c:if>
                            <c:if test="${manager && r.status.id eq 5}">

                                <input type="hidden" id="hiddenId" value="${r.id}">
                                <button id="refundBtn" class="btn red mb-2" onclick="preRefund(event)"> 
                                    Refund
                                </button>
                            </c:if>
                        </div>

                    </div>


                    <div class="services-table">
                        <table id="reservationdetailTable" class="table">
                            <thead>
                                <tr>
                                    <th class="text-center">Service</th>
                                    <th class="text-center">Quantity</th>
                                    <th class="text-center">Price</th>
                                    <th class="text-center">Total</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center">Assigned</th>                              
                                    <th style="text-align: center;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="rd" items="${rdList}">
                                    <tr>
                                        <td>${rd.service.name}</td>
                                        <td>${rd.quantity}</td>
                                        <td>${rd.price}</td>
                                        <td>${rd.quantity * rd.price}$</td>
                                        <td> 
                                            <c:if test="${rd.status.id == 1}">
                                                <span class="badge badge-secondary " style="width: fit-content">Not Yet</span>
                                            </c:if>

                                            <c:if test="${rd.status.id == 2}">
                                                <span class="badge badge-info" style="width: fit-content">Assigned</span>
                                            </c:if>

                                            <c:if test="${rd.status.id == 3}">
                                                <span class="badge badge-danger" style="width: fit-content">Rejected</span>
                                            </c:if>

                                            <c:if test="${rd.status.id == 4}">
                                                <span class="badge badge-success" style="width: fit-content">Confirmed</span>
                                            </c:if>

                                            <c:if test="${rd.status.id == 5}">
                                                <span class="badge badge-warning" style="width: fit-content">Processing</span>
                                            </c:if>

                                            <c:if test="${rd.status.id == 6}">
                                                <span class="badge badge-primary" style="width: fit-content">Completed</span>
                                            </c:if>
                                        </td>
                                        <td>${rd.staff.profile.lastName} ${rd.staff.profile.firstName}</td>                                        
                                        <td style="display: flex; align-items: center; justify-content: center; gap: 5px;">
                                            <c:if test="${manager && r.status.statusName eq 'Confirmed'}">
                                                <form action="reservation" method="POST" style="display: flex; align-items: center; justify-content: center; gap: 5px;">
                                                    <input type="hidden" name="servicename" value="${rd.service.name}" />
                                                    <input type="hidden" name="quantity" value="${rd.quantity}" />
                                                    <input type="hidden" name="price" value="${rd.price}" />
                                                    <input type="hidden" name="action" value="assign" />
                                                    <!-- Gửi reservation ID và reservation_detail_id qua form -->
                                                    <input type="hidden" name="reservation_id" value="${r.id}" />
                                                    <input type="hidden" name="reservation_detail_id" value="${rd.id}" />
                                                    <input type="submit" class="btn btn-block btn-primary" value="Assign"/>
                                                    <select class="form-control" id="staff-select" name="staff_id">
                                                        <option value="-1" selected="">Choose staff</option>
                                                        <!-- Lặp qua danh sách nhân viên và tạo các option -->
                                                        <c:forEach items="${staffs}" var="st">
                                                            <option value="${st.id}">
                                                               ${st.id} - ${st.profile.lastName} ${st.profile.firstName} 
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </form>
                                            </c:if>
                                            <c:if test="${!manager && rd.status.id eq 2 && rd.staff.id eq id}">
                                                <form action="reservation" method="POST" onsubmit="confirmChangeStatus(event)">

                                                    <input type="hidden" name="action" value="rejectD" />
                                                    <!-- Gửi reservation ID và reservation_detail_id qua form -->
                                                    <input type="hidden" name="reservation_id" value="${r.id}" />
                                                    <input type="hidden" name="reservation_detail_id" value="${rd.id}" />
                                                    <input type="submit" class="btn red" value="Reject"/>
                                                </form>
                                                <form action="reservation" method="POST" onsubmit="confirmChangeStatus(event)">

                                                    <input type="hidden" name="action" value="confirmD" />
                                                    <!-- Gửi reservation ID và reservation_detail_id qua form -->
                                                    <input type="hidden" name="reservation_id" value="${r.id}" />
                                                    <input type="hidden" name="reservation_detail_id" value="${rd.id}" />
                                                    <input type="submit" class="btn blue" value="Confirm"/>
                                                </form>
                                            </c:if>
                                            <c:if test="${!manager && rd.status.id eq 4 && rd.staff.id eq id}">

                                                <form action="reservation" method="POST" onsubmit="confirmChangeStatus(event)">

                                                    <input type="hidden" name="action" value="processD" />
                                                    <!-- Gửi reservation ID và reservation_detail_id qua form -->
                                                    <input type="hidden" name="reservation_id" value="${r.id}" />
                                                    <input type="hidden" name="reservation_detail_id" value="${rd.id}" />
                                                    <input type="submit" class="btn gray" value="Processing"/>
                                                </form>
                                            </c:if>
                                            <c:if test="${!manager && rd.status.id eq 5 && rd.staff.id eq id}">

                                                <form action="reservation" method="POST" onsubmit="confirmChangeStatus(event)">

                                                    <input type="hidden" name="action" value="completeD" />
                                                    <!-- Gửi reservation ID và reservation_detail_id qua form -->
                                                    <input type="hidden" name="reservation_id" value="${r.id}" />
                                                    <input type="hidden" name="reservation_detail_id" value="${rd.id}" />
                                                    <input type="submit" class="btn green" value="Complete"/>
                                                </form>
                                            </c:if>


                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Phân trang -->
                        <div class="col-lg-12 m-b20">
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
                                                    function confirmChangeStatus(event) {
                                                        event.preventDefault();

                                                        Swal.fire({
                                                            title: "Are you sure?",
                                                            text: "Do you really want to change the status?",
                                                            icon: "warning",
                                                            showCancelButton: true,
                                                            confirmButtonColor: "#3085d6",
                                                            cancelButtonColor: "#d33",
                                                            confirmButtonText: "Yes, change it!",
                                                            cancelButtonText: "No, cancel!"
                                                        }).then((result) => {
                                                            if (result.isConfirmed) {
                                                                event.target.submit();
                                                            }
                                                        });

                                                        return false;
                                                    }

                                                    function preRefund(event)
                                                    {
                                                        Swal.fire({
                                                            title: "Are you sure?",
                                                            text: "Do you really want to refund for this reservation?",
                                                            icon: "warning",
                                                            showCancelButton: true,
                                                            confirmButtonColor: "#3085d6",
                                                            cancelButtonColor: "#d33",
                                                            confirmButtonText: "Yes, change it!",
                                                            cancelButtonText: "No, cancel!"
                                                        }).then((result) => {
                                                            if (result.isConfirmed) {
                                                                let id = $('#hiddenId').val();
//                                                                url = '/app/reservation/refund?id=' + id;
//                                                                window.location.href = url;

                                                                $.ajax({
                                                                    url: '/app/reservation/refund',
                                                                    type: 'POST',
                                                                    data: {id: id},
                                                                    success: function (response) {
                                                                        $('#refundBtn').hide();

                                                                        Swal.fire({
                                                                            title: "Good job!",
                                                                            text: "Refund successfully!",
                                                                            icon: "success"
                                                                        });
                                                                    },
                                                                    error: function (jqXHR, textStatus, errorThrown) {
                                                                        Swal.fire({
                                                                            icon: "error",
                                                                            title: "Oops...",
                                                                            text: "Something went wrong!",
                                                                            footer: '<a href="#">Why do I have this issue?</a>'
                                                                        });
                                                                    }
                                                                });

                                                            }
                                                        });
                                                    }
        </script>
        <script>
            <c:if test="${notification eq 1}">
            Swal.fire({
                title: "Success!",
                text: "The reservation change status successfully.",
                icon: "success",
                confirmButtonText: "OK",
                didOpen: () => {
                    document.querySelector(".swal2-select")?.remove();
                }
            });
            </c:if>
            <c:if test="${notification eq 0}">
            Swal.fire({
                title: "Cannot Confirmed!",
                text: "Not have enough available staff to do this reservation.",
                icon: "error",
                confirmButtonText: "OK",
                didOpen: () => {
                    document.querySelector(".swal2-select")?.remove();
                }
            });
            </c:if>
            <c:if test="${notification eq 3}">
            Swal.fire({
                title: "Cannot Change!",
                text: "Cannot change status please try again.",
                icon: "error",
                confirmButtonText: "OK",
                didOpen: () => {
                    document.querySelector(".swal2-select")?.remove();
                }
            });
            </c:if>
        </script>
        <script>
            function confirmChangeStatusCancel(event) {
                event.preventDefault();

                Swal.fire({
                    title: "Are you sure?",
                    text: "Do you really want to change the status?",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "Yes, change it!",
                    cancelButtonText: "No, cancel!",
                    input: 'textarea', // Cho phép người dùng nhập lý do
                    inputPlaceholder: 'Please enter the reason for cancellation...',
                    inputAttributes: {
                        'aria-label': 'Reason for cancellation'
                    },
                    inputValidator: (value) => {
                        if (!value) {
                            return 'You need to provide a reason for cancellation!';
                        }
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Nếu có lý do, thêm lý do vào form
                        let reason = result.value;

                        // Thêm lý do vào form hủy (cancel)
                        var form = event.target;
                        var reasonInput = document.createElement("input");
                        reasonInput.type = "hidden";
                        reasonInput.name = "reason"; // Tên trường dữ liệu
                        reasonInput.value = reason; // Giá trị là lý do người dùng nhập
                        form.appendChild(reasonInput);

                        event.target.submit();
                    }
                });

                return false;
            }
        </script>
        <script>
            $(document).ready(function () {
                var table = $('#reservationdetailTable').DataTable({
                    paging: true,
                    lengthMenu: [8],
                    ordering: true,
                    searching: true,
                    info: false,
                    dom: "t",
                    columnDefs: [
                        {targets: [4, 6], orderable: false}, // Vô hiệu hóa sắp xếp ở cột Action
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
