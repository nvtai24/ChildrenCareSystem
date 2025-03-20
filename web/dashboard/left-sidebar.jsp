<%-- Document : left-sidebar Created on : Feb 15, 2025, 12:50:37 AM Author :
Nvtai --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="ttr-sidebar">
    <div class="ttr-sidebar-wrapper content-scroll">
        <!-- side menu logo end -->
        <!-- sidebar menu start -->
        <nav class="ttr-sidebar-navi">
            
            <ul>
                <li>
                    <a href="/app/dashboard" class="ttr-material-button">
                        <span class="ttr-icon"><i class="fa fa-home"></i></span>
                        <span class="ttr-label">Dashboard</span>
                    </a>
                </li>

                <li>
                    <c:if test="${sessionScope.permissions.contains('/setting')}">
                        <a href="/app/settings" class="ttr-material-button">
                            <span class="ttr-icon"><i class="fa fa-cogs"></i></span>
                            <span class="ttr-label">Setting</span>
                        </a>
                    </c:if>
                </li>

                <li>
                    <c:if test="${sessionScope.permissions.contains('/reservations')}">
                        <a href="/app/reservations" class="ttr-material-button">
                            <span class="ttr-icon"><i class="fa fa-calendar"></i></span>
                            <span class="ttr-label">Reservation</span>
                        </a>
                    </c:if>
                </li>

                <li>
                    <c:if test="${sessionScope.permissions.contains('/services/manager')}">
                        <a href="/app/services/manager" class="ttr-material-button">
                            <span class="ttr-icon"><i class="fa fa-medkit"></i></span>
                            <span class="ttr-label">Service</span>
                        </a>
                    </c:if>
                </li>

                <li>
                    <c:if test="${sessionScope.permissions.contains('/feedbacks')}">
                        <a href="/app/feedbacks" class="ttr-material-button">
                            <span class="ttr-icon"><i class="fa fa-comments"></i></span>
                            <span class="ttr-label">Feedback</span>
                        </a>
                    </c:if>
                </li>

                <li>
                    <c:if test="${sessionScope.permissions.contains('/sliders')}">
                        <a href="/app/sliders" class="ttr-material-button">
                            <span class="ttr-icon"><i class="fa fa-wpforms"></i></span>
                            <span class="ttr-label">Slider</span>
                        </a>
                    </c:if>
                </li>

                <li>
                    <c:if test="${sessionScope.permissions.contains('/posts')}">
                        <a href="/app/posts" class="ttr-material-button">
                            <span class="ttr-icon"><i class="fa fa-tags"></i></span>
                            <span class="ttr-label">Post</span>
                        </a>
                    </c:if>
                </li>

                <li>
                    <c:if test="${sessionScope.permissions.contains('/users')}">
                        <a href="/app/users" class="ttr-material-button">
                            <span class="ttr-icon"
                                  ><i class="fa fa-users" aria-hidden="true"></i
                                ></span>
                            <span class="ttr-label">User</span>
                        </a>
                    </c:if>
                </li>

                <li>
                    <c:if test="${sessionScope.permissions.contains('/customers')}">
                        <a href="/app/customers" class="ttr-material-button">
                            <span class="ttr-icon"><i class="fa fa-address-book"></i></span>
                            <span class="ttr-label">Customer</span>
                        </a>
                    </c:if>
                </li>

<!--                <li>
                    <a href="/app/profile" class="ttr-material-button">
                        <span class="ttr-icon"><i class="fa fa-user"></i></span>
                        <span class="ttr-label">My Profile</span>
                    </a>
                </li>-->

                <li>
                    <c:if test="${sessionScope.permissions.contains('/permissions')}">
                        <a href="/app/permissions" class="ttr-material-button">
                            <span class="ttr-icon"><i class="fa fa-unlock-alt"></i></span>
                            <span class="ttr-label">Permissions</span>
                        </a>
                    </c:if>
                </li>
                <li class="ttr-seperate"></li>
            </ul>
            <!-- sidebar menu end -->
        </nav>
        <!-- sidebar menu end -->
    </div>
</div>
