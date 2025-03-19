/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;
import model.Profile;
import model.Reservation;
import model.ReservationDetail;
import model.Service;
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
        }

        return result;
    }

    public List<Feedback> getAllFeedbackWithDetails() {
        List<Feedback> feedbackList = new ArrayList<>();

        try {
            String query = "SELECT f.reservationdetail_id, f.rating, f.comment, f.status, \n"
                    + "       f.created_date, f.updated_date, s.name AS service_name, \n"
                    + "       CONCAT(r.first_name, ' ', r.last_name) AS customer_name, \n"
                    + "       rd.reservation_id, p.avatar \n"
                    + "FROM feedback f \n"
                    + "JOIN reservationdetail rd ON f.reservationdetail_id = rd.id \n"
                    + "JOIN reservation r ON rd.reservation_id = r.id \n"
                    + "JOIN service s ON rd.service_id = s.id \n"
                    + "LEFT JOIN user u ON r.customer_id = u.id \n"
                    + "LEFT JOIN profile p ON u.id = p.userid;";

            ResultSet rs = executeQuery(query);

            while (rs.next()) {
                Service service = Service.builder()
                        .name(rs.getString("service_name"))
                        .build();

                Reservation reservation = Reservation.builder()
                        .id(rs.getInt("reservation_id"))
                        .fullName(rs.getString("customer_name"))
                        .build();

                ReservationDetail reservationDetail = ReservationDetail.builder()
                        .id(rs.getInt("reservationdetail_id"))
                        .reservation(reservation)
                        .service(service)
                        .build();

                Feedback feedback = Feedback.builder()
                        .id(rs.getInt("reservationdetail_id"))
                        .reservationDetail(reservationDetail)
                        .rating(rs.getInt("rating"))
                        .comment(rs.getString("comment"))
                        .status(rs.getBoolean("status"))
                        .createdDate(rs.getObject("created_date", LocalDateTime.class))
                        .updatedDate(rs.getObject("updated_date", LocalDateTime.class))
                        .avatar(rs.getString("avatar"))
                        .build();

                feedbackList.add(feedback);
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return feedbackList;
    }

    public List<Feedback> getFeedbackBySearch(String searchQuery) {
        List<Feedback> feedbackList = new ArrayList<>();

        try {
            String query = "SELECT f.reservationdetail_id, f.rating, f.comment, f.status, \n"
                    + "       f.created_date, f.updated_date, s.name AS service_name, s.id AS service_id, \n"
                    + "       CONCAT(r.first_name, ' ', r.last_name) AS customer_name, \n"
                    + "       rd.reservation_id, p.avatar \n"
                    + "FROM feedback f \n"
                    + "JOIN reservationdetail rd ON f.reservationdetail_id = rd.id \n"
                    + "JOIN reservation r ON rd.reservation_id = r.id \n"
                    + "JOIN service s ON rd.service_id = s.id \n"
                    + "LEFT JOIN user u ON r.customer_id = u.id \n"
                    + "LEFT JOIN profile p ON u.id = p.userid \n"
                    + "WHERE s.name LIKE ? OR f.comment LIKE ? OR CONCAT(r.first_name, ' ', r.last_name) LIKE ?";

            ResultSet rs = executeQuery(query,
                    "%" + searchQuery + "%",
                    "%" + searchQuery + "%",
                    "%" + searchQuery + "%");

            while (rs.next()) {
                Service service = Service.builder()
                        .id(rs.getInt("service_id"))
                        .name(rs.getString("service_name"))
                        .build();

                Reservation reservation = Reservation.builder()
                        .id(rs.getInt("reservation_id"))
                        .fullName(rs.getString("customer_name"))
                        .build();

                ReservationDetail reservationDetail = ReservationDetail.builder()
                        .id(rs.getInt("reservationdetail_id"))
                        .reservation(reservation)
                        .service(service)
                        .build();

                Feedback feedback = Feedback.builder()
                        .id(rs.getInt("reservationdetail_id"))
                        .reservationDetail(reservationDetail)
                        .rating(rs.getInt("rating"))
                        .comment(rs.getString("comment"))
                        .status(rs.getBoolean("status"))
                        .createdDate(rs.getObject("created_date", LocalDateTime.class))
                        .updatedDate(rs.getObject("updated_date", LocalDateTime.class))
                        .avatar(rs.getString("avatar"))
                        .build();

                feedbackList.add(feedback);
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return feedbackList;
    }

    public void updateFeedbackStatus(int id, int status) {
        try {
            String query = "UPDATE feedback SET status = ?, updated_date = NOW() WHERE reservationdetail_id = ?";
            executeUpdate(query, status, id);
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Feedback> getListFeedbackByRatingServiceAndStatus(int rating, int serviceId, int status) {
        List<Feedback> feedbackList = new ArrayList<>();

        try {
            StringBuilder query = new StringBuilder(
                    "SELECT f.reservationdetail_id, f.rating, f.comment, f.status, \n"
                    + "       f.created_date, f.updated_date, s.name AS service_name, s.id AS service_id, \n"
                    + "       CONCAT(r.first_name, ' ', r.last_name) AS customer_name, \n"
                    + "       rd.reservation_id, p.avatar \n"
                    + "FROM feedback f \n"
                    + "JOIN reservationdetail rd ON f.reservationdetail_id = rd.id \n"
                    + "JOIN reservation r ON rd.reservation_id = r.id \n"
                    + "JOIN service s ON rd.service_id = s.id \n"
                    + "LEFT JOIN user u ON r.customer_id = u.id \n"
                    + "LEFT JOIN profile p ON u.id = p.userid \n"
                    + "WHERE 1=1"
            );

            if (rating != -1) {
                query.append(" AND f.rating = ").append(rating);
            }

            if (serviceId != -1) {
                query.append(" AND s.id = ").append(serviceId);
            }

            if (status != -1) {
                query.append(" AND f.status = ").append(status);
            }

            ResultSet rs = executeQuery(query.toString());

            while (rs.next()) {
                Service service = Service.builder()
                        .id(rs.getInt("service_id"))
                        .name(rs.getString("service_name"))
                        .build();

                Reservation reservation = Reservation.builder()
                        .id(rs.getInt("reservation_id"))
                        .fullName(rs.getString("customer_name"))
                        .build();

                ReservationDetail reservationDetail = ReservationDetail.builder()
                        .id(rs.getInt("reservationdetail_id"))
                        .reservation(reservation)
                        .service(service)
                        .build();

                Feedback feedback = Feedback.builder()
                        .id(rs.getInt("reservationdetail_id"))
                        .reservationDetail(reservationDetail)
                        .rating(rs.getInt("rating"))
                        .comment(rs.getString("comment"))
                        .status(rs.getBoolean("status"))
                        .createdDate(rs.getObject("created_date", LocalDateTime.class))
                        .updatedDate(rs.getObject("updated_date", LocalDateTime.class))
                        .avatar(rs.getString("avatar"))
                        .build();

                feedbackList.add(feedback);
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return feedbackList;
    }
}
