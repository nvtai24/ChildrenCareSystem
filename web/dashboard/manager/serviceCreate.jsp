<%-- 
    Document   : serviceCreate/    Created on : Jan 23, 2025, 11:43:25 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/add-listing.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
    <head>

        <!-- META ============================================= -->
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
        <link
            rel="shortcut icon"
            type="image/x-icon"
            href="${pageContext.request.contextPath}/assets/images/logo.png"
            />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Children Care</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="${pageContext.request.contextPath}/assets2/js/html5shiv.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets2/js/respond.min.js"></script>
        <![endif]-->

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

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <jsp:include page="../../dashboard/header.jsp"/>         
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <jsp:include page="../../dashboard/left-sidebar.jsp"/>                           
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Add Service</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="../services/manager"><i class="fa fa-home"></i>Service List</a></li>
                        <li>Add Service</li>
                    </ul>
                </div>	
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Add Service</h4>
                            </div>
                            <div class="widget-inner">
                                <form class="edit-profile m-b30" name="serviceForm" id="numberForm" action="../servicecreate/manager" method="POST" enctype="multipart/form-data">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>1. Basic info</h3>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service name</label>
                                            <div>
                                                <input class="form-control" type="text" name="name" placeholder="Enter a name" >
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Category</label>
                                            <div>
                                                <select select name="idCategory" >


                                                    <c:forEach items="${listCategory}" var="c">                                
                                                        <option value="${c.id}" >${c.name}</option>                                
                                                    </c:forEach>

                                                </select>

                                            </div>
                                        </div>

                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service price</label>
                                            <div>
                                                <input class="form-control" type="number" 
                                                       placeholder="Enter a number" 
                                                       name ="price"
                                                       >
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service discount</label>
                                            <div>
                                                <input class="form-control" type="number" placeholder="Enter a number"  name="discount"
                                                       >
                                            </div>
                                        </div>

                                        <div class="seperator"></div>

                                        <div class="col-12 m-t20">
                                            <div class="ml-auto m-b5">
                                                <h3>2. Description</h3>
                                            </div>
                                        </div>
                                        <div class="form-group col-12">

                                            <label class="col-form-label">Service Brief Information</label>
                                            <div>
                                                <input class="form-control" type="text" name="briefInfo" placeholder="Enter a Brief Information"/>                                                
                                            </div>
                                            <label class="col-form-label">Service description</label>
                                            <div>
                                                <textarea class="form-control" name="description" placeholder="Enter a description" ></textarea>
                                            </div>

                                        </div>
                                        <div class="col-12 m-t20">
                                            <div class="ml-auto">
                                                <h3 class="m-form__section">3. Add Item</h3>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <table id="item-add" style="width:100%;">
                                                <tr class="list-item">
                                                    <td>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <label class="col-form-label">Thumbnail URL</label>
                                                                <div>
                                                                    <label for="thumbnail" class="btn btn-light">Choose Thumbnail</label>
                                                                    <input type="file" name="thumbnail"  accept="image/*" id="thumbnail" required onchange="previewImage(event)" style="display: none">
                                                                    <img id="imagePreview" src="${pageContext.request.contextPath}/#" alt="Image Preview" style="display: none; width: 200px; height: auto; margin-top: 10px;">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6 ">
                                                                <label class="col-form-label">Status</label><br/>
                                                                <div class="row-md-3 ">
                                                                    <input type="radio" name="status" checked="checked" value="1" check="checked"/>Active

                                                                </div>
                                                                <div class="row-md-3 ">
                                                                    <input type="radio" name="status" checked="checked" value="0"/>Inactive
                                                                </div>


                                                            </div>

                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-12">

                                            <button type="submit" class="btn">Save changes</button>                                             
                                        </div>
                                    </div>
                                </form>
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
        <c:if test="${requestScope.error != null}">
            <script>
                                                                        alert('<%= request.getAttribute("error") %>');
            </script>
        </c:if>


        <script>
            function previewImage(event) {
                var input = event.target;
                var reader = new FileReader();

                reader.onload = function () {
                    var img = document.getElementById('imagePreview');
                    img.src = reader.result;
                    img.style.display = 'block';
                };

                if (input.files && input.files[0]) {
                    reader.readAsDataURL(input.files[0]);
                }
            }
            function validateForm() {
                let name = document.forms["serviceForm"]["name"].value.trim();
                let description = document.forms["serviceForm"]["description"].value.trim();
                let price = document.forms["serviceForm"]["price"].value.trim();
                let discount = document.forms["serviceForm"]["discount"].value.trim();
                let briefInfo = document.forms["serviceForm"]["briefInfo"].value.trim();

                if (name === "" || description === "" || price === "" || discount === "" || briefInfo === "") {
                    alert("Please fill in all required fields.");
                    return false;
                }

                if (isNaN(price) || price <= 0) {
                    alert("Price must be a positive number.");
                    return false;
                }

                if (isNaN(discount) || discount < 0) {
                    alert("Discount must be a valid number and not negative.");
                    return false;
                }

                if (parseFloat(discount) > parseFloat(price)) {
                    alert("Discount cannot be greater than the price.");
                    return false;
                }
                alert("Created successfully.");
                return true;
            }

        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/add-listing.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
</html>
