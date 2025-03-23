<%-- Document : header.jsp Created on : Feb 6, 2025, 10:20:40 PM Author : ADMIN
--%> <%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
                                                                      uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>JSP Page</title>
    </head>
    <body>
        <header class="header rs-nav">
            <jsp:include page="top-bar.jsp" />

            <!-- Navigation Menu ==== -->
            <div class="sticky-header navbar-expand-lg">
                <div class="menu-bar clearfix">
                    <div class="container clearfix">
                        <!-- Header Logo ==== -->
                        <div class="menu-logo">
                            <a href="/app"
                               ><img src="assets/images/logo.png"
                                  /></a>
                        </div>

                        <div
                            class="menu-links navbar-collapse collapse justify-content-between"
                            >
                            <ul class="nav navbar-nav">
                                <li><a href="/app">Home</a></li>
                                <li><a href="services">Services</a></li>
                                <li><a href="blogs">Blogs</a></li>
                                <li>
                                    <a href="javascript:;"
                                       >Contact us <i class="fa fa-chevron-down"></i
                                        ></a>
                                    <ul class="sub-menu">
                                        <li><a href="blog-classic-grid.html">Blog Classic</a></li>
                                        <li>
                                            <a href="blog-classic-sidebar.html"
                                               >Blog Classic Sidebar</a
                                            >
                                        </li>
                                        <li>
                                            <a href="blog-list-sidebar.html">Blog List Sidebar</a>
                                        </li>
                                        <li>
                                            <a href="blog-standard-sidebar.html"
                                               >Blog Standard Sidebar</a
                                            >
                                        </li>
                                        <li><a href="blog-details.html">Blog Details</a></li>
                                    </ul>
                                </li>


                                <c:if test="${sessionScope.account != null && sessionScope.account.role.id !=15}">
                                    <li><a href="dashboard">Dashboard</a></li>
                                    </c:if>
                            </ul>


                            <ul class="navbar-nav" style="display: flex; align-items: center; gap: 10px; margin: 0; padding: 0; list-style: none; flex-direction: row-reverse;">
                                <c:if test="${sessionScope.account != null}" >
                                    <li class="nav-item dropdown">
                                        <a class="nav-link d-flex align-items-center" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="display: flex; align-items: center;">
                                            <img id="userAvatar" src="${sessionScope.account.profile.avatar != null ? sessionScope.account.profile.avatar : "assets/images/profile/default.jpg"}" alt="User Avatar" class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover;">
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow" style="min-width: auto" aria-labelledby="userAvatar">
                                            <a class="dropdown-item" href="#" data-toggle="modal"
                                               data-target="#profileModal"
                                               >Edit Profile</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item text-danger" href="logout">Logout</a>
                                        </div>
                                    </li>

                                    <c:if test="${sessionScope.account != null && sessionScope.account.role.id == 15  || sessionScope.account.role.id == 16}">
                                        <li class="nav-item">
                                            <a class="nav-link" href="reservation/detail" style="color: black;">
                                                <i class="fa fa-calendar-plus-o" aria-hidden="true" style="font-size: 20px" title="My Reservation"></i>
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a class="nav-link" href="history" style="color: black;">
                                                <i class="fa fa-history" aria-hidden="true" style="font-size: 20px" title="History"></i>
                                            </a>
                                        </li>
                                    </c:if>

                                </c:if>

                                <c:if test="${sessionScope.account == null}">

                                    <!-- Nếu chưa đăng nhập, chỉ hiển thị Login & Register -->
                                    <li class="nav-item"><a class="nav-link" href="login" style="text-decoration: none; color: black;">Login</a></li>
                                    <li class="nav-item"><a class="nav-link" href="register" style="text-decoration: none; color: black;">Register</a></li>
                                    </c:if>   
                            </ul>

                        </div>
                        <!-- Navigation Menu END ==== -->
                    </div>
                </div>
            </div>
            <!-- Navigation Menu END ==== -->

            <jsp:include page="profile.jsp" />
        </header>


    </body>
</html>