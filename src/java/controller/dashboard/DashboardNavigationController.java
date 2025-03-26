/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard;

import dal.FeedbackDAO;
import dal.ReservationDAO;
import dal.ReservationDetailDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Reservation;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class DashboardNavigationController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");

        if (account.getRole().getId() == 12 || (account.getRole().getId() == 14) || (account.getRole().getId() == 16)) {

            ReservationDAO reservationDAO = new ReservationDAO();
            UserDAO userDAO = new UserDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            List<Reservation> reservations = reservationDAO.getRecentReservations();
            List<User> latestUsers = userDAO.getLatestFiveUsers();
            ReservationDetailDAO dao = new ReservationDetailDAO();
            int totalFeedback = feedbackDAO.countFeedbackInLast7Days();
            int totalUsers = userDAO.countUsersInLast7Days();
            double totalRevenue = dao.getTotalRevenue();
            int totalReservations = reservationDAO.countReservationsInLast7Days();
            int totalReservations1 = reservationDAO.countReservations1InLast7Days();
            int totalReservations2 = reservationDAO.countReservations2InLast7Days();
            int totalReservations3 = reservationDAO.countReservations3InLast7Days();
            int totalReservations4 = reservationDAO.countReservations4InLast7Days();
            int totalReservations5 = reservationDAO.countReservations5InLast7Days();
            request.setAttribute("totalReservations", totalReservations);
            request.setAttribute("totalReservations1", totalReservations1);
            request.setAttribute("totalReservations2", totalReservations2);
            request.setAttribute("totalReservations3", totalReservations3);
            request.setAttribute("totalReservations4", totalReservations4);
            request.setAttribute("totalReservations5", totalReservations5);
            request.setAttribute("reservations", reservations);
            request.setAttribute("latestUsers", latestUsers);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalFeedback", totalFeedback);

            request.getRequestDispatcher("dashboard/dashboard.jsp").forward(request, response);
        } else if (account.getRole().getId() == 13) {
            response.sendRedirect("/app/reservations");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
