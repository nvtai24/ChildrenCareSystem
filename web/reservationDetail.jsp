<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.ReservationDetail" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Reservation Cart</title>
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dashboard.css">
        



    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <div class="ttr-header-right ttr-with-seperator">
                    <button class="btn btn-secondary" onclick="window.history.back()">Back</button>
                </div>
            </div>
        </header>

        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Your Reservation Cart</h4>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Reservations</h4>
                            </div>
                            <div class="widget-inner">
                                <table class="table table-bordered text-center">
                                    <thead>
                                        <tr class="table-warning">
                                            <th>Select</th>
                                            <th>Service Name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total Cost</th>
                                            <th>Reserve Date</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="reservation" items="${requestScope.reservationDetails}">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" id="checkbox_${reservation.id}" onchange="updateTotalPrice()"/>
                                                </td>
                                                <td>${reservation.service.name}</td>
                                                <td id="price_${reservation.id}">$${reservation.price}</td>
                                                <td>
                                                    <input type="number" id="quantity_${reservation.id}" value="${reservation.quantity}" min="1" oninput="updateTotalCost(${reservation.id})">
                                                </td>
                                                <td id="totalCost_${reservation.id}">$${reservation.total}</td>
                                                <td>${reservation.reservation.reservedDate}</td>
                                                <td>
                                                    <a href="ReservationDetailDelete?id=${reservation.id}">
                                                        <button class="btn btn-danger">Delete</button>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <h4 class="text-end">Total Price: $<span id="totalPrice">0.0</span></h4>
                                <div class="d-flex justify-content-between">
                                    <a href="services" class="btn btn-primary">Choose More Services</a>
                                    <a href="reservation-contact." class="btn btn-success">Check Out</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script src="assets/js/functions.js"></script>
        <script>
    function updateTotalCost(reservationId) {
        let quantityInput = document.getElementById("quantity_" + reservationId);
        let priceElement = document.getElementById("price_" + reservationId);
        let totalCostElement = document.getElementById("totalCost_" + reservationId);

        let quantity = parseInt(quantityInput.value);
        let price = parseFloat(priceElement.innerText.replace('$', '')); 
        let totalCost = quantity * price;
        totalCostElement.innerText = "$" + totalCost.toFixed(2);
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

        document.querySelector(".text-end").innerText = "Total Price: $" + totalPrice.toFixed(2);
    }
</script>

    </body>
</html>
