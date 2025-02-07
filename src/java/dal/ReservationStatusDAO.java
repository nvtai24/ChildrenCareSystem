package dal;

import model.ReservationStatus;
import java.sql.*;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Nvtai
 */
public class ReservationStatusDAO  extends DBContext {
    
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
}
