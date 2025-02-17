/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Service;

/**
 *
 * @author Nvtai
 */
public class ServiceDAO extends DBContext {

    public List<Service> getAllAvailableServices() {
        List<Service> result = new ArrayList<>();

        String query = "SELECT `service`.`id`,\n"
                + "    `service`.`category_id`,\n"
                + "    `service`.`name`,\n"
                + "    `service`.`description`,\n"
                + "    `service`.`brief_info`,\n"
                + "    `service`.`price`,\n"
                + "    `service`.`discount`,\n"
                + "    `service`.`thumbnail`,\n"
                + "    `service`.`created_date`,\n"
                + "    `service`.`updated_date`\n"
                + "FROM `childrencare`.`service` where status = 1"
                + "ORDER BY GREATEST(`service`.`created_date`, COALESCE(`service`.`updated_date`, '1970-01-01')) DESC\n";

        try {
            ResultSet rs = executeQuery(query);

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String brief = rs.getString("brief_info");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                String thumbnail = rs.getString("thumbnail");
                LocalDateTime created = rs.getTimestamp("created_date").toLocalDateTime();
                Timestamp updated = rs.getTimestamp("updated_date");
                int cid = rs.getInt("category_id");

                Service s = new Service();
                s.setId(id);
                s.setName(name);
                s.setBriefInfo(brief);
                s.setDescription(description);
                s.setPrice(price);
                s.setDiscount(discount);
                s.setThumbnail(thumbnail);
                s.setCreatedDate(created);

                CategoryDAO cDB = new CategoryDAO();
                Category c = cDB.getCategoryById(cid);
                s.setCategory(c);

                if (updated != null) {
                    s.setUpdatedDate(updated.toLocalDateTime());
                }

                result.add(s);
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

        return result;
    }

    public List<Service> getAllAvailableServicesByInfo(String info) {
        List<Service> result = new ArrayList<>();

        String query = "SELECT `service`.`id`,\n"
                + "    `service`.`category_id`,\n"
                + "    `service`.`name`,\n"
                + "    `service`.`description`,\n"
                + "    `service`.`brief_info`,\n"
                + "    `service`.`price`,\n"
                + "    `service`.`discount`,\n"
                + "    `service`.`thumbnail`,\n"
                + "    `service`.`created_date`,\n"
                + "    `service`.`updated_date`\n"
                + "FROM `childrencare`.`service` where status = 1 and (name like ? or description like ? or brief_info like ?)"
                + "ORDER BY GREATEST(`service`.`created_date`, COALESCE(`service`.`updated_date`, '1970-01-01')) DESC\n";

        try {

            String searchParam = "%" + info + "%";

            ResultSet rs = executeQuery(query, searchParam, searchParam, searchParam);

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String brief = rs.getString("brief_info");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                String thumbnail = rs.getString("thumbnail");
                LocalDateTime created = rs.getTimestamp("created_date").toLocalDateTime();
                Timestamp updated = rs.getTimestamp("updated_date");
                int cid = rs.getInt("category_id");

                Service s = new Service();
                s.setId(id);
                s.setName(name);
                s.setBriefInfo(brief);
                s.setDescription(description);
                s.setPrice(price);
                s.setDiscount(discount);
                s.setThumbnail(thumbnail);
                s.setCreatedDate(created);

                CategoryDAO cDB = new CategoryDAO();
                Category c = cDB.getCategoryById(cid);
                s.setCategory(c);

                if (updated != null) {
                    s.setUpdatedDate(updated.toLocalDateTime());
                }

                result.add(s);
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

        return result;
    }

    public List<Service> getAllAvailableServicesByCategoryId(int cid) {
        List<Service> result = new ArrayList<>();

        String query = "SELECT `service`.`id`,\n"
                + "    `service`.`category_id`,\n"
                + "    `service`.`name`,\n"
                + "    `service`.`description`,\n"
                + "    `service`.`brief_info`,\n"
                + "    `service`.`price`,\n"
                + "    `service`.`discount`,\n"
                + "    `service`.`thumbnail`,\n"
                + "    `service`.`created_date`,\n"
                + "    `service`.`updated_date`\n"
                + "FROM `childrencare`.`service` \n"
                + "WHERE status = 1 AND category_id = ? \n"
                + "ORDER BY GREATEST(`service`.`created_date`, COALESCE(`service`.`updated_date`, '1970-01-01')) DESC";

        try {

            ResultSet rs = executeQuery(query, cid);

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String brief = rs.getString("brief_info");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                String thumbnail = rs.getString("thumbnail");
                LocalDateTime created = rs.getTimestamp("created_date").toLocalDateTime();
                Timestamp updated = rs.getTimestamp("updated_date");

                Service s = new Service();
                s.setId(id);
                s.setName(name);
                s.setBriefInfo(brief);
                s.setDescription(description);
                s.setPrice(price);
                s.setDiscount(discount);
                s.setThumbnail(thumbnail);
                s.setCreatedDate(created);

                CategoryDAO cDB = new CategoryDAO();
                Category c = cDB.getCategoryById(cid);
                s.setCategory(c);

                if (updated != null) {
                    s.setUpdatedDate(updated.toLocalDateTime());
                }

                result.add(s);
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

        return result;
    }

    public List<Service> getThreeRecentServices() {
        List<Service> result = new ArrayList<>();

        String query = "SELECT `service`.`id`,\n"
                + "       `service`.`category_id`,\n"
                + "       `service`.`name`,\n"
                + "       `service`.`description`,\n"
                + "       `service`.`brief_info`,\n"
                + "       `service`.`price`,\n"
                + "       `service`.`discount`,\n"
                + "       `service`.`thumbnail`,\n"
                + "       `service`.`status`,\n"
                + "       `service`.`created_date`,\n"
                + "       `service`.`updated_date`\n"
                + "FROM `childrencare`.`service`\n"
                + "WHERE status = 1\n"
                + "ORDER BY GREATEST(`service`.`created_date`, COALESCE(`service`.`updated_date`, '1970-01-01')) DESC\n"
                + "LIMIT 3;";

        try {

            ResultSet rs = executeQuery(query);

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String brief = rs.getString("brief_info");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                String thumbnail = rs.getString("thumbnail");
                LocalDateTime created = rs.getTimestamp("created_date").toLocalDateTime();
                Timestamp updated = rs.getTimestamp("updated_date");
                int cid = rs.getInt("category_id");

                Service s = new Service();
                s.setId(id);
                s.setName(name);
                s.setBriefInfo(brief);
                s.setDescription(description);
                s.setPrice(price);
                s.setDiscount(discount);
                s.setThumbnail(thumbnail);
                s.setCreatedDate(created);

                CategoryDAO cDB = new CategoryDAO();
                Category c = cDB.getCategoryById(cid);
                s.setCategory(c);

                if (updated != null) {
                    s.setUpdatedDate(updated.toLocalDateTime());
                }

                result.add(s);
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

        return result;
    }

    public Service getServiceById(int id) {
        Service s = null;

        String query = "SELECT `service`.`category_id`,\n"
                + "    `service`.`name`,\n"
                + "    `service`.`description`,\n"
                + "    `service`.`brief_info`,\n"
                + "    `service`.`price`,\n"
                + "    `service`.`discount`,\n"
                + "    `service`.`thumbnail`,\n"
                + "    `service`.`created_date`,\n"
                + "    `service`.`updated_date`\n"
                + "FROM `childrencare`.`service` where id = ?";

        try {
            ResultSet rs = executeQuery(query, id);

            if (rs.next()) {
                String name = rs.getString("name");
                String description = rs.getString("description");
                String brief = rs.getString("brief_info");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                String thumbnail = rs.getString("thumbnail");
                LocalDateTime created = rs.getTimestamp("created_date").toLocalDateTime();
                LocalDateTime updated = rs.getTimestamp("updated_date").toLocalDateTime();

                int cid = rs.getInt("category_id");

                s = new Service();
                s.setId(id);
                s.setName(name);
                s.setBriefInfo(brief);
                s.setDescription(description);
                s.setPrice(price);
                s.setDiscount(discount);
                s.setThumbnail(thumbnail);
                s.setCreatedDate(created);
                s.setUpdatedDate(updated);

                CategoryDAO cDB = new CategoryDAO();
                Category c = cDB.getCategoryById(cid);
                s.setCategory(c);

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

        return s;
    }

    public List<Service> getAllAvailableServicesWithPagination(int page, int pageSize) {
        List<Service> result = new ArrayList<>();
        String query = "SELECT id, category_id, name, description, brief_info, price, discount, thumbnail, status, created_date, updated_date "
                + "FROM childrencare.service WHERE status = 1 "
                + "ORDER BY GREATEST(`service`.`created_date`, COALESCE(`service`.`updated_date`, '1970-01-01')) DESC\n"
                + "LIMIT ? OFFSET ?";

        try {

            ResultSet rs = executeQuery(query, pageSize, (page - 1) * pageSize); // Offset để lấy dữ liệu cho trang hiện
            // tại
            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setBriefInfo(rs.getString("brief_info"));
                s.setPrice(rs.getDouble("price"));
                s.setDiscount(rs.getDouble("discount"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setStatus(rs.getInt("status"));
                s.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());

                int cid = rs.getInt("category_id");
                CategoryDAO cDB = new CategoryDAO();
                Category c = cDB.getCategoryById(cid);
                s.setCategory(c);

                Timestamp updated = rs.getTimestamp("updated_date");
                if (updated != null) {
                    s.setUpdatedDate(updated.toLocalDateTime());
                }

                result.add(s);
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
        return result;
    }

    public int countAllAvailableServices() {
        int result = 0;

        String query = "SELECT COUNT(*) AS total FROM childrencare.service WHERE status = 1";
        try {
            ResultSet rs = executeQuery(query);

            if (rs.next()) {
                result = rs.getInt("total");
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
        return result;
    }

    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String query = "SELECT * FROM childrencare.service WHERE status = 1";

        try {
            ResultSet rs = executeQuery(query);
            while (rs.next()) {
                // Tạo đối tượng Service"id"));
                Service service = new Service();
                service.setName(rs.getString("name"));
                service.setId(rs.getInt("id"));
                service.setDescription(rs.getString("description"));
                service.setBriefInfo(rs.getString("brief_info"));
                service.setPrice(rs.getDouble("price"));
                service.setDiscount(rs.getDouble("discount"));
                service.setThumbnail(rs.getString("thumbnail"));
                service.setStatus(rs.getDouble("status"));
                service.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
                if (rs.getTimestamp("updated_date") != null) {
                    service.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
                }
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }
    

}
