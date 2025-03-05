<%-- 
    Document   : header
    Created on : Feb 15, 2025, 12:50:37 AM
    Author     : Nvtai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<header class="ttr-header">
    <div class="ttr-header-wrapper">
        <div class="ttr-toggle-sidebar ttr-material-button">
            <i class="ti-close ttr-open-icon"></i>
            <i class="ti-menu ttr-close-icon"></i>
        </div>
        <!--sidebar menu toggler end -->
        <!--logo start -->
        <div class="ttr-logo-box">
            <div>
                <a href="/app" class="ttr-logo">
                    <img alt="" class="ttr-logo-mobile" src="${pageContext.request.contextPath}/assets/images/logo.png" width="30" height="30">
                    <img alt="" class="ttr-logo-desktop" src="${pageContext.request.contextPath}/assets/images/logo.png" width="100" height="27">
                </a>
            </div>
        </div>
        <!--logo end -->
        <div class="ttr-header-menu">
            <!-- header left menu start -->
            <ul class="ttr-header-navigation">
                <li>
                    <a href="/app" class="ttr-material-button ttr-submenu-toggle">HOME</a>
                </li>
            </ul>
            <!-- header left menu end -->
        </div>
        <div class="ttr-header-right ttr-with-seperator">
            <!-- header right menu start -->
            <ul class="ttr-header-navigation">
                <li>
                    <a href="#" class="ttr-material-button ttr-search-toggle"><i class="fa fa-search"></i></a>
                </li>
                <li>
                    <a href="#" class="ttr-material-button ttr-submenu-toggle"><i class="fa fa-bell"></i></a>
                    <div class="ttr-header-submenu noti-menu">
                        <div class="ttr-notify-header">
                            <span class="ttr-notify-text-top">9 New</span>
                            <span class="ttr-notify-text">User Notifications</span>
                        </div>
                        <div class="noti-box-list">
                            <ul>
                                <li>
                                    <span class="notification-icon dashbg-gray">
                                        <i class="fa fa-check"></i>
                                    </span>
                                    <span class="notification-text">
                                        <span>Sneha Jogi</span> sent you a message.
                                    </span>
                                    <span class="notification-time">
                                        <a href="#" class="fa fa-close"></a>
                                        <span> 02:14</span>
                                    </span>
                                </li>
                                <li>
                                    <span class="notification-icon dashbg-yellow">
                                        <i class="fa fa-shopping-cart"></i>
                                    </span>
                                    <span class="notification-text">
                                        <a href="#">Your order is placed</a> sent you a message.
                                    </span>
                                    <span class="notification-time">
                                        <a href="#" class="fa fa-close"></a>
                                        <span> 7 Min</span>
                                    </span>
                                </li>
                                <li>
                                    <span class="notification-icon dashbg-red">
                                        <i class="fa fa-bullhorn"></i>
                                    </span>
                                    <span class="notification-text">
                                        <span>Your item is shipped</span> sent you a message.
                                    </span>
                                    <span class="notification-time">
                                        <a href="#" class="fa fa-close"></a>
                                        <span> 2 May</span>
                                    </span>
                                </li>
                                <li>
                                    <span class="notification-icon dashbg-green">
                                        <i class="fa fa-comments-o"></i>
                                    </span>
                                    <span class="notification-text">
                                        <a href="#">Sneha Jogi</a> sent you a message.
                                    </span>
                                    <span class="notification-time">
                                        <a href="#" class="fa fa-close"></a>
                                        <span> 14 July</span>
                                    </span>
                                </li>
                                <li>
                                    <span class="notification-icon dashbg-primary">
                                        <i class="fa fa-file-word-o"></i>
                                    </span>
                                    <span class="notification-text">
                                        <span>Sneha Jogi</span> sent you a message.
                                    </span>
                                    <span class="notification-time">
                                        <a href="#" class="fa fa-close"></a>
                                        <span> 15 Min</span>
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                
                <li>
                    <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="${pageContext.request.contextPath}/${sessionScope.account.profile.avatar != null ? sessionScope.account.profile.avatar : "assets/images/profile/default.jpg"}" width="32" height="32"></span></a>
                    <div class="ttr-header-submenu">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/profile">My Profile</a></li>
                            <li><a href="logout" style="color: red">Log Out</a></li>
                        </ul>
                    </div>
                </li>

                <li class="ttr-hide-on-mobile">
                    <a href="#" class="ttr-material-button"><i class="ti-layout-grid3-alt"></i></a>
                    <div class="ttr-header-submenu ttr-extra-menu">
                        <a href="#">
                            <i class="fa fa-music"></i>
                            <span>Musics</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-youtube-play"></i>
                            <span>Videos</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-envelope"></i>
                            <span>Emails</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-book"></i>
                            <span>Reports</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-smile-o"></i>
                            <span>Persons</span>
                        </a>
                        <a href="#">
                            <i class="fa fa-picture-o"></i>
                            <span>Pictures</span>
                        </a>
                    </div>
                </li>
            </ul>
            <!-- header right menu end -->
        </div>
        <!--header search panel start -->
        <div class="ttr-search-bar">
            <form class="ttr-search-form">
                <div class="ttr-search-input-wrapper">
                    <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                    <button type="submit" name="search" class="ttr-search-submit"><i class="ti-arrow-right"></i></button>
                </div>
                <span class="ttr-search-close ttr-search-toggle">
                    <i class="ti-close"></i>
                </span>
            </form>
        </div>
        <!--header search panel end -->
    </div>
</header>

