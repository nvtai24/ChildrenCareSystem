/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

/**
 *
 * @author Nvtai
 */
public class CategoryDAO extends DBContext {

    public List<Category> getAllAvailabelCategories() {
        List<Category> result = new ArrayList<>();

        String query = "select * from setting\n"
                + "where type_id = 1 and status = 1";

        try {
            ResultSet rs = executeQuery(query);

            while (rs.next()) {
                int id = rs.getInt("setting_id");
                String name = rs.getString("value");
                String description = rs.getString("description");

                Category c = new Category();
                c.setId(id);
                c.setName(name);
                c.setDescription(description);

                result.add(c);
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

        return result;
    }

    public Category getCategoryById(int cid) {
        Category c = null;

        String query = "select value, description from setting\n"
                + "where setting_id = ?";

        try {
            ResultSet rs = executeQuery(query, cid);

            if (rs.next()) {
                String name = rs.getString("value");
                String description = rs.getString("description");

                c = new Category();
                c.setId(cid);
                c.setName(name);
                c.setDescription(description);
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

        return c;
    }

}
