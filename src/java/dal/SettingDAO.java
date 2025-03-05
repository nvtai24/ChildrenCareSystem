/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;
import model.SettingType;

/**
 *
 * @author Nvtai
 */
public class SettingDAO extends DBContext {

    <<<<<<<HEAD
    public ArrayList<Setting> filterSettings(int status, int typeid, String keyword) {
=======

    public ArrayList<Setting> filterSettings(int status, int typeid) {
>>>>>>> 6f78941b8b668de7dbf7589129785470aa54b3b6
        ArrayList<Setting> result = new ArrayList<>();
        String query = "SELECT \n"
                + "    s.setting_id,\n"
                + "    s.value,\n"
                + "    s.description,\n"
                + "    s.status,\n"
                + "    st.id,\n"
                + "    st.name\n"
                + "FROM\n"
                + "    setting s\n"
                + "        JOIN\n"
                + "    settingtype st ON s.type_id = st.id\n"
                + "WHERE 1=1";

        if (status != -1) {
            query += " AND s.status = ?";
        }
        if (typeid != -1) {
            query += " AND st.id = ?";
        }

        if (keyword != null && !keyword.isBlank()) {
            query += " AND (s.value like ? or s.description like ?)";
        }

        try (PreparedStatement ps = connection.prepareStatement(query)) {

            int paramIndex = 1;

            if (status != -1) {
                ps.setInt(paramIndex++, status);
            }
            if (typeid != -1) {
                ps.setInt(paramIndex++, typeid);
            }

            if (keyword != null && !keyword.isBlank()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
                ps.setString(paramIndex++, "%" + keyword + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int sid = rs.getInt("setting_id");
                    String value = rs.getString("value");
                    String description = rs.getString("description");
                    int stid = rs.getInt("id");
                    boolean sstatus = rs.getInt("status") == 1;
                    String stname = rs.getString("name");

                    SettingType st = new SettingType()
                            .builder()
                            .id(stid)
                            .name(stname)
                            .build();

                    Setting s = new Setting()
                            .builder()
                            .id(sid)
                            .settingValue(value)
                            .description(description)
                            .status(sstatus)
                            .settingType(st)
                            .build();

                    result.add(s);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public ArrayList<Setting> listAllSettings() {
        ArrayList<Setting> result = new ArrayList<>();

        String query = "SELECT \n"
                + "    s.setting_id,\n"
                + "    s.value,\n"
                + "    s.description,\n"
                + "    s.status,\n"
                + "    st.id,\n"
                + "    st.name\n"
                + "FROM\n"
                + "    setting s\n"
                + "        JOIN\n"
                + "    settingtype st ON s.type_id = st.id";

        try {
            ResultSet rs = executeQuery(query);

            while (rs.next()) {
                int sid = rs.getInt("setting_id");
                String value = rs.getString("value");
                String description = rs.getString("description");
                boolean status = rs.getBoolean("status");
                int stid = rs.getInt("id");
                String stname = rs.getString("name");

                SettingType st = new SettingType()
                        .builder()
                        .id(stid)
                        .name(stname)
                        .build();

                Setting s = new Setting()
                        .builder()
                        .id(sid)
                        .settingValue(value)
                        .description(description)
                        .status(status)
                        .settingType(st)
                        .build();

                result.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public Setting getSettingById(int id) {
        String query = "SELECT s.setting_id, s.value, s.description, s.status FROM setting s WHERE s.setting_id = ?";
        try {
            ResultSet rs = executeQuery(query, id);
            if (rs.next()) {
                return new Setting(
                        rs.getInt("setting_id"),
                        null,
                        rs.getString("value"),
                        rs.getString("description"),
                        rs.getBoolean("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateSetting(Setting setting) {
        String query = "UPDATE setting SET value = ?, description = ?, status = ? WHERE setting_id = ?";
        try {
            executeUpdate(query, setting.getSettingValue(), setting.getDescription(), setting.isStatus(),
                    setting.getId());
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addSetting(Setting setting) {
        String query = "INSERT INTO setting (value, description, status) VALUES (?, ?, ?)";
        try {
            executeUpdate(query, setting.getSettingValue(), setting.getDescription(), setting.isStatus());
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void toggleStatus(int stid) {
        String query = "update setting\n"
                + "set status = status ^ 1\n"
                + "where setting_id = ?";

        try {
            executeUpdate(query, stid);
        } catch (SQLException ex) {
            Logger.getLogger(SettingTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
