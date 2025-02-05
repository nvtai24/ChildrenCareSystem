/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Profile;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nvtai
 */
public class ProfileDAO extends DBContext {

    public Profile getProfileByUserId(int id) {

        String query = "SELECT `userid`,`full_name`, `gender`, `dob`, `address`, `phone`, `avatar`, `created_date`, `updated_date`\n"
                + "FROM `profile` where userid = ?";

        try {
            ResultSet rs = executeQuery(query, id);

            if (rs.next()) {
                Profile profile = new Profile();

                profile.setFullName(rs.getString("full_name"));
                profile.setGender(rs.getBoolean("gender"));
                profile.setDob(rs.getDate("dob"));
                profile.setAddress(rs.getString("address"));
                profile.setPhone(rs.getString("phone"));
                profile.setAvatar(rs.getString("avatar"));

                return profile;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

}
