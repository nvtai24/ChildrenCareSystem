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
                + "where rf.role_id = ? and f.status = 1";

        try {
            ResultSet rs = executeQuery(query, roleId);

            while (rs.next()) {
                String permission = rs.getString("url");

                permissions.add(permission);
            }

        } catch (SQLException ex) {
            Logger.getLogger(FeatureDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(FeatureDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return permissions;
    }

}
