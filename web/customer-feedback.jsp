<%-- 
    Document   : customer-feedback
    Created on : Mar 23, 2025, 7:16:04 PM
    Author     : ADMIN
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
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                text-align: center;
                padding: 20px;
            }

            form {
                background: white;
                max-width: 500px;
                margin: auto;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .rating {
                display: flex;
                justify-content: center;
                flex-direction: row-reverse;
                margin-top: 10px;
            }

            .rating input {
                display: none;
            }

            .rating label {
                font-size: 35px;
                color: lightgray;
                cursor: pointer;
                transition: color 0.3s;
            }

            .rating input:checked ~ label,
            .rating label:hover,
            .rating label:hover ~ label {
                color: purple;
            }

            textarea {
                width: 90%;
                padding: 10px;
                margin-top: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                resize: none;
            }

            button {
                background-color: #EFBB20;
                color: black;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s;
            }

            button:hover {
                background-color: #0056b3;
            }
            h2 {
                justify-content: center;
                font-size: 35px;
                font-weight: bold;
                color: #333;
                text-align: center;
                background: linear-gradient(to right, #007BFF, #00C6FF);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                padding: 10px 0;
                margin-bottom: 15px;
            }

            h3{
                font-size: 20px;
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
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner3.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Feedback</h1>
                        </div>
                    </div>
                </div>

                <div class="section-area section-sp2 popular-courses-bx">
                    <h2>Thank you very much for using our service!</h2>
                    <div class="container">

                        <form action="customer-feedback" method="post">

                            <input type="hidden" id="rDetailId" name="rDetailId" value="${rDetailId}"><br><br>   
                            <h3>Rating :</h3>
                            <div class="rating">
                                <input type="radio" id="star5" name="rate" value="5" required="">
                                <label for="star5">★</label>

                                <input type="radio" id="star4" name="rate" value="4" required="">
                                <label for="star4">★</label>

                                <input type="radio" id="star3" name="rate" value="3" required="">
                                <label for="star3">★</label>

                                <input type="radio" id="star2" name="rate" value="2" required="">
                                <label for="star2">★</label>

                                <input type="radio" id="star1" name="rate" value="1" required="">
                                <label for="star1">★</label>
                            </div>
                            <br>
                            <h3>Comment:</h3>
                            <textarea id="comment" name="comment" rows="4" cols="50" required=""></textarea><br><br>
                            <button type="submit">Send Feedback</button>
                        </form>

                    </div>
                </div>
            </div>
            <jsp:include page="footer.jsp"/>

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


