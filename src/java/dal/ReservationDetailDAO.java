/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ReservationDetail;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.ReservationDetail;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Profile;
import model.Reservation;
import model.ReservationDetailStatus;
import model.Service;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class ReservationDetailDAO extends DBContext {

    public double getTotalRevenue() {
        double totalRevenue = 0;
        String query = "SELECT SUM(price * quantity) AS total_revenue FROM reservationdetail WHERE DATE(created_date) >= DATE(NOW()) - INTERVAL 7 DAY;";

        try {
            ResultSet rs = executeQuery(query);
            if (rs.next()) {
                totalRevenue = rs.getDouble("total_revenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRevenue;
    }

    public ArrayList<ReservationDetail> getListReservationDetail(int reservationId) {
        DBContext db = new DBContext();
        String sql = "SELECT "
                + "rd.id, "
                + "s.name AS 'service', "
                + "rd.quantity, "
                + "rd.price, "
                + "rd.staff_id, "
                + "rd.status_id, "
                + "r.reserve_date, "
                + "p.firstname, "
                + "p.lastname " // Thêm first_name và last_name từ bảng profile
                + "FROM reservationdetail rd "
                + "JOIN service s ON rd.service_id = s.id "
                + "JOIN reservation r ON rd.reservation_id = r.id "
                + "LEFT JOIN profile p ON rd.staff_id = p.userid " // JOIN bảng profile để lấy first_name và last_name
                + "WHERE rd.reservation_id = ?";

        ResultSet rs = null;
        ArrayList<ReservationDetail> list = new ArrayList<>();
        try {
            rs = db.executeQuery(sql, reservationId);

            while (rs.next()) {
                ReservationDetail rd = new ReservationDetail();
                rd.setId(rs.getInt("id"));
                Service service = new Service();
                service.setName(rs.getString("service"));
                rd.setService(service);
                rd.setQuantity(rs.getInt("quantity"));
                rd.setPrice(rs.getDouble("price"));

                ReservationDetailStatus status = new ReservationDetailStatus();
                status.setId(rs.getInt("status_id"));
                rd.setStatus(status);

                User staff = new User();
                staff.setId(rs.getInt("staff_id"));

                // Lấy thông tin firstName và lastName của nhân viên từ bảng profile
                Profile profile = new Profile();
                profile.setFirstName(rs.getString("firstname"));
                profile.setLastName(rs.getString("lastname"));
                staff.setProfile(profile);  // Gán thông tin profile cho nhân viên

                rd.setStaff(staff);

                // Lấy reserve_date từ bảng reservation
                LocalDateTime reserveDate = rs.getTimestamp("reserve_date").toLocalDateTime();
                Reservation r = new Reservation();
                r.setReverseDate(reserveDate);
                rd.setReservation(r);

                list.add(rd);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                db.connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public boolean assignStaff(int staff_id, int reservation_id) {
        DBContext db = new DBContext();
        String sql = "Update reservationdetail set staff_id = ? where id = ? ;";
        String sqldelete = "UPDATE reservationdetail SET staff_id = NULL WHERE id = ?;";

        try {
            if (staff_id != -1) {
                db.executeUpdate(sql, staff_id, reservation_id);
            } else {
                db.executeUpdate(sqldelete, reservation_id);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                db.connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            }
        }

        return true;
    }

    public boolean changeStatusReservationDetail(int status, int reservationDetailId) {
        DBContext db = new DBContext();
        String sql = "UPDATE reservationdetail SET status_id = ? WHERE id = ? ";

        try {
            db.executeUpdate(sql, status, reservationDetailId);
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                db.connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            }
        }
        return true;
    }

    public ArrayList<ReservationDetail> getListReservationDetail(int reservationId, int staffId) {
        DBContext db = new DBContext();
        String sql = "SELECT "
                + "rd.id, "
                + "s.name AS 'service', "
                + "rd.quantity, "
                + "rd.price, "
                + "rd.staff_id, "
                + "rd.status_id, "
                + "r.reserve_date, "
                + "p.firstname, "
                + "p.lastname "
                + "FROM reservationdetail rd "
                + "JOIN service s ON rd.service_id = s.id "
                + "JOIN reservation r ON rd.reservation_id = r.id "
                + "LEFT JOIN profile p ON rd.staff_id = p.userid "
                + "WHERE rd.reservation_id = ? "
                + "ORDER BY CASE WHEN rd.staff_id = ? THEN 0 ELSE 1 END, rd.id";

        ResultSet rs = null;
        ArrayList<ReservationDetail> list = new ArrayList<>();
        try {
            rs = db.executeQuery(sql, reservationId,staffId);

            while (rs.next()) {
                ReservationDetail rd = new ReservationDetail();
                rd.setId(rs.getInt("id"));
                Service service = new Service();
                service.setName(rs.getString("service"));
                rd.setService(service);
                rd.setQuantity(rs.getInt("quantity"));
                rd.setPrice(rs.getDouble("price"));

                ReservationDetailStatus status = new ReservationDetailStatus();
                status.setId(rs.getInt("status_id"));
                rd.setStatus(status);

                User staff = new User();
                staff.setId(rs.getInt("staff_id"));

                // Lấy thông tin firstName và lastName của nhân viên từ bảng profile
                Profile profile = new Profile();
                profile.setFirstName(rs.getString("firstname"));
                profile.setLastName(rs.getString("lastname"));
                staff.setProfile(profile);  // Gán thông tin profile cho nhân viên

                rd.setStaff(staff);

                // Lấy reserve_date từ bảng reservation
                LocalDateTime reserveDate = rs.getTimestamp("reserve_date").toLocalDateTime();
                Reservation r = new Reservation();
                r.setReverseDate(reserveDate);
                rd.setReservation(r);

                list.add(rd);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                db.connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ReservationDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

}
