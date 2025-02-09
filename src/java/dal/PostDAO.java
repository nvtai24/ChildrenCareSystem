/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import model.Service;


/**
 *
 * @author Nvtai
 */
public class PostDAO extends DBContext {
    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM childrencare.post";

        try {
            ResultSet rs = executeQuery(query);
            while (rs.next()) {
                // Tạo đối tượng Service"id"));
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setStatus(rs.getBoolean("status"));
                post.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
                if (rs.getTimestamp("updated_date") != null) {
                    post.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
                }
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    public int getPostCount(String search, Boolean status) {
        String query = "SELECT COUNT(*) AS total FROM post WHERE title LIKE ?";

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

    public List<Post> getPostsByPageSearchAndStatus(int page, int postsPerPage, String search, Boolean status) {
    List<Post> posts = new ArrayList<>();
    String query = "SELECT * FROM post WHERE title LIKE ?";

    // Nếu có trạng thái, thêm điều kiện lọc
    if (status != null) {
        query += " AND status = ?";
    }

    query += " ORDER BY created_date DESC LIMIT ? OFFSET ?";

    try {
        int offset = (page - 1) * postsPerPage;

        ResultSet rs;
        if (status != null) {
            rs = executeQuery(query, "%" + search + "%", status, postsPerPage, offset);
        } else {
            rs = executeQuery(query, "%" + search + "%", postsPerPage, offset);
        }

        while (rs.next()) {
            Post post = new Post();
            post.setId(rs.getInt("id"));
            post.setTitle(rs.getString("title"));
            post.setContent(rs.getString("content"));
            post.setThumbnail(rs.getString("thumbnail"));
            post.setStatus(rs.getBoolean("status"));
            post.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());

            if (rs.getTimestamp("updated_date") != null) {
                post.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
            }

            posts.add(post);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return posts;
}

    public List<Post> getTop3Post() {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM childrencare.post ORDER BY created_date DESC LIMIT 3";

        try {
            ResultSet rs = executeQuery(query);
            while (rs.next()) {
                // Tạo đối tượng Service"id"));
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setStatus(rs.getBoolean("status"));
                post.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
                if (rs.getTimestamp("updated_date") != null) {
                    post.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
                }
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public Post getPostById(int id) {
        String query = "SELECT * FROM childrencare.post WHERE id = ?";

        try {
            ResultSet rs = executeQuery(query, id);
            if (rs.next()) {
                // Tạo đối tượng Service"id"));
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setStatus(rs.getBoolean("status"));
                post.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
                if (rs.getTimestamp("updated_date") != null) {
                    post.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
                }
                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
