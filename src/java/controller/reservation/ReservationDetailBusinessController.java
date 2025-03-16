/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ReservationDAO;
import dal.ReservationDetailDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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

        String action = request.getParameter("action");
        ReservationDetailDAO rdDAO = new ReservationDetailDAO();
        ReservationDAO rDAO = new ReservationDAO();
        UserDAO uDAO = new UserDAO();

        String reservationId = request.getParameter("reservation_id");
        request.setAttribute("id", reservationId);
        switch (action) {
            case "assign":
                LocalDateTime currentDateTime = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String formattedDateTime = currentDateTime.format(formatter);
                Reservation reservation = rDAO.getReservation(Integer.parseInt(reservationId));
                int staff_id = Integer.parseInt(request.getParameter("staff_id"));
                int reservation_detail_id = Integer.parseInt(request.getParameter("reservation_detail_id"));

                if (rdDAO.assignStaff(staff_id, reservation_detail_id) && staff_id != -1) {
                    User staff = uDAO.get(staff_id);
                    String subject = "You have been assigned a new service task";
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

                ArrayList<ReservationDetail> rdList = rdDAO.getListReservationDetail(reservation.getId());
                ArrayList<User> staffList = uDAO.getAvailableStaff(reservation.getReverseDate());

                request.setAttribute("r", reservation);
                request.setAttribute("rdList", rdList);
                request.setAttribute("staffs", staffList);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
                break;
            default:
                Reservation reservation2 = rDAO.getReservation(Integer.parseInt(reservationId));
                ArrayList<ReservationDetail> rdList2 = rdDAO.getListReservationDetail(reservation2.getId());
                ArrayList<User> staffList2 = uDAO.getAvailableStaff(reservation2.getReverseDate());

                request.setAttribute("r", reservation2);
                request.setAttribute("rdList", rdList2);
                request.setAttribute("staffs", staffList2);
                request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO uDAO = new UserDAO();
        ReservationDAO rDAO = new ReservationDAO();
        ReservationDetailDAO rdDAO = new ReservationDetailDAO();
        int id = Integer.parseInt(req.getParameter("id"));

        Reservation reservation = rDAO.getReservation(id);
        ArrayList<ReservationDetail> rdList = rdDAO.getListReservationDetail(id);
        ArrayList<User> staffList = uDAO.getAvailableStaff(reservation.getReverseDate());

        req.setAttribute("r", reservation);
        req.setAttribute("rdList", rdList);
        req.setAttribute("staffs", staffList);
        req.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(req, resp);
    }

}
