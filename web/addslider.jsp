<%-- 
    Document   : addslider
    Created on : Feb 7, 2025, 10:16:33 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/add-listing.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="../error-404.html" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>ChildrenCare</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets2/js/html5shiv.min.js"></script>
        <script src="assets2/js/respond.min.js"></script>
        <![endif]-->

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
        <jsp:include page="dashboard/header.jsp"/>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <jsp:include page="dashboard/left-sidebar.jsp"/>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Add Slider</h4>
                    <ul class="db-breadcrumb-list">

                        <li>Add Slider</li>
                    </ul>
                </div>	
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Add New Slider</h4>
                            </div>
                            <div class="widget-inner">
                                <form class="edit-profile m-b30" action="addslider" method="post" enctype="multipart/form-data">
                                    <div class="row">

                                        <div class="form-group col-6">
                                            <h3>1. Slider Title</h3>
                                            <small style="color: red;">${titleError}</small>
                                            <div>
                                                <input name="title" class="form-control" type="text"
                                                       placeholder="Type anything..."
                                                       value="${titleValue != null ? titleValue : ''}" >
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <h3>2. Back Link</h3>
                                            <small style="color: red;">${backLinkError}</small>
                                            <div>
                                                <input name="backLink" class="form-control" type="text"
                                                       placeholder="Type anything..."
                                                       value="${backLinkValue != null ? backLinkValue : ''}" >                                    
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <h3>3. Image</h3>
                                            <div>
                                                <input type="file" name="image" class="form-control" accept="image/*" onchange="validateImageFile(this)" required>
                                            </div>
                                        </div>

                                        <div class="seperator"></div>

                                        <div class="col-12">

                                            <button type="submit" class="btn">Save changes</button>

                                        </div>

                                    </div>


                                </form>

                                <button class="btn-secondry add-item m-r5">          
                                    <a style="color: white" href="sliders"><< Slider List</a>
                                </button>


                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                                    // Pricing add
                                                    function newMenuItem() {
                                                        var newElem = $('tr.list-item').first().clone();
                                                        newElem.find('input').val('');
                                                        newElem.appendTo('table#item-add');
                                                    }
                                                    if ($("table#item-add").is('*')) {
                                                        $('.add-item').on('click', function (e) {
                                                            e.preventDefault();
                                                            newMenuItem();
                                                        });
                                                        $(document).on("click", "#item-add .delete", function (e) {
                                                            e.preventDefault();
                                                            $(this).parent().parent().parent().parent().remove();
                                                        });
                                                    }
        </script>
        <script>
            function validateImageFile(input) {
                const file = input.files[0];

                if (!file)
                    return;

                const fileType = file.type;

                if (!fileType.startsWith("image/")) {
                    Swal.fire({
                        icon: "error",
                        title: "Invalid file type!",
                        text: "Only image files are allowed.",
                        confirmButtonText: "OK"
                    });

                    input.value = ""; // Clear the file input
                }
            }
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/add-listing.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
</html>
