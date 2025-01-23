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
            while(rs.next()){
                // Get attribute into object.
                Service s = new Service();
                s.setId(rs.getInt("id"));
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
        }finally{
            try {
                connection.close();
                
            } catch (SQLException ex) {
                Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        
        
        return list;
    }
}
