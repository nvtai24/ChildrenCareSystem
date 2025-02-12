<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.ReservationDetail" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Reservation Cart</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body style="background-color: #eee;">

        <div class="container py-5">
            <div class="row d-flex justify-content-center align-items-center">
                <div class="col-lg-10">
                    <div class="card">
                        <div class="card-body p-4">

                            <h5 class="mb-3">
                                <a href="#" class="text-body" onclick="goBack()">
                                    <i class="fas fa-long-arrow-alt-left me-2"></i>Continue shopping
                                </a>
                            </h5>
                            <hr>

                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div>
                                    <p class="mb-1">Reservation Cart</p>
                                    <p class="mb-0">You have <strong>${requestScope.reservationDetails.size()}</strong> items in your cart</p>
                                </div>
                                <div>
                                    <p class="mb-0"><span class="text-muted">Sort by:</span> 
                                        <a href="#!" class="text-body">price <i class="fas fa-angle-down mt-1"></i></a>
                                    </p>
                                </div>
                            </div>

                            <!-- Thêm tiêu đề cột -->
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between fw-bold">
                                        <div class="d-flex flex-row align-items-center">
                                            <span style="width: 250px;">Service Name</span>
                                        </div>
                                        <div class="d-flex flex-row align-items-center">

                                            <span style="width: 80px; text-align: center;">Price</span>
                                            <span style="width: 80px; text-align: center;">Total Cost</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Loop through reservation details -->
                            <c:forEach var="reservation" items="${requestScope.reservationDetails}">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div class="d-flex flex-row align-items-center">
                                                <input type="checkbox" id="checkbox_${reservation.id}" onchange="updateTotalPrice()">
                                                <div class="ms-3">
                                                    <h5>${reservation.service.name}</h5>
                                                    <p class="small mb-0">Reserved Date: ${reservation.reservation.reservedDate}</p>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center">
                                                <input type="number" id="quantity_${reservation.id}" class="form-control text-center" style="width: 60px;" 
                                                       value="${reservation.quantity}" min="1" onchange="updateTotalCost(${reservation.id})">
                                                <div style="width: 80px; text-align: center;">
                                                    <h5 id="price_${reservation.id}">$${reservation.price}</h5>
                                                </div>
                                                <div style="width: 80px; text-align: center;">
                                                    <h5 id="totalCost_${reservation.id}" class="text-danger">$${reservation.total}</h5>
                                                </div>
                                                <a href="ReservationDetailDelete?id=${reservation.id}" class="text-danger ms-3">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>


                            <div class="d-flex justify-content-between">
                                <h4 class="text-end">Total Price: $<span id="totalPrice">0.0</span></h4>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="services" class="btn btn-primary">Choose More Services</a>
                                <a href="reservation-contact" class="btn btn-success">Check Out</a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function updateTotalCost(reservationId) {
                let quantityInput = document.getElementById("quantity_" + reservationId);
                let priceElement = document.getElementById("price_" + reservationId);
                let totalCostElement = document.getElementById("totalCost_" + reservationId);

                let quantity = parseInt(quantityInput.value);
                let price = parseFloat(priceElement.innerText.replace('$', ''));

                // Tính toán lại total cost
                let totalCost = quantity * price;
                totalCostElement.innerText = "$" + totalCost.toFixed(1);

                // Nếu checkbox được chọn, cập nhật tổng giá
                updateTotalPrice();
            }

            function updateTotalPrice() {
                let totalPrice = 0;

                document.querySelectorAll("[id^='checkbox_']").forEach(function (checkbox) {
                    if (checkbox.checked) {
                        let reservationId = checkbox.id.replace("checkbox_", "");
                        let totalCostElement = document.getElementById("totalCost_" + reservationId);
                        totalPrice += parseFloat(totalCostElement.innerText.replace('$', ''));
                    }
                });

                document.getElementById("totalPrice").innerText = totalPrice.toFixed(1);
            }

            function goBack() {
                window.history.back();
            }

        </script>

    </body>
</html>
