<%-- 
    Document   : settings
    Created on : Feb 15, 2025, 12:31:16 AM
    Author     : Nvtai
--%>

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

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
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
        <jsp:include page="../admin/header.jsp"/>
        <!-- header end -->
        
        <!-- Left sidebar menu start -->
        <jsp:include page="../admin/left-sidebar.jsp"/>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Courses</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Courses</li>
                    </ul>
                </div>	
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Your Courses</h4>
                            </div>
                            <div class="widget-inner">
                                <div class="card-courses-list admin-courses">
                                    <div class="card-courses-media">
                                        <img src="assets2/images/courses/pic1.jpg" alt=""/>
                                    </div>
                                    <div class="card-courses-full-dec">
                                        <div class="card-courses-title">
                                            <h4>Become a PHP Master and Make Money</h4>
                                        </div>
                                        <div class="card-courses-list-bx">
                                            <ul class="card-courses-view">
                                                <li class="card-courses-user">
                                                    <div class="card-courses-user-pic">
                                                        <img src="assets2/images/testimonials/pic3.jpg" alt=""/>
                                                    </div>
                                                    <div class="card-courses-user-info">
                                                        <h5>Teacher</h5>
                                                        <h4>Keny White</h4>
                                                    </div>
                                                </li>
                                                <li class="card-courses-categories">
                                                    <h5>3 Categories</h5>
                                                    <h4>Backend</h4>
                                                </li>
                                                <li class="card-courses-review">
                                                    <h5>3 Review</h5>
                                                    <ul class="cours-star">
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li><i class="fa fa-star"></i></li>
                                                        <li><i class="fa fa-star"></i></li>
                                                    </ul>
                                                </li>
                                                <li class="card-courses-stats">
                                                    <a href="#" class="btn button-sm green radius-xl">Pending</a>
                                                </li>
                                                <li class="card-courses-price">
                                                    <del>$190</del>
                                                    <h5 class="text-primary">$120</h5>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="row card-courses-dec">
                                            <div class="col-md-12">
                                                <h6 class="m-b10">Course Description</h6>
                                                <p>Lorem ipsum dolor sit amet, est ei idque voluptua copiosae, pro detracto disputando reformidans at, ex vel suas eripuit. Vel alii zril maiorum ex, mea id sale eirmod epicurei. Sit te possit senserit, eam alia veritus maluisset ei, id cibo vocent ocurreret per. Te qui doming doctus referrentur, usu debet tamquam et. Sea ut nullam aperiam, mei cu tollit salutatus delicatissimi. </p>	
                                            </div>
                                            <div class="col-md-12">
                                                <a href="#" class="btn green radius-xl outline">Approve</a>
                                                <a href="#" class="btn red outline radius-xl ">Cancel</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="card-courses-list admin-courses">
                                    <div class="card-courses-media">
                                        <img src="assets2/images/courses/pic2.jpg" alt=""/>
                                    </div>
                                    <div class="card-courses-full-dec">
                                        <div class="card-courses-title">
                                            <h4>Become a PHP Master and Make Money</h4>
                                        </div>
                                        <div class="card-courses-list-bx">
                                            <ul class="card-courses-view">
                                                <li class="card-courses-user">
                                                    <div class="card-courses-user-pic">
                                                        <img src="assets2/images/testimonials/pic3.jpg" alt=""/>
                                                    </div>
                                                    <div class="card-courses-user-info">
                                                        <h5>Teacher</h5>
                                                        <h4>Keny White</h4>
                                                    </div>
                                                </li>
                                                <li class="card-courses-categories">
                                                    <h5>3 Categories</h5>
                                                    <h4>Backend</h4>
                                                </li>
                                                <li class="card-courses-review">
                                                    <h5>3 Review</h5>
                                                    <ul class="cours-star">
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li><i class="fa fa-star"></i></li>
                                                        <li><i class="fa fa-star"></i></li>
                                                    </ul>
                                                </li>
                                                <li class="card-courses-stats">
                                                    <a href="#" class="btn button-sm green radius-xl">Pending</a>
                                                </li>
                                                <li class="card-courses-price">
                                                    <del>$190</del>
                                                    <h5 class="text-primary">$120</h5>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="row card-courses-dec">
                                            <div class="col-md-12">
                                                <h6 class="m-b10">Course Description</h6>
                                                <p>Lorem ipsum dolor sit amet, est ei idque voluptua copiosae, pro detracto disputando reformidans at, ex vel suas eripuit. Vel alii zril maiorum ex, mea id sale eirmod epicurei. Sit te possit senserit, eam alia veritus maluisset ei, id cibo vocent ocurreret per. Te qui doming doctus referrentur, usu debet tamquam et. Sea ut nullam aperiam, mei cu tollit salutatus delicatissimi. </p>	
                                            </div>
                                            <div class="col-md-12">
                                                <a href="#" class="btn green radius-xl outline">Approve</a>
                                                <a href="#" class="btn red outline radius-xl ">Cancel</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="card-courses-list admin-courses">
                                    <div class="card-courses-media">
                                        <img src="assets2/images/courses/pic3.jpg" alt=""/>
                                    </div>
                                    <div class="card-courses-full-dec">
                                        <div class="card-courses-title">
                                            <h4>Become a PHP Master and Make Money</h4>
                                        </div>
                                        <div class="card-courses-list-bx">
                                            <ul class="card-courses-view">
                                                <li class="card-courses-user">
                                                    <div class="card-courses-user-pic">
                                                        <img src="assets2/images/testimonials/pic3.jpg" alt=""/>
                                                    </div>
                                                    <div class="card-courses-user-info">
                                                        <h5>Teacher</h5>
                                                        <h4>Keny White</h4>
                                                    </div>
                                                </li>
                                                <li class="card-courses-categories">
                                                    <h5>3 Categories</h5>
                                                    <h4>Backend</h4>
                                                </li>
                                                <li class="card-courses-review">
                                                    <h5>3 Review</h5>
                                                    <ul class="cours-star">
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li><i class="fa fa-star"></i></li>
                                                        <li><i class="fa fa-star"></i></li>
                                                    </ul>
                                                </li>
                                                <li class="card-courses-stats">
                                                    <a href="#" class="btn button-sm green radius-xl">Pending</a>
                                                </li>
                                                <li class="card-courses-price">
                                                    <del>$190</del>
                                                    <h5 class="text-primary">$120</h5>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="row card-courses-dec">
                                            <div class="col-md-12">
                                                <h6 class="m-b10">Course Description</h6>
                                                <p>Lorem ipsum dolor sit amet, est ei idque voluptua copiosae, pro detracto disputando reformidans at, ex vel suas eripuit. Vel alii zril maiorum ex, mea id sale eirmod epicurei. Sit te possit senserit, eam alia veritus maluisset ei, id cibo vocent ocurreret per. Te qui doming doctus referrentur, usu debet tamquam et. Sea ut nullam aperiam, mei cu tollit salutatus delicatissimi. </p>	
                                            </div>
                                            <div class="col-md-12">
                                                <a href="#" class="btn green radius-xl outline">Approve</a>
                                                <a href="#" class="btn red outline radius-xl ">Cancel</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="card-courses-list admin-courses">
                                    <div class="card-courses-media">
                                        <img src="assets2/images/courses/pic4.jpg" alt=""/>
                                    </div>
                                    <div class="card-courses-full-dec">
                                        <div class="card-courses-title">
                                            <h4>Become a PHP Master and Make Money</h4>
                                        </div>
                                        <div class="card-courses-list-bx">
                                            <ul class="card-courses-view">
                                                <li class="card-courses-user">
                                                    <div class="card-courses-user-pic">
                                                        <img src="assets2/images/testimonials/pic3.jpg" alt=""/>
                                                    </div>
                                                    <div class="card-courses-user-info">
                                                        <h5>Teacher</h5>
                                                        <h4>Keny White</h4>
                                                    </div>
                                                </li>
                                                <li class="card-courses-categories">
                                                    <h5>3 Categories</h5>
                                                    <h4>Backend</h4>
                                                </li>
                                                <li class="card-courses-review">
                                                    <h5>3 Review</h5>
                                                    <ul class="cours-star">
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                        <li><i class="fa fa-star"></i></li>
                                                        <li><i class="fa fa-star"></i></li>
                                                    </ul>
                                                </li>
                                                <li class="card-courses-stats">
                                                    <a href="#" class="btn button-sm green radius-xl">Pending</a>
                                                </li>
                                                <li class="card-courses-price">
                                                    <del>$190</del>
                                                    <h5 class="text-primary">$120</h5>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="row card-courses-dec">
                                            <div class="col-md-12">
                                                <h6 class="m-b10">Course Description</h6>
                                                <p>Lorem ipsum dolor sit amet, est ei idque voluptua copiosae, pro detracto disputando reformidans at, ex vel suas eripuit. Vel alii zril maiorum ex, mea id sale eirmod epicurei. Sit te possit senserit, eam alia veritus maluisset ei, id cibo vocent ocurreret per. Te qui doming doctus referrentur, usu debet tamquam et. Sea ut nullam aperiam, mei cu tollit salutatus delicatissimi. </p>	
                                            </div>
                                            <div class="col-md-12">
                                                <a href="#" class="btn green radius-xl outline">Approve</a>
                                                <a href="#" class="btn red outline radius-xl ">Cancel</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>
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
        <script src='assets2/vendors/switcher/switcher.js'></script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
