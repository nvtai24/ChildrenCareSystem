/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Slider;

/**
 *
 * @author Nvtai
 */
public class SliderDAO extends DBContext {

    public List<Slider> getAllSliders() {
        List<Slider> sliders = new ArrayList<>();
        String query = "SELECT * FROM childrencare.slider WHERE status = 1";

        try {
            ResultSet rs = executeQuery(query);
            while (rs.next()) {
                // Tạo đối tượng Service"id"));
                Slider slider = new Slider();
                slider.setId(rs.getInt("id"));
                slider.setTitle(rs.getString("title"));
                slider.setImageUrl(rs.getString("image_url"));
                slider.setBackLink(rs.getString("back_link"));
                slider.setStatus(rs.getBoolean("status"));
                slider.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
                if (rs.getTimestamp("updated_date") != null) {
                    slider.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
                }
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public void updateStatus(int sliderId, boolean newStatus) {
        String query = "UPDATE slider SET status = ? WHERE id = ?";
        try {
            executeUpdate(query, newStatus, sliderId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteSlider(int sliderId) {
        String query = "DELETE FROM slider WHERE id = ?";
        try {
            executeUpdate(query, sliderId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getSliderCount(String search, Boolean status) {
        String query = "SELECT COUNT(*) AS total FROM slider WHERE title LIKE ?";

        // Nếu có trạng thái, thêm điều kiện lọc
        if (status != null) {
            query += " AND status = ?";
        }

        try {
            if (status != null) {
                ResultSet rs = executeQuery(query, "%" + search + "%", status);
                if (rs.next()) {
                    return rs.getInt("total");
                }
            } else {
                ResultSet rs = executeQuery(query, "%" + search + "%");
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Slider> getSlidersByPageSearchAndStatus(int page, int slidersPerPage, String search, Boolean status) {
        List<Slider> sliders = new ArrayList<>();
        String query = "SELECT * FROM slider WHERE title LIKE ?";

        // Nếu có trạng thái, thêm điều kiện lọc
        if (status != null) {
            query += " AND status = ?";
        }

        query += " LIMIT ? OFFSET ?";

        try {
            int offset = (page - 1) * slidersPerPage;

            ResultSet rs;
            if (status != null) {
                rs = executeQuery(query, "%" + search + "%", status, slidersPerPage, offset);
            } else {
                rs = executeQuery(query, "%" + search + "%", slidersPerPage, offset);
            }

            while (rs.next()) {
                Slider slider = new Slider();
                slider.setId(rs.getInt("id"));
                slider.setTitle(rs.getString("title"));
                slider.setImageUrl(rs.getString("image_url"));
                slider.setBackLink(rs.getString("back_link"));
                slider.setStatus(rs.getBoolean("status"));
                slider.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
                if (rs.getTimestamp("updated_date") != null) {
                    slider.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
                }
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }
}
