/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Category;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nvtai
 */
public class CategoryDAO extends DBContext {

    public ArrayList<Category> list() {
        DBContext db = new DBContext();
        ArrayList<Category> list = new ArrayList<>();
        String sql = "select id,name,description,status from category;";

        try {
            ResultSet rs = db.executeQuery(sql);

            while (rs.next()) {
                // Get attribute into object.
                Category c = new Category();
                c.setId(rs.getInt("id"));

                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getInt("status") == 1);
                // Get category into list 
                list.add(c);

            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return list;
    }

}
