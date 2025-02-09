<%-- 
    Document   : top-bar
    Created on : Feb 9, 2025, 9:24:29 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="top-bar" style="background: transparent; width: 92%;">
                <div class="container">
                    <div class="row d-flex align-items-center justify-content-between" style="display: flex; flex-wrap: nowrap; align-items: center; width: 100%;">

                        <!-- Phần bên trái -->
                        <div class="topbar-left" style="display: flex; align-items: center; gap: 15px; flex-shrink: 0;">
                            <ul style="display: flex; align-items: center; gap: 15px; margin: 0; padding: 0; list-style: none;">
                                <li>
                                    <a href="faq-1.html" style="text-decoration: none; color: white;">
                                        <i class="fa fa-question-circle"></i> Ask a Question
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" style="text-decoration: none; color: white;">
                                        <i class="fa fa-envelope-o"></i> Support@website.com
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <!-- Phần bên phải -->
                        <!-- Phần bên phải -->
                        <div class="topbar-right" style="display: flex; align-items: center; gap: 10px;">
                            <ul class="navbar-nav" style="display: flex; align-items: center; gap: 10px; margin: 0; padding: 0; list-style: none; flex-direction: row-reverse;">
                                <c:if test="${sessionScope.account != null}" >
                                    <!-- Avatar khi đã đăng nhập (LUÔN BÊN PHẢI) -->
                                    <li class="nav-item dropdown">
                                        <a class="nav-link d-flex align-items-center" href="#" id="userAvatar" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="display: flex; align-items: center;">
                                            <img src="uploads/profile/pr.png" alt="User Avatar" width="32" height="32" class="rounded-circle" style="border-radius: 50%; cursor: pointer; transition: transform 0.2s ease-in-out;">
                                        </a>
                                        <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userAvatar">
                                            <li><a class="dropdown-item" href="profile" style="color: black; text-decoration: none;">Edit Profile</a></li>
                                            <li><a class="dropdown-item" href="logout" style="color: black; text-decoration: none;">Logout</a></li>
                                        </ul>
                                    </li>
                                    <!-- Icon giỏ hàng (LUÔN BÊN TRÁI) -->
                                    <li class="nav-item">
                                        <a class="nav-link" href="reservationDetail" style="color: white;">
                                            <i class="fas fa-shopping-cart" style="font-size: 18px;"></i>
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.account == null}">
                                    <!-- Nếu chưa đăng nhập, chỉ hiển thị Login & Register -->
                                    <li class="nav-item"><a class="nav-link" href="login" style="text-decoration: none; color: white;">Login</a></li>
                                    <li class="nav-item"><a class="nav-link" href="register" style="text-decoration: none; color: white;">Register</a></li>
                                    </c:if>   
                            </ul>
                        </div>
                    </div>
                </div>
            </div>


    </body>
</html>
