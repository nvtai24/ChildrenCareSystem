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
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.util.List;
import model.Comment;

/**
 *
 * @author ADMIN
 */
public class CommentDAO extends DBContext {

    public List<Comment> listCommentsOfPost(int cid) {
        List<Comment> result = new ArrayList<>();

        String sql = "SELECT \n"
                + "    c.comment,\n"
                + "    c.created_date,\n"
                + "    p.firstname,\n"
                + "    p.lastname,\n"
                + "    p.avatar\n"
                + "FROM comment c\n"
                + "JOIN user u ON c.author_id = u.id\n"
                + "JOIN profile p ON u.id = p.userid\n"
                + "WHERE c.post_id = ?\n"
                + "ORDER BY c.created_date DESC";

        try {
            ResultSet rs = executeQuery(sql, cid);

            while (rs.next()) {
            Comment comment = new Comment();
            comment.setComment(rs.getString("comment"));
            comment.setCreatedDate(rs.getTimestamp("created_date").toLocalDateTime());
            comment.setFirstName(rs.getString("firstname"));
            comment.setLastName(rs.getString("lastname"));
            comment.setAvatar(rs.getString("avatar"));

            result.add(comment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return result;
    }
    
    public boolean addCommentByUser(int postId, int authorId, String comment) {
         try {
            String query = "INSERT INTO comment (post_id, author_id, comment, created_date) VALUES (?, ?, ?, ?)";
            int result = executeUpdate(query, postId, authorId, comment,java.sql.Timestamp.valueOf(LocalDateTime.now(ZoneId.systemDefault())));
            return result > 0;
          } catch (SQLException e) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return false;
    } 
}
