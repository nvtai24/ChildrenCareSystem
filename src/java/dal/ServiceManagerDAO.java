/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Service;
import java.sql.*;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

/**
 *
 * @author Nvtai
 */
public class ServiceManagerDAO extends DBContext {

    public boolean checkServiceName(String name) {
        DBContext db = new DBContext();
        String sql = "select name from service;";
        try {

            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                String nameService = rs.getString("name");
                if (nameService.equalsIgnoreCase(name)) {
                    return true;
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public Service getServiceByID(int id) {
        DBContext db = new DBContext();
        Service s = new Service();
        String sql = "Select s.id,s.category_id,c.value,s.name,s.description,s.brief_info,s.price,s.discount,s.thumbnail,s.status \n"
                + "from service s join setting c on s.category_id = c.setting_id WHERE s.id = ?; ";

        try {

            ResultSet rs = db.executeQuery(sql, id);
            while (rs.next()) {
                // Get attribute into object.                
                s.setId(rs.getInt("s.id"));

                Category c = new Category();
                c.setId(rs.getInt("category_id"));
                c.setName(rs.getString("c.value"));
                s.setCategory(c);
                s.setName(rs.getString("s.name"));

                s.setDescription(rs.getString("s.description"));
                s.setBriefInfo(rs.getString("s.brief_info"));
                s.setPrice(rs.getDouble("s.price"));
                s.setDiscount(rs.getDouble("s.discount"));
                s.setThumbnail(rs.getString("s.thumbnail"));
                s.setStatus(rs.getDouble("s.status"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return s;

    }

    public ArrayList<Service> list() {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();
        String sql = "select s.id,s.category_id,c.value,s.name,s.description,s.brief_info,s.price,s.discount,s.thumbnail,s.status \n"
                + "from service s join setting c on s.category_id = c.setting_id; ";

        try {

            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                // Get attribute into object.
                Service s = new Service();
                s.setId(rs.getInt("s.id"));
                Category c = new Category();
                c.setName(rs.getString("c.value"));
                s.setCategory(c);
                s.setName(rs.getString("s.name"));
                s.setDescription(rs.getString("s.description"));
                s.setBriefInfo(rs.getString("s.brief_info"));
                s.setPrice(rs.getDouble("s.price"));
                s.setDiscount(rs.getDouble("s.discount"));
                s.setThumbnail(rs.getString("s.thumbnail"));
                s.setStatus(rs.getDouble("s.status"));

                // Get service into list 
                list.add(s);

            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<Service> getListByCategoryId(int id) {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();

        String sql = "select s.id,s.category_id,c.value,s.name,s.description,s.brief_info,s.price,s.discount,s.thumbnail,s.status \n"
                + "from service s join setting c on s.category_id = c.setting_id ";
        if (id != -1) {
            sql += "WHERE s.category_id = ?";
        }

        try {

            ResultSet rs = null;

            if (id != -1) {
                rs = db.executeQuery(sql, id);
            } else {
                rs = db.executeQuery(sql);
            }

            while (rs.next()) {
                // Lấy thông tin và thêm vào danh sách
                Service s = new Service();
                s.setId(rs.getInt("s.id"));
                Category c = new Category();
                c.setName(rs.getString("c.value"));
                s.setCategory(c);
                s.setName(rs.getString("s.name"));
                s.setDescription(rs.getString("s.description"));
                s.setBriefInfo(rs.getString("s.brief_info"));
                s.setPrice(rs.getDouble("s.price"));
                s.setDiscount(rs.getDouble("s.discount"));
                s.setThumbnail(rs.getString("s.thumbnail"));
                s.setStatus(rs.getDouble("s.status"));

                list.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                db.connection.close(); // Đảm bảo đóng kết nối sau khi sử dụng
            } catch (SQLException ex) {
                Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    // get list by info and name 
    public ArrayList<Service> getListByName(String nameService) {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();

        // Sử dụng LIKE để tìm kiếm tên dịch vụ với ký tự đại diện "%"
        String sql = "select s.id,s.category_id,c.value,s.name,s.description,s.brief_info,s.price,s.discount,s.thumbnail,s.status \n"
                + "from service s join setting c on s.category_id = c.setting_id WHERE s.name LIKE ? OR s.brief_info LIKE ? ;";

        try {
            // Thêm dấu "%" vào tên dịch vụ để tìm kiếm theo chuỗi
            nameService = "%" + nameService + "%";

            ResultSet rs = db.executeQuery(sql, nameService, nameService);

            while (rs.next()) {
                // Lấy thông tin và thêm vào danh sách
                Service s = new Service();
                s.setId(rs.getInt("s.id"));
                Category c = new Category();
                c.setName(rs.getString("c.value"));
                s.setCategory(c);
                s.setName(rs.getString("s.name"));
                s.setDescription(rs.getString("s.description"));
                s.setBriefInfo(rs.getString("s.brief_info"));
                s.setPrice(rs.getDouble("s.price"));
                s.setDiscount(rs.getDouble("s.discount"));
                s.setThumbnail(rs.getString("s.thumbnail"));
                s.setStatus(rs.getDouble("s.status"));

                list.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                db.connection.close(); // Đảm bảo đóng kết nối sau khi sử dụng
            } catch (SQLException ex) {
                Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<Service> getListByStatusAndCategory(double status, int categoryId) {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();
        String sql = "SELECT s.id, s.category_id, c.value AS category_name, s.name, s.description, "
                + "s.brief_info, s.price, s.discount, s.thumbnail, s.status "
                + "FROM service s "
                + "JOIN setting c ON s.category_id = c.setting_id";

        // Danh sách tham số
        List<Object> params = new ArrayList<>();
        if (status != -1 || categoryId != -1) {
            sql += " WHERE ";
            if (status != -1) {
                sql += " s.status = ? ";
                params.add(status);
            }
            if (categoryId != -1) {
                if (!params.isEmpty()) {
                    sql += " AND ";
                }
                sql += " s.category_id = ? ";
                params.add(categoryId);
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
                } else if (params.get(i) instanceof Double) {
                    ps.setDouble(i + 1, (Double) params.get(i));
                }
            }

            // Thực thi truy vấn
            rs = ps.executeQuery();

            // Lặp qua kết quả
            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("id"));

                Category c = new Category();
                c.setName(rs.getString("category_name")); // Lấy tên category
                s.setCategory(c);

                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setBriefInfo(rs.getString("brief_info"));
                s.setPrice(rs.getDouble("price"));
                s.setDiscount(rs.getDouble("discount"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setStatus(rs.getDouble("status")); // Giữ nguyên kiểu `double`

                list.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public ArrayList<Service> getListByStatus(double status) {
        DBContext db = new DBContext();
        ArrayList<Service> list = new ArrayList<>();
        String sql = "select s.id,s.category_id,c.value,s.name,s.description,s.brief_info,s.price,s.discount,s.thumbnail,s.status \n"
                + "from service s join setting c on s.category_id = c.setting_id";

        if (status != -1) {
            sql += " WHERE s.status = ?";
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
                // Lấy thông tin và thêm vào danh sách
                Service s = new Service();
                s.setId(rs.getInt("s.id"));
                Category c = new Category();
                c.setName(rs.getString("c.value"));
                s.setCategory(c);
                s.setName(rs.getString("s.name"));
                s.setDescription(rs.getString("s.description"));
                s.setBriefInfo(rs.getString("s.brief_info"));
                s.setPrice(rs.getDouble("s.price"));
                s.setDiscount(rs.getDouble("s.discount"));
                s.setThumbnail(rs.getString("s.thumbnail"));
                s.setStatus(rs.getDouble("s.status"));

                list.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

    public boolean updateStatusById(int id) {
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
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {

                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return true;
    }

    public boolean createService(Service service) {
        DBContext db = new DBContext();
        String sql = "INSERT INTO service (name, category_id, description, brief_info, price, discount, thumbnail, status) "
                + "VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            db.executeUpdate(sql, service.getName(), service.getCategory().getId(), service.getDescription(), service.getBriefInfo(), service.getPrice(), service.getDiscount(), service.getThumbnail(), service.getStatus());
        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                db.connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return true;
    }

    public void updateService(Service s) {
        DBContext db = new DBContext();
        String sql = "update service \n"
                + "set category_id = ?,\n"
                + "	name = ?,\n"
                + "    description = ?,\n"
                + "    brief_info = ?,\n"
                + "	price = ?,\n"
                + "    discount = ?,  \n"
                + "    thumbnail = ?,\n"
                + "    status = ?\n"
                + "WHERE id = ?;";

        try {
            db.executeUpdate(sql, s.getCategory().getId(), s.getName(), s.getDescription(),
                    s.getBriefInfo(), s.getPrice(), s.getDiscount(), s.getThumbnail(), s.getStatus(), s.getId());

        } catch (SQLException ex) {
            Logger.getLogger(ServiceManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
