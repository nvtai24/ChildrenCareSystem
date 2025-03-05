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
import model.Setting;
import model.SettingType;

/**
 *
 * @author Nvtai
 */
public class SettingTypeDAO extends DBContext {

    public ArrayList<SettingType> listAllTypes() {
        ArrayList<SettingType> result = new ArrayList<>();

        String query = "SELECT `settingtype`.`id`,\n"
                + "    `settingtype`.`name`\n"
                + "FROM `childrencare`.`settingtype`";

        try {
            ResultSet rs = executeQuery(query);

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");

                SettingType st = new SettingType().builder()
                        .id(id)
                        .name(name)
                        .build();

                result.add(st);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }


}
