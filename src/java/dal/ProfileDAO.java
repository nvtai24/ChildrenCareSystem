/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Profile;
import java.sql.*;
import java.time.LocalDateTime;
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

    public void updateUserProfile(int id, String fullname, String gender, String rawDob, String address, String phone, String avatarPath) {
        String query = "UPDATE `profile` SET `full_name` = ?, `gender` = ?, `dob` = ?, `address` = ?, `phone` = ?, `avatar` = ? WHERE `userid` = ?";
        DBContext db = new DBContext();
        try {
            // Kiểm tra nếu ngày sinh bị null hoặc rỗng, thì lưu NULL vào database
            String formattedDob = (rawDob == null || rawDob.isEmpty()) ? null : rawDob;

            db.executeUpdate(query, fullname, gender.equals("male"), formattedDob, address, phone, avatarPath, id);
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

    public boolean existsProfile(int userId) {
        String query = "SELECT COUNT(*) FROM profile WHERE userid = ?";
        DBContext db = new DBContext();
        try {

            ResultSet rs = db.executeQuery(query, userId);

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean createProfile(Profile profile) {
        String query = "INSERT INTO profile (userid, full_name, gender, dob, address, phone, avatar, created_date,updated_date) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            executeUpdate(query,
                    profile.getUser().getId(),
                    profile.getFullName(),
                    profile.isGender() ? "1" : "0", // Chuyển boolean thành String ("1" cho nam, "0" cho nữ)
                    profile.getDob(),
                    profile.getAddress(),
                    profile.getPhone(),
                    profile.getAvatar(),
                    Timestamp.valueOf(LocalDateTime.now()), // created_date
                    Timestamp.valueOf(LocalDateTime.now()) // updated_date

            );
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
