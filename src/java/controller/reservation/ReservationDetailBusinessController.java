/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ReservationDAO;
import dal.ReservationDetailDAO;
import dal.RoleDAO;
import dal.UserDAO;
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
import model.auth.User;
import util.EmailUtil;

/**
 *
 * @author milo9
 */
public class ReservationDetailBusinessController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        //Get action
        String action = request.getParameter("action");

        //Get DAO
        ReservationDetailDAO rdDAO = new ReservationDetailDAO();
        ReservationDAO rDAO = new ReservationDAO();
        RoleDAO roleDAO = new RoleDAO();
        UserDAO uDAO = new UserDAO();

        // get attribute
        int userId = (int) session.getAttribute("id");
        boolean isStaff = roleDAO.checkStaffRole(userId);
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);
        String subject = "";

        //get parameter from form
        String reservationId = request.getParameter("reservation_id");

        Reservation reservation = reservation = rDAO.getReservation(Integer.parseInt(reservationId));;
        ArrayList<ReservationDetail> rdList = rdDAO.getListReservationDetail(reservation.getId());
        ArrayList<User> staffList;
        String serviceContent = reservation.getDetails().stream()
                .map(s2 -> s2.getService().getName() + " x" + s2.getQuantity())
                .collect(Collectors.joining(", "));

        switch (action) {
            case "assign" -> {
                int reservation_detail_id = Integer.parseInt(request.getParameter("reservation_detail_id"));
                int staff_id = Integer.parseInt(request.getParameter("staff_id"));

                if (rdDAO.assignStaff(staff_id, reservation_detail_id) && staff_id != -1 && rdDAO.changeStatusReservationDetail(2, reservation_detail_id)) {
                    User staff = uDAO.get(staff_id);
                    subject = "You have been assigned a new service task";
                    String message = String.format(
                            "Dear %s %s,\n\nYou have been assigned a new service task.\n\n"
                            + "Reservation ID: %d\n"
                            + "Service: %s\n"
                            + "Quantity: %d\n"
                            + "Price: %.2f\n"
                            + "Assigned time: %s\n\nThank you for your service!",
                            staff.getProfile().getFirstName(), staff.getProfile().getLastName(),
                            reservation.getId(), request.getParameter("servicename"),
                            Integer.parseInt(request.getParameter("quantity")),
                            Double.parseDouble(request.getParameter("price")),
                            formattedDateTime
                    );
                    EmailUtil.sendReserveNotification(staff.getEmail(), subject, message);
                }

                reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                request.setAttribute("r", reservation);
                rdList = rdDAO.getListReservationDetail(reservation.getId());
                request.setAttribute("rdList", rdList);
                staffList = uDAO.getAvailableStaff(reservation.getReverseDate());
                request.setAttribute("staffs", staffList);
                request.setAttribute("manager", !isStaff);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
            }

            case "confirm" -> {

                subject = "Reservation confirmed!";
                String message2 = generateReservationMessage(reservation, "Confirmed", formattedDateTime, null, serviceContent);
                EmailUtil.sendReserveNotification(reservation.getEmail(), subject, message2);
                rDAO.changeReservationStatus(2, reservation.getId()); // 2 - Confirmed

                reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                request.setAttribute("r", reservation);
                request.setAttribute("rdList", rdList);
                staffList = uDAO.getAvailableStaff(reservation.getReverseDate());
                request.setAttribute("staffs", staffList);
                request.setAttribute("manager", !isStaff);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
            }

            case "cancel" -> {

                subject = "Reservation cancel!";
                String message1 = generateReservationMessage(reservation, "Cancelled", formattedDateTime, request.getParameter("reason"), serviceContent);
                EmailUtil.sendReserveNotification(reservation.getEmail(), subject, message1);
                rDAO.changeReservationStatus(4, reservation.getId()); // 4 - Cancelled

                reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                request.setAttribute("r", reservation);
                request.setAttribute("rdList", rdList);
                staffList = uDAO.getAvailableStaff(reservation.getReverseDate());
                request.setAttribute("staffs", staffList);
                request.setAttribute("manager", !isStaff);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
            }

            case "rejectD" -> {
                int reservation_detail_id = Integer.parseInt(request.getParameter("reservation_detail_id"));
                rdDAO.changeStatusReservationDetail(3, reservation_detail_id);

                reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                request.setAttribute("r", reservation);
                rdList = rdDAO.getListReservationDetail(reservation.getId());
                request.setAttribute("rdList", rdList);
                staffList = uDAO.getAvailableStaff(reservation.getReverseDate());
                request.setAttribute("staffs", staffList);
                request.setAttribute("manager", !isStaff);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
            }

            case "confirmD" -> {

                int reservation_detail_id = Integer.parseInt(request.getParameter("reservation_detail_id"));
                rdDAO.changeStatusReservationDetail(4, reservation_detail_id);

                reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                request.setAttribute("r", reservation);
                rdList = rdDAO.getListReservationDetail(reservation.getId());
                request.setAttribute("rdList", rdList);
                staffList = uDAO.getAvailableStaff(reservation.getReverseDate());
                request.setAttribute("staffs", staffList);
                request.setAttribute("manager", !isStaff);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
            }

            case "processD" -> {

                int reservation_detail_id = Integer.parseInt(request.getParameter("reservation_detail_id"));
                rdDAO.changeStatusReservationDetail(5, reservation_detail_id);

                reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                request.setAttribute("r", reservation);
                rdList = rdDAO.getListReservationDetail(reservation.getId());
                request.setAttribute("rdList", rdList);
                staffList = uDAO.getAvailableStaff(reservation.getReverseDate());
                request.setAttribute("staffs", staffList);
                request.setAttribute("manager", !isStaff);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
            }

            case "completeD" -> {

                int reservation_detail_id = Integer.parseInt(request.getParameter("reservation_detail_id"));
                rdDAO.changeStatusReservationDetail(6, reservation_detail_id);

                reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                request.setAttribute("r", reservation);
                rdList = rdDAO.getListReservationDetail(reservation.getId());
                request.setAttribute("rdList", rdList);
                staffList = uDAO.getAvailableStaff(reservation.getReverseDate());
                request.setAttribute("staffs", staffList);
                request.setAttribute("manager", !isStaff);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
            }

            default -> {

                reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                request.setAttribute("r", reservation);
                request.setAttribute("rdList", rdList);
                staffList = uDAO.getAvailableStaff(reservation.getReverseDate());
                request.setAttribute("staffs", staffList);
                request.setAttribute("manager", !isStaff);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        RoleDAO roleDAO = new RoleDAO();
        int userId = (int) session.getAttribute("id");
        UserDAO uDAO = new UserDAO();
        ReservationDAO rDAO = new ReservationDAO();
        ReservationDetailDAO rdDAO = new ReservationDetailDAO();
        int id = Integer.parseInt(req.getParameter("id"));
        boolean isStaff = roleDAO.checkStaffRole(userId);
        Reservation reservation = rDAO.getReservation(id);

        ArrayList<ReservationDetail> rdList;
        if (isStaff) {
            rdList = rdDAO.getListReservationDetail(id, userId);
        } else {
            rdList = rdDAO.getListReservationDetail(id);
        }

        ArrayList<User> staffList = uDAO.getAvailableStaff(reservation.getReverseDate());

        req.setAttribute("r", reservation);
        req.setAttribute("rdList", rdList);
        req.setAttribute("staffs", staffList);
        req.setAttribute("manager", !isStaff);
        req.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(req, resp);
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

}
