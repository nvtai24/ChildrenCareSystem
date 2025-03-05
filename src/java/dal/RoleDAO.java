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
                + "    rf.status as fstatus\n"
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
        }

        return roles;
    }

    public void togglePermission(int roleId, int featureId) {
        String sql = "update rolefeature\n"
                + "set status = status ^ 1\n"
                + "where role_id = ? and feature_id = ?";

        try {
            executeUpdate(sql, roleId, featureId);
        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void unassignPermission(int roleId, int featureId) {
        String sql = "DELETE FROM rolefeature\n"
                + "WHERE role_id = ? and feature_id = ?";

        try {
            executeUpdate(sql, roleId, featureId);
        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Role getRoleById(int id) {
        Role result = null;

        String sql = "SELECT `role`.`role_name`,\n"
                + "    `role`.`description`\n"
                + "FROM `childrencare`.`role`\n"
                + "where id = ?";

        try {
            ResultSet rs = executeQuery(sql, id);

            if (rs.next()) {
                String rname = rs.getString("role_name");
                String description = rs.getString("description");

                result = new Role().builder()
                        .id(id)
                        .roleName(rname)
                        .description(description)
                        .build();
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    private boolean isPermissionAssigned(int rid, int fid) {
        try {
            String sql = "SELECT 1\n"
                    + "FROM `childrencare`.`rolefeature`\n"
                    + "where role_id = ? and feature_id = ?";

            ResultSet rs = executeQuery(sql, rid, fid);

            return rs.next();

        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void assignPermission(int roleId, int featureId) {
        String sql = "";
        if (!isPermissionAssigned(roleId, featureId)) {

            sql = "INSERT INTO `childrencare`.`rolefeature`\n"
                    + "(`role_id`,\n"
                    + "`feature_id`)\n"
                    + "VALUES\n"
                    + "(?, ?)";
        } else {
            sql = "DELETE FROM rolefeature\n"
                    + "WHERE role_id = ? and feature_id = ?";
        }
        try {
            executeUpdate(sql, roleId, featureId);
        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
