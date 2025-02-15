/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.util.Date;
import model.auth.Role;
import model.auth.User;

public class UserDAO extends DBContext {

    private DBContext dbContext;

    public UserDAO() {
        dbContext = new DBContext();
    }

    public User get(String username, String password) {
        User user = null;
        PreparedStatement stm = null;
        try {
            String sql = "SELECT `id`, `username`, `password`, `email`, `role_id` FROM `user` WHERE `username` = ? AND `password` = ?";
            stm = dbContext.connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                user = new User();
                int id = rs.getInt("id");
                String email = rs.getString("email");
                int roleId = rs.getInt("role_id");

                user.setId(id);
                user.setUsername(username);
                user.setEmail(email);

                Role r = new Role();
                r.setId(roleId);
                user.setRole(r);
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

    public ArrayList<User> listAllUsers() {
        ArrayList<User> users = new ArrayList<>();

        String query = "SELECT \n"
                + "    u.id,\n"
                + "    u.username,\n"
                + "    u.email,\n"
                + "    r.role_name,\n"
                + "    u.status,\n"
                + "    u.created_date,\n"
                + "    u.updated_date\n"
                + "FROM\n"
                + "    user u\n"
                + "        JOIN\n"
                + "    role r ON u.role_id = r.id";

        try {
            ResultSet rs = executeQuery(query);

            while (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                boolean status = rs.getInt("status") == 1;
                LocalDateTime createdDate = rs.getTimestamp("created_date").toLocalDateTime();
                LocalDateTime updatedDate = rs.getTimestamp("updated_date").toLocalDateTime();
                String roleName = rs.getString("role_name");

                User u = new User().builder()
                        .id(userId)
                        .username(username)
                        .email(email)
                        .status(status)
                        .createdDate(createdDate)
                        .updatedDate(updatedDate)
                        .build();

                Role r = new Role();
                r.setRoleName(roleName);
                u.setRole(r);
                
                users.add(u);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return users;
    }
}
