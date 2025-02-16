<%-- 
    Document   : serviceList
    Created on : Jan 23, 2025, 10:17:15 PM
    Author     : Admin
--%>




<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG (Open Graph) ============================================= -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

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
                    <a href="../servicecreate/manager" class="btn " style=" margin-left:  10px; margin-right: 10px"><i class="fa fa-plus-circle"> </i>Add New Service</a>

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
                            <th>Service Name</th>
                            <th>Thumbnail</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Discount</th>
                            <th>Sale Price</th>
                            <th>Brief Info</th>
                            <th>Status</th>
                            <th class="text-center">Actions</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.list}" var="s">
                            <tr>
                                <td>${s.name}</td>
                                <td><img src="${pageContext.request.contextPath}/${s.thumbnail}" alt="No image" height="150px" width="150px"/></td>
                                <td>${s.category.name}</td>
                                <td>$${s.price}</td>
                                <td>$${s.discount}</td>
                                <td><strong class="text-primary">$${s.price - s.discount}</strong></td>
                                <td>${s.briefInfo}</td>
                                <td>
                                    <span class="badge ${s.status == 1 ? 'badge-success' : 'badge-danger'}">
                                        ${s.status == 1 ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td class="text-center text-nowrap">
                                    <form action="../services/manager" method="POST" onsubmit="return confirmChangeStatus()" class="d-inline">
                                        <input type="hidden" name="id" value="${s.id}">
                                        <input type="hidden" name="action" value="change">
                                        <button type="submit" class="btn  ${s.status == 1 ? 'red mb-2' : 'green mb-2'}">

                                            ${s.status == 1 ? '<i class="fa fa-refresh" aria-hidden="true"></i> Deactivate' : '<i class="fa fa-pencil" aria-hidden="true"></i> Activate'}
                                        </button>
                                    </form>
                                    <a href="../serviceupdate/manager?id=${s.id}" class="btn green mb-2"> <i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>
                                </td>


                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>                                       
        </div>
    </div>


</main>
<div class="ttr-overlay"></div>

<!-- External JavaScripts -->
<!-- jQuery: -->
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
<script src='${pageContext.request.contextPath}/assets2/vendors/switcher/switcher.js'></script>

<!-- Custom Scripts -->
<script>
                                        function confirmChangeStatus() {
                                            return confirm("Are you sure you want to change the status?");
                                        }

                                        $(document).ready(function () {

                                            $('#serviceTable').DataTable({
                                                "paging": true,
                                                "lengthMenu": [10],
                                                "searching": false,
                                                "ordering": true,
                                                "info": false,
                                                "columnDefs": [
                                                    {"orderable": false, "targets": [1, 7, 8]}
                                                ],
                                                "dom": 't<"dt-paging"p>'
                                            });


                                            if ($(".selectpicker").length) {
                                                $(".selectpicker").selectpicker();
                                            }


                                            if ($(".owl-carousel").length) {
                                                $(".owl-carousel").owlCarousel({
                                                    loop: true,
                                                    margin: 10,
                                                    nav: true,
                                                    dots: true,
                                                    autoplay: true,
                                                    autoplayTimeout: 3000,
                                                    responsive: {
                                                        0: {items: 1},
                                                        600: {items: 2},
                                                        1000: {items: 3}
                                                    }
                                                });
                                            }
                                        });
</script>

</body>

<!-- Mirrored from educhamp.themetrades.com/demo/admin/courses.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>
