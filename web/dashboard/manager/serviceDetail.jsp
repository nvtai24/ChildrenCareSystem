<%-- 
    Document   : serviceCreate
    Created on : Jan 23, 2025, 11:43:25 PM
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
                    <h4 class="breadcrumb-title">Service Detail</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="../services/manager"><i class="fa fa-home"></i>Service List</a></li>
                        <li>View</li>
                    </ul>
                </div>	
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Service Detail</h4>
                            </div>
                            <div class="widget-inner">
                                <form class="edit-profile m-b30" name="serviceForm" action="../services/update" method="POST" onsubmit="return validateForm()" enctype="multipart/form-data">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="ml-auto">
                                                <h3>1. Basic info</h3>
                                            </div>
                                        </div>

                                        <!-- Service Name -->
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service name</label>
                                            <div>
                                                <input class="form-control" type="text" name="name" id="serviceName" placeholder="Enter a name" value="${s.name}">
                                                <small id="nameError" class="error-text text-danger"></small>
                                                <input type="hidden" value="${s.id}" name="id">
                                            </div>
                                        </div>

                                        <!-- Category -->
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Category</label>
                                            <div>
                                                <select name="idCategory">
                                                    <c:forEach items="${listCategory}" var="c">                                
                                                        <option value="${c.id}" ${s.category.id == c.id ? 'selected' : ''}>${c.name}</option>                                
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- Service Price -->
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service price</label>
                                            <div>
                                                <input class="form-control" type="text" name="price" id="servicePrice" placeholder="Enter a positive number" value="${s.price}" min="0" step="any">
                                                <small id="priceError" class="error-text text-danger"></small>
                                            </div>
                                        </div>

                                        <!-- Service Discount -->
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Service discount (%)</label>
                                            <div>
                                                <input class="form-control" type="text" name="discount" id="serviceDiscount" placeholder="Enter a number" value="${s.discount}">
                                                <small id="discountError" class="error-text text-danger"></small>
                                            </div>
                                        </div>

                                        <div class="seperator"></div>

                                        <!-- Service Description -->
                                        <div class="col-12 m-t20">
                                            <div class="ml-auto m-b5">
                                                <h3>2. Description</h3>
                                            </div>
                                        </div>

                                        <div class="form-group col-12">
                                            <label class="col-form-label">Service Brief Information</label>
                                            <div>
                                                <textarea class="form-control" name="briefInfo" id="briefInfo" placeholder="Enter a Brief Information" rows="3">${s.briefInfo}</textarea>
                                                <small id="briefInfoError" class="error-text text-danger"></small>
                                            </div>

                                            <label class="col-form-label">Service description</label>
                                            <div>
                                                <textarea class="form-control" name="description" id="serviceDescription" placeholder="Enter a description" rows="6">${s.description}</textarea>
                                                <small id="descriptionError" class="error-text text-danger"></small>
                                            </div>
                                        </div>

                                        <!-- Thumbnail Upload -->
                                        <div class="col-12">
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
                                                                <div class="service-image">
                                                                    <c:choose>
                                                                        <c:when test="${empty s.thumbnail}">
                                                                            <img id="imagePreview" 
                                                                                 src="${pageContext.request.contextPath}/assets/images/services/default-thumbnail.jpg" 
                                                                                 alt="Default Image" 
                                                                                 style="width: 200px; height: auto; margin-top: 10px;">
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <img id="imagePreview" 
                                                                                 src="${pageContext.request.contextPath}/${s.thumbnail}" 
                                                                                 alt="Service Image" 
                                                                                 style="width: 200px; height: auto; margin-top: 10px;" 
                                                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/services/default-thumbnail.jpg';"/>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                
                                                                <label for="thumbnail" class="btn btn-light mt-2">Choose Thumbnail</label>
                                                                <input type="file" name="thumbnail" accept="image/*" id="thumbnail" onchange="previewImage(event)" style="display: none;">
                                                                <input type="hidden" name="oldThumbnail" value="${s.thumbnail}">
                                                            </div>
                                                            <div class="col-md-6 ">
                                                                <label class="col-form-label">Status</label><br/>
                                                                <div class="row-md-3">
                                                                    <input type="radio" name="status" value="1" ${s.status == 1 ? 'checked' : ''}/> Active
                                                                </div>
                                                                <div class="row-md-3">
                                                                    <input type="radio" name="status" value="0" ${s.status == 0 ? 'checked' : ''}/> Inactive
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
        <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
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
        <c:if test="${not empty notification}">
            <script>
                                                                    document.addEventListener("DOMContentLoaded", function () {
                                                                        Swal.fire({
                                                                            title: "<c:out value='${notification eq "successfull" ? "Success!" : "Oops..."}' />",
                                                                            text: "<c:out value='${notification eq "successfull" ? "Service has been updated successfully." : "Service cannot updated please try again!"}' />",
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
// CKEditor setup
            CKEDITOR.replace('serviceDescription', {
                versionCheck: false
            });

// Function to validate each field
            function validateField(fieldId, errorId, validationFunction) {
                const field = document.getElementById(fieldId);
                const errorElement = document.getElementById(errorId);
                const value = fieldId === 'serviceDescription' ? CKEDITOR.instances.serviceDescription.getData() : field.value.trim();

                const validationResult = validationFunction(value);

                if (validationResult !== true) {
                    errorElement.textContent = validationResult;
                    return false;
                } else {
                    errorElement.textContent = "";
                    return true;
                }
            }

// Validate service name
            function validateServiceName(value) {
                if (!value || value.trim() === "") {
                    return "Service name cannot be empty.";
                }

                const trimmed = value.trim();

                if (trimmed.length > 100) {
                    return "Service name cannot be longer than 100 characters.";
                }

                return true;
            }
// Validate service price
            function validateServicePrice(value) {
                if (value === "") {
                    return "Price cannot be empty.";
                }

                const price = parseFloat(value);

                if (isNaN(price) || price <= 0) {
                    return "Price must be a positive number.";
                }

                if (!/^\d+(\.\d{1,2})?$/.test(value)) {
                    return "Price must have at most 2 decimal places.";
                }

                if (price >= 9999999.99) {
                    return "Price cannot be greater than 9,999,999.99$";
                }

                return true;
            }

// Validate service discount
            function validateServiceDiscount(value) {
                if (value === "") {
                    return "Discount cannot be empty.";
                }
                if (isNaN(value) || parseFloat(value) < 0 || parseFloat(value) > 100) {
                    return "Discount must be between 0 and 100.";
                }

                if (!/^\d+(\.\d{1,2})?$/.test(value)) {
                    return "Discount must have at most 2 decimal places.";
                }

                return true;
            }

// Validate brief info
            function validateBriefInfo(value) {
                if (value === "") {
                    return "Brief information cannot be empty.";
                }
                return true;
            }

// Validate description
            function validateDescription(value) {
                if (!value || value.trim() === "") {
                    return "Service description cannot be empty.";
                }
                return true;
            }

// Check for service name uniqueness
            function checkServiceNameUniqueness(serviceName, originalName) {
                return new Promise((resolve) => {
                    if (serviceName === "") {
                        resolve(false);
                        return;
                    }

                    // If name hasn't changed, it's valid
                    if (serviceName === originalName) {
                        resolve(true);
                        return;
                    }

                    $.ajax({
                        url: "../services/update",
                        type: "POST",
                        data: {action: "checkServiceName", name: serviceName},
                        success: function (response) {
                            if (response === "exists") {
                                $("#nameError").text("Service name already exists.");
                                resolve(false);
                            } else {
                                $("#nameError").text("");
                                resolve(true);
                            }
                        },
                        error: function () {
                            resolve(true); // Assume valid on error to prevent blocking submission
                        }
                    });
                });
            }

            // Validate the entire form
            function validateForm() {
                let isValid = true;

                // Validate each field
                isValid = validateField('serviceName', 'nameError', validateServiceName) && isValid;
                isValid = validateField('servicePrice', 'priceError', validateServicePrice) && isValid;
                isValid = validateField('serviceDiscount', 'discountError', validateServiceDiscount) && isValid;
                isValid = validateField('briefInfo', 'briefInfoError', validateBriefInfo) && isValid;
                isValid = validateField('serviceDescription', 'descriptionError', validateDescription) && isValid;

                return isValid;
            }

// Set up event listeners when the document is ready
            $(document).ready(function () {
                // Store the original service name for comparison
                const originalServiceName = $("#serviceName").val().trim();

                // Validate service name on input
                $("#serviceName").on("input", function () {
                    validateField('serviceName', 'nameError', validateServiceName);

                    // Check name uniqueness after a short delay
                    clearTimeout(this.timeoutId);
                    this.timeoutId = setTimeout(() => {
                        checkServiceNameUniqueness($(this).val().trim(), originalServiceName);
                    }, 500);
                });

                // Validate price on input
                $("#servicePrice").on("input", function () {
                    validateField('servicePrice', 'priceError', validateServicePrice);
                });

                // Validate discount on input
                $("#serviceDiscount").on("input", function () {
                    validateField('serviceDiscount', 'discountError', validateServiceDiscount);
                });

                // Validate brief info on input
                $("#briefInfo").on("input", function () {
                    validateField('briefInfo', 'briefInfoError', validateBriefInfo);
                });

                // Validate description when CKEditor content changes
                CKEDITOR.instances.serviceDescription.on('change', function () {
                    validateField('serviceDescription', 'descriptionError', validateDescription);
                });

                // Handle form submission
                $("#serviceForm").on("submit", async function (e) {
                    e.preventDefault(); // Prevent default submission

                    // Full validation before submission
                    const isValid = validateForm();

                    // Check for name uniqueness if name has changed
                    const currentName = $("#serviceName").val().trim();
                    const nameUnique = await checkServiceNameUniqueness(currentName, originalServiceName);

                    if (isValid && nameUnique) {
                        this.submit(); // Submit the form if validation passes
                    } else {
                        Swal.fire({
                            title: 'Validation Error',
                            text: 'Please check the form and correct all errors.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                });
            });

// Function to preview the uploaded image
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
