/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.ReservationDetail;
import java.sql.*;
import java.time.LocalDateTime;
import model.Reservation;
import model.ReservationStatus;
import model.Service;
import model.auth.User;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Nvtai
 */
public class ReservationDetailDAO extends DBContext {

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    public List<ReservationDetail> getUserReservations(int userId) {

        List<ReservationDetail> list = new ArrayList<>();

        String query = "SELECT \n"
                + "    rd.id, \n"
                + "    r.customer_id, \n"
                + "    r.reserved_date, \n"
                + "    rd.service_id,\n"
                + "    rd.reservation_id,\n"
                + "    s.name AS service_name, \n"
                + "    rd.quantity, \n"
                + "    rd.price, \n"
                + "    rd.created_date,\n"
                + "    r.status_id,\n"
                + "    rs.status_name\n"
                + "FROM reservationdetail rd \n"
                + "JOIN reservation r ON rd.reservation_id = r.id \n"
                + "JOIN service s ON rd.service_id = s.id \n"
                + "JOIN reservationStatus rs ON r.status_id = rs.id \n"
                + "WHERE r.customer_id = ?;";

        try (ResultSet rs = executeQuery(query, userId)) {
            while (rs.next()) {
                LocalDateTime reservedDate = rs.getTimestamp("reserved_date").toLocalDateTime();
                String formattedReservedDate = reservedDate.format(formatter);
                ReservationStatus status = ReservationStatus.builder()
                        .id(rs.getInt("status_id"))
                        .statusName(rs.getString("status_name"))
                        .build();
                ReservationDetail reservationDetail = ReservationDetail.builder()
                        .id(rs.getInt("id"))
                        .reservation(Reservation.builder()
                                .id(rs.getInt("reservation_id"))
                                .reservedDate(reservedDate)
                                .status(status)
                                .build())
                        .service(Service.builder()
                                .id(rs.getInt("service_id"))
                                .name(rs.getString("service_name"))
                                .build())
                        .user(User.builder().id(rs.getInt("customer_id")).build())
                        .quantity(rs.getInt("quantity"))
                        .price(rs.getDouble("price"))
                        .total(rs.getDouble("price") * rs.getInt("quantity"))
                        .createdDate(rs.getTimestamp("created_date").toLocalDateTime())
                        .build();
                list.add(reservationDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Calculates the total cost of all reservations made by a customer.
     */
    public double getTotalReservationPrice(int userId) {
        double total = 0;
        String query = "SELECT SUM(rd.price * rd.quantity) AS total_price "
                + "FROM reservationdetail rd "
                + "JOIN reservation r ON rd.reservation_id = r.id "
                + "WHERE r.customer_id = ?";

        try (ResultSet rs = executeQuery(query, userId)) {
            if (rs.next()) {
                total = rs.getDouble("total_price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    /**
     * Inserts a new reservation detail.
     */
    public boolean insertReservationDetail(int reservationId, int serviceId, int quantity, double price) {
        String query = "INSERT INTO reservationdetail (reservation_id, service_id, quantity, price, created_date, updated_date) "
                + "VALUES (?, ?, ?, ?, NOW(), NOW())";
        try {
            return executeUpdate(query, reservationId, serviceId, quantity, price) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates an existing reservation detail.
     */
    public boolean updateReservationDetail(int id, int quantity) {
        String query = "UPDATE reservationdetail rd\n"
                + "JOIN service s ON rd.service_id = s.id\n"
                + "SET rd.quantity = ?, \n"
                + "    rd.price = s.price\n"
                + "WHERE rd.id = ?;";
        try {
            return executeUpdate(query, quantity, id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a reservation detail by ID.
     */
    public boolean deleteReservationDetail(int id) {
        String query = "DELETE FROM reservationdetail WHERE id = ?";
        try {
            return executeUpdate(query, id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
