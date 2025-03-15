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
import java.util.List;
import model.Profile;
import model.auth.Role;
import model.auth.User;
import java.sql.Timestamp;

public class UserDAO extends DBContext {

    private DBContext dbContext;

    public UserDAO() {
        dbContext = new DBContext();
    }

    public User get(String username, String password) {
        User user = null;
        PreparedStatement stm = null;
        try {
            String sql = "SELECT `id`, `username`, `password`, `status`, `email`, `role_id`, `email_verified` FROM `user` WHERE (`username` = ? OR `email` = ?) AND `password` = ?";
            stm = dbContext.connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, username);
            stm.setString(3, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                user = new User();
                if (rs.getInt("status") == 0) {
                    return null;
                }
                int id = rs.getInt("id");
                String email = rs.getString("email");
                int roleId = rs.getInt("role_id");
                boolean emailVerified = rs.getBoolean("email_verified");

                user.setId(id);
                user.setUsername(username);
                user.setEmail(email);
                user.setEmailVerified(emailVerified);

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
        String sql = "INSERT INTO `user` (`username`, `password`, `email` ,`role_id`, `verification_token`, `token_expiration`, `email_verified`) VALUES (?, ?, ?, 15, ?, ?, 0)";
        try (PreparedStatement ps = dbContext.connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getVerificationToken());
            ps.setTimestamp(5, new Timestamp(user.getTokenExpiration().getTime()));
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean register(User user, int role_Id) {
        String sql = "INSERT INTO `user` (`username`, `password`, `email` ,`role_id`, `verification_token`, `token_expiration`, `email_verified`) VALUES (?, ?, ?, ?, ?, ?, 0)";
        try (PreparedStatement ps = dbContext.connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, role_Id + "");
            ps.setString(5, user.getVerificationToken());
            ps.setTimestamp(6, new Timestamp(user.getTokenExpiration().getTime()));
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

    public boolean verifyEmail(String token) {
        String sql = "UPDATE `user` SET `email_verified` = 1, `verification_token` = NULL, `token_expiration` = NULL WHERE `verification_token` = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByToken(String token) {
        String sql = "SELECT * FROM `user` WHERE `verification_token` = ? AND `token_expiration` > NOW()";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setVerificationToken(rs.getString("verification_token"));
                user.setEmailVerified(rs.getBoolean("email_verified"));
                user.setTokenExpiration(rs.getTimestamp("token_expiration"));

                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT id, username, email, role_id, status FROM user WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setStatus(rs.getInt("status") == 1);

                Role role = new Role();
                role.setId(rs.getInt("role_id"));
                user.setRole(role);
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean generatePasswordResetToken(int userId, String token, Timestamp expirationTime) {
        String sql = "UPDATE user SET reset_token = ?, reset_token_expiration = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setTimestamp(2, expirationTime);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean resetPassword(String token, String newPassword) {
        String sql = "UPDATE user SET password = ?, reset_token = NULL, reset_token_expiration = NULL WHERE reset_token = ? AND reset_token_expiration > NOW()";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, token);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM user WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE user SET password = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<User> listAllUsersExcept(int idUser) {
        ArrayList<User> users = new ArrayList<>();

        String query = "select u.id"
                + ",u.username"
                + ",p.firstname"
                + ",p.lastname"
                + ",u.email"
                + ",u.role_id"
                + ",u.status"
                + ",u.created_date"
                + ",u.updated_date"
                + ",s.value "
                + "from user u join setting s on u.role_id = s.setting_id "
                + "join settingtype st on s.type_id = st.id "
                + "left join profile p on u.id = p.userid "
                + "where st.name = 'Role' AND u.id NOT LIKE ?";

        try {
            ResultSet rs = executeQuery(query, idUser);

            while (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                boolean status = rs.getInt("status") == 1;

                Timestamp createdTimestamp = rs.getTimestamp("created_date");
                Timestamp updatedTimestamp = rs.getTimestamp("updated_date");

                LocalDateTime createdDate = (createdTimestamp != null) ? createdTimestamp.toLocalDateTime() : null;
                LocalDateTime updatedDate = (updatedTimestamp != null) ? updatedTimestamp.toLocalDateTime() : null;

                int roleId = rs.getInt("role_id");
                String roleName = rs.getString("value");
                String firstname = rs.getString("firstname");
                String lastname = rs.getString("lastname");

                User u = new User().builder()
                        .id(userId)
                        .username(username)
                        .email(email)
                        .status(status)
                        .createdDate(createdDate)
                        .updatedDate(updatedDate)
                        .build();

                Role r = new Role();
                r.setId(roleId);
                r.setRoleName(roleName);
                u.setRole(r);

                Profile p = new Profile();
                p.setFirstName(firstname);
                p.setLastName(lastname);
                u.setProfile(p);

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

    public ArrayList<User> getListUserByStatusAndRole(int status, int roleId, int userId) {
        DBContext db = new DBContext();
        ArrayList<User> list = new ArrayList<>();
        String sql = "select u.id"
                + ",u.username"
                + ",p.firstname"
                + ",p.lastname"
                + ",u.email"
                + ",u.role_id"
                + ",u.status"
                + ",u.created_date"
                + ",u.updated_date"
                + ",s.value  "
                + "from user u "
                + "left join setting s on u.role_id = s.setting_id  "
                + "left join profile p on u.id = p.userid ";

        List<Object> params = new ArrayList<>();
        if (status != -1 || roleId != -1) {
            sql += " WHERE ";
            if (status != -1) {
                sql += " u.status = ? ";
                params.add(status);
            }
            if (roleId != -1) {
                if (!params.isEmpty()) {
                    sql += " AND ";
                }
                sql += " u.role_id = ? ";
                params.add(roleId);
            }
        }
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = db.connection.prepareStatement(sql);

            // Gán tham số động
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) instanceof Integer) {
                    ps.setInt(i + 1, (Integer) params.get(i));
                } else if (params.get(i) instanceof Integer) {
                    ps.setInt(i + 1, (Integer) params.get(i));
                }
            }

            // Thực thi truy vấn
            rs = ps.executeQuery();

            // Lặp qua kết quả
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("u.id"));
                u.setUsername(rs.getString("u.username"));
                u.setEmail(rs.getString("u.email"));
                u.setStatus(rs.getString("u.status").equalsIgnoreCase("1"));
                u.setCreatedDate(rs.getTimestamp("u.created_date").toLocalDateTime());

                Timestamp updatedTimestamp = rs.getTimestamp("updated_date");
                LocalDateTime updatedDate = (updatedTimestamp != null) ? updatedTimestamp.toLocalDateTime() : null;
                u.setUpdatedDate(updatedDate);
                Role r = new Role();
                r.setId(rs.getInt("u.role_id"));
                r.setRoleName(rs.getString("value"));

                Profile p = new Profile();
                p.setFirstName(rs.getString("p.firstname"));
                p.setLastName(rs.getString("p.lastname"));
                u.setProfile(p);

                u.setRole(r);
                if (u.getId() != userId) {
                    list.add(u);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<User> getUserBySearch(String title, int userId) {
        DBContext db = new DBContext();
        ArrayList<User> list = new ArrayList<>();
        String sql = "select u.id"
                + ",u.username"
                + ",p.firstname"
                + ",p.lastname"
                + ",u.email"
                + ",u.role_id"
                + ",u.status"
                + ",u.created_date"
                + ",u.updated_date"
                + ",s.value  "
                + "from user u "
                + "left join setting s on u.role_id = s.setting_id  "
                + "left join profile p on u.id = p.userid ";

        ResultSet rs = null;
        String titleValue = "";

        if (title != null && !title.trim().isEmpty()) {
            titleValue = "%" + title + "%";
            sql += " WHERE u.username LIKE ? "
                    + " OR u.email LIKE ? "
                    + " OR s.value LIKE ? "
                    + " OR p.firstname LIKE ? "
                    + " OR p.lastname LIKE ? ";
        }

        try {
            if (title != null && !title.trim().isEmpty()) {
                rs = db.executeQuery(sql, titleValue, titleValue, titleValue, titleValue, titleValue);
            } else {
                rs = db.executeQuery(sql);
            }

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setStatus(rs.getString("status").equalsIgnoreCase("1"));
                u.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
                Timestamp updatedTimestamp = rs.getTimestamp("updated_date");
                u.setUpdatedDate(updatedTimestamp != null ? updatedTimestamp.toLocalDateTime() : null);

                Role r = new Role();
                r.setId(rs.getInt("role_id"));
                r.setRoleName(rs.getString("value"));

                Profile p = new Profile();
                p.setFirstName(rs.getString("firstname"));
                p.setLastName(rs.getString("lastname"));
                u.setProfile(p);

                u.setRole(r);
                if (u.getId() != userId) {
                    list.add(u);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return list;
    }

    public void UpdateStatusByUser(int id, int status) {
        DBContext db = new DBContext();
        String sql = "Update user set status = ? where id = ? ";
        int changeStatus = (status == 1 ? 0 : 1);

        try {
            db.executeUpdate(sql, changeStatus, id);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                db.connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public User get(int idUser) {
        User user = null;
        PreparedStatement stm = null;
        try {
            String sql = "select u.id"
                    + ",u.username"
                    + ",p.firstname"
                    + ",p.lastname"
                    + ",u.email"
                    + ",u.role_id"
                    + ",u.status"
                    + ",u.created_date"
                    + ",u.updated_date"
                    + ",s.value as 'role_name' "
                    + ",p.address"
                    + ",p.avatar"
                    + ",p.dob"
                    + ",p.gender"
                    + ",p.phone\n"
                    + "from user u \n"
                    + "left join setting s on u.role_id = s.setting_id  \n"
                    + "left join profile p on u.id = p.userid where u.id = ?";
            stm = dbContext.connection.prepareStatement(sql);
            stm.setInt(1, idUser);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("u.id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));

                Role r = new Role();

                r.setId(rs.getInt("role_id"));
                r.setRoleName(rs.getString("role_name"));

                user.setRole(r);

                Profile p = new Profile();
                p.setFirstName(rs.getString("firstname"));
                p.setLastName(rs.getString("lastname"));
                p.setGender(rs.getInt("gender") == 1);
                p.setDob(rs.getDate("dob"));
                p.setAddress(rs.getString("address"));
                p.setPhone(rs.getString("phone"));
                p.setAvatar(rs.getString("avatar"));

                user.setProfile(p);
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
        return user;
    }

    public void updateRoleUser(int idUser, int roleId) {
        DBContext db = new DBContext();
        String sql = "UPDATE user SET role_id = ?, updated_date = ? WHERE id = ?";
        try {
            db.executeUpdate(sql, roleId, Timestamp.valueOf(LocalDateTime.now()), idUser);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public ArrayList<User> getCustomerList() {
        DBContext db = new DBContext();
        ArrayList<User> list = new ArrayList<>();
        String sql = "SELECT u.id, u.username, u.email, u.status,u.role_id "
                + ",r.value, "
                + "p.firstname, p.lastname, p.gender, p.dob, p.address, p.phone, p.avatar, "
                + "u.created_date, u.updated_date "
                + "FROM user u "
                + "JOIN setting r ON u.role_id = r.setting_id "
                + "LEFT JOIN profile p ON u.id = p.userid "
                + "WHERE r.value = 'customer';";

        ResultSet rs = null;
        try {
            rs = db.executeQuery(sql);
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setStatus(rs.getString("status") != null && rs.getString("status").equalsIgnoreCase("1"));
                u.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());

                Timestamp updatedTimestamp = rs.getTimestamp("updated_date");
                u.setUpdatedDate(updatedTimestamp != null ? updatedTimestamp.toLocalDateTime() : null);

                Role r = new Role();
                r.setId(rs.getInt("role_id"));
                r.setRoleName(rs.getString("value"));
                u.setRole(r);

                Profile p = new Profile();
                p.setFirstName(rs.getString("firstname"));
                p.setLastName(rs.getString("lastname"));
                p.setGender(rs.getString("gender") != null && rs.getString("gender").equalsIgnoreCase("1"));
                p.setDob(rs.getDate("dob"));
                p.setAddress(rs.getString("address"));
                p.setPhone(rs.getString("phone"));
                p.setAvatar(rs.getString("avatar"));

                u.setProfile(p);
                list.add(u); // Thêm đối tượng User vào danh sách
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (db.connection != null) {
                    db.connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<User> getCustomerListByStatus(int status) {
        DBContext db = new DBContext();
        ArrayList<User> list = new ArrayList<>();
        String sql = "SELECT u.id, u.username, u.email, u.status, "
                + "r.setting_id AS role_id, r.value, "
                + "p.firstname, p.lastname, p.gender, p.dob, p.address, p.phone, p.avatar, "
                + "u.created_date, u.updated_date "
                + "FROM user u "
                + "JOIN setting r ON u.role_id = r.setting_id "
                + "LEFT JOIN profile p ON u.id = p.userid "
                + "WHERE r.value = 'customer' ";

        if (status != -1) {
            sql += "AND u.status = ?"; // Điều kiện nếu status không phải -1
        }

        ResultSet rs = null;
        try {
            PreparedStatement ps = db.connection.prepareStatement(sql);
            if (status != -1) {
                ps.setInt(1, status); // Gán giá trị status nếu khác -1
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setStatus(rs.getString("status") != null && rs.getString("status").equalsIgnoreCase("1"));
                u.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());

                Timestamp updatedTimestamp = rs.getTimestamp("updated_date");
                u.setUpdatedDate(updatedTimestamp != null ? updatedTimestamp.toLocalDateTime() : null);

                Role r = new Role();
                r.setId(rs.getInt("role_id"));
                r.setRoleName(rs.getString("value"));
                u.setRole(r);

                Profile p = new Profile();
                p.setFirstName(rs.getString("firstname"));
                p.setLastName(rs.getString("lastname"));
                p.setGender(rs.getString("gender") != null && rs.getString("gender").equalsIgnoreCase("1"));
                p.setDob(rs.getDate("dob"));
                p.setAddress(rs.getString("address"));
                p.setPhone(rs.getString("phone"));
                p.setAvatar(rs.getString("avatar"));

                u.setProfile(p);
                list.add(u); // Thêm đối tượng User vào danh sách
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (db.connection != null) {
                    db.connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<User> searchCustomer(String searchTerm) {
        DBContext db = new DBContext();
        ArrayList<User> list = new ArrayList<>();
        String sql = "SELECT u.id, u.username, u.email, u.status, "
                + "r.setting_id AS role_id, r.value, "
                + "p.firstname, p.lastname, p.gender, p.dob, p.address, p.phone, p.avatar, "
                + "u.created_date, u.updated_date "
                + "FROM user u "
                + "JOIN setting r ON u.role_id = r.setting_id "
                + "LEFT JOIN profile p ON u.id = p.userid "
                + "WHERE r.value = 'customer' ";

        // Nếu searchTerm là null hoặc rỗng, không thêm điều kiện tìm kiếm
        if (searchTerm != null && !searchTerm.isEmpty()) {
            String searchTermValue = "%" + searchTerm + "%"; // Tạo điều kiện tìm kiếm với phần từ khóa

            // Thêm điều kiện tìm kiếm cho các trường id, firstname,lastname , phone, email ,username
            sql += "AND (u.id LIKE ? "
                    + "OR p.firstname LIKE ? "
                    + "OR p.lastname LIKE ? "
                    + "OR p.phone LIKE ? "
                    + "OR u.email LIKE ? "
                    + "OR u.username LIKE ?)";
        }

        ResultSet rs = null;

        try {
            PreparedStatement ps = db.connection.prepareStatement(sql);

            if (searchTerm != null && !searchTerm.isEmpty()) {
                String searchTermValue = "%" + searchTerm + "%"; // Tạo điều kiện tìm kiếm với phần từ khóa
                ps.setString(1, searchTermValue);  // Gán điều kiện tìm kiếm cho id
                ps.setString(2, searchTermValue); // Gán điều kiện tìm kiếm cho firstname
                ps.setString(3, searchTermValue);// Gán điều kiện tìm kiếm cho lastname
                ps.setString(4, searchTermValue);  // Gán điều kiện tìm kiếm cho phone
                ps.setString(5, searchTermValue);  // Gán điều kiện tìm kiếm cho email
                ps.setString(6, searchTermValue);  // Gán điều kiện tìm kiếm cho username
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setStatus(rs.getString("status") != null && rs.getString("status").equalsIgnoreCase("1"));
                u.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());

                Timestamp updatedTimestamp = rs.getTimestamp("updated_date");
                u.setUpdatedDate(updatedTimestamp != null ? updatedTimestamp.toLocalDateTime() : null);

                Role r = new Role();
                r.setId(rs.getInt("role_id"));
                r.setRoleName(rs.getString("value"));
                u.setRole(r);

                Profile p = new Profile();
                p.setFirstName(rs.getString("firstname"));
                p.setLastName(rs.getString("lastname"));
                p.setGender(rs.getString("gender") != null && rs.getString("gender").equalsIgnoreCase("1"));
                p.setDob(rs.getDate("dob"));
                p.setAddress(rs.getString("address"));
                p.setPhone(rs.getString("phone"));
                p.setAvatar(rs.getString("avatar"));

                u.setProfile(p);
                list.add(u); // Thêm đối tượng User vào danh sách
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (db.connection != null) {
                    db.connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public boolean saveProfile(Profile profile) {
        String sql = "INSERT INTO profile (userid, firstname, lastname, gender, dob, address, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = dbContext.connection.prepareStatement(sql)) {
            ps.setInt(1, profile.getUser().getId());
            ps.setString(2, profile.getFirstName());
            ps.setString(3, profile.getLastName());
            ps.setBoolean(4, profile.isGender());
            ps.setDate(5, (java.sql.Date) profile.getDob());
            ps.setString(6, profile.getAddress());
            ps.setString(7, profile.getPhone());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public void createUser(String email, String username, String password) {
        String query = "INSERT INTO user (username, password, email, email_verified, role_id, status) VALUES (?, ?, ?, 1, 15, 1)";
        try {
            executeUpdate(query, username, password, email);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> getLatestFiveUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT u.username, u.email, p.avatar\n"
                + "FROM user u\n"
                + "JOIN profile p ON u.id = p.userid\n"
                + "WHERE u.status = 1 \n"
                + "AND u.role_id IN (2, 3, 4) \n"
                + "AND DATE(u.created_date) >= DATE(NOW()) - INTERVAL 7 DAY\n"
                + "ORDER BY u.created_date DESC \n"
                + "LIMIT 5;";

        try {
            ResultSet rs = executeQuery(query);
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setAvatar(rs.getString("avatar")); 
                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

}
