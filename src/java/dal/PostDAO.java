/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.sun.jdi.connect.spi.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;
import model.Service;

/**
 *
 * @author Nvtai
 */
public class PostDAO extends DBContext {

    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT post.id, post.title, post.content, post.thumbnail, post.status,  post.created_date, post.updated_date, user.username  \n"
                + "FROM post  \n"
                + "JOIN user ON post.author_id = user.id WHERE post.status = 1";

        try {
            ResultSet rs = executeQuery(query);
            while (rs.next()) {
                // Tạo đối tượng Service"id"));
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setUsername(rs.getString("username"));
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
        String query = "SELECT post.id, post.title, post.content, post.thumbnail, post.status,  post.created_date, post.updated_date, user.username  \n"
                + "FROM post  \n"
                + "JOIN user ON post.author_id = user.id   WHERE post.title LIKE ? AND post.status = 1";

        
        query += " ORDER BY post.created_date DESC LIMIT ? OFFSET ?";

        try {
            int offset = (page - 1) * postsPerPage;

            ResultSet rs = executeQuery(query, "%" + search + "%", postsPerPage, offset);

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setUsername(rs.getString("username"));
                post.setStatus(rs.getBoolean("status"));
                post.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());

                if (rs.getTimestamp("updated_date") != null) {
                    post.setUpdatedDate(rs.getTimestamp("updated_date").toLocalDateTime());
                }

                posts.add(post);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> getTop3Post() {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM childrencare.post WHERE status = 1 ORDER BY created_date DESC LIMIT 3";

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
        String query = "SELECT post.id, post.title, post.content, post.thumbnail, post.status, "
                + "post.created_date, post.updated_date, user.username "
                + "FROM post "
                + "JOIN user ON post.author_id = user.id "
                + "WHERE post.id = ?";

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
                post.setUsername(rs.getString("username"));
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

    public void updateStatus(int postId, boolean newStatus) {
        String query = "UPDATE post SET status = ? WHERE id = ?";
        try {
            executeUpdate(query, newStatus, postId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletePost(int postId) {
        String deletelabelquery = "DELETE FROM labelpost WHERE post_id = ?";
        try {
            executeUpdate(deletelabelquery, postId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String query = "DELETE FROM post WHERE id = ?";
        try {
            executeUpdate(query, postId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Post> getPostsPageSearchAndStatus(int page, int postsPerPage, String search, Boolean status) {
        List<Post> posts = new ArrayList<>();
        ResultSet rs;
        String query = "SELECT post.id, post.title, post.content, post.thumbnail, post.status,  post.created_date, post.updated_date, user.username  \n"
                + "FROM post  \n"
                + "JOIN user ON post.author_id = user.id   WHERE post.title LIKE ?";

        // Nếu có trạng thái, thêm điều kiện lọc
        if (status != null) {
            query += " AND post.status = ?";
        }

        query += " LIMIT ? OFFSET ?";

        try {
            int offset = (page - 1) * postsPerPage;

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
                post.setUsername(rs.getString("username"));
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

    public boolean AddNewPost(String title, String thumbnail, String content, int author_id) {
        try {
            String query = "INSERT INTO post (title, thumbnail, content, status, created_date, author_id) VALUES (?, ?, ?, ?, ?, ?)";
            int result = executeUpdate(query,
                    title,
                    thumbnail,
                    content,
                    true, // Status mặc định là true
                    java.sql.Timestamp.valueOf(LocalDateTime.now(ZoneId.systemDefault())),
                    author_id
            );
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, null, e);
        }finally {
            try {
                connection.close();
            } catch (SQLException e) {
                Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return false;
    }

    public Post GetPostById(int id) {
        String query = "SELECT * FROM childrencare.post WHERE id = ?";

        try {
            ResultSet rs = executeQuery(query, id);
            if (rs.next()) {
                // Tạo đối tượng Service"id"));
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setContent(rs.getString("content"));
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

    public boolean updatePost(Post post) {
        String query = "UPDATE post SET title = ?, thumbnail = ?, content = ? WHERE id = ? ";
        try {
            int result = executeUpdate(query, post.getTitle(), post.getThumbnail(), post.getContent(), post.getId());
            if (result > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
