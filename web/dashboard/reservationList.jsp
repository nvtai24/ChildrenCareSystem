<%-- 
    Document   : reservationList
    Created on : Mar 9, 2025, 2:05:14 PM
    Author     : Admin
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
                </div>	
                <div class="toolbar">
                    <div class="form-row align-items-center">
                        <form action="reservations" method="POST">
                            <input type="hidden" name="action" value="status"/>
                            <div class="col-auto">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Status</div>
                                    </div>
                                    <select name="status" onchange="this.form.submit()">
                                        <option value="-1" >All</option>
                                        <c:forEach items="${statusList}" var="sl">
                                            <option value="${sl.id}" >${sl.statusName}</option>                                             
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </form>
                        <form action="reservations" method="POST" class="form-inline">
                            <input type="hidden" name="action" value="filterDate"/>
                            <div class="form-group mx-sm-3 mb-2">
                                <label for="fromDate" class="mr-2">From:</label>
                                <input type="date" class="form-control" id="fromDate" name="fromDate" value="${param.fromDate}">
                            </div>
                            <div class="form-group mx-sm-3 mb-2">
                                <label for="toDate" class="mr-2">To:</label>
                                <input type="date" class="form-control" id="toDate" name="toDate" value="${param.toDate}">
                            </div>
                            <button type="submit" class="btn btn-primary mb-2">
                                <i class="fa fa-filter"></i> Filter
                            </button>
                        </form>
                        <form action="reservations" method="POST" class="d-flex align-items-center">
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
                            <th>#</th>                            
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Reserved Date</th>
                            <th>Service name</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.users}" var="u" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="text-center text-nowrap">
                                    <a href="reservation?id=${u.id}" class="btn green mb-2">
                                        <i class="fa fa-pencil" aria-hidden="true"></i> Detail
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
//                                        function confirmChangeStatus(event) {
//                                            event.preventDefault();
//
//                                            Swal.fire({
//                                                title: "Are you sure?",
//                                                text: "Do you really want to change the status?",
//                                                icon: "warning",
//                                                showCancelButton: true,
//                                                confirmButtonColor: "#3085d6",
//                                                cancelButtonColor: "#d33",
//                                                confirmButtonText: "Yes, change it!",
//                                                cancelButtonText: "No, cancel!"
//                                            }).then((result) => {
//                                                if (result.isConfirmed) {
//                                                    event.target.submit();
//                                                }
//                                            });
//
//                                            return false;
//                                        }
//                                        $(document).ready(function () {
//                                            $('[data-toggle="tooltip"]').tooltip();
//                                        });
//                                        $('#userTable').DataTable({
//                                            "paging": true,
//                                            "lengthMenu": [10],
//                                            "searching": false,
//                                            "ordering": true,
//                                            "info": false,
//                                            "columnDefs": [
//                                                {"orderable": false, "targets": [6, 9]}
//                                            ],
//                                            "dom": 't<"dt-paging"p>'
//                                        });

        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/mailbox.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
