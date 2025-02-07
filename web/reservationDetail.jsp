<%-- 
    Document   : reservationDetail
    Created on : Feb 5, 2025, 11:27:18 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.ReservationDetail" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="assets/css/style.css">
<!DOCTYPE html>
<html lang="en">
    <style>
            /* ================================
   RESERVATION DETAIL PAGE STYLING
================================ */

/* Container */
.reservation-container {
    max-width: 900px;
    margin: auto;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Table Styling */
.reservation-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.reservation-table th, .reservation-table td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
}

.reservation-table th {
    background: #efbb20;
    color: white;
    font-weight: bold;
}

/* Input Fields */
.reservation-table input {
    width: 60px;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 5px;
}

/* Total Price */
.total-price {
    font-size: 20px;
    font-weight: bold;
    text-align: right;
    margin-top: 15px;
}

/* Buttons */
.reservation-buttons {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

.reservation-buttons .btn {
    padding: 10px 15px;
    border-radius: 5px;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    text-align: center;
    display: inline-block;
}

.btn-primary {
    background: #007bff;
    color: white;
    border: none;
}

.btn-success {
    background: #28a745;
    color: white;
    border: none;
}

.btn-danger {
    background: #dc3545;
    color: white;
    border: none;
}

.btn:hover {
    opacity: 0.8;
}

/* Delete Button */
.delete-btn {
    background: #ff4d4d;
    border: none;
    color: white;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
}

.delete-btn:hover {
    background: #d43f3f;
}

    </style>
<head>
    <meta charset="UTF-8">
    <title>Reservation Cart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        function updateReservation(reservationId) {
            let quantity = document.getElementById('quantity_' + reservationId).value;
            let numPersons = document.getElementById('numPersons_' + reservationId).value;

            fetch('reservationDetail', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `action=update&reservationId=${reservationId}&quantity=${quantity}&numPersons=${numPersons}`
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
            <a href="checkout.jsp" class="btn btn-success">Check Out</a>
        </div>
    </div>
</body>
</html>