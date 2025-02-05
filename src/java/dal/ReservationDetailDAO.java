/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.ReservationDetail;
import java.sql.*;
/**
 *
 * @author Nvtai
 */
public class ReservationDetailDAO extends DBContext {

    public List<ReservationDetail> getUserReservations(int userId) {
        List<ReservationDetail> list = new ArrayList<>();
        String query = "SELECT rd.id, r.customer_id, r.reserved_date, s.name AS service_name, rd.quantity, rd.num_persons, rd.price "
                + "FROM reservationdetail rd "
                + "JOIN reservation r ON rd.reservation_id = r.id "
                + "JOIN service s ON rd.service_id = s.id "
                + "WHERE r.customer_id = ?";

        try (ResultSet rs = executeQuery(query, userId)) {
            while (rs.next()) {
                ReservationDetail reservation = new ReservationDetail();
                reservation.setId(rs.getInt("id"));
                reservation.setCustomerId(rs.getInt("customer_id"));
                reservation.setReservedDate(rs.getTimestamp("reserved_date"));
                reservation.setServiceName(rs.getString("service_name"));
                reservation.setQuantity(rs.getInt("quantity"));
                reservation.setNumberOfPersons(rs.getInt("num_persons"));
                reservation.setPrice(rs.getDouble("price"));
                reservation.setTotalCost(rs.getDouble("price") * rs.getInt("quantity") * rs.getInt("num_persons"));
                list.add(reservation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public double getTotalReservationPrice(int userId) {
        double total = 0;
        String query = "SELECT SUM(rd.price * rd.quantity * rd.num_persons) AS total_price "
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
}
