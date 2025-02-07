/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.reservation;

import dal.ReservationDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.ReservationDetail;
import model.auth.User;

/**
 *
 * @author admin
 */
public class ReservationDetailController extends HttpServlet {
   private static final long serialVersionUID = 1L;
    private ReservationDetailDAO reservationdetailDAO;

    public void init() {
        reservationdetailDAO = new ReservationDetailDAO();
    }

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("account");
        int userId = user.getId();
        List<ReservationDetail> reservationDetails = reservationdetailDAO.getUserReservations(userId);
        double totalReservationPrice = reservationdetailDAO.getTotalReservationPrice(userId);
        
        request.setAttribute("reservationDetails", reservationDetails);
        request.setAttribute("totalPrice", totalReservationPrice);
        request.getRequestDispatcher("reservationDetail.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        int reservationId = Integer.parseInt(request.getParameter("reservationId"));

        if ("update".equals(action)) {
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int numberOfPersons = Integer.parseInt(request.getParameter("numPersons"));
            reservationdetailDAO.updateReservationDetail(reservationId, quantity, numberOfPersons);
        } else if ("delete".equals(action)) {
            reservationdetailDAO.deleteReservationDetail(reservationId);
        }

        response.sendRedirect("reservationDetail");
    }

}
