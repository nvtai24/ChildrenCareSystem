<%-- 
    Document   : blogdetails
    Created on : Feb 6, 2025, 10:25:32 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Children Care</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <jsp:include page="header.jsp"/>
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(${POST.thumbnail});">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Blog Details</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="/app">Home</a></li>
                            <li>Blog Details</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <!-- Left part start -->
                                <div class="col-lg-8 col-xl-8">
                                    <!-- blog start -->
                                    <div class="recent-news blog-lg">
                                        <div class="action-box blog-lg">
                                            <img src="${POST.thumbnail}" alt="">
                                        </div>
                                        <div class="info-bx">
                                            <ul class="media-post">
                                                <li><a><i class="fa fa-calendar"></i>${POST.createdDate}</a></li>
                                                <li><a><i class="fa fa-comments-o"></i>.....</a></li>
                                            </ul>
                                            <h5 class="post-title"><a >${POST.title}</a></h5>
                                            <p>${POST.content}</p>
                                            <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                            <div class="widget_tag_cloud">
                                                <h6>TAGS</h6>
                                                <div class="tagcloud"> 
                                                    <a>Design</a> 
                                                    <a>User interface</a> 
                                                    <a>SEO</a> 
                                                    <a>WordPress</a> 
                                                    <a>Development</a> 
                                                    <a>Joomla</a> 
                                                    <a>Design</a> 
                                                    <a>User interface</a> 
                                                    <a>SEO</a> 
                                                    <a>WordPress</a> 
                                                    <a>Development</a> 
                                                    <a>Joomla</a> 
                                                    <a>Design</a> 
                                                    <a>User interface</a> 
                                                    <a>SEO</a> 
                                                    <a>WordPress</a> 
                                                    <a>Development</a> 
                                                    <a>Joomla</a> 
                                                </div>
                                            </div>
                                            <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                            <h6>SHARE </h6>
                                            <ul class="list-inline contact-social-bx">
                                                <li><a href="#" class="btn outline radius-xl"><i class="fa fa-facebook"></i></a></li>
                                                <li><a href="#" class="btn outline radius-xl"><i class="fa fa-twitter"></i></a></li>
                                                <li><a href="#" class="btn outline radius-xl"><i class="fa fa-linkedin"></i></a></li>
                                                <li><a href="#" class="btn outline radius-xl"><i class="fa fa-google-plus"></i></a></li>
                                            </ul>
                                            <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                        </div>
                                    </div>
                                    <div class="clear" id="comment-list">

                                    </div>
                                    <!-- blog END -->
                                </div>
                                <!-- Left part END -->
                                <!-- Side bar start -->
                                <div class="col-lg-4 col-xl-4">
                                    <aside  class="side-bar sticky-top">
                                        <div class="widget">

                                        </div>
                                        <div class="widget recent-posts-entry">
                                            <h6 class="widget-title">Recent Blogs</h6>
                                            <div class="widget-post-bx">

                                                <c:forEach var="post" items="${LISTPOSTS}">
                                                    <div class="widget-post clearfix">
                                                        <div class="ttr-post-media"> <a href="blogdetail?id=${post.id}"><img src="${post.thumbnail}" width="200" height="143" alt=""></a> </div>
                                                        <div class="ttr-post-info">
                                                            <div class="ttr-post-header">
                                                                <h6 class="post-title"><a href="blogdetail?id=${post.id}">${post.title}</a></h6>
                                                            </div>
                                                            <ul class="media-post">
                                                                <li><a><i class="fa fa-calendar"></i>${post.createdDate}</a></li>
                                                                <li><a><i class="fa fa-comments-o"></i>...</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                </c:forEach>



                                            </div>
                                        </div>


                                        <div class="widget widget_tag_cloud">
                                            <h6 class="widget-title">Tags</h6>
                                            <div class="tagcloud"> 
                                                <a>Design</a> 
                                                <a>User interface</a> 
                                                <a>SEO</a> 
                                                <a>WordPress</a> 
                                                <a>Development</a> 
                                                <a>Joomla</a> 
                                                <a>Design</a> 
                                                <a>User interface</a> 
                                                <a>SEO</a> 
                                                <a>WordPress</a> 
                                                <a>Development</a> 
                                                <a>Joomla</a> 
                                                <a>Design</a> 
                                                <a>User interface</a> 
                                                <a>SEO</a> 
                                                <a>WordPress</a> 
                                                <a>Development</a> 
                                                <a>Joomla</a> 
                                            </div>
                                        </div>
                                    </aside>
                                </div>
                                <!-- Side bar END -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Content END-->
            <!-- Footer ==== -->
            <jsp:include page="footer.jsp"/>
            <!-- Footer END ==== -->
            <!-- scroll top button -->
            <button class="back-to-top fa fa-chevron-up" ></button>
        </div>
        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        
    </body>

</html>
