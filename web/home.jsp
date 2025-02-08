<%-- 
    Document   : home
    Created on : Jan 26, 2025, 5:01:02 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logochildren.jpg" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>ChildrenCare </title>

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <link rel="stylesheet" type="text/css" href="assets/css/post.css">

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        <!-- REVOLUTION SLIDER END -->	
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <jsp:include page="header.jsp"/>
            <!-- Header Top END ==== -->

            <!-- Content -->
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
                                        <img src="assets/images/slider/${slider.imageUrl}" alt="" 
                                             data-bgposition="center center" 
                                             data-bgfit="cover" 
                                             data-bgrepeat="no-repeat" 
                                             data-bgparallax="10" 
                                             class="rev-slidebg" 
                                             data-no-retina />

                                        <!-- LAYER NR. 1 -->
                                        <div class="tp-caption tp-shape tp-shapewrapper " 
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
                                             style="z-index: 5;background-color:rgba(2, 0, 11, 0.80);border-color:rgba(0, 0, 0, 0);border-width:0px;"> </div>	
                                        <!-- LAYER NR. 2 -->
                                        <div class="tp-caption Newspaper-Title   tp-resizeme" 
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
                                        </div>

                                        <!-- LAYER NR. 3 -->
                                        <div class="tp-caption Newspaper-Subtitle   tp-resizeme" 
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
                                        </div>

                                        <!-- LAYER NR. 3 -->
                                        <div class="tp-caption Newspaper-Subtitle   tp-resizeme" 
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
                                        </div>
                                        <!-- LAYER NR. 4 -->

                                    </li>
                                </c:forEach>

                            </ul>
                        </div><!-- END REVOLUTION SLIDER -->  
                    </div>  
                </div>  
                <!-- Main Slider -->
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

                                            <h4><a href="#">Professional Service</a></h4>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/ser5.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">

                                            <h4><a href="#">Give Parents Peace Of Mind</a></h4>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12">
                                    <div class="service-bx m-b0">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/ser4.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">

                                            <h4><a href="#">Build Good Habits</a></h4>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Popular Courses -->
                    <div class="section-area section-sp2 popular-courses-bx">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 heading-bx left">
                                    <h2 class="title-head">Blog</h2>

                                </div>
                            </div>
                            <div class="row">
                                <div class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0">

                                    <c:forEach items="${POSTS}" var="post">
                                        <div class="item">
                                            <div class="cours-bx">
                                                <div class="action-box">
                                                    <a href="BlogDetailController?id=${post.id}"><img src="assets/images/courses/${post.thumbnail}" alt=""></a>

                                                </div>
                                                <div class="info-bx text-center">
                                                    <h5><a href="#">${post.title}</a></h5>
                                                    <span>${post.content}</span>
                                                </div>

                                            </div>
                                        </div>
                                    </c:forEach>


                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Popular Courses END -->

                    <!-- Footer ==== -->
                    <jsp:include page="footer.jsp"/>

                    <!-- Footer END ==== -->
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
                            ttrevapi = tpj("#rev_slider_486_1").show().revolution({
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
                                        drag_block_vertical: false
                                    }
                                    ,
                                    arrows: {
                                        style: "uranus",
                                        enable: true,
                                        hide_onmobile: false,
                                        hide_onleave: false,
                                        tmp: '',
                                        left: {
                                            h_align: "left",
                                            v_align: "center",
                                            h_offset: 10,
                                            v_offset: 0
                                        },
                                        right: {
                                            h_align: "right",
                                            v_align: "center",
                                            h_offset: 10,
                                            v_offset: 0
                                        }
                                    },

                                },
                                viewPort: {
                                    enable: true,
                                    outof: "pause",
                                    visible_area: "80%",
                                    presize: false
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
                                    levels: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 46, 47, 48, 49, 50, 55],
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
                                }
                            });
                        }
                    });
                </script>
            </div>
    </body>

</html>

