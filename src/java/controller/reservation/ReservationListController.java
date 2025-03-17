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
