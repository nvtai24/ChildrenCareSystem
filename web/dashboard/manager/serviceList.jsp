<%-- 
    Document   : serviceList
    Created on : Jan 23, 2025, 10:17:15 PM
    Author     : Admin
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:10:19 GMT -->
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- PAGE TITLE ============================================= -->
        <title>Children Care</title>

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="${pageContext.request.contextPath}/assets/images/logo.png" type="image/x-icon" />
        <link
            rel="shortcut icon"
            type="image/x-icon"
            href="${pageContext.request.contextPath}/assets/images/logo.png"
            />

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/assets.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets2/css/shortcodes/shortcodes.css">

        <!-- MAIN STYLESHEETS ============================================= -->
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
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <jsp:include page="../../dashboard/header.jsp"/>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <jsp:include page="../../dashboard/left-sidebar.jsp"/>
        <!-- sidebar menu end -->


        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb " style="display: flex;">

                    <a href="../services/manager"><h4 class="breadcrumb-title">Service List</h4></a>                    
                    <a href="../services/add" class="btn " style=" margin-left:  10px; margin-right: 10px"><i class="fa fa-plus-circle"> </i>Add New Service</a>

                </div>	
                <div class="widget-box">
                    <div class="wc-title d-flex align-items-center justify-content-between">


                        <div class="d-flex">
                            <!-- Form 1: Category -->
                            <div class="col-auto">
                                <form method="POST" action="../services/manager">
                                    <div class="input-group mb-2">
                                        <input name="action" value="category" type="hidden"/>
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">Category</div>
                                        </div>
                                        <select name="idCategory" onchange="this.form.submit()" >
                                            <option value="-1" ${ sessionScope.sessionCategoryId == -1 ? 'selected' : ''}>All</option>
                                            <c:forEach items="${listCategory}" var="c">
                                                <option value="${c.id}" ${ sessionScope.sessionCategoryId == c.id ? 'selected' : ''}>${c.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </form> 
                            </div>

                            <!-- Form 2: Status -->
                            <div class="col-auto">
                                <form method="POST" action="../services/manager" class="mr-2">
                                    <div class="input-group mb-2">
                                        <input name="action" value="status" type="hidden"/>
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">Status</div>
                                        </div>
                                        <select name="status" onchange="this.form.submit()" >
                                            <option value="-1" ${ sessionScope.sessionStatus == -1 ? 'selected' : ''}>All</option>
                                            <option value="1" ${ sessionScope.sessionStatus == 1 ? 'selected' : ''}>Active</option>
                                            <option value="0" ${ sessionScope.sessionStatus == 0 ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                </form>
                            </div>

                            <!-- Form 3: Search -->

                            <form " action="../services/manager" method="POST" class="d-flex align-items-center">

                                <input type="hidden" name="action" value="search"/>
                                <div class="input-group">
                                    <input type="text" class="form-control mb-2" placeholder="Search service" name="nameService" value="${nameService}"/>
                                    <button type="submit" class="btn btn-primary mb-2">
                                        <i class="fa fa-search" aria-hidden="true"></i>
                                    </button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
                <table id="serviceTable" class="table table-striped table-hover" style="width:100%">
                    <thead class="thead-light">
                        <tr>
                            <th class="text-center">Service Name</th>
                            <th class="text-center">Thumbnail</th>
                            <th class="text-center">Category</th>
                            <th class="text-center">Price</th>
                            <th class="text-center">Discount</th>
                            <th class="text-center">Sale Price</th>
                            <th class="text-center">Brief Info</th>
                            <th class="text-center">Status</th>
                            <th class="text-center">Actions</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.list}" var="s">
                            <tr>
                                <td>${s.name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty s.thumbnail}">
                                            <img src="${pageContext.request.contextPath}/assets/images/services/default-thumbnail.jpg" 
                                                 alt="Default Image" 
                                                 height="150px" 
                                                 width="150px"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/${s.thumbnail}" 
                                                 alt="Service Image" 
                                                 height="150px" 
                                                 width="150px"
                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/services/default-thumbnail.jpg';"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${s.category.name}</td>
                                <td>$${s.price}</td>
                                <td>${s.discount}%</td>
                                <td><strong class="text-primary">$${s.price - (s.discount*s.price)/100 }</strong></td>
                                <td>${s.briefInfo}</td>
                                <td>
                                    <span class="badge ${s.status == 1 ? 'badge-success' : 'badge-danger'}">
                                        ${s.status == 1 ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td class="text-center text-nowrap">
                                    <form action="../services/manager" method="POST" onsubmit="confirmChangeStatus(event)" class="d-inline">
                                        <input type="hidden" name="id" value="${s.id}">
                                        <input type="hidden" name="action" value="change">
                                        <button type="submit" class="btn ${s.status == 1 ? 'red mb-2' : 'green mb-2'}">
                                            ${s.status == 1 ? '<i class="fa fa-refresh" aria-hidden="true"></i> Deactivate' : '<i class="fa fa-refresh" aria-hidden="true"></i> Activate'}
                                        </button>
                                    </form>
                                    <a href="../services/update?id=${s.id}" class="btn green mb-2"> <i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>
                                </td>


                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="col-lg-12 m-b20">
                    <div class="pagination-bx rounded-sm gray clearfix">
                        <!-- Phân trang s? ???c c?p nh?t t? ??ng ? ?ây -->
                    </div>
                </div>
            </div>                                       
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <!-- jQuery: -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/js/jquery.min.js"></script> 

        <!-- Bootstrap & Plugin  -->
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>

        <!-- Owl Carousel -->
        <script src="${pageContext.request.contextPath}/assets2/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/magnific-popup/magnific-popup.js"></script>

        <!-- Counter &  Scroll -->
        <script src="${pageContext.request.contextPath}/assets2/vendors/counter/waypoints-min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/counter/counterup.min.js"></script>
        <script src='${pageContext.request.contextPath}/assets2/vendors/scroll/scrollbar.min.js'></script>

        <!-- Masonry & image -->
        <script src="${pageContext.request.contextPath}/assets2/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/masonry/masonry.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/vendors/masonry/filter.js"></script>

        <!-- DataTables  -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

        <!-- Chart & Admin Scripts -->
        <script src="${pageContext.request.contextPath}/assets2/vendors/chart/chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/js/admin.js"></script>

        <!-- function website -->
        <script src="${pageContext.request.contextPath}/assets2/js/functions.js"></script>


        <!-- Custom Scripts -->
        <script>
                                        function confirmChangeStatus(event) {
                                            event.preventDefault();

                                            Swal.fire({
                                                title: "Are you sure?",
                                                text: "Do you really want to change the status?",
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

                                            var table = $('#serviceTable').DataTable({
                                                paging: true,
                                                lengthMenu: [10],
                                                ordering: true,
                                                searching: true,
                                                info: false,
                                                dom: "t",
                                                columnDefs: [
                                                    {targets: [1, 7, 8], orderable: false}, // Vô hi?u hóa s?p x?p ? c?t Action
                                                ],
                                                drawCallback: function () {
                                                    updatePagination(this.api());
                                                },
                                            });


                                            function updatePagination(api) {
                                                var pageInfo = api.page.info();
                                                var paginationHTML = '<ul class="pagination">';

                                                // Nút Previous
                                                if (pageInfo.page > 0) {
                                                    paginationHTML +=
                                                            '<li class="previous"><a href="#" data-page="' +
                                                            (pageInfo.page - 1) +
                                                            '"><i class="ti-arrow-left"></i> Prev</a></li>';
                                                } else {
                                                    paginationHTML +=
                                                            '<li class="previous disabled"><a href="#"><i class="ti-arrow-left"></i> Prev</a></li>';
                                                }

                                                // S? trang
                                                for (var i = 0; i < pageInfo.pages; i++) {
                                                    paginationHTML +=
                                                            '<li class="' +
                                                            (pageInfo.page === i ? "active" : "") +
                                                            '"><a href="#" data-page="' +
                                                            i +
                                                            '">' +
                                                            (i + 1) +
                                                            "</a></li>";
                                                }

                                                // Nút Next
                                                if (pageInfo.page < pageInfo.pages - 1) {
                                                    paginationHTML +=
                                                            '<li class="next"><a href="#" data-page="' +
                                                            (pageInfo.page + 1) +
                                                            '">Next <i class="ti-arrow-right"></i></a></li>';
                                                } else {
                                                    paginationHTML +=
                                                            '<li class="next disabled"><a href="#">Next <i class="ti-arrow-right"></i></a></li>';
                                                }

                                                paginationHTML += "</ul>";

                                                // C?p nh?t pagination vào giao di?n
                                                $(".pagination-bx").html(paginationHTML);

                                                // Thêm s? ki?n click cho pagination tùy ch?nh
                                                $(".pagination a").on("click", function (e) {
                                                    e.preventDefault();
                                                    var page = $(this).data("page");
                                                    if (page !== undefined) {
                                                        table.page(page).draw("page");
                                                    }
                                                });
                                            }
                                        });
        </script>

    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
