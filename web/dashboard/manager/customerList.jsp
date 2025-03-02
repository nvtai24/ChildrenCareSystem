<%-- 
    Document   : users
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
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <jsp:include page="../header.jsp"/>
        <!-- header end -->

        <!-- Left sidebar menu start -->
        <jsp:include page="../left-sidebar.jsp"/>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Customer List</h4>
                    <form action="customer/add" method="Get">
                        <button type="submit" class="btn btn-primary mb-2">
                            <a>
                                <i class="fa fa-plus-circle"> </i>
                                Add Customer
                            </a>
                        </button>
                    </form>
                </div>	
                <div class="toolbar">

                    <div class="form-row align-items-center">
                        <form action="customers" method="POST">
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
                        <form action="customers" method="POST" class="d-flex align-items-center">
                            <input type="hidden" name="action" value="search"/>
                            <div class="input-group">
                                <input type="text" class="form-control mb-2" id="inlineFormInput" placeholder="Type anything..." value="${title}" name="search">
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
                            <th>#</th>
                            <th>User Name</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Mobile</th>
                            <th>Status</th>                            
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.customers}" var="c" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${c.username}</td>
                                <td>${c.profile.firstName}</td>
                                <td>${c.profile.lastName}</td>
                                <td>${c.profile.gender ? "Male" : "Female"}</td>
                                <td>${c.email}</td>
                                <td>${c.profile.phone}</td>
                                <td>
                                    <span class="badge ${c.status ? 'badge-success' : 'badge-danger'}">
                                        ${c.status ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td class="text-center text-nowrap">
                                    <form action="customers" method="POST" onsubmit="confirmChangeStatus(event)" class="d-inline">
                                        <input type="hidden" name="id" value="${c.id}">
                                        <input type="hidden" name="status" value="${c.status}">
                                        <input type="hidden" name="action" value="change">
                                        <button type="submit" class="btn ${c.status ? 'red' : 'green'} mb-2">
                                            <i class="fa fa-refresh" aria-hidden="true"></i> ${c.status ? 'Deactivate' : 'Activate'}
                                        </button>
                                    </form>
                                    <a href="customer?id=${c.id}" class="btn green mb-2">
                                        <i class="fa fa-pencil" aria-hidden="true"></i> Edit
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

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
                                                    event.target.closest("form").submit();
                                                }
                                            });
                                        }
                                        $(document).ready(function () {
                                            $('[data-toggle="tooltip"]').tooltip();
                                        });
                                        $('#userTable').DataTable({
                                            "paging": true,
                                            "lengthMenu": [10],
                                            "searching": false,
                                            "ordering": true,
                                            "info": false,
                                            "columnDefs": [
                                                {"orderable": false, "targets": [7, 8]}
                                            ],
                                            "dom": 't<"dt-paging"p>'
                                        });

        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/mailbox.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
