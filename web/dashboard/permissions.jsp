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
        <link rel="stylesheet" href="assets/css/myButton.css"/>


        <style>
            .table td, .table th {
                vertical-align: middle;
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

            <c:forEach items="${requestScope.r}" var="r" varStatus="loop">
                <c:if test="${r.id != 1}">
                    <div class="container-fluid">
                        <div class="db-breadcrumb">
                            <h3 style="cursor: pointer">
                                <a type="button" data-toggle="collapse" href="#collapse${loop.index}" aria-expanded="false" id="toggle-btn-${loop.index}">
                                    <i class="ti-arrow-circle-down icon-down"></i>
                                    <i class="ti-arrow-circle-up icon-up d-none"></i>
                                    ${r.roleName} 
                                </a>
                            </h3>
                        </div>  

                        <div id="collapse${loop.index}" class="collapse">
                            <div class="toolbar">
                                <a class="btn btn-primary mb-2" href="permissions/assign?rid=${r.id}">
                                    <i class="fa fa-plus-circle"></i> Assign More Permission
                                </a>

                                <!--                                <form>
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
                                                                </form>-->
                            </div>

                            <table class="table table-hover">
                                <thead class="thead-light align-middle">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Feature Name</th>
                                        <th scope="col">Description</th>
                                        <th scope="col">URL</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${r.features}" var="f" varStatus="status">
                                        <tr>
                                            <th scope="row">${status.index + 1}</th>
                                            <td>${f.featureName}</td>
                                            <td>${f.description}</td>
                                            <td>${f.url}</td>
                                            <td>
                                                <label class="switch" style="margin: 0">
                                                    <input type="checkbox" ${f.status == true ? 'checked' : ''} class="toggle-permission" data-roleid="${r.id}" data-featureid="${f.id}">
                                                    <span class="slider round"></span>
                                                </label>
                                            </td>

                                            <td>
                                                <button class="btn red" onclick="unassignPermission(${r.id}, ${f.id}, this)">
                                                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
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

            <script>
                $(document).ready(function () {
                    $(".toggle-permission").change(function () {
                        var checkbox = $(this);
                        var roleId = checkbox.data("roleid");
                        var featureId = checkbox.data("featureid");

                        $.ajax({
                            url: "/app/permissions",
                            type: "POST",
                            data: {
                                rid: roleId,
                                fid: featureId
                            }
                        });
                    });
                });
            </script>

            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script>
                function unassignPermission(rid, fid, buttonElement) {
                    Swal.fire({
                        title: "Confirm Permission Removal?",
                        text: "Are you sure you want to remove this permission from the role?",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#d33",
                        cancelButtonColor: "#3085d6",
                        confirmButtonText: "Yes, remove it!",
                        cancelButtonText: "Cancel"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                url: "/app/permissions",
                                type: "POST",
                                data: {
                                    rid: rid,
                                    fid: fid,
                                    remove: true
                                },
                                success: function (response) {
                                    Swal.fire(
                                            "Removed!",
                                            "The permission has been successfully removed.",
                                            "success"
                                            ).then(() => {
                                        $(buttonElement).closest("tr").fadeOut();
                                    });
                                },
                                error: function () {
                                    Swal.fire(
                                            "Error!",
                                            "An error occurred, please try again.",
                                            "error"
                                            );
                                }
                            });
                        }
                    });
                }
            </script>

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
