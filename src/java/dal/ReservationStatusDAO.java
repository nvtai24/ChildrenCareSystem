package dal;

import model.ReservationStatus;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Nvtai
 */
public class ReservationStatusDAO extends DBContext {

    public ReservationStatus getStatusById(int id) {

        String query = "SELECT * FROM reservationstatus WHERE id = ?";
        try (ResultSet rs = executeQuery(query, id)) {
            if (rs.next()) {
                return new ReservationStatus(rs.getInt("id"), rs.getString("status_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    public ArrayList<ReservationStatus> list() {
        DBContext db = new DBContext();
        String sql = "select id,status_name from reservationstatus";
        ResultSet rs = null;
        ArrayList<ReservationStatus> list = new ArrayList<>();

        try {
            rs = db.executeQuery(sql);
            while (rs.next()) {
                ReservationStatus reservationStatus = new ReservationStatus();
                reservationStatus.setId(rs.getInt("id"));
                reservationStatus.setStatusName(rs.getString("status_name"));

                list.add(reservationStatus);

            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationStatusDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }
}
