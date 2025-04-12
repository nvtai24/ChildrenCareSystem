<%-- 
    Document   : users
    Created on : Feb 15, 2025, 1:27:25 PM
    Author     : Nvtai
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <h4 class="breadcrumb-title">User List</h4>
                    <form action="users/add" method="Get">
                        <button type="submit" class="btn btn-primary mb-2">
                            <a>
                                <i class="fa fa-plus-circle"> </i>
                                Add User
                            </a>
                        </button>
                    </form>
                </div>	
                <div class="toolbar">

                    <div class="form-row align-items-center">
                        <form action="users" method="POST" >
                            <input type="hidden" name="action" value="role"/>
                            <div class="col-auto">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Role</div>
                                    </div>
                                    <select name="role" onchange="this.form.submit()">
                                        <option value="-1" ${sessionScope.sessionRoleId == -1 ? 'selected' : ''}>All</option>
                                        <c:forEach items="${requestScope.roles}" var="r">
                                            <option value="${r.id}" ${sessionScope.sessionRoleId == r.id ? 'selected' : ''}>${r.roleName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </form>
                        <form action="users" method="POST">
                            <input type="hidden" name="action" value="status"/>
                            <div class="col-auto">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Status</div>
                                    </div>
                                    <select name="status" onchange="this.form.submit()">
                                        <option value="-1" ${ sessionScope.sessionStatus == -1 ? 'selected' : ''}>All</option>
                                        <option value="1" ${ sessionScope.sessionStatus == 1 ? 'selected' : ''}>Active</option>      
                                        <option value="0" ${ sessionScope.sessionStatus == 0 ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                        <form action="users" method="POST" class="d-flex align-items-center">
                            <input type="hidden" name="action" value="search"/>
                            <div class="input-group">
                                <input type="text" class="form-control mb-2" id="inlineFormInput" placeholder="Type anything..." value="${requestScope.title}" name="search">
                                <button type="submit" class="btn btn-primary mb-2">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                </button>
                            </div>
                        </form>

                    </div>

                </div>



                <table id="userTable" class="table table-striped table-hover" style="width:100%">
                    <thead class="thead-light">
                        <tr>
                            <th class="text-center">#</th>
                            <th class="text-center">Username</th>
                            <th class="text-center">First Name</th>
                            <th class="text-center">Last Name</th>
                            <th class="text-center">Email</th>
                            <th class="text-center">Role</th>
                            <th class="text-center">Status</th>
                            <th class="text-center">Created Date</th>
                            <th class="text-center">Updated Date</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.users}" var="u" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${u.username}</td>
                                <td>${u.profile.firstName}</td>
                                <td>${u.profile.lastName}</td>
                                <td>${u.email}</td>
                                <td>${u.role.roleName}</td>
                                <td>
                                    <span class="badge ${u.status ? 'badge-success' : 'badge-danger'}">
                                        ${u.status ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>${u.createdDate.toLocalDate()}</td>
                                <td>${u.updatedDate.toLocalDate()}</td>
                                <td class="text-center text-nowrap">
                                    <form action="users" method="POST" onsubmit="confirmChangeStatus(event)" class="d-inline">
                                        <input type="hidden" name="id" value="${u.id}">
                                        <input type="hidden" name="status" value="${u.status}">
                                        <input type="hidden" name="action" value="change">
                                        <button type="submit" class="btn ${u.status ? 'red' : 'green'} mb-2" ${u.role.roleName eq 'Admin'?'style="display: none"':''} >
                                            <i class="fa fa-refresh" aria-hidden="true"></i> ${u.status ? 'Deactivate' : 'Activate'}
                                        </button>
                                    </form>
                                    <a href="users/update?id=${u.id}" class="btn green mb-2">
                                        <i class="fa fa-pencil" aria-hidden="true"></i> Edit
                                    </a>
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

        <c:if test="${not empty notification}">
            <script>
                                        document.addEventListener("DOMContentLoaded", function () {
                                            Swal.fire({
                                                title: "<c:out value='${notification eq "successfull" ? "Success!" : "Oops..."}' />",
                                                text: "<c:out value='${notification eq "successfull" ? "User has been updated successfully." : "User cannot updated please try again!"}' />",
                                                icon: "<c:out value='${notification eq "successfull" ? "success" : "error"}' />",
                                                confirmButtonText: "OK",
                                                didOpen: () => {
                                                    document.querySelector(".swal2-select")?.remove();
                                                }
                                            });
                                        });
            </script>
        </c:if>

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
            $(document).ready(function () {

                var table = $('#userTable').DataTable({
                    paging: true,
                    lengthMenu: [10],
                    ordering: true,
                    searching: true,
                    info: false,
                    dom: "t",
                    columnDefs: [
                        {targets: [6, 9], orderable: false}, // Vô hiệu hóa sắp xếp ở cột Action
                    ],
                    drawCallback: function () {
                        updatePagination(this.api());
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
