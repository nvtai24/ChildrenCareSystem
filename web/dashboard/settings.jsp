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

            <c:forEach items="${requestScope.settingTypes}" var="type" varStatus="loop">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h3 style="cursor: pointer">
                            <a type="button" data-toggle="collapse" href="#collapse${loop.index}" aria-expanded="false" id="toggle-btn-${loop.index}">
                                <i class="ti-arrow-circle-down icon-down"></i>
                                <i class="ti-arrow-circle-up icon-up d-none"></i>
                                ${type.name} 
                            </a>
                        </h3>
                    </div>  

                    <div id="collapse${loop.index}" class="collapse">
                        <div class="toolbar">
                            <button type="submit" class="btn btn-primary mb-2">
                                <a>
                                    <i class="fa fa-plus-circle"></i> Add New ${type.name}
                                </a>
                            </button>

                            <form>
                                <div class="form-row align-items-center">
                                    <div class="col-auto">
                                        <div class="input-group mb-2">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">Status</div>
                                            </div>
                                            <select name="status">
                                                <option value="-1">All</option>
                                                <option value="1">Active</option>      
                                                <option value="0">Inactive</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-auto">
                                        <input type="text" class="form-control mb-2" placeholder="Type anything...">
                                    </div>

                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-primary mb-2">
                                            <i class="fa fa-search" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Value</th>
                                    <th scope="col">Description</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${type.settings}" var="s" varStatus="status">
                                    <tr>
                                        <th scope="row">${status.index + 1}</th>
                                        <td>${s.settingValue}</td>
                                        <td>${s.description}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${s.status}">
                                                    <span class="badge badge-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-danger">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${s.status}">
                                                    <button type="submit" class="btn red mb-2">
                                                        <a>
                                                            <i class="fa fa-refresh" aria-hidden="true"></i> Inactive
                                                        </a>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="submit" class="btn green mb-2">
                                                        <a>
                                                            <i class="fa fa-refresh" aria-hidden="true"></i> Active
                                                        </a>
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                            <button type="submit" class="btn green mb-2">
                                                <a href="setting?id=${s.id}">
                                                    <i class="fa fa-pencil" aria-hidden="true"></i> Edit
                                                </a>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:forEach>


            <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
            <script>
                $(document).ready(function () {
                    $('[data-toggle="collapse"]').on('click', function () {
                        var target = $(this).attr('href'); // Lấy ID của phần collapse
                        var iconDown = $(this).find('.icon-down'); // Icon xuống
                        var iconUp = $(this).find('.icon-up'); // Icon lên

                        $(target).on('show.bs.collapse', function () {
                            iconDown.addClass("d-none");
                            iconUp.removeClass("d-none");
                        });

                        $(target).on('hide.bs.collapse', function () {
                            iconDown.removeClass("d-none");
                            iconUp.addClass("d-none");
                        });
                    });
                });
            </script>

            <style>
                .icon-down, .icon-up {
                    transition: opacity 0.2s ease-in-out;
                }
            </style>



        </main>
        <div class="ttr-overlay"></div>

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
        <script>
                $(document).ready(function () {
                    $('[data-toggle="tooltip"]').tooltip();
                });
        </script>

    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/mailbox.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
