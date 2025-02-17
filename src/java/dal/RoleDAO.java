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

}
