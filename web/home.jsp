<%-- 
    Document   : home2
    Created on : Feb 11, 2025, 10:33:33 PM
    Author     : Nvtai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo.png" type="image/x-icon" />
        <link
            rel="shortcut icon"
            type="image/x-icon"
            href="assets/images/logo.png"
            />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Children Care</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />


        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css" />

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css" />

        <!-- SHORTCODES ============================================= -->
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/css/shortcodes/shortcodes.css"
            />

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css" />
        <link
            class="skin"
            rel="stylesheet"
            type="text/css"
            href="assets/css/color/color-1.css"
            />

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/vendors/revolution/css/layers.css"
            />
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/vendors/revolution/css/settings.css"
            />
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/vendors/revolution/css/navigation.css"
            />
        <!-- REVOLUTION SLIDER END -->

        <link
            rel="stylesheet"
            type="text/css"
            href="assets/css/shortcodes/button.css"
            />

        <style>
            
            .recent-news-carousel .item {
                width: 100%; /* Chiều rộng 100% của container */
                display: flex;
                justify-content: center; /* Canh giữa các item */
                flex: 0 0 33%; /* Đảm bảo các item có chiều rộng đều nhau (3 item trên mỗi hàng) */
                padding: 10px; /* Khoảng cách giữa các item */
            }

            /* Đảm bảo tất cả các blog có chiều cao và chiều rộng bằng nhau */
            .recent-news {
                width: 100%; /* Chiều rộng bằng 100% */
                height: 500px; /* Chiều cao cố định cho blog */
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Đảm bảo các phần tử bên trong được căn chỉnh đều */
                overflow: hidden; /* Ẩn những phần tử vượt ra ngoài */
            }

            /* Hình ảnh sẽ chiếm 100% chiều rộng và chiều cao cố định */
            .recent-news .action-box {
                height: 500px; /* Chiều cao cố định cho ảnh */
                width: 100%; /* Chiều rộng bằng 100% */
                overflow: hidden; /* Ẩn phần ảnh vượt quá chiều cao */
            }

            .recent-news .action-box img {
                width: 100%; /* Chiều rộng của ảnh bằng với chiều rộng của container */
                height: 100%; /* Chiều cao của ảnh bằng với chiều cao của container */
                object-fit: cover; /* Đảm bảo ảnh lấp đầy không gian mà không bị méo */
            }

            /* Căn chỉnh phần tiêu đề và mô tả sao cho đều nhau */
            .recent-news .info-bx {
                padding: 15px;
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Đảm bảo các phần tử con được căn chỉnh đều nhau */
                height: 100%; /* Đảm bảo container chiếm hết chiều cao */
            }

            /* Tiêu đề sẽ có kích thước cố định và căn chỉnh */
            .recent-news .info-bx .post-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
                text-overflow: ellipsis;
                white-space: nowrap;
                overflow: hidden;
            }

            /* Mô tả nội dung sẽ bị giới hạn dòng */
            .recent-news .info-bx p {
                font-size: 14px;
                line-height: 1.6;
                margin-bottom: 10px;
                text-overflow: ellipsis;
                white-space: nowrap;
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 3; /* Giới hạn 3 dòng nội dung */
                -webkit-box-orient: vertical;
            }
            .courses-carousel .cours-bx {
                display: flex;
                flex-direction: column;
                height: 400px;
                border: 1px solid #ddd;
                box-sizing: border-box;
                overflow: hidden;
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
            }

            .courses-carousel .action-box {
                flex-shrink: 0;
                margin-bottom: 15px;
                position: relative;
            }

            .courses-carousel .action-box img {
                width: 100%;
                height: 155px;
                border-radius: 8px;
            }

            .courses-carousel .info-bx {
                display: flex;
                flex-direction: column;
                justify-content: flex-start;  /* Căn phần tử từ trên xuống, không gian sẽ được chia đều */
                height: auto; /* Đảm bảo chiều cao tự động để phù hợp với nội dung */

                flex-grow: 1;  /* Để các phần tử bên trong có thể chiếm không gian tự do */
            }

            /* Phần tiêu đề */
            .courses-carousel h5 {
                margin-bottom: 10px;
                font-size: 15px;
                font-weight: 600;
                white-space: normal; /* Đảm bảo tiêu đề có thể xuống dòng */
                overflow: visible;   /* Hiển thị toàn bộ nội dung mà không bị cắt */
                text-overflow: clip; /* Không cắt chữ */
                word-wrap: break-word; /* Đảm bảo chữ sẽ xuống dòng khi dài quá */
            }

            /* Phần nội dung (span) */
            .courses-carousel span {
                display: -webkit-box;
                -webkit-line-clamp: 3; /* Giới hạn 3 dòng cho nội dung */
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                font-size: 14px;
                color: #555;
            }

            /* Giới hạn chiều cao nếu cần */
            @media (max-width: 768px) {
                .courses-carousel .info-bx {
                    height: auto;  /* Cho phép chiều cao thay đổi theo nội dung */
                }

                .courses-carousel h5, .courses-carousel span {
                    white-space: normal;
                }
            }
        </style>

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <jsp:include page="header.jsp"/>
            <!-- Header Top END ==== -->

            <div class="page-content bg-white">
                <!-- Main Slider -->
                <div class="rev-slider">
                    <div id="rev_slider_486_1_wrapper" class="rev_slider_wrapper fullwidthbanner-container" data-alias="news-gallery36" data-source="gallery" style="margin:0px auto;background-color:#ffffff;padding:0px;margin-top:0px;margin-bottom:0px;">
                        <!-- START REVOLUTION SLIDER 5.3.0.2 fullwidth mode -->
                        <div id="rev_slider_486_1" class="rev_slider fullwidthabanner" style="display:none;" data-version="5.3.0.2" >
                            <ul>	<!-- SLIDE  -->

                                <c:forEach items="${SLIDERS}" var="slider" varStatus="count">
                                    <li data-index="rs-${count.index + 1}00" 
                                        data-transition="parallaxhorizontal" 
                                        data-slotamount="default" 
                                        data-hideafterloop="0" 
                                        data-hideslideonmobile="off" 
                                        data-easein="default" 
                                        data-easeout="default" 
                                        data-masterspeed="default" 
                                        data-thumb="error-404.html" 
                                        data-rotate="0" 
                                        data-fstransition="fade" 
                                        data-fsmasterspeed="1500" 
                                        data-fsslotamount="7" 
                                        data-saveperformance="off"
                                        data-delay="5000"

                                        data-param1="" data-param2="" 
                                        data-param3="" data-param4="" 
                                        data-param5="" data-param6="" 
                                        data-param7="" data-param8="" 
                                        data-param9="" data-param10="" 
                                        >
                                        <!-- MAIN IMAGE -->
                                        <img src="${slider.imageUrl}" alt="" 
                                             data-bgposition="center center" 
                                             data-bgfit="cover" 
                                             data-bgrepeat="no-repeat" 
                                             data-bgparallax="10" 
                                             class="rev-slidebg" 
                                             data-no-retina />

                                        <!-- LAYER NR. 1 -->
                                        <a href="/app${slider.backLink}"><div class="tp-caption tp-shape tp-shapewrapper " 
                                                                               id="slide-100-layer-1" 
                                                                               data-x="['center','center','center','center']" data-hoffset="['0','0','0','0']" 
                                                                               data-y="['middle','middle','middle','middle']" data-voffset="['0','0','0','0']" 
                                                                               data-width="full"
                                                                               data-height="full"
                                                                               data-whitespace="nowrap"
                                                                               data-type="shape" 
                                                                               data-basealign="slide" 
                                                                               data-responsive_offset="off" 
                                                                               data-responsive="off"
                                                                               data-frames='[{"from":"opacity:0;","speed":1,"to":"o:1;","delay":0,"ease":"Power4.easeOut"},{"delay":"wait","speed":1,"to":"opacity:0;","ease":"Power4.easeOut"}]'
                                                                               data-textAlign="['left','left','left','left']"
                                                                               data-paddingtop="[0,0,0,0]"
                                                                               data-paddingright="[0,0,0,0]"
                                                                               data-paddingbottom="[0,0,0,0]"
                                                                               data-paddingleft="[0,0,0,0]"
                                                                               style="z-index: 5;background-color:rgba(2, 0, 11, 0.80);border-color:rgba(0, 0, 0, 0);border-width:0px;"> </div></a>
                                        <!-- LAYER NR. 2 -->
                                        <a href="/app${slider.backLink}"><div class="tp-caption Newspaper-Title   tp-resizeme" 
                                                                               id="slide-100-layer-2" 
                                                                               data-x="['center','center','center','center']" 
                                                                               data-hoffset="['0','0','0','0']" 
                                                                               data-y="['top','top','top','top']" 
                                                                               data-voffset="['250','250','250','240']" 
                                                                               data-fontsize="['50','50','50','30']"
                                                                               data-lineheight="['55','55','55','35']"
                                                                               data-width="full"
                                                                               data-height="none"
                                                                               data-whitespace="normal"
                                                                               data-type="text" 
                                                                               data-responsive_offset="on" 
                                                                               data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                                                               data-textAlign="['center','center','center','center']"
                                                                               data-paddingtop="[0,0,0,0]"
                                                                               data-paddingright="[0,0,0,0]"
                                                                               data-paddingbottom="[10,10,10,10]"
                                                                               data-paddingleft="[0,0,0,0]"
                                                                               style="z-index: 6; font-family:rubik; font-weight:700; text-align:center; white-space: normal;">
                                                ${slider.title}
                                            </div></a>

                                        <!-- LAYER NR. 3 -->
                                        <a href="/app${slider.backLink}"><div class="tp-caption Newspaper-Subtitle   tp-resizeme" 
                                                                               id="slide-100-layer-3" 
                                                                               data-x="['center','center','center','center']" 
                                                                               data-hoffset="['0','0','0','0']" 
                                                                               data-y="['top','top','top','top']" 
                                                                               data-voffset="['210','210','210','210']" 
                                                                               data-width="none"
                                                                               data-height="none"
                                                                               data-whitespace="nowrap"
                                                                               data-type="text" 
                                                                               data-responsive_offset="on"
                                                                               data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                                                               data-textAlign="['left','left','left','left']"
                                                                               data-paddingtop="[0,0,0,0]"
                                                                               data-paddingright="[0,0,0,0]"
                                                                               data-paddingbottom="[0,0,0,0]"
                                                                               data-paddingleft="[0,0,0,0]"
                                                                               style="z-index: 7; white-space: nowrap; color:#fff; font-family:rubik; font-size:18px; font-weight:400;">
                                                ${slider.title}
                                            </div></a>

                                        <!-- LAYER NR. 3 -->
                                        <a href="/app${slider.backLink}"><div class="tp-caption Newspaper-Subtitle   tp-resizeme" 
                                                                               id="slide-100-layer-4" 
                                                                               data-x="['center','center','center','center']" 
                                                                               data-hoffset="['0','0','0','0']" 
                                                                               data-y="['top','top','top','top']" 
                                                                               data-voffset="['320','320','320','290']" 
                                                                               data-width="['800','800','700','420']"
                                                                               data-height="['100','100','100','120']"
                                                                               data-whitespace="unset"
                                                                               data-type="text" 
                                                                               data-responsive_offset="on"
                                                                               data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                                                               data-textAlign="['center','center','center','center']"
                                                                               data-paddingtop="[0,0,0,0]"
                                                                               data-paddingright="[0,0,0,0]"
                                                                               data-paddingbottom="[0,0,0,0]"
                                                                               data-paddingleft="[0,0,0,0]"
                                                                               style="z-index: 7; text-transform:capitalize; white-space: unset; color:#fff; font-family:rubik; font-size:18px; line-height:28px; font-weight:400;">
                                                We always provide the best service for you
                                            </div></a>
                                        <!-- LAYER NR. 4 -->

                                    </li>
                                </c:forEach>

                            </ul>
                        </div><!-- END REVOLUTION SLIDER -->  
                    </div>  
                </div>  

                <div class="content-block">
                    <div class="section-area content-inner service-info-bx">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/ser1.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">

                                            <h4><a >Professional Service</a></h4>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/ser5.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">

                                            <h4><a >Give Parents Peace Of Mind</a></h4>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12">
                                    <div class="service-bx m-b0">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/ser4.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">

                                            <h4><a >Build Good Habits</a></h4>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="section-area section-sp2 popular-courses-bx">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 heading-bx left">
                                    <h2 class="title-head">Services</h2>
                                </div>
                            </div>
                            <div class="row">
                                <div
                                    class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0"
                                    >
                                    <c:forEach items="${SERVICES}" var="service">
                                        <div class="item" onclick="window.location.href = 'service?id=${service.id}'" style="cursor: pointer;">
                                            <div class="cours-bx">
                                                <div class="action-box">
                                                    <img src="${service.thumbnail}" alt="" />
                                                </div>
                                                <div class="info-bx text-center">
                                                    <h5>
                                                        <a href="#">${service.name}</a>
                                                    </h5>
                                                    <span>${service.briefInfo}</span>
                                                </div>
                                                <div class="cours-more-info">
                                                    <div class="review">
                                                        <span>Discount</span>
                                                        <h5>${service.discount}%</h5>
                                                    </div>
                                                    <div class="price">
                                                        <span>Price</span>
                                                        <h5>$${service.price}</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Popular Courses -->
                    <div class="section-area section-sp2 popular-courses-bx">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 heading-bx left">


                                    <h2 class="title-head">Blogs</h2>


                                </div>
                            </div>
                            <div class="row">
                                <div class="recent-news-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                                    <c:forEach items="${POSTS}" var="post">
                                        <div class="item">
                                            <div class="recent-news">
                                                <div class="action-box">
                                                    <a href="blog?id=${post.id}"><img src="${post.thumbnail}" alt=""></a>
                                                </div>
                                                <div class="info-bx">
                                                    <ul class="media-post">
                                                        <li><a><i class="fa fa-calendar"></i>${post.createdDateOnly}</a></li>
                                                        <li><a><i class="fa fa-clock-o" aria-hidden="true"></i>${post.createdTimeOnly}</a></li>
                                                        <li><a><i class="fa fa-user"></i>By ${post.username}</a></li>
                                                    </ul>
                                                    <h5 class="post-title">
                                                        <a href="blog?id=${post.id}">${post.title}</a>
                                                    </h5>
                                                    <p>${post.briefInfo}</p>
                                                    <div class="post-extra">
                                                        <a href="blog?id=${post.id}">READ MORE</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <!-- Content END-->
                <!-- Footer ==== -->
                <jsp:include page="footer.jsp"/>
                <!-- Footer END ==== -->
                <button class="back-to-top fa fa-chevron-up"></button>
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
            <!-- Revolution JavaScripts Files -->
            <script src="assets/vendors/revolution/js/jquery.themepunch.tools.min.js"></script>
            <script src="assets/vendors/revolution/js/jquery.themepunch.revolution.min.js"></script>
            <!-- Slider revolution 5.0 Extensions  (Load Extensions only on Local File Systems !  The following part can be removed on Server for On Demand Loading) -->
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.actions.min.js"></script>
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.carousel.min.js"></script>
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.kenburn.min.js"></script>
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.migration.min.js"></script>
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.parallax.min.js"></script>
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
            <script src="assets/vendors/revolution/js/extensions/revolution.extension.video.min.js"></script>
            <script>
                                            jQuery(document).ready(function () {
                                                var ttrevapi;
                                                var tpj = jQuery;
                                                if (tpj("#rev_slider_486_1").revolution == undefined) {
                                                    revslider_showDoubleJqueryError("#rev_slider_486_1");
                                                } else {
                                                    ttrevapi = tpj("#rev_slider_486_1")
                                                            .show()
                                                            .revolution({
                                                                sliderType: "standard",
                                                                jsFileLocation: "assets/vendors/revolution/js/",
                                                                sliderLayout: "fullwidth",
                                                                dottedOverlay: "none",
                                                                delay: 9000,
                                                                navigation: {
                                                                    keyboardNavigation: "on",
                                                                    keyboard_direction: "horizontal",
                                                                    mouseScrollNavigation: "off",
                                                                    mouseScrollReverse: "default",
                                                                    onHoverStop: "on",
                                                                    touch: {
                                                                        touchenabled: "on",
                                                                        swipe_threshold: 75,
                                                                        swipe_min_touches: 1,
                                                                        swipe_direction: "horizontal",
                                                                        drag_block_vertical: false,
                                                                    },
                                                                    arrows: {
                                                                        style: "uranus",
                                                                        enable: true,
                                                                        hide_onmobile: false,
                                                                        hide_onleave: false,
                                                                        tmp: "",
                                                                        left: {
                                                                            h_align: "left",
                                                                            v_align: "center",
                                                                            h_offset: 10,
                                                                            v_offset: 0,
                                                                        },
                                                                        right: {
                                                                            h_align: "right",
                                                                            v_align: "center",
                                                                            h_offset: 10,
                                                                            v_offset: 0,
                                                                        },
                                                                    },
                                                                },
                                                                viewPort: {
                                                                    enable: true,
                                                                    outof: "pause",
                                                                    visible_area: "80%",
                                                                    presize: false,
                                                                },
                                                                responsiveLevels: [1240, 1024, 778, 480],
                                                                visibilityLevels: [1240, 1024, 778, 480],
                                                                gridwidth: [1240, 1024, 778, 480],
                                                                gridheight: [768, 600, 600, 600],
                                                                lazyType: "none",
                                                                parallax: {
                                                                    type: "scroll",
                                                                    origo: "enterpoint",
                                                                    speed: 400,
                                                                    levels: [
                                                                        5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 46, 47, 48, 49, 50, 55,
                                                                    ],
                                                                    type: "scroll",
                                                                },
                                                                shadow: 0,
                                                                spinner: "off",
                                                                stopLoop: "off",
                                                                stopAfterLoops: -1,
                                                                stopAtSlide: -1,
                                                                shuffle: "off",
                                                                autoHeight: "off",
                                                                hideThumbsOnMobile: "off",
                                                                hideSliderAtLimit: 0,
                                                                hideCaptionAtLimit: 0,
                                                                hideAllCaptionAtLilmit: 0,
                                                                debugMode: false,
                                                                fallbacks: {
                                                                    simplifyAll: "off",
                                                                    nextSlideOnWindowFocus: "off",
                                                                    disableFocusListener: false,
                                                                },
                                                            });
                                                }
                                            });
            </script>
    </body>
</html>

