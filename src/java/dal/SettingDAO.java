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
import model.Setting;
import model.SettingType;

/**
 *
 * @author Nvtai
 */
public class SettingDAO extends DBContext {

    public ArrayList<SettingType> listAllSettings() {
        ArrayList<SettingType> settings = new ArrayList<>();

        String query = "SELECT \n"
                + "    st.id AS typeid,\n"
                + "    st.name AS typename,\n"
                + "    s.setting_id,\n"
                + "    s.value,\n"
                + "    s.description,\n"
                + "    s.status\n"
                + "FROM\n"
                + "    settingtype st\n"
                + "        JOIN\n"
                + "    setting s ON st.id = s.type_id";

        try {
            Map<Integer, SettingType> settingTypeMap = new HashMap<>();

            ResultSet rs = executeQuery(query);

            while (rs.next()) {

                int id = rs.getInt("typeid");
                String name = rs.getString("typename");

                SettingType type = settingTypeMap.get(id);

                if (type == null) {
                    type = new SettingType();
                    type.setId(id);
                    type.setName(name);
                    type.setSettings(new ArrayList<>());
                    settingTypeMap.put(id, type);
                }

                int settingId = rs.getInt("setting_id");
                String value = rs.getString("value");
                String description = rs.getString("description");
                boolean status = rs.getBoolean("status");

                Setting s = new Setting(settingId, type, value, description, status);
                type.getSettings().add(s);
            }

            settings.addAll(settingTypeMap.values());
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return settings;
    }

}
