/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Profile;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class ProfileDAO extends DBContext {

    public Profile getProfileByUserId(int id) {

        String query = "select p.full_name, p.gender, p.dob, p.address, p.phone, p.avatar, u.email\n"
                + "from profile p \n"
                + "join user u on p.userid = u.id where p.userid = ?";

        try {
            ResultSet rs = executeQuery(query, id);

            if (rs.next()) {
                User u = new User();
                u.setEmail(rs.getString("email"));

                Profile profile = new Profile().builder()
                        .avatar(rs.getString("avatar"))
                        .fullName(rs.getString("full_name"))
                        .gender(rs.getBoolean("gender"))
                        .dob(rs.getDate("dob"))
                        .address(rs.getString("address"))
                        .phone(rs.getString("phone"))
                        .user(u)
                        .build();
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

    public void updateUserProfile(int id, String fullname, String gender, String raw_dob, String address, String phone,
            String avatarPath) {
        String query = "UPDATE `profile`\n"
                + "SET\n"
                + "`full_name` = ?,\n"
                + "`gender` = ?,\n"
                + "`dob` = ?,  \n"
                + "`address` = ?,\n"
                + "`phone` = ?,\n"
                + "`avatar` = ?\n"
                + "WHERE `userid` = ?";

        try {
            executeUpdate(query, fullname, gender.equals("male"), Date.valueOf(raw_dob), address, phone, avatarPath,
                    id);
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
