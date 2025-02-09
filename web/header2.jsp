<%-- 
    Document   : header2
    Created on : Feb 8, 2025, 9:35:41 AM
    Author     : Nvtai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <header class="header rs-nav">
            <div class="top-bar">
                <div class="container">
                    <div class="row d-flex justify-content-between">
                        <div class="topbar-left"></div>
                        <div class="topbar-right">
                            <ul>
                                <li><a href="login.html">Login</a></li>
                                <li><a href="register.html">Register</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sticky-header navbar-expand-lg">
                <div class="menu-bar clearfix">
                    <div class="container clearfix">
                        <!-- Header Logo ==== -->
                        <div class="menu-logo">
                            <a href="/app"><img src="assets/images/logochildren.jpg" alt ></a>
                        </div>
                        <!-- Mobile Nav Button ==== -->

                        <!-- Author Nav ==== -->
                        <div class="secondary-menu">
                            <div class="secondary-inner">
                            </div>
                        </div>
                        <!-- Search Box ==== -->
                        <div class="nav-search-bar">
                            <form action="#">
                                <input
                                    name="search"
                                    value=""
                                    type="text"
                                    class="form-control"
                                    placeholder="Type to search"
                                    />
                                <span><i class="ti-search"></i></span>
                            </form>
                            <span id="search-remove"><i class="ti-close"></i></span>
                        </div>
                        <!-- Navigation Menu ==== -->
                        <div
                            class="menu-links navbar-collapse collapse justify-content-start"
                            id="menuDropdown"
                            >
                            <div class="menu-logo">
                                <a href="index.html"
                                   ><img src="assets/images/logo.png" alt=""
                                      /></a>
                            </div>
                            <ul class="nav navbar-nav">
                                <li><a href="/app">Home</a></li>

                                <li><a href="services">Services</a></li>

                                <li><a href="BlogListController">Blogs</a></li>

                                <li><a href="javascript:;">Contact us</a></li>
                            </ul>
                        </div>
                        <!-- Navigation Menu END ==== -->
                    </div>
                </div>
            </div>
        </header>
    </body>
</html>
