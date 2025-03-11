<%-- 
    Document   : settings
    Created on : Feb 15, 2025, 1:27:25 PM
    Author     : Nvtai
--%>

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
        <link rel="stylesheet" href="assets/css/myButton.css"/>

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


        <style>
            .table td, .table th {
                vertical-align: middle;
            }

            .checkbox-wrapper-19 {
                box-sizing: border-box;
                --background-color: #fff;
                --checkbox-height: 25px;
            }

            @-moz-keyframes dothabottomcheck-19 {
                0% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) / 2);
                }
            }

            @-webkit-keyframes dothabottomcheck-19 {
                0% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) / 2);
                }
            }

            @keyframes dothabottomcheck-19 {
                0% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) / 2);
                }
            }

            @keyframes dothatopcheck-19 {
                0% {
                    height: 0;
                }
                50% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) * 1.2);
                }
            }

            @-webkit-keyframes dothatopcheck-19 {
                0% {
                    height: 0;
                }
                50% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) * 1.2);
                }
            }

            @-moz-keyframes dothatopcheck-19 {
                0% {
                    height: 0;
                }
                50% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) * 1.2);
                }
            }

            .checkbox-wrapper-19 input[type=checkbox] {
                display: none;
            }

            .checkbox-wrapper-19 .check-box {
                height: var(--checkbox-height);
                width: var(--checkbox-height);
                background-color: transparent;
                border: calc(var(--checkbox-height) * .1) solid #000;
                border-radius: 5px;
                position: relative;
                display: inline-block;
                -moz-box-sizing: border-box;
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                -moz-transition: border-color ease 0.2s;
                -o-transition: border-color ease 0.2s;
                -webkit-transition: border-color ease 0.2s;
                transition: border-color ease 0.2s;
                cursor: pointer;
            }
            .checkbox-wrapper-19 .check-box::before,
            .checkbox-wrapper-19 .check-box::after {
                -moz-box-sizing: border-box;
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                position: absolute;
                height: 0;
                width: calc(var(--checkbox-height) * .2);
                background-color: #34b93d;
                display: inline-block;
                -moz-transform-origin: left top;
                -ms-transform-origin: left top;
                -o-transform-origin: left top;
                -webkit-transform-origin: left top;
                transform-origin: left top;
                border-radius: 5px;
                content: " ";
                -webkit-transition: opacity ease 0.5;
                -moz-transition: opacity ease 0.5;
                transition: opacity ease 0.5;
            }
            .checkbox-wrapper-19 .check-box::before {
                top: calc(var(--checkbox-height) * .72);
                left: calc(var(--checkbox-height) * .41);
                box-shadow: 0 0 0 calc(var(--checkbox-height) * .05) var(--background-color);
                -moz-transform: rotate(-135deg);
                -ms-transform: rotate(-135deg);
                -o-transform: rotate(-135deg);
                -webkit-transform: rotate(-135deg);
                transform: rotate(-135deg);
            }
            .checkbox-wrapper-19 .check-box::after {
                top: calc(var(--checkbox-height) * .37);
                left: calc(var(--checkbox-height) * .05);
                -moz-transform: rotate(-45deg);
                -ms-transform: rotate(-45deg);
                -o-transform: rotate(-45deg);
                -webkit-transform: rotate(-45deg);
                transform: rotate(-45deg);
            }

            .checkbox-wrapper-19 input[type=checkbox]:checked + .check-box,
            .checkbox-wrapper-19 .check-box.checked {
                border-color: #34b93d;
            }
            .checkbox-wrapper-19 input[type=checkbox]:checked + .check-box::after,
            .checkbox-wrapper-19 .check-box.checked::after {
                height: calc(var(--checkbox-height) / 2);
                -moz-animation: dothabottomcheck-19 0.2s ease 0s forwards;
                -o-animation: dothabottomcheck-19 0.2s ease 0s forwards;
                -webkit-animation: dothabottomcheck-19 0.2s ease 0s forwards;
                animation: dothabottomcheck-19 0.2s ease 0s forwards;
            }
            .checkbox-wrapper-19 input[type=checkbox]:checked + .check-box::before,
            .checkbox-wrapper-19 .check-box.checked::before {
                height: calc(var(--checkbox-height) * 1.2);
                -moz-animation: dothatopcheck-19 0.4s ease 0s forwards;
                -o-animation: dothatopcheck-19 0.4s ease 0s forwards;
                -webkit-animation: dothatopcheck-19 0.4s ease 0s forwards;
                animation: dothatopcheck-19 0.4s ease 0s forwards;
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

                <div class="toolbar">
                    <a class="btn btn-success green mb-2" href="/app/permissions">
                        Back
                    </a>

                    <h3>
                        ${requestScope.r.roleName} - ${requestScope.r.description}
                    </h3>
                </div>


                <div class="toolbar">
                    <div>
                        <div class="form-row align-items-center">
                            <!--                            <div class="col-auto">
                                                            <div class="input-group mb-2">
                                                                <div class="input-group-prepend">
                                                                    <div class="input-group-text">Status</div>
                                                                </div>
                                                                <select name="status" id="selectStatus">
                                                                    <option value="-1">All</option>
                                                                    <option value="1">Active</option>      
                                                                    <option value="0">Inactive</option>
                                                                </select>
                                                            </div>
                                                        </div>-->

                            <div class="col-auto w-50" >
                                <input type="text" id="featureSearchBox" class="form-control mb-2" name="keyword" placeholder="Search for features...">
                            </div>

                            <div class="col-auto" id="clearSearch">
                                <button type="submit" class="btn btn-primary mb-2">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                </button>
                            </div>
                        </div>
                        </form>
                    </div>

                    <table id="permissionTable" class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Feature Name</th>
                                <th scope="col">Description</th>
                                <th scope="col">URL</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.allF}" var="a" varStatus="status">
                                <tr>
                                    <th scope="row">${status.index + 1}</th>
                                    <td>${a.featureName}</td>
                                    <td>${a.description}</td>
                                    <td>${a.url}</td>
                                    <td>
                                        <div class="checkbox-wrapper-19">
                                            <input type="checkbox" class="permissionCheckbox"
                                                   data-rid="${requestScope.r.id}" data-fid="${a.id}"
                                                   id="cbtest-${a.id}" ${roleF != null && roleF.contains(a.url) ? 'checked' : ''}/>
                                            <label for="cbtest-${a.id}" class="check-box">
                                        </div>
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
                var table = $("#permissionTable").DataTable({
                    paging: true,
                    lengthMenu: [10], // Số dòng hiển thị trên mỗi trang
                    ordering: true,
                    searching: true,
                    info: false,
                    dom: "t", // Ẩn phân trang mặc định của DataTables
                    columnDefs: [
                        {targets: [4], orderable: false} // Vô hiệu hóa sắp xếp ở cột Action (index 4)
                    ],
                    drawCallback: function () {
                        updatePagination(this.api()); // Cập nhật phân trang tùy chỉnh sau mỗi lần vẽ lại
                    }
                });

                // **Sử dụng event delegation thay vì bind trực tiếp**
                $(document).on("change", ".permissionCheckbox", function () {
                    var checkbox = $(this);
                    var roleId = checkbox.data("rid");
                    var featureId = checkbox.data("fid");

                    $.ajax({
                        url: "/app/permissions/assign",
                        type: "POST",
                        data: {
                            rid: roleId,
                            fid: featureId
                        }
                    });
                });

                // Tìm kiếm theo từ khóa
                $("#featureSearchBox").on("keyup", function () {
                    table.search(this.value).draw();
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
                    $(".pagination a").off("click").on("click", function (e) {
                        e.preventDefault();
                        var page = $(this).data("page");
                        if (page !== undefined) {
                            table.page(page).draw("page");
                        }
                    });
                }
            });

        </script>



        <!-- External JavaScripts -->
        <!--        <script src="assets2/js/jquery.min.js"></script>-->
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
