/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ReservationDAO;
import dal.ReservationStatusDAO;
import dal.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.stream.Collectors;
import model.Reservation;
import model.ReservationDetail;
import model.ReservationStatus;
import util.EmailUtil;

/**
 *
 * @author Admin
 */
public class ReservationListController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String reservationId_RAW = request.getParameter("reservation_id");
        int reservationId = Integer.parseInt(reservationId_RAW);
        ReservationDAO rDAO = new ReservationDAO();
        Reservation r = rDAO.getReservation(reservationId);

        // Lấy ngày giờ hiện tại và định dạng
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);
        String serviceContent = r.getDetails().stream()
                .map(s2 -> s2.getService().getName() + " x" + s2.getQuantity())
                .collect(Collectors.joining(", "));

        if (action == null) {
            doGet(request, response);
        } else {
            String subject = "";
            String message = "";
            switch (action) {
                case "cancel":
                    // Gửi email hủy
                    subject = "Reservation cancel!";
                    message = generateReservationMessage(r, "Cancelled", formattedDateTime, request.getParameter("reason"), serviceContent);
                    EmailUtil.sendReserveNotification(r.getEmail(), subject, message);
                    rDAO.changeReservationStatus(4, reservationId); // 4 - Cancelled
                    break;
                case "confirm":
                    // Gửi email xác nhận
                    subject = "Reservation confirmed!";
                    message = generateReservationMessage(r, "Confirmed", formattedDateTime, null, serviceContent);
                    EmailUtil.sendReserveNotification(r.getEmail(), subject, message);
                    rDAO.changeReservationStatus(2, reservationId); // 2 - Confirmed
                    break;
                default:
                    doGet(request, response);
                    return;
            }
            doGet(request, response);  // Refresh the reservation list after action
        }
    }

    // Phương thức tạo thông báo cho email
    private String generateReservationMessage(Reservation r, String action, String formattedDateTime, String reason, String serviceContent) {
        return String.format(
                "Dear %s %s,\n\n"
                + "Your reservation has been %s.\n\n"
                + "-----------------------------------------\n"
                + "🗓 %s time: %s \n"
                + "%s"
                + "📞 Phone: %s\n"
                + "📧 Email: %s\n"
                + "📌 Reservation ID: %d\n"
                + "💳 Payment Method: On Arrival\n"
                + "-----------------------------------------\n\n"
                + "Services:\n%s\n\n"
                + "Thank you for using our service!\n"
                + "Best regards,\nYour Service Team",
                r.getFirstName(), r.getLastName(),
                action,
                action.equals("Cancelled") ? "Cancelled" : "Confirmed", formattedDateTime,
                reason != null ? "📧 Reason: " + reason.trim() + "\n" : "",
                r.getPhone(), r.getEmail(),
                r.getId(),
                serviceContent
        );
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        RoleDAO rDAO = new RoleDAO();
        ReservationDAO reservationDAO = new ReservationDAO();
        ReservationStatusDAO rsDAO = new ReservationStatusDAO();

        // Fetch status list and set to request once
        ArrayList<ReservationStatus> statusList = rsDAO.list();
        request.setAttribute("statusList", statusList);

        int userId = (int) session.getAttribute("id");

        // If staff, show reservations specific to the staff
        boolean isStaff = rDAO.checkStaffRole(userId);
        ArrayList<Reservation> list = isStaff ? reservationDAO.listReservationsByStaffId(userId) : reservationDAO.listAllReservations();

        // Count total price and quantity for reservations
        request.setAttribute("reservations", countTotalForReservation(list));
        request.setAttribute("manager", !isStaff);

        // Forward to the reservation list page
        request.getRequestDispatcher("dashboard/reservationList.jsp").forward(request, response);
    }

    public ArrayList<Reservation> countTotalForReservation(ArrayList<Reservation> list) {
        for (Reservation reservation : list) {
            int totalQuantity = 0;
            double totalPrice = 0;
            for (ReservationDetail reservationDetail : reservation.getDetails()) {
                totalQuantity += reservationDetail.getQuantity();
                totalPrice += reservationDetail.getPrice() * reservationDetail.getQuantity();
            }
            reservation.setTotalPrice(totalPrice);
            reservation.setTotalQuantity(totalQuantity);
        }
        return list;
    }
}
