/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;
import model.Profile;
import model.Reservation;
import model.ReservationDetail;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class FeedbackDAO extends DBContext {

    public List<Feedback> listFeedbacksOfService(int sid) {
        List<Feedback> result = new ArrayList<>();

        String sql = "select f.rating, f.comment, p.firstname, p.lastname, p.avatar from reservationdetail rd \n"
                + "join reservation r on rd.reservation_id = r.id\n"
                + "join feedback f on rd.id = f.reservationdetail_id\n"
                + "join user u on r.customer_id = u.id\n"
                + "join profile p on u.id = p.userid\n"
                + "where service_id = ?";

        try {
            ResultSet rs = executeQuery(sql, sid);

            while (rs.next()) {
                int rating = rs.getInt("rating");
                String comment = rs.getString("comment");
                String firstName = rs.getString("firstname");
                String lastName = rs.getString("lastname");
                String avatar = rs.getString("avatar");

                Feedback f = new Feedback();
                f.setRating(rating);
                f.setComment(comment);

                ReservationDetail rd = new ReservationDetail();

                Reservation r = new Reservation();

                User u = new User();

                Profile p = new Profile();
                p.setAvatar(avatar);
                p.setFirstName(firstName);
                p.setLastName(lastName);

                u.setProfile(p);
                r.setCustomer(u);
                rd.setReservation(r);
                f.setReservationDetail(rd);

                result.add(f);

                f.getReservationDetail().getReservation().getCustomer().getProfile().getAvatar();
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return result;
    }

    public List<Feedback> listFeedbacksOfServiceByRating(int sid, int rating) {
        List<Feedback> result = new ArrayList<>();

        String sql = "select f.comment, p.firstname, p.lastname, p.avatar from reservationdetail rd \n"
                + "join reservation r on rd.reservation_id = r.id\n"
                + "join feedback f on rd.id = f.reservationdetail_id\n"
                + "join user u on r.customer_id = u.id\n"
                + "join profile p on u.id = p.userid\n"
                + "where service_id = ? and f.rating = ?";

        try {
            ResultSet rs = executeQuery(sql, sid, rating);

            while (rs.next()) {
                String comment = rs.getString("comment");
                String firstName = rs.getString("firstname");
                String lastName = rs.getString("lastname");
                String avatar = rs.getString("avatar");

                Feedback f = new Feedback();
                f.setRating(rating);
                f.setComment(comment);

                ReservationDetail rd = new ReservationDetail();

                Reservation r = new Reservation();

                User u = new User();

                Profile p = new Profile();
                p.setAvatar(avatar);
                p.setFirstName(firstName);
                p.setLastName(lastName);

                u.setProfile(p);
                r.setCustomer(u);
                rd.setReservation(r);
                f.setReservationDetail(rd);

                result.add(f);

                f.getReservationDetail().getReservation().getCustomer().getProfile().getAvatar();
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return result;
    }

    public int getAverageRating(int sid) {
        int result = 0;

        String query = "SELECT \n"
                + "    CEIL(AVG(f.rating)) AS average_rating\n"
                + "FROM reservationdetail rd \n"
                + "JOIN reservation r ON rd.reservation_id = r.id\n"
                + "JOIN feedback f ON rd.id = f.reservationdetail_id\n"
                + "JOIN user u ON r.customer_id = u.id\n"
                + "JOIN profile p ON u.id = p.userid\n"
                + "where service_id = ?";

        try {
            ResultSet rs = executeQuery(query, sid);

            if (rs.next()) {
                result = rs.getInt("average_rating");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return result;
    }

}
