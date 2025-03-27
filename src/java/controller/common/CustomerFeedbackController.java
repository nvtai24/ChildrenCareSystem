/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common;

import dal.FeedbackDAO;
import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import model.Feedback;
import model.Service;
import util.EmailUtil;

/**
 *
 * @author ADMIN
 */
public class CustomerFeedbackController extends HttpServlet {

    public static String RESERVATION_URL = "http://localhost:9999/app/reservation/info?id=";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerFeedbackController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerFeedbackController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        
        try {
            
            String reservationId = request.getParameter("rDetailId");
            String customerEmail = request.getParameter("email");
            HttpSession session = request.getSession();
            String action = request.getParameter("action");
            if (reservationId != null) {
                var reservationLink = RESERVATION_URL.concat(reservationId);
            }
            switch (action) {
                case "feedback" -> {
                    request.setAttribute("rDetailId", reservationId);
                    request.getRequestDispatcher("customer-feedback.jsp").forward(request, response);
                    break;
                }
            }
        } catch (Exception e) {
            System.out.println(e);
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
        try {
            int reservationId = request.getParameter("rDetailId") != null ? Integer.parseInt(request.getParameter("rDetailId")) : 0;;
            int rate = request.getParameter("rate") != null ? Integer.parseInt(request.getParameter("rate")) : 0;
            String comment = request.getParameter("comment");

            HttpSession session = request.getSession();

            var feedbackDAO = new FeedbackDAO();
            var feedbackModel = new Feedback();
            feedbackModel.setReservationDetailId(reservationId);
            feedbackModel.setComment(comment);
            feedbackModel.setRating(rate);
            feedbackModel.setCreatedDate(LocalDateTime.now());

            var result = feedbackDAO.addFeedbackByUser(feedbackModel);
            if (result) {
                session.setAttribute("successMessage", "Send feedback successfully! Thanks for your feedback!");
                response.sendRedirect(request.getContextPath() + "/history");

            } else {
                session.setAttribute("errorMessage",  "You have already provided feedback for this reservation! You cannot submit more.");
                response.sendRedirect(request.getContextPath() + "/history");
            }
            

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
