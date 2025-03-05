<%-- 
    Document   : serviceCreate/    Created on : Jan 23, 2025, 11:43:25 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <style>
            .service-image-container {
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                text-align: center;
                margin-top: 15px;
                max-width: 250px;
                margin-left: auto;
                margin-right: auto;
            }

            .service-image-container img {
                width: 100%;
                height: auto;
                border-radius: 10px;
                border: 2px solid #ddd;
                transition: transform 0.3s ease-in-out;
            }

            .service-image-container img:hover {
                transform: scale(1.05);
            }
        </style>

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
                                <form class="edit-profile m-b30" name="serviceForm" id="serviceForm" action="../services/add" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
                                    <div class="row">
                                        <div class="col-12"><h3>1. Basic Info</h3></div>

                                        <!-- Service Name -->
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service name</label>
                                            <div>
                                                <input class="form-control" type="text" id="serviceName" name="name" placeholder="Enter a name">
                                                <small id="nameError" class="text-danger"></small>
                                            </div>
                                        </div>

                                        <!-- Category -->
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Category</label>
                                            <div>
                                                <select name="idCategory">
                                                    <c:forEach items="${listCategory}" var="c">
                                                        <option value="${c.id}">${c.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- Service Price -->
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service price</label>
                                            <div>
                                                <input class="form-control" type="text" id="servicePrice" name="price" placeholder="Enter a number">
                                                <small id="priceError" class="text-danger"></small>
                                            </div>
                                        </div>

                                        <!-- Service Discount -->
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service discount (%)</label>
                                            <div>
                                                <input class="form-control" type="text" id="serviceDiscount" name="discount" placeholder="Enter a number">
                                                <small id="discountError" class="text-danger"></small>
                                            </div>
                                        </div>

                                        <div class="seperator"></div>
                                        <div class="col-12"><h3>2. Description</h3></div>

                                        <!-- Brief Info -->
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Service Brief Information</label>
                                            <div>
                                                <input class="form-control" type="text" id="briefInfo" name="briefInfo" placeholder="Enter a brief info">
                                                <small id="briefInfoError" class="text-danger"></small>
                                            </div>
                                        </div>

                                        <!-- Description -->
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Service description</label>
                                            <div>
                                                <textarea class="form-control" id="serviceDescription" name="description" placeholder="Enter a description"></textarea>
                                                <small id="descriptionError" class="text-danger"></small>
                                            </div>
                                        </div>

                                        <div class="col-12"><h3 class="m-form__section">3. Add Item</h3></div>

                                        <!-- Thumbnail Upload -->
                                        <div class="col-md-6">
                                            <label class="col-form-label">Thumbnail URL</label>
                                            <div class="service-image-container">
                                                <img id="imagePreview" src="${pageContext.request.contextPath}\assets\images\services\default-thumbnail.jpg" alt="Service Image">
                                            </div>
                                            <label for="thumbnail" class="btn btn-light mt-2">Choose Thumbnail</label>
                                            <input type="file" name="thumbnail" accept="image/*" id="thumbnail" onchange="previewImage(event)" style="display: none;">
                                            <input type="hidden" name="oldThumbnail" value="${s.thumbnail}">
                                        </div>

                                        <!-- Status -->
                                        <div class="col-md-6">
                                            <label class="col-form-label">Status</label><br>
                                            <div>
                                                <input type="radio" name="status" value="1" checked> Active
                                                <input type="radio" name="status" value="0"> Inactive
                                            </div>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        <c:if test="${not empty notification}">
            <script>
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    Swal.fire({
                                                        title: "<c:out value='${notification eq "successfull" ? "Success!" : "Oops..."}' />",
                                                        text: "<c:out value='${notification eq "successfull" ? "Customer has been created successfully." : "Something went wrong!"}' />",
                                                        icon: "<c:out value='${notification eq "successfull" ? "success" : "error"}' />",
                                                        confirmButtonText: "OK",
                                                        didOpen: () => {
                                                            document.querySelector(".swal2-select")?.remove();
                                                        }
                                                    });
                                                });
            </script>
        </c:if>
        <script>
            $(document).ready(function () {
                function validateForm() {
                    var isValid = true;

                    // Validate Price
                    var price = $("#servicePrice").val().trim();
                    if (price === "" || isNaN(price) || parseFloat(price) <= 0) {
                        $("#priceError").text("Price must be a positive number.");
                        isValid = false;
                    } else {
                        $("#priceError").text("");
                    }

                    // Validate Discount (0-100%)
                    var discount = $("#serviceDiscount").val().trim();
                    if (discount === "" || isNaN(discount) || parseFloat(discount) < 0 || parseFloat(discount) > 100) {
                        $("#discountError").text("Discount must be between 0 and 100.");
                        isValid = false;
                    } else {
                        $("#discountError").text("");
                    }

                    // Validate Brief Info
                    var briefInfo = $("#briefInfo").val().trim();
                    if (briefInfo === "") {
                        $("#briefInfoError").text("Brief information cannot be empty.");
                        isValid = false;
                    } else {
                        $("#briefInfoError").text("");
                    }

                    // Validate Description
                    var description = $("#serviceDescription").val().trim();
                    if (description === "") {
                        $("#descriptionError").text("Service description cannot be empty.");
                        isValid = false;
                    } else {
                        $("#descriptionError").text("");
                    }

                    return isValid;
                }

                // Validate on input change
                $("#serviceName, #servicePrice, #serviceDiscount, #briefInfo, #serviceDescription").on("input change", function () {
                    validateForm();
                });

                // Prevent form submission if validation fails
                $("form").on("submit", function (e) {
                    if (!validateForm()) {
                        e.preventDefault();
                        Swal.fire({
                            title: 'Oops...',
                            text: 'Something went wrong!',
                            icon: 'error',
                            confirmButtonText: 'Try Again'
                        });
                    }
                });
            });

            //check service name
            $(document).ready(function () {


                $("#serviceName").on("input", function () {
                    var serviceName = $(this).val().trim();

                    if (serviceName === "") {
                        $("#nameError").text("Service name cannot be empty.");
                        return;
                    } else {
                        $("#nameError").text("");
                        return;
                    }


                    $.ajax({
                        url: "../services/add",
                        type: "POST",
                        data: {action: "checkServiceName", name: serviceName},
                        success: function (response) {
                            if (response === "exists") {
                                $("#nameError").text("Service name already exists.");
                            } else {
                                $("#nameError").text("");
                            }
                        }
                    });
                });
            });

            function previewImage(event) {
                var input = event.target;
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#imagePreview").attr("src", e.target.result).css("display", "block");
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/add-listing.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
</html>
