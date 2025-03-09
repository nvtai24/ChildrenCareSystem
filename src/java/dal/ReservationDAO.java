package dal;

import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Reservation;
import model.ReservationDetail;

public class ReservationDAO extends DBContext {

    // đây là mới xử lí insert dữ liệu bởi phương thức thanh toán arrival, còn thanh toán online thì chưa (r.isBanking == true) -> payment table
    public void insertReservation(Reservation r) {
        String reservationQuery = "INSERT INTO `childrencare`.`reservation` "
                + "(`customer_id`, `first_name`, `last_name`, `reserve_date`, `phone`, `email`, `note`, `banking`) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        String detailsQuery = "INSERT INTO `childrencare`.`reservationdetail` "
                + "(`reservation_id`, `service_id`, `quantity`, `price`) "
                + "VALUES (?, ?, ?, ?)";

        if (connection == null) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, "Database connection is null!");
            return;
        }

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // Insert vào bảng reservation
            int reservationId = -1;
            try (PreparedStatement ps1 = connection.prepareStatement(reservationQuery, Statement.RETURN_GENERATED_KEYS)) {
                ps1.setInt(1, r.getCustomer().getId());
                ps1.setString(2, r.getFirstName());
                ps1.setString(3, r.getLastName());
                ps1.setTimestamp(4, Timestamp.valueOf(r.getReverseDate()));
                ps1.setString(5, r.getPhone());
                ps1.setString(6, r.getEmail());
                ps1.setString(7, r.getNote());
                ps1.setBoolean(8, r.isBanking());

                int affectedRows = ps1.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Creating reservation failed, no rows affected.");
                }

                try (ResultSet generatedKeys = ps1.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        reservationId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Creating reservation failed, no ID obtained.");
                    }
                }
            }

            // Insert danh sách reservation details
            try (PreparedStatement ps2 = connection.prepareStatement(detailsQuery)) {
                for (ReservationDetail detail : r.getDetails()) {
                    ps2.setInt(1, reservationId);
                    ps2.setInt(2, detail.getService().getId());
                    ps2.setInt(3, detail.getQuantity());
                    ps2.setDouble(4, detail.getPrice());
                    ps2.addBatch();
                }
                ps2.executeBatch();
            }

            connection.commit(); // Xác nhận transaction

        } catch (SQLException ex) {
            try {
                if (connection != null) {
                    connection.rollback(); // Nếu có lỗi, rollback toàn bộ
                }
            } catch (SQLException rollbackEx) {
                Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, "Rollback failed!", rollbackEx);
            }
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, "Insert reservation failed!", ex);
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                    connection.close(); // Đóng kết nối sau khi hoàn tất
                }
            } catch (SQLException ex) {
                Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, "Closing connection failed!", ex);
            }
        }
    }
    
    public ArrayList<Reservation> listAllReservation(){
        
        return null;
    }
}
