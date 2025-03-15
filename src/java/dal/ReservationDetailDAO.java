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
}
