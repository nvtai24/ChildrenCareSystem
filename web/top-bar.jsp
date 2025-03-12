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
        <div class="top-bar">
            <div class="container">
                <div class="row d-flex align-items-center justify-content-between" style="display: flex; flex-wrap: nowrap; align-items: center; width: 100%;">

                    <div class="topbar-left">
                        <ul>
                            <li>
                                <a href="faq-1.html"
                                   ><i class="fa fa-question-circle"></i>Ask a Question</a
                                >
                            </li>
                            <li>
                                <a href="javascript:;"
                                   ><i class="fa fa-envelope-o"></i>Support@website.com</a
                                >
                            </li>
                            <li class="search-btn">
                                <button id="quik-search-btn" type="button" class="btn-link">Search<i class="fa fa-search"></i></button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <div class="nav-search-bar">
            <form id="searchForm" method="get" action="/app" class="form-search">
                <input name="search" value="${param.search}" type="text" class="form-control" placeholder="Type anything...">
                <span id="search-icon"><i class="ti-search"></i></span>
            </form>
            <span id="search-remove"><i class="ti-close"></i></span>
        </div>
        <script>document.getElementById("search-icon").addEventListener("click", function () {
                document.getElementById("searchForm").submit();
            });</script>
    </body>
</html>
