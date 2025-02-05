/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import model.auth.User;

public class UserDAO {

    private DBContext dbContext;

    public UserDAO() {
        dbContext = new DBContext();

    }

    public User get(String username, String password) {
        User user = null;

        String sql = "SELECT `username`, `password` FROM `user` WHERE `username` = ? AND `password` = ?";
        try (ResultSet rs = dbContext.executeQuery(sql, username, password)) {
            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO `user` (`username`, `password`, `email`, `verification_token`, `verified`) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = dbContext.connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); 
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getVerificationToken());
            ps.setBoolean(5, false);  // Mặc định chưa xác minh
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean checkUsernameExists(String username) {
        String sql = "SELECT `username` FROM `user` WHERE `username` = ?";
        try (PreparedStatement ps = dbContext.connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            boolean exists = rs.next();
            rs.close();
            return exists;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean checkEmailExists(String email) {
        String sql = "SELECT `email` FROM `user` WHERE `email` = ?";
        try (PreparedStatement ps = dbContext.connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            boolean exists = rs.next();
            rs.close();
            return exists;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean verifyUser(String token) {
        String sql = "UPDATE `user` SET `verified` = true WHERE `verification_token` = ?";
        try (PreparedStatement ps = dbContext.connection.prepareStatement(sql)) {
            ps.setString(1, token);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
