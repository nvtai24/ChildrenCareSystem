<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="${pageContext.request.contextPath}/assets/images/logo.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Children Care</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/assets.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/style.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/color/color-1.css">
        <!-- DATA TABLES ============================================= -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

        <style>
            div.dataTables_wrapper div.dataTables_paginate {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                padding: 15px 0;
                font-size: 14px;
            }

            .dt-paging {
                text-align: center;
                margin-top: 0;
                padding-top: 10px;
            }

            .paginate_button {
                padding: 5px 10px;
                margin: 0 5px;
            }

            .feedback-container {
                margin-bottom: 20px;
            }

            /* Hide elements when using DataTable to avoid display conflicts */
            .dataTables_length, .dataTables_filter {
                display: none;
            }

            .toolbar {
                margin-bottom: 20px;
            }

            .badge-success {
                background-color: #36b37e;
            }

            .badge-danger {
                background-color: #ff5630;
            }

            .badge {
                padding: 5px 10px;
                border-radius: 4px;
                color: white;
                font-weight: 500;
            }
        </style>
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
                    <h4 class="breadcrumb-title">Feedback</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="/app"><i class="fa fa-home"></i>Home</a></li>
                        <li>Feedback</li>
                    </ul>
                </div>

                <!-- Add filter section -->
                <div class="toolbar">
                    <div class="form-row align-items-center">
                        <form action="feedbacks" method="POST">
                            <input type="hidden" name="action" value="rating"/>
                            <div class="col-auto">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Rating</div>
                                    </div>
                                    <select name="rating" onchange="this.form.submit()">
                                        <option value="-1" ${sessionScope.sessionRating == -1 ? 'selected' : ''}>All</option>
                                        <option value="1" ${sessionScope.sessionRating == 1 ? 'selected' : ''}>1 Star</option>
                                        <option value="2" ${sessionScope.sessionRating == 2 ? 'selected' : ''}>2 Stars</option>
                                        <option value="3" ${sessionScope.sessionRating == 3 ? 'selected' : ''}>3 Stars</option>
                                        <option value="4" ${sessionScope.sessionRating == 4 ? 'selected' : ''}>4 Stars</option>
                                        <option value="5" ${sessionScope.sessionRating == 5 ? 'selected' : ''}>5 Stars</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                        <form action="feedbacks" method="POST">
                            <input type="hidden" name="action" value="service"/>
                            <div class="col-auto">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Service</div>
                                    </div>
                                    <select name="service" onchange="this.form.submit()">
                                        <option value="-1" ${sessionScope.sessionServiceId == -1 ? 'selected' : ''}>All</option>
                                        <c:forEach items="${requestScope.serviceList}" var="s">
                                            <option value="${s.id}" ${sessionScope.sessionServiceId == s.id ? 'selected' : ''}>${s.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </form>
                        <form action="feedbacks" method="POST">
                            <input type="hidden" name="action" value="status"/>
                            <div class="col-auto">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">Status</div>
                                    </div>
                                    <select name="status" onchange="this.form.submit()">
                                        <option value="-1" ${sessionScope.sessionStatus == -1 ? 'selected' : ''}>All</option>
                                        <option value="1" ${sessionScope.sessionStatus == 1 ? 'selected' : ''}>Active</option>
                                        <option value="0" ${sessionScope.sessionStatus == 0 ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                        <form action="feedbacks" method="POST" class="d-flex align-items-center">
                            <input type="hidden" name="action" value="search"/>
                            <div class="input-group">
                                <input type="text" class="form-control mb-2" id="inlineFormInput" placeholder="Search feedback..." value="${requestScope.searchQuery}" name="search">
                                <button type="submit" class="btn btn-primary mb-2">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Feedback</h4>
                            </div>
                            <div class="widget-inner">
                                <table id="feedbackTable" class="display" style="width:100%">
                                    <thead style="display: none;">
                                        <tr>
                                            <th>Feedback</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${feedbackList}" var="feedback">
                                            <tr>
                                                <td>
                                                    <div class="feedback-container">
                                                        <div class="card-courses-list admin-review">
                                                            <div class="card-courses-full-dec">
                                                                <div class="card-courses-title">
                                                                    <h4>${feedback.reservationDetail.service.name}</h4>
                                                                </div>
                                                                <div class="card-courses-list-bx">
                                                                    <ul class="card-courses-view">
                                                                        <li class="card-courses-user">
                                                                            <div class="card-courses-user-pic">
                                                                                <img src="${feedback.avatar}" alt="" style="object-fit: cover" width="150px" height="150px"/>
                                                                            </div>
                                                                            <div class="card-courses-user-info">
                                                                                <h5>Reviewer</h5>
                                                                                <h4>${feedback.reservationDetail.reservation.fullName}</h4>
                                                                            </div>
                                                                        </li>
                                                                        <li class="card-courses-review">
                                                                            <h5>${feedback.rating} Star Review</h5>
                                                                            <ul class="cours-star">
                                                                                <c:forEach begin="1" end="5" var="i">
                                                                                    <c:if test="${i <= feedback.rating}">
                                                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                                                        </c:if>
                                                                                        <c:if test="${i > feedback.rating}">
                                                                                        <li><i class="fa fa-star"></i></li>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                            </ul>
                                                                        </li>
                                                                        <li class="card-courses-categories">
                                                                            <h5>Date</h5>
                                                                            <h4>${feedback.createdDate}</h4>
                                                                        </li>
                                                                        <li class="card-courses-categories">
                                                                            <h5>Status</h5>
                                                                            <span class="badge ${feedback.status ? 'badge-success' : 'badge-danger'}">
                                                                                ${feedback.status ? 'Active' : 'Inactive'}
                                                                            </span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="row card-courses-dec">
                                                                    <div class="col-md-12">
                                                                        <h6 class="m-b10">Feedback</h6>
                                                                        <p>${feedback.comment}</p>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="d-flex">
                                                                            <!--<a href="#" class="btn" data-toggle="modal" data-target="#replyModal${feedback.id}">Reply Review</a>-->
                                                                            <form action="feedbacks" method="POST" onsubmit="confirmChangeStatus(event)" class="ml-2">
                                                                                <input type="hidden" name="id" value="${feedback.id}">
                                                                                <input type="hidden" name="status" value="${feedback.status}">
                                                                                <input type="hidden" name="action" value="change">
                                                                                <button type="submit" class="btn ${feedback.status ? 'red' : 'green'}">
                                                                                    <i class="fa fa-refresh" aria-hidden="true"></i> ${feedback.status ? 'Deactivate' : 'Activate'}
                                                                                </button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Modals for all feedbacks -->
                                <c:forEach items="${feedbackList}" var="feedback">
                                    <div class="modal fade review-bx-reply" id="replyModal${feedback.id}" tabindex="-1" role="dialog" aria-labelledby="replyModalLabel${feedback.id}" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="replyModalLabel${feedback.id}">Reply to ${feedback.reservationDetail.reservation.fullName}'s review</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <textarea class="form-control" placeholder="Type your reply"></textarea>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn mr-auto">Reply</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="${pageContext.request.contextPath}/assets2/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/counter/waypoints-min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/counter/counterup.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/masonry/masonry.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/masonry/filter.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='${pageContext.request.contextPath}/assets2/vendors/scroll/scrollbar.min.js'></script>
        <script src="${pageContext.request.contextPath}/assets2/js/functions.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/chart/chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/js/admin.js"></script>
        <script src='${pageContext.request.contextPath}/assets2/vendors/switcher/switcher.js'></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                                                                function confirmChangeStatus(event) {
                                                                                    event.preventDefault();

                                                                                    Swal.fire({
                                                                                        title: "Are you sure?",
                                                                                        text: "Do you really want to change the status of this feedback?",
                                                                                        icon: "warning",
                                                                                        showCancelButton: true,
                                                                                        confirmButtonColor: "#3085d6",
                                                                                        cancelButtonColor: "#d33",
                                                                                        confirmButtonText: "Yes, change it!",
                                                                                        cancelButtonText: "No, cancel!"
                                                                                    }).then((result) => {
                                                                                        if (result.isConfirmed) {
                                                                                            event.target.submit();
                                                                                        }
                                                                                    });

                                                                                    return false;
                                                                                }

                                                                                $(document).ready(function () {
                                                                                    $('#feedbackTable').DataTable({
                                                                                        "paging": true,
                                                                                        "lengthMenu": [5, 10, 15],
                                                                                        "pageLength": 5,
                                                                                        "searching": false,
                                                                                        "ordering": false,
                                                                                        "info": false,
                                                                                        "autoWidth": false,
                                                                                        "dom": 't<"dt-paging"p>'
                                                                                    });
                                                                                });
        </script>
    </body>
</html>