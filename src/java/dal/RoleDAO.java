/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.auth.Feature;
import model.auth.Role;

/**
 *
 * @author Nvtai
 */
public class RoleDAO extends DBContext {

    public ArrayList<Role> listAllAvailableRole() {
        ArrayList<Role> roles = new ArrayList<>();

        String query = "SELECT `role`.`id`,\n"
                + "    `role`.`role_name`,\n"
                + "    `role`.`description`,\n"
                + "    `role`.`status`\n"
                + "FROM `childrencare`.`role`\n"
                + "where status = 1;";

        try {
            ResultSet rs = executeQuery(query);

            while (rs.next()) {
                int id = rs.getInt("id");
                String roleName = rs.getString("role_name");

                Role r = new Role();
                r.setId(id);
                r.setRoleName(roleName);

                roles.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return roles;
    }

    public ArrayList<Role> listAllRoleDashboard() {
        ArrayList<Role> roles = new ArrayList<>();

        String query = "SELECT \n"
                + "    r.id AS roleid,\n"
                + "    r.role_name,\n"
                + "    r.description as rdescription,\n"
                + "    r.status as rstatus,\n"
                + "    f.id AS featureid,\n"
                + "    f.feature_name,\n"
                + "    f.url,\n"
                + "    f.description as fdescription,\n"
                + "    f.status as fstatus\n"
                + "FROM\n"
                + "    role r\n"
                + "        JOIN\n"
                + "    rolefeature rf ON r.id = rf.role_id\n"
                + "        JOIN\n"
                + "    feature f ON f.id = rf.feature_id;";

        try {
            ResultSet rs = executeQuery(query);

            Map<Integer, Role> roleMap = new HashMap<>();

            while (rs.next()) {
                int roleId = rs.getInt("roleid");

                Role r = roleMap.get(roleId);
                if (r == null) {
                    String roleName = rs.getString("role_name");
                    String description = rs.getString("rdescription");
                    boolean status = rs.getBoolean("rstatus");

                    r = new Role().builder()
                            .id(roleId)
                            .roleName(roleName)
                            .description(description)
                            .status(status)
                            .features(new ArrayList<>())
                            .build();

                    roleMap.put(roleId, r);
                }

                int featureId = rs.getInt("featureid");
                String featureName = rs.getString("feature_name");
                String url = rs.getString("url");
                String fdescription = rs.getString("fdescription");
                boolean fstatus = rs.getBoolean("fstatus");

                Feature f = new Feature().builder()
                        .id(featureId)
                        .featureName(featureName)
                        .url(url)
                        .description(fdescription)
                        .status(fstatus)
                        .build();

                r.getFeatures().add(f);
            }
            
            roles.addAll(roleMap.values());

        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return roles;
    }

}
