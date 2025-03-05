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
        <jsp:include page="left-sidebar.jsp"/>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">

            <div class="toolbar">
                <button type="submit" class="btn btn-primary mb-2">
                    <a href="settings/add">
                        <i class="fa fa-plus-circle mr-1"></i> Add New Setting
                    </a>
                </button>

                <form action="settings" method="get">
                    <div class="form-row align-items-center">
                        <div class="col-auto">
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">Status</div>
                                </div>
                                <select name="status">
                                    <option value="-1" 
                                            ${requestScope.status == null || requestScope.status == '-1' ? 'selected' : ''}
                                            >All</option>
                                    <option value="1"
                                            ${requestScope.status != null && requestScope.status == '1' ? 'selected' : ''}
                                            >Active</option>      
                                    <option value="0"
                                            ${requestScope.status != null && requestScope.status == '0' ? 'selected' : ''}
                                            >Inactive</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-auto">
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">Type</div>
                                </div>
                                <select name="type">
                                    <option value="-1"
                                            ${requestScope.type != null || requestScope.type == '-1' ? 'selected' : ''}
                                            >All</option>

                                    <c:forEach items="${requestScope.types}" var="s">
                                        <option value="${s.id}"
                                                ${requestScope.type != null && requestScope.type == s.id ? 'selected' : ''}
                                                >${s.name}
                                        </option>      
                                    </c:forEach>

                                </select>
                            </div>
                        </div>

                        <div class="col-auto">
                            <input type="text" class="form-control mb-2" name="keyword" placeholder="Type anything..." value="${requestScope.keyword != null ? requestScope.keyword : '' }">
                        </div>

                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary mb-2">
                                <i class="fa fa-search" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="container-fluid">
                <table id="userTable" class="table table-striped table-hover" style="width:100%">
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
            </div>

        </main>
        <div class="ttr-overlay"></div>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

        <script>
            $(document).ready(function () {
                $('.status-toggle').on('click', function () {
                    var $toggleButton = $(this);
                    var settingId = $toggleButton.data('id');
                    var currentStatus = $toggleButton.data('status');
                    var $statusLabel = $toggleButton.closest('td').prev().find('.badge');

                    $.ajax({
                        url: '/app/setting/toggle',
                        type: 'POST',
                        data: {stid: settingId},
                        success: function (response) {
                            if (currentStatus === true || currentStatus === 'true') {
                                // Switch to Inactive
                                $toggleButton.html(`
                        <div class="btn green mb-2" style="width: 100px">
                            <i class="fa fa-refresh" aria-hidden="true"></i> Active
                        </div>
                    `);
                                $toggleButton.data('status', false);
                                $statusLabel.removeClass('badge-success')
                                        .addClass('badge-danger')
                                        .text('Inactive');
                            } else {
                                // Switch to Active
                                $toggleButton.html(`
                        <div class="btn red mb-2" style="width: 100px">
                            <i class="fa fa-refresh" aria-hidden="true"></i> Inactive
                        </div>
                    `);
                                $toggleButton.data('status', true);
                                $statusLabel.removeClass('badge-danger')
                                        .addClass('badge-success')
                                        .text('Active');
                            }
                        },
                        error: function (xhr, status, error) {
                            alert('Error toggling status: ' + error);
                        }
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
        <!-- DataTables  -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script >
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
                    {"orderable": false, "targets": [4, 5]}
                ],
                "dom": 't<"dt-paging"p>'
            });
        </script>

    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/mailbox.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
