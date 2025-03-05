/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.auth.Feature;

/**
 *
 * @author Nvtai
 */
public class FeatureDAO extends DBContext {

    public ArrayList<String> getPermissions(int roleId) {
        ArrayList<String> permissions = new ArrayList<>();

        String query = "select f.url\n"
                + "from rolefeature rf \n"
                + "join feature f on rf.feature_id = f.id\n"
                + "where rf.role_id = ?";

        try {
            ResultSet rs = executeQuery(query, roleId);

            while (rs.next()) {
                String permission = rs.getString("url");

                permissions.add(permission);
            }

        } catch (SQLException ex) {
            Logger.getLogger(FeatureDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return permissions;
    }

    public ArrayList<Feature> listAllFeatures() {
        ArrayList<Feature> result = new ArrayList<>();

        String sql = "SELECT `feature`.`id`,\n"
                + "    `feature`.`feature_name`,\n"
                + "    `feature`.`url`,\n"
                + "    `feature`.`description`,\n"
                + "    `feature`.`status`\n"
                + "FROM `childrencare`.`feature`";

        try {
            ResultSet rs = executeQuery(sql);

            while (rs.next()) {
                int id = rs.getInt("id");
                String fname = rs.getString("feature_name");
                String url = rs.getString("url");
                String description = rs.getString("description");

                Feature f = new Feature().builder()
                        .id(id)
                        .featureName(fname)
                        .url(url)
                        .description(description)
                        .build();

                result.add(f);
            }

        } catch (SQLException ex) {
            Logger.getLogger(FeatureDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }
}
