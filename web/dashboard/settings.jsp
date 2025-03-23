<%-- Document : settings Created on : Feb 15, 2025, 1:27:25 PM Author : Nvtai
--%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@page
    contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <!-- META ============================================= -->
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />

            <!-- FAVICONS ICON ============================================= -->
            <link rel="icon" href="assets/images/logo.png" type="image/x-icon" />
            <link
                rel="shortcut icon"
                type="image/x-icon"
                href="assets/images/logo.png"
                />

            <!-- PAGE TITLE HERE ============================================= -->
            <title>Admin Dashboard</title>
            <base href="${pageContext.request.contextPath}/" />

            <!-- MOBILE SPECIFIC ============================================= -->
            <meta name="viewport" content="width=device-width, initial-scale=1" />
           

            <!-- All PLUGINS CSS ============================================= -->
            <link rel="stylesheet" type="text/css" href="assets2/css/assets.css" />
            <link
                rel="stylesheet"
                type="text/css"
                href="assets2/vendors/calendar/fullcalendar.css"
                />

            <!-- TYPOGRAPHY ============================================= -->
            <link rel="stylesheet" type="text/css" href="assets2/css/typography.css" />

            <!-- SHORTCODES ============================================= -->
            <link
                rel="stylesheet"
                type="text/css"
                href="assets2/css/shortcodes/shortcodes.css"
                />

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
            </style>
        </head>
        <body class="ttr-opened-sidebar ttr-pinned-sidebar">

            <!-- header start -->
            <jsp:include page="header.jsp"/>
            <!-- header end -->

            <!-- Left sidebar menu start -->
            <jsp:include page="left-sidebar.jsp" />
            <!-- Left sidebar menu end -->

            <!--Main container start -->
            <main class="ttr-wrapper">
                <div class="container-fluid">
                    <div class="toolbar">
                        <a href="settings/add" class="btn btn-primary mb-2">
                            <i class="fa fa-plus-circle mr-1"></i> Add New Setting
                        </a>

                        <div class="toolbar mt-2">
                            <div class="form-row align-items-center">
                                <div class="col-auto">
                                    <div class="input-group mb-2">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">Type</div>
                                        </div>
                                        <select name="type" id="typeFilter">
                                            <option value="-1">All</option>

                                            <c:forEach items="${requestScope.types}" var="s">
                                                <option value="${s.id}">${s.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-auto">
                                    <div class="input-group mb-2">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">Status</div>
                                        </div>
                                        <select name="status" id="statusFilter">
                                            <option value="-1">All</option>
                                            <option value="1">Active</option>
                                            <option value="0">Inactive</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-auto">
                                    <input
                                        type="text"
                                        class="form-control mb-2"
                                        name="keyword"
                                        placeholder="Type anything..."
                                        />
                                </div>

                                <div class="col-auto">
                                    <button type="submit" class="btn btn-primary mb-2">
                                        <i class="fa fa-search" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <table id="settingsTable" class="table table-striped table-hover" style="width:100%">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Value</th>
                                    <th scope="col">Type</th>
                                    <th scope="col">Description</th>
                                    <th scope="col">Status</th>
                                    <th scope="col" class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.settings}" var="s" varStatus="status">
                                    <tr>
                                        <td scope="row">${status.index + 1}</td>
                                        <td>${s.settingValue}</td>
                                        <td>${s.settingType.name}</td>
                                        <td>${s.description}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${s.status}">
                                                    <span class="badge badge-success mt-3" style="width: 70px">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-danger mt-3" style="width: 70px">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="display: flex; gap: 20px" class="text-center text-nowrap">
                                            <div class="status-toggle" data-id="${s.id}" data-status="${s.status}">
                                                <c:choose>
                                                    <c:when test="${s.status}">
                                                        <div class="btn red mb-2" style="width: 100px">
                                                            <i class="fa fa-refresh" aria-hidden="true"></i> Inactive
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="btn green mb-2" style="width: 100px">
                                                            <i class="fa fa-refresh" aria-hidden="true"></i> Active
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <button type="submit" class="btn green mb-2" style="width: 100px">
                                                <a href="setting?id=${s.id}" style="color: white">
                                                    <i class="fa fa-pencil" aria-hidden="true"></i> Edit
                                                </a>
                                            </button>
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

            </main>
            <div class="ttr-overlay"></div>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

            <script>
                $(document).ready(function () {
                    var table = $("#settingsTable").DataTable({
                        paging: true,
                        lengthMenu: [10],
                        ordering: true,
                        searching: true,
                        info: false,
                        dom: "t",
                        columnDefs: [
                            {targets: [5], orderable: false}, // Vô hiệu hóa sắp xếp ở cột Action
                        ],
                        drawCallback: function () {
                            updatePagination(this.api());
                        },
                    });

                    // Hàm lọc kết hợp Type và Status
                    function applyFilters() {
                        var typeVal = $("#typeFilter").find("option:selected").text().trim();
                        var statusVal = $("#statusFilter").val();

                        $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
                            var typeColumn = data[2]; // Cột Type (index 2)
                            var statusColumn = data[4]; // Cột Status (index 4)
                            var isActive = statusColumn.includes("Active");

                            // Kiểm tra Type
                            var typeMatch = typeVal === "All" || typeColumn === typeVal;

                            // Kiểm tra Status
                            var statusMatch =
                                    statusVal == "-1" ||
                                    (statusVal == "1" && isActive) ||
                                    (statusVal == "0" && !isActive);

                            // Chỉ hiển thị hàng nếu cả Type và Status đều khớp
                            return typeMatch && statusMatch;
                        });

                        table.draw();
                        $.fn.dataTable.ext.search.pop(); // Xóa bộ lọc sau khi vẽ
                    }

                    // Lọc khi thay đổi Status
                    $("#statusFilter").on("change", function () {
                        applyFilters(); // Gọi hàm lọc kết hợp
                    });

                    // Lọc khi thay đổi Type
                    $("#typeFilter").on("change", function () {
                        var typeVal = $(this).find("option:selected").text().trim();
                        console.log("Filtering type:", typeVal); // Debug
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

//                    $(".status-toggle").on("click", function () {
//                        var $toggleButton = $(this);
//                        var settingId = $toggleButton.data("id");
//                        var currentStatus = $toggleButton.data("status");
//                        var $statusLabel = $toggleButton.closest("td").prev().find(".badge");
//
//                        $.ajax({
//                            url: "/app/setting/toggle",
//                            type: "POST",
//                            data: {stid: settingId},
//                            success: function (response) {
//                                if (currentStatus === true || currentStatus === "true") {
//                                    // Switch to Inactive
//                                    $toggleButton.html(`
//                                            <div class="btn green mb-2" style="width: 100px">
//                                                <i class="fa fa-refresh" aria-hidden="true"></i> Active
//                                            </div>
//                                        `);
//                                    $toggleButton.data("status", false);
//                                    $statusLabel
//                                            .removeClass("badge-success")
//                                            .addClass("badge-danger")
//                                            .text("Inactive");
//                                } else {
//                                    // Switch to Active
//                                    $toggleButton.html(`
//                                <div class="btn red mb-2" style="width: 100px">
//                                    <i class="fa fa-refresh" aria-hidden="true"></i> Inactive
//                                </div>
//                            `);
//                                    $toggleButton.data("status", true);
//                                    $statusLabel
//                                            .removeClass("badge-danger")
//                                            .addClass("badge-success")
//                                            .text("Active");
//                                }
//                            },
//                            error: function (xhr, status, error) {
//                                alert("Error toggling status: " + error);
//                            },
//                        });
//                    });


                    $(document).on("click", ".status-toggle", function () {
                        var $toggleButton = $(this);
                        var settingId = $toggleButton.data("id");
                        var currentStatus = $toggleButton.data("status");
                        var $statusLabel = $toggleButton.closest("td").prev().find(".badge");
                        var $row = $toggleButton.closest("tr"); // Lấy hàng hiện tại
                        var table = $("#settingsTable").DataTable();

                        $.ajax({
                            url: "/app/setting/toggle",
                            type: "POST",
                            data: {stid: settingId},
                            success: function (response) {
                                if (currentStatus === true || currentStatus === "true") {
                                    // Switch to Inactive
                                    $toggleButton.html(`
                    <div class="btn green mb-2" style="width: 100px">
                        <i class="fa fa-refresh" aria-hidden="true"></i> Active
                    </div>
                `);
                                    $toggleButton.data("status", false);
                                    $statusLabel
                                            .removeClass("badge-success")
                                            .addClass("badge-danger")
                                            .text("Inactive");

                                    // Cập nhật dữ liệu trong DataTable
                                    table.cell($row, 4).data('<span class="badge badge-danger mt-3" style="width: 70px">Inactive</span>');
                                } else {
                                    // Switch to Active
                                    $toggleButton.html(`
                    <div class="btn red mb-2" style="width: 100px">
                        <i class="fa fa-refresh" aria-hidden="true"></i> Inactive
                    </div>
                `);
                                    $toggleButton.data("status", true);
                                    $statusLabel
                                            .removeClass("badge-danger")
                                            .addClass("badge-success")
                                            .text("Active");

                                    // Cập nhật dữ liệu trong DataTable
                                    table.cell($row, 4).data('<span class="badge badge-success mt-3" style="width: 70px">Active</span>');
                                }

                                // Áp dụng lại bộ lọc sau khi dữ liệu thay đổi
                                applyFilters();
                            },
                            error: function (xhr, status, error) {
                                alert("Error toggling status: " + error);
                            },
                        });
                    });


                });


            </script>

            <!-- External JavaScripts -->
            <!--<script src="assets2/js/jquery.min.js"></script>-->
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


        </body>

        <!-- Mirrored from educhamp.themetrades.com/demo/admin/mailbox.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
    </html>
