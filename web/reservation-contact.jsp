<%-- 
    Document   : reservation-contact
    Created on : Feb 19, 2025, 11:40:26 AM
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

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <jsp:include page="header.jsp"/>
            <!-- header END ==== -->

            <!-- Content -->
            <div class="page-content bg-white">
                <div class="content-block mb-2">
                    <div class="section-area">
                        <div class="container">
                            <div class="breadcrumb-row">
                                <div class="container">
                                    <ul class="list-inline">
                                        <li><a href="/app"><i class="fa fa-home"></i> Home</a></li>
                                        <li>Appointment</li>
                                        <li>Contact</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="row justify-content-center mt-2">
                                <div class="col-md-12">
                                    <div class="card p-4">
                                        <div class="card-body">
                                            <h4 class="text-dark font-weight-bold">Reservation Form</h4>
                                            <p class="text-muted">We will get in touch with you shortly</p>
                                            <form method="get" action="/app/reservation/complete">
                                                <!-- Name Fields -->
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <label for="firstName">First Name</label>
                                                        <input
                                                            type="text"
                                                            class="form-control"
                                                            id="firstName"
                                                            name="firstname"
                                                            placeholder="First Name"
                                                            value="${requestScope.p.firstName}"
                                                            required
                                                            />
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label for="firstName">Last Name</label>
                                                        <input
                                                            type="text"
                                                            class="form-control"
                                                            id="lastName"
                                                            name="lastname"
                                                            placeholder="Last Name"
                                                            value="${requestScope.p.lastName}"
                                                            required
                                                            />
                                                    </div>

                                                </div>

                                                <form>
                                                    <!-- Name Fields -->
                                                    <div class="form-row">
                                                        <div class="form-group col-md-6">
                                                            <label for="date">Date</label>
                                                            <input
                                                                type="date"
                                                                class="form-control"
                                                                id="date"
                                                                name="date"
                                                                required
                                                                />
                                                        </div>

                                                        <div class="form-group col-md-6">
                                                            <label for="time">Time</label>
                                                            <input
                                                                type="time"
                                                                class="form-control"
                                                                id="time"
                                                                name="time"
                                                                required
                                                                />
                                                        </div>
                                                    </div>

                                                    <!-- Contact Fields -->
                                                    <div class="form-row">
                                                        <div class="form-group col-md-6">
                                                            <label for="phone">Phone Number</label>
                                                            <input
                                                                type="tel"
                                                                class="form-control"
                                                                id="phone"
                                                                name="phone"
                                                                placeholder="(000) 000-0000"
                                                                value="${requestScope.p.phone}"
                                                                required
                                                                />
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label for="email">E-mail <small class="text-muted">(Optional)</small></label>
                                                            <input
                                                                type="email"
                                                                class="form-control"
                                                                id="email"
                                                                name="email"
                                                                placeholder="ex: myname@example.com"
                                                                value="${sessionScope.account.email}"
                                                                />

                                                        </div>
                                                    </div>

                                                    <!-- Message -->
                                                    <div class="form-group">
                                                        <label for="message">Leave Your Message</label>
                                                        <textarea
                                                            class="form-control"
                                                            id="message"
                                                            rows="4"
                                                            placeholder="Type your message here"
                                                            name="note"
                                                            style="resize: none"
                                                            ></textarea>
                                                    </div>

                                                    <!--                                                     Payment Method Selection 
                                                                                                        <div class="form-group">
                                                                                                            <label for="email">Payment Method</label>
                                                                                                            <br>
                                                                                                            <div class="form-check form-check-inline mr-4">
                                                                                                                <input class="form-check-input" type="radio" name="payment" id="cash" value="cash" checked>
                                                                                                                <label class="form-check-label" for="cash">Cash</label>
                                                                                                            </div>
                                                                                                            <div class="form-check form-check-inline mr-4">
                                                                                                                <input class="form-check-input" type="radio" name="payment" id="banking" value="banking">
                                                                                                                <label class="form-check-label" for="banking">Online Banking</label>
                                                                                                            </div>
                                                                                                        </div>-->

                                                    <!-- Buttons -->
                                                    <div class="form-row">
                                                        <div class="col-md-6">
                                                            <button type="button" class="btn btn-danger btn-block red">
                                                                Back
                                                            </button>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <button type="submit" class="btn btn-success btn-block green">
                                                                Continue
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>
                                        </div>
                                    </div>
                                </div>
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
                    document.querySelectorAll(".item-row").forEach(row => {
                        let checkbox = row.querySelector(".item-checkbox");
                        let totalPriceElement = row.querySelector(".total-price");

                        if (checkbox.checked) {
                            total += parseFloat(totalPriceElement.innerText.replace("$", ""));
                        }
                    });

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
