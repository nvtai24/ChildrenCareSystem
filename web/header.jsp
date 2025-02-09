<%-- 
    Document   : header.jsp
    Created on : Feb 6, 2025, 10:20:40 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="sticky-header navbar-expand-lg">
                    <div class="menu-bar clearfix">
                        <div class="container clearfix">
                            <!-- Header Logo ==== -->
                            <div class="menu-logo">
                                <a href="/app"><img src="assets/images/logochildren.jpg" alt ></a>
                            </div>
                            <!-- Mobile Nav Button ==== -->

                            <!-- Author Nav ==== -->

                            <!-- Search Box ==== -->

                            <!-- Navigation Menu ==== -->
                            <div class="menu-links navbar-collapse collapse justify-content-start" id="menuDropdown">

                                <ul class="nav navbar-nav">
                                    <li><a href="/app">Home</a>
                                      
                                    </li>
                                    <li><a href="javascript:;">Services</a>
                                        
                                    </li>
                                     <li><a href="blog">Blogs</a>

                            </li>
                                    <li><a href="javascript:;">Contact us <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="blog-classic-grid.html">Blog Classic</a></li>
                                            <li><a href="blog-classic-sidebar.html">Blog Classic Sidebar</a></li>
                                            <li><a href="blog-list-sidebar.html">Blog List Sidebar</a></li>
                                            <li><a href="blog-standard-sidebar.html">Blog Standard Sidebar</a></li>
                                            <li><a href="blog-details.html">Blog Details</a></li>
                                        </ul>
                                    </li>
                                    

                                </ul>

                            </div>
                            <!-- Navigation Menu END ==== -->
                        </div>
                    </div>
                </div>
    </body>
</html>
