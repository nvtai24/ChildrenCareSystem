/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Service;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nvtai
 */
public class ServiceDAO extends DBContext {

    public ArrayList<Service> list() {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();
        String sql = "select id,category_id,name,description,brief_info,price,discount,thumbnail,status\n"
                + "from service;";

        try {

            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                // Get attribute into object.
                Service s = new Service();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setBriefInfo(rs.getString("brief_info"));
                s.setPrice(rs.getDouble("price"));
                s.setDiscount(rs.getDouble("discount"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setStatus(rs.getDouble("status"));

                // Get service into list 
                list.add(s);

            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<Service> getListByName(String nameService) {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();

        // Sử dụng LIKE để tìm kiếm tên dịch vụ với ký tự đại diện "%"
        String sql = "SELECT id, category_id, name, description, brief_info, price, discount, thumbnail, status FROM service WHERE name LIKE ?";

        try {
            // Thêm dấu "%" vào tên dịch vụ để tìm kiếm theo chuỗi
            nameService = "%" + nameService + "%";

            ResultSet rs = db.executeQuery(sql, nameService);

            while (rs.next()) {
                // Lấy thông tin và thêm vào danh sách
                Service s = new Service();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setBriefInfo(rs.getString("brief_info"));
                s.setPrice(rs.getDouble("price"));
                s.setDiscount(rs.getDouble("discount"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setStatus(rs.getDouble("status"));

                list.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                db.connection.close(); // Đảm bảo đóng kết nối sau khi sử dụng
            } catch (SQLException ex) {
                Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<Service> getListByStatus(double status) {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();
        String sql = "SELECT id, category_id, name, description, brief_info, price, discount, thumbnail, status FROM service";

        if (status != -1) {
            sql += " WHERE status = ?";
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            ps = db.connection.prepareStatement(sql);

            // Nếu cần, set tham số cho truy vấn
            if (status != -1) {
                ps.setDouble(1, status);
            }

            // Thực thi truy vấn
            rs = ps.executeQuery();

            // Duyệt qua kết quả
            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setBriefInfo(rs.getString("brief_info"));
                s.setPrice(rs.getDouble("price"));
                s.setDiscount(rs.getDouble("discount"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setStatus(rs.getDouble("status"));

                list.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                // Đóng ResultSet và PreparedStatement nếu chúng không null
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<Service> getServiceListBySortByOrder(String field, boolean order, double status) {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();

        String sql = "SELECT id, category_id, name, description, brief_info, price, discount, thumbnail, status FROM service";

        // Nếu status không phải là -1, thêm điều kiện WHERE
        if (status != -1) {
            sql += " WHERE status = ?";
        }

        // Thêm phần sắp xếp theo field và order
        sql += " ORDER BY " + field + (order ? " ASC" : " DESC");

        ResultSet rs = null;
        try {
            // Sử dụng PreparedStatement để truyền tham số vào câu lệnh
            PreparedStatement stmt = db.connection.prepareStatement(sql);

            // Nếu status không phải là -1, gán giá trị cho tham số
            if (status != -1) {
                stmt.setDouble(1, status);
            }

            rs = stmt.executeQuery();

            // Duyệt qua kết quả và ánh xạ vào đối tượng Service
            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setBriefInfo(rs.getString("brief_info"));
                s.setPrice(rs.getDouble("price"));
                s.setDiscount(rs.getDouble("discount"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setStatus(rs.getDouble("status"));

                list.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                // Đóng ResultSet và PreparedStatement nếu chúng không null
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public void updateStatusById(int id) {
        DBContext db = new DBContext();
        String sql_select = "select * from service where id = ?;";
        String sql_update = "UPDATE Service SET status = ? WHERE id = ?";

        ResultSet rs = null;

        try {
            db.connection.prepareStatement(sql_select);

            rs = db.executeQuery(sql_select, id);
            int check = 0;
            if (rs.next()) {
                check = rs.getInt("status");
            }

            if (check == 1) {
                db.executeUpdate(sql_update, 0, id);
            } else {
                db.executeUpdate(sql_update, 1, id);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }

            } catch (SQLException ex) {
                Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    public void createService(Service service) {
        DBContext db = new DBContext();
        String sql = "INSERT INTO service (name, description, brief_info, price, discount, thumbnail, status) "
                + "VALUES ( ?, ?, ?, ?, ?, ?, ?)";

        try {
            db.executeUpdate(sql, service.getName(), service.getName(), service.getBriefInfo(), service.getPrice(), service.getDiscount(), service.getThumbnail(), service.getStatus());
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                db.connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

}
