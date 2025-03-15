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
import java.util.logging.Level;
import java.util.logging.Logger;
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
        String sql = "select "
                + "s.name as 'service'"
                + ", rd.quantity "
                + ", rd.price "
                + ", rd.staff_id "
                + "from reservationdetail rd "
                + "join service s ON rd.service_id = s.id "
                + "WHERE rd.reservation_id = ?";

        ResultSet rs = null;
        ArrayList<ReservationDetail> list = new ArrayList<>();
        try {
            rs = db.executeQuery(sql, reservationId);

            while (rs.next()) {
                ReservationDetail rd = new ReservationDetail();
                Service service = new Service();
                service.setName(rs.getString("service"));
                rd.setService(service);
                rd.setQuantity(rs.getInt("quantity"));
                rd.setPrice(rs.getDouble("price"));

                User staff = new User();
                staff.setId(rs.getInt("staff_id"));
                rd.setStaff(staff);

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
