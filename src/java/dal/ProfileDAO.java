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

        String query = "select p.firstname, p.lastname, p.gender, p.dob, p.address, p.phone, p.avatar, u.email\n"
                + "from profile p \n"
                + "join user u on p.userid = u.id where p.userid = ?";

        try {
            ResultSet rs = executeQuery(query, id);

            if (rs.next()) {
                User u = new User();
                u.setEmail(rs.getString("email"));

                Profile profile = new Profile().builder()
                        .avatar(rs.getString("avatar"))
                        .firstName(rs.getString("firstname"))
                        .lastName(rs.getString("lastname"))
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

    public void updateUserProfile(int id, String firstName, String lastName, String gender, String rawDob, String address, String phone, String avatarPath) {
        String query = "UPDATE `profile` SET `firstname` = ?, `lastname` = ?, `gender` = ?, `dob` = ?, `address` = ?, `phone` = ?, `avatar` = ? WHERE `userid` = ?";
        DBContext db = new DBContext();
        try {
            // Kiểm tra nếu ngày sinh bị null hoặc rỗng, thì lưu NULL vào database
            String formattedDob = (rawDob == null || rawDob.isEmpty()) ? null : rawDob;

            db.executeUpdate(query, firstName, lastName, gender.equals("male"), formattedDob, address, phone, avatarPath, id);
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
        String query = "INSERT INTO profile (userid, firstName, lastName, gender, dob, address, phone, avatar, created_date,updated_date) "
                + "VALUES (?, ?, ?,?, ?, ?, ?, ?, ?, ?)";

        try {
            executeUpdate(query,
                    profile.getUser().getId(),
                    profile.getFirstName(),
                    profile.getLastName(),
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

    public boolean saveProfile(Profile profile) {
        DBContext dbContext = new DBContext();
        String sql = "INSERT INTO profile (userid, firstname, lastname, gender, dob, address, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = dbContext.connection.prepareStatement(sql)) {
            ps.setInt(1, profile.getUser().getId());
            ps.setString(2, profile.getFirstName());
            ps.setString(3, profile.getLastName());
            ps.setBoolean(4, profile.isGender());
            ps.setDate(5, (Date) profile.getDob());
            ps.setString(6, profile.getAddress());
            ps.setString(7, profile.getPhone());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
