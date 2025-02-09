/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.service.publi;

import dal.FeedbackDAO;
import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Feedback;
import model.Service;

/**
 *
 * @author Nvtai
 */
public class ServiceDetailsPublicController extends HttpServlet {

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

        int id = Integer.parseInt(request.getParameter("id"));

        ServiceDAO sDB = new ServiceDAO();
        Service s = sDB.getServiceById(id);
        request.setAttribute("s", s);

        FeedbackDAO fDB = new FeedbackDAO();
        List<Feedback> feedbacks = fDB.listFeedbacksOfService(id);
        request.setAttribute("feedbacks", feedbacks);

        fDB = new FeedbackDAO();
        List<Feedback> ones = fDB.listFeedbacksOfServiceByRating(id, 1);
        request.setAttribute("ones", ones);

        fDB = new FeedbackDAO();
        List<Feedback> twos = fDB.listFeedbacksOfServiceByRating(id, 2);
        request.setAttribute("twos", twos);

        fDB = new FeedbackDAO();
        List<Feedback> threes = fDB.listFeedbacksOfServiceByRating(id, 3);
        request.setAttribute("threes", threes);

        fDB = new FeedbackDAO();
        List<Feedback> fours = fDB.listFeedbacksOfServiceByRating(id, 4);
        request.setAttribute("fours", fours);

        fDB = new FeedbackDAO();
        List<Feedback> fives = fDB.listFeedbacksOfServiceByRating(id, 5);
        request.setAttribute("fives", fives);

        fDB = new FeedbackDAO();
        int average = fDB.getAverageRating(id);
        request.setAttribute("average", average);

        request.getRequestDispatcher("service-details.jsp").forward(request, response);
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
