package dal;

import java.sql.SQLException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Reservation;
import model.ReservationDetail;
import model.ReservationStatus;
import model.Service;

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

    public ArrayList<Reservation> listMyReservations(int uid) {
        ArrayList<Reservation> result = new ArrayList<>();

        String sql = "SELECT \n"
                + "    r.id,\n"
                + "    rs.id AS statusid,\n"
                + "    rs.status_name,\n"
                + "    r.reserve_date,\n"
                + "    r.created_date,\n"
                + "    r.first_name,\n"
                + "    r.last_name,\n"
                + "    r.email,\n"
                + "    r.phone,\n"
                + "    r.note,\n"
                + "    r.banking,\n"
                + "    rd.id AS rdid,\n"
                + "    rd.service_id,\n"
                + "    s.name as sname,\n"
                + "    rd.quantity,\n"
                + "    rd.price\n"
                + "FROM\n"
                + "    reservation r\n"
                + "        JOIN\n"
                + "    reservationdetail rd ON r.id = rd.reservation_id\n"
                + "        JOIN\n"
                + "    reservationstatus rs ON r.status_id = rs.id\n"
                + "        JOIN\n"
                + "    service s ON rd.service_id = s.id\n"
                + "    where r.customer_id = ?"
                + "  order by r.created_date desc";

        try {
            ResultSet rs = executeQuery(sql, uid);

            Map<Integer, Reservation> rMap = new LinkedHashMap<>();

            while (rs.next()) {
                int rid = rs.getInt("id");

                Reservation r = rMap.get(rid);

                if (r == null) {
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String note = rs.getString("note");
                    boolean banking = rs.getBoolean("banking");
                    LocalDateTime createDate = rs.getTimestamp("created_date").toLocalDateTime();
                    LocalDateTime reserveDate = rs.getTimestamp("reserve_date").toLocalDateTime();

                    int rsid = rs.getInt("statusid");
                    String status = rs.getString("status_name");
                    ReservationStatus rstt = new ReservationStatus(rsid, status);

                    r = new Reservation().builder()
                            .id(rid)
                            .firstName(firstName)
                            .lastName(lastName)
                            .email(email)
                            .phone(phone)
                            .note(note)
                            .banking(banking)
                            .createdDate(createDate)
                            .reverseDate(reserveDate)
                            .status(rstt)
                            .details(new ArrayList<ReservationDetail>())
                            .build();

                    rMap.put(rid, r);
                }

                int rdid = rs.getInt("rdid");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");

                int sid = rs.getInt("service_id");
                String sname = rs.getString("sname");

                Service s = new Service().builder()
                        .id(sid)
                        .name(sname)
                        .build();

                ReservationDetail rd = new ReservationDetail().builder()
                        .id(rdid)
                        .quantity(quantity)
                        .price(price)
                        .service(s)
                        .build();

                r.getDetails().add(rd);
            }

            result.addAll(rMap.values());

        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public Reservation getReservation(int id) {
        Reservation r = null;

        String sql = "SELECT \n"
                + "    r.id AS rid,\n"
                + "    rs.id AS statusid,\n"
                + "    rs.status_name,\n"
                + "    r.reserve_date,\n"
                + "    r.created_date,\n"
                + "    r.first_name,\n"
                + "    r.last_name,\n"
                + "    r.email,\n"
                + "    r.phone,\n"
                + "    r.note,\n"
                + "    r.banking,\n"
                + "    rd.id AS rdid,\n"
                + "    rd.service_id,\n"
                + "    s.name AS sname,\n"
                + "    s.thumbnail,\n"
                + "    s2.value as category,\n"
                + "    rd.quantity,\n"
                + "    rd.price\n"
                + "FROM\n"
                + "    reservation r\n"
                + "        JOIN\n"
                + "    reservationdetail rd ON r.id = rd.reservation_id\n"
                + "        JOIN\n"
                + "    reservationstatus rs ON r.status_id = rs.id\n"
                + "        JOIN\n"
                + "    service s ON rd.service_id = s.id\n"
                + "	join setting s2 on s.category_id = s2.setting_id\n"
                + "WHERE r.id = ?";

        try (ResultSet rs = executeQuery(sql, id)) {
            Map<Integer, Reservation> rMap = new HashMap<>();

            while (rs.next()) {
                int rid = rs.getInt("rid");

                if (!rMap.containsKey(rid)) {
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String note = rs.getString("note");
                    boolean banking = rs.getBoolean("banking");
                    LocalDateTime createDate = rs.getTimestamp("created_date").toLocalDateTime();
                    LocalDateTime reserveDate = rs.getTimestamp("reserve_date").toLocalDateTime();

                    int rsid = rs.getInt("statusid");
                    String status = rs.getString("status_name");
                    ReservationStatus rstt = new ReservationStatus(rsid, status);

                    r = new Reservation().builder()
                            .id(rid)
                            .firstName(firstName)
                            .lastName(lastName)
                            .email(email)
                            .phone(phone)
                            .note(note)
                            .banking(banking)
                            .createdDate(createDate)
                            .reverseDate(reserveDate)
                            .status(rstt)
                            .details(new ArrayList<>())
                            .build();

                    rMap.put(rid, r);
                }

                int rdid = rs.getInt("rdid");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");

                int sid = rs.getInt("service_id");
                String sname = rs.getString("sname");
                String thumbnail = rs.getString("thumbnail");

                Category c = new Category()
                        .builder()
                        .name(rs.getString("category"))
                        .build();

                Service s = new Service().builder()
                        .id(sid)
                        .name(sname)
                        .thumbnail(thumbnail)
                        .category(c)
                        .build();

                ReservationDetail rd = new ReservationDetail().builder()
                        .id(rdid)
                        .quantity(quantity)
                        .price(price)
                        .service(s)
                        .build();

                rMap.get(rid).getDetails().add(rd);
            }

            r = rMap.get(id); // Lấy reservation cuối cùng
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return r;
    }

    public ArrayList<ReservationStatus> listStatus() {
        ArrayList<ReservationStatus> result = new ArrayList<>();

        String sql = "SELECT `reservationstatus`.`id`,\n"
                + "    `reservationstatus`.`status_name`\n"
                + "FROM `childrencare`.`reservationstatus`";

        try {
            ResultSet rs = executeQuery(sql);

            while (rs.next()) {
                int id = rs.getInt("id");
                String status = rs.getString("status_name");

                ReservationStatus stt = new ReservationStatus(id, status);

                result.add(stt);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

}
