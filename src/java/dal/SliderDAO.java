/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
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

    public Slider GetSliderById(int id) {
        String query = "SELECT * FROM childrencare.slider WHERE id = ?";

        try {
            ResultSet rs = executeQuery(query, id);
            if (rs.next()) {
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
                return slider;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateStatus(int sliderId, boolean newStatus) {
        String query = "UPDATE slider SET status = ? WHERE id = ?";
        try {
            executeUpdate(query, newStatus, sliderId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateSlider(Slider slider) {
        String query = "UPDATE slider SET title = ?, image_url = ?, back_link=? WHERE id = ? ";
        try {
            int result = executeUpdate(query, slider.getTitle(), slider.getImageUrl(), slider.getBackLink(), slider.getId());
            if (result > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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

    public boolean AddNewSlider(String title, String imageUrl, String backLink, int author_id) {
        try {
            String query = "INSERT INTO slider (title, image_url, back_link, status, created_date, author_id) VALUES (?, ?, ?, ?, ?, ?)";
            int result = executeUpdate(query, title, imageUrl, backLink,
                    true, java.sql.Timestamp.valueOf(LocalDateTime.now(ZoneId.systemDefault())), author_id);
            if (result > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
