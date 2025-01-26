/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Service;

/**
 *
 * @author Nvtai
 */
public class ServiceDAO  extends DBContext {
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String query = "SELECT * FROM childrencare.service";

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
                if(rs.getTimestamp("updated_date") != null) {
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
