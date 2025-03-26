<%-- 
    Document   : admin
    Created on : Feb 14, 2025, 11:53:08 PM
    Author     : Nvtai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <style>
        .btn {
            min-width: 80px;
            text-align: center;
            padding: 8px 12px;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Dashboard</title>
        <base href="${pageContext.request.contextPath}/">        

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

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
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Dashboard</h4>
                </div>	
                <!-- Card -->
                <div class="row">
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg1">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Total Revenue
                                </h4>
                                <span class="wc-des">
                                    All Customs Value
                                </span>
                                <span class="wc-stats">
                                    $<span class="counter">${totalRevenue}</span>
                                </span>		
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg2">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Total Feedback
                                </h4>
                                <span class="wc-des">
                                    Customer Review
                                </span>
                                <span class="wc-stats counter">
                                    ${totalFeedback} 
                                </span>		

                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg3">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Total Reservations
                                </h4>
                                <span class="wc-des">
                                    Reservations Amount 
                                </span>
                                <span class="wc-stats counter">
                                    ${totalReservations}
                                </span>		

                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12" >
                        <div class="widget-card widget-bg4">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Total Users
                                </h4>
                                <span class="wc-des">
                                    Joined User
                                </span>
                                <span class="wc-stats counter">
                                    ${totalUsers}
                                </span>		

                            </div>				      
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12" style="max-width: 238px;">
                        <div class="widget-card widget-bg4">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Pending 
                                </h4>
                                <span class="wc-des">
                                    Reservations Amount 
                                </span>
                                <span class="wc-stats counter">
                                    ${totalReservations1}
                                </span>		

                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12" style="max-width: 238px;">
                        <div class="widget-card widget-bg3">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Confirmed 
                                </h4>
                                <span class="wc-des">
                                    Reservations Amount 
                                </span>
                                <span class="wc-stats counter">
                                    ${totalReservations2}
                                </span>		

                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12" style="max-width: 238px;">
                        <div class="widget-card widget-bg2">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Completed 
                                </h4>
                                <span class="wc-des">
                                    Reservations Amount 
                                </span>
                                <span class="wc-stats counter">
                                    ${totalReservations3} 
                                </span>		
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12" style="max-width: 238px;">
                        <div class="widget-card widget-bg1">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Cancelled 
                                </h4>
                                <span class="wc-des">
                                    Reservations Amount 
                                </span>
                                <span class="wc-stats counter">
                                    ${totalReservations4} 
                                </span>		
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12" style="max-width: 238px;">
                        <div class="widget-card widget-bg1">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Refunding 
                                </h4>
                                <span class="wc-des">
                                    Reservations Amount 
                                </span>
                                <span class="wc-stats counter">
                                    ${totalReservations5} 
                                </span>		
                            </div>				      
                        </div>
                    </div>
                </div>
                <!-- Card END -->
                <div class="row">
                    <!-- Your Profile Views Chart -->

                    <!-- Your Profile Views Chart END-->

                    <div class="col-lg-6 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>New Users</h4>
                            </div>
                            <c:choose>
                                <c:when test="${not empty latestUsers}">
                                    <c:forEach var="user" items="${latestUsers}">
                                        <div class="widget-inner">
                                            <div class="new-user-list">
                                                <ul>
                                                    <li>
                                                        <span class="new-users-pic">
                                                            <img src="${user.avatar}" alt=""/>
                                                        </span>
                                                        <span class="new-users-text">
                                                            <a class="new-users-name">${user.lastname} ${user.firstname} </a>
                                                            <span class="new-users-info">Username: ${user.username} </span>
                                                        </span>
                                                        <span class="new-users-btn">
                                                            <a class="new-users-name">Email: ${user.email}</a>
                                                        </span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="widget-inner">
                                        <p style="text-align: center; color: red;">No new users in the last 7 days.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-lg-6 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Reservations</h4>
                            </div>
                            <c:choose>
                                <c:when test="${not empty reservations}">
                                    <c:forEach var="reservation" items="${reservations}">
                                        <div class="widget-inner">
                                            <div class="orders-list">
                                                <ul>
                                                    <li>
                                                        <span class="orders-title">
                                                            <a class="orders-title-name">${reservation.lastName} ${reservation.firstName}</a>
                                                            <span class="orders-info">
                                                                Reservation #${reservation.id} | Date Time: ${reservation.reverseDate}
                                                            </span>
                                                        </span>

                                                        <c:choose>
                                                            <c:when test='${reservation.statusId == 1}'> 
                                                                <c:set var="statusClass" value="blue"/> 
                                                                <c:set var="statusText" value="Pending"/>
                                                            </c:when>
                                                            <c:when test='${reservation.statusId == 2}'> 
                                                                <c:set var="statusClass" value="yellow"/> 
                                                                <c:set var="statusText" value="Confirm"/>
                                                            </c:when>
                                                            <c:when test='${reservation.statusId == 3}'> 
                                                                <c:set var="statusClass" value="green"/> 
                                                                <c:set var="statusText" value="Completed"/>
                                                            </c:when>
                                                            <c:when test='${reservation.statusId == 4}'> 
                                                                <c:set var="statusClass" value="red"/> 
                                                                <c:set var="statusText" value="Cancelled"/>
                                                            </c:when>
                                                            <c:when test='${reservation.statusId == 5}'> 
                                                                <c:set var="statusClass" value="purple"/> 
                                                                <c:set var="statusText" value="Refunding"/>
                                                            </c:when>                                                           
                                                            <c:otherwise>
                                                                <c:set var="statusClass" value="gray"/> 
                                                                <c:set var="statusText" value="Unknown"/>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <span class="orders-btn">
                                                            <a class="btn button-sm ${statusClass}">${statusText}</a>
                                                        </span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="widget-inner">
                                        <p style="text-align: center; color: red;">No new reservations in the last 7 days.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
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
        <script src='assets2/vendors/calendar/moment.min.js'></script>
        <script src='assets2/vendors/calendar/fullcalendar.js'></script>
        <script>
            $(document).ready(function () {

                $('#calendar').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay,listWeek'
                    },
                    defaultDate: '2019-03-12',
                    navLinks: true, // can click day/week names to navigate views

                    weekNumbers: true,
                    weekNumbersWithinDays: true,
                    weekNumberCalculation: "ISO",

                    editable: true,
                    eventLimit: true, // allow "more" link when too many events
                    events: [
                        {
                            title: "All Day Event",
                            start: "2019-03-01",
                        },
                        {
                            title: "Long Event",
                            start: "2019-03-07",
                            end: "2019-03-10",
                        },
                        {
                            id: 999,
                            title: "Repeating Event",
                            start: "2019-03-09T16:00:00",
                        },
                        {
                            id: 999,
                            title: "Repeating Event",
                            start: "2019-03-16T16:00:00",
                        },
                        {
                            title: "Conference",
                            start: "2019-03-11",
                            end: "2019-03-13",
                        },
                        {
                            title: "Meeting",
                            start: "2019-03-12T10:30:00",
                            end: "2019-03-12T12:30:00",
                        },
                        {
                            title: "Lunch",
                            start: "2019-03-12T12:00:00",
                        },
                        {
                            title: "Meeting",
                            start: "2019-03-12T14:30:00",
                        },
                        {
                            title: "Happy Hour",
                            start: "2019-03-12T17:30:00",
                        },
                        {
                            title: "Dinner",
                            start: "2019-03-12T20:00:00",
                        },
                        {
                            title: "Birthday Party",
                            start: "2019-03-13T07:00:00",
                        },
                        {
                            title: "Click for Google",
                            url: "http://google.com/",
                            start: "2019-03-28",
                        },
                    ],
                });
            });
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
</html>
