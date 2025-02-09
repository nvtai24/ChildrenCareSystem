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
    <script>
        function saveReservation(reservationId) {
            let quantity = document.getElementById('quantity_' + reservationId).value;
            fetch('reservationDetail', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `action=save&reservationId=${reservationId}&quantity=${quantity}`
            }).then(() => location.reload());
        }
        
        function saveAll() {
            let updates = [];
            document.querySelectorAll('[id^="quantity_"]').forEach(input => {
                let id = input.id.split('_')[1];
                let quantity = input.value;
                updates.push(`reservationId=${id}&quantity=${quantity}`);
            });
            fetch('reservationDetail', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `action=saveAll&` + updates.join('&')
            }).then(() => location.reload());
        }

        function deleteReservation(reservationId) {
            if (confirm("Are you sure you want to remove this service?")) {
                fetch('reservationDetail', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `action=delete&reservationId=${reservationId}`
                }).then(() => location.reload());
            }
        }
    </script>
</head>
<body>
    <div class="reservation-container mt-5">
        <h2 class="text-center">Your Reservation Cart</h2>

        <table class="reservation-table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Service Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Cost</th>
                    <th>Actions</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <form action="reservationDetail" method="get">
                <c:forEach var="reservation" items="${requestScope.reservationDetails}">
                    <tr>
                        <td>${reservation.id}</td>
                        <td>${reservation.service.name}</td>
                        <td>$${reservation.price}</td>
                        <td>
                            <input type="number" id="quantity_${reservation.id}" value="${reservation.quantity}" min="1"
                                   onchange="updateReservation(${reservation.id})">
                        </td>
                        <td id="totalCost_${reservation.id}">$${reservation.total}</td>
                        <td>
                            <button class="delete-btn btn-danger" onclick="deleteReservation(${reservation.id})">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
            </form>
                
            </tbody>
        </table>

        <h4 class="total-price">Total Price: $${totalPrice}</h4>

        <div class="reservation-buttons">
            <a href="services.jsp" class="btn btn-primary">Choose More Services</a>
            <a href="reservation-contact.jsp" class="btn btn-success">Check Out</a>
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
                                        <th>ID</th>
                                        <th>Service Name</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total Cost</th>
                                        <th>Reserve Date</th>
                                        <th>Actions</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="reservation" items="${requestScope.reservationDetails}">
                                        <tr>
                                            <td>${reservation.id}</td>
                                            <td>${reservation.service.name}</td>
                                            <td>$${reservation.price}</td>
                                            <td>
                                                <input type="number" id="quantity_${reservation.id}" value="${reservation.quantity}" min="1">
                                            </td>
                                            <td id="totalCost_${reservation.id}">$${reservation.total}</td>
                                            <td>${reservation.reservation.reservedDate}</td>
                                            <td>
                                                <button class="btn btn-danger" onclick="deleteReservation(${reservation.id})">Delete</button>
                                            </td>
                                            <td>${reservation.reservation.status.statusName}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <h4 class="text-end">Total Price: $${totalPrice}</h4>
                            <div class="d-flex justify-content-between">
                                <a href="services.jsp" class="btn btn-primary">Choose More Services</a>
                                <button class="btn btn-warning" onclick="saveAll()">Save All</button>
                                <a href="reservation-contact.jsp" class="btn btn-success">Check Out</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="assets/js/functions.js"></script>
</body>
</html>
