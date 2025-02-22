<%-- 
    Document   : services_public
    Created on : Jan 25, 2025, 11:38:51 PM
    Author     : Nvtai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />


        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/logo.png" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Children Care</title>
        <base href="${pageContext.request.contextPath}/">


        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <style>
            .fixed-size-img {
                width: 200px;  /* Thay đổi kích thước theo nhu cầu */
                height: 100px; /* Thay đổi kích thước theo nhu cầu */
                object-fit: cover; /* Đảm bảo hình ảnh không bị méo */
            }

        </style>

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <jsp:include page="header.jsp"/>
            <!-- header END ==== -->

            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner3.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Reservation Details</h1>
                        </div>
                    </div>
                </div>

                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="/app"><i class="fa fa-home"></i> Home</a></li>
                            <li>Appointment</li>
                        </ul>
                    </div>
                </div>

                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp4">
                        <div class="container">
                            <div class="row">
                                <div class="container">
                                    <div class="row align-items-center border-bottom pb-3">
                                        <div class="col-md-1 text-center">
                                            <input type="checkbox" id="select-all">
                                        </div>
                                        <div class="col-md-5 font-weight-bold">Service</div>
                                        <div class="col-md-2 font-weight-bold">Unit Price</div>
                                        <div class="col-md-2 font-weight-bold">Quantity</div>
                                        <div class="col-md-1 font-weight-bold">Sum</div>
                                        <div class="col-md-1 font-weight-bold">Action</div>
                                    </div>

                                    <form action="/app/reservation/contact" method="get">
                                        <c:forEach items="${requestScope.items}" var="i">
                                            <div class="row align-items-center border-bottom pb-3 item-row">
                                                <div class="col-md-1 text-center">
                                                    <input type="checkbox" class="item-checkbox" name="serviceId" value="${i.service.id}">
                                                </div>

                                                <div class="col-md-2 text-center">
                                                    <img src="${i.service.thumbnail}" class="img-fluid fixed-size-img">
                                                </div>

                                                <div class="col-md-3">
                                                    <h6 class="text-muted">${i.service.category.name}</h6>
                                                    <h5 class="font-weight-bold">${i.service.name}</h5>
                                                </div>

                                                <div class="col-md-2 font-weight-bold">
                                                    <del>${i.service.price}</del>
                                                    <h5 class="sale-price" data-price="${i.service.price}" data-discount="${i.service.discount}">
                                                        $${i.service.price * (1 - i.service.discount / 100)}
                                                    </h5>
                                                </div>

                                                <div class="col-md-2">

                                                    <div class="btn btn-outline-secondary btn-sm decrease"
                                                         onclick="changeQuantityItem(${sessionScope.account.id}, ${i.service.id}, this, -1)">-</div>
                                                    <input type="number" value="${i.quantity}" min="1" class="text-center quantity" style="width: 50px;">
                                                    <div class="btn btn-outline-secondary btn-sm increase"
                                                         onclick="changeQuantityItem(${sessionScope.account.id}, ${i.service.id}, this, 1)">+</div>
                                                </div>

                                                <div class="col-md-1 font-weight-bold total-price">
                                                    $${(i.service.price * (1 - i.service.discount / 100)) * i.quantity}
                                                </div>

                                                <div class="col-md-1">
                                                    <div class="btn red" onclick="deleteItem('${sessionScope.account.id}', '${i.service.id}')"><i class="fa fa-trash"></i></div>
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <div class="row pt-3">
                                            <div class="col-md-6 text-right font-weight-bold">Total:</div>
                                            <div class="col-md-2 font-weight-bold" id="total-price">$0.0</div>
                                            <button type="submit" id="finalSubmit" class=" col-md-2 btn gray" disabled >Checkout</button>
                                        </div>
                                    </form>
                                </div
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp"/>
        </div>

        <script>
            document.getElementById('select-all').addEventListener('change', function () {
                let checkboxes = document.querySelectorAll('.item-checkbox');
                checkboxes.forEach(checkbox => checkbox.checked = this.checked);
            });
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                function updateTotalPrice(row) {
                    let quantityInput = row.querySelector(".quantity");
                    let salePriceElement = row.querySelector(".sale-price");
                    let totalPriceElement = row.querySelector(".total-price");

                    let price = parseFloat(salePriceElement.dataset.price);
                    let discount = parseFloat(salePriceElement.dataset.discount);
                    let salePrice = (price * (1 - discount / 100)).toFixed(1);
                    let quantity = parseInt(quantityInput.value);

                    let totalPrice = (salePrice * quantity).toFixed(1);

                    totalPriceElement.innerText = "$" + totalPrice;

                    updateSelectedTotal(); // Cập nhật tổng giá trị của sản phẩm đã chọn
                }

                function updateSelectedTotal() {
                    let total = 0;
                    let checkoutButton = document.getElementById("finalSubmit");

                    document.querySelectorAll(".item-row").forEach(row => {
                        let checkbox = row.querySelector(".item-checkbox");
                        let totalPriceElement = row.querySelector(".total-price");


                        if (checkbox.checked) {
                            total += parseFloat(totalPriceElement.innerText.replace("$", ""));
                        }
                    });

                    console.log(total);

                    if (total == 0) {
                        checkoutButton.classList.add('gray');
                        checkoutButton.classList.remove('green', 'btn-success');
                        checkoutButton.disabled = true;
                    } else {
                        checkoutButton.classList.remove('gray');
                        checkoutButton.classList.add('green', 'btn-success');
                        checkoutButton.disabled = false;
                    }

                    document.getElementById("total-price").innerText = "$" + total.toFixed(1);
                }

                // Xử lý sự kiện khi thay đổi số lượng
                document.querySelectorAll(".item-row").forEach(row => {
                    let quantityInput = row.querySelector(".quantity");
                    let decreaseBtn = row.querySelector(".decrease");
                    let increaseBtn = row.querySelector(".increase");
                    let checkbox = row.querySelector(".item-checkbox");

                    // Khi số lượng thay đổi
                    quantityInput.addEventListener("input", function () {
                        if (quantityInput.value < 1)
                            quantityInput.value = 1;
                        updateTotalPrice(row);
                    });

                    // Giảm số lượng
                    decreaseBtn.addEventListener("click", function () {
                        if (quantityInput.value >= 1) {
//                            quantityInput.value--;
                            updateTotalPrice(row);
                        }
                    });

                    // Tăng số lượng
                    increaseBtn.addEventListener("click", function () {
//                        quantityInput.value++;
                        updateTotalPrice(row);
                    });

                    // Khi checkbox thay đổi trạng thái
                    checkbox.addEventListener("change", function () {
                        updateSelectedTotal();
                    });
                });

                // Xử lý chọn tất cả
                document.getElementById("select-all").addEventListener("change", function () {
                    let isChecked = this.checked;
                    document.querySelectorAll(".item-checkbox").forEach(checkbox => {
                        checkbox.checked = isChecked;
                    });
                    updateSelectedTotal();
                });
            });
        </script>

        <script>
            function changeQuantityItem(uid, sid, btn, change) {
                // Tìm phần tử input số lượng trong cùng hàng với nút bấm
                let quantityInput = btn.parentElement.querySelector(".quantity");

                // Lấy giá trị số lượng hiện tại
                let currentQuantity = parseInt(quantityInput.value);

                // Tính toán số lượng mới
                let newQuantity = currentQuantity + change;

                // Đảm bảo số lượng không nhỏ hơn 1
                if (newQuantity < 1) {
                    newQuantity = 1;
                }

                // Cập nhật số lượng mới trên giao diện ngay lập tức
                quantityInput.value = newQuantity;

                console.log(uid + ' ' + sid + ' ' + newQuantity);

                // Gửi dữ liệu cập nhật lên server
                $.ajax({
                    url: '/app/wishlist/change',
                    type: 'POST',
                    data: {
                        uid: uid,
                        sid: sid,
                        quantity: newQuantity
                    },
                    success: function (response) {
                        console.log("Cập nhật thành công!");

                        // Cập nhật lại giá trị quantity cho nút tăng/giảm
                        btn.previousElementSibling.value = newQuantity; // Cập nhật input number
                    },
                    error: function () {
                        console.log("Lỗi khi cập nhật số lượng!");
                    }
                });
            }

            function deleteItem(uid, sid) {

                var button = event.target;

                var itemRow = button.closest('.item-row');

                $.ajax({
                    url: '/app/wishlist/delete',
                    type: 'POST',
                    data: {
                        uid: uid,
                        sid: sid
                    },
                    success: function (response) {
                        itemRow.style.display = 'none';
                        alert('Delete ok');
                    }
                });
            }
        </script>


        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>

    </body>

</html>
