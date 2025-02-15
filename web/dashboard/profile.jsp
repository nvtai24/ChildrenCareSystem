<%-- 
    Document   : profile
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
        <jsp:include page="header.jsp"/>
        <!-- header end -->

        <!-- Left sidebar menu start -->
        <jsp:include page="left-sidebar.jsp"/>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="row">
                <!-- Profile Sidebar -->
                <div class="col-md-4">
                    <div class="card p-3">
                        <div class="text-center">
                            <img
                                src="https://bootdey.com/img/Content/avatar/avatar7.png"
                                class="rounded-circle"
                                width="100"
                                />
                            <h4 class="mt-2">John Doe</h4>
                            <p>Full Stack Developer</p>
                            <p>Bay Area, San Francisco, CA</p>
                            <button class="btn btn-primary btn-sm">Follow</button>
                            <button class="btn btn-outline-primary btn-sm">Message</button>
                        </div>
                        <hr />
                        <ul class="list-unstyled">
                            <li>
                                <strong>Website:</strong> <a href="#">https://bootdey.com</a>
                            </li>
                            <li><strong>Github:</strong> bootdey</li>
                            <li><strong>Twitter:</strong> @bootdey</li>
                            <li><strong>Instagram:</strong> bootdey</li>
                            <li><strong>Facebook:</strong> bootdey</li>
                        </ul>

                        <div class="social-list">
                            <div class="mb-2">
                                <i class="fas fa-globe mr-2"></i>https://bootdey.com
                            </div>
                            <div class="mb-2"><i class="fab fa-github mr-2"></i>bootdey</div>
                            <div class="mb-2">
                                <i class="fab fa-twitter mr-2"></i>@bootdey
                            </div>
                            <div class="mb-2">
                                <i class="fab fa-instagram mr-2"></i>bootdey
                            </div>
                            <div class="mb-2">
                                <i class="fab fa-facebook mr-2"></i>bootdey
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Profile Details -->
                <div class="col-md-8">
                    <div class="card p-3">
                        <h5>Profile Details</h5>
                        <form>
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" class="form-control" value="John Doe" />
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input
                                    type="email"
                                    class="form-control"
                                    value="john@example.com"
                                    />
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    value="(239) 816-9029"
                                    />
                            </div>
                            <div class="form-group">
                                <label>Mobile</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    value="(320) 380-4539"
                                    />
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    value="Bay Area, San Francisco, CA"
                                    />
                            </div>
                            <button class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>

                    <!-- Project Status -->
                    <div class="card mt-3 p-3">
                        <h5>Project Status</h5>
                        <div class="mb-2">Web Design</div>
                        <div class="progress mb-3">
                            <div class="progress-bar bg-primary" style="width: 70%"></div>
                        </div>
                        <div class="mb-2">Website Markup</div>
                        <div class="progress mb-3">
                            <div class="progress-bar bg-danger" style="width: 50%"></div>
                        </div>
                        <div class="mb-2">One Page</div>
                        <div class="progress mb-3">
                            <div class="progress-bar bg-success" style="width: 80%"></div>
                        </div>
                        <div class="mb-2">Mobile Template</div>
                        <div class="progress mb-3">
                            <div class="progress-bar bg-warning" style="width: 40%"></div>
                        </div>
                        <div class="mb-2">Backend API</div>
                        <div class="progress mb-3">
                            <div class="progress-bar bg-info" style="width: 60%"></div>
                        </div>
                    </div>
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
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
