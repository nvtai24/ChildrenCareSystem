/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ReservationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Reservation;

/**
 *
 * @author Nvtai
 */
public class ReservationInfoController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        ReservationDAO rdb = new ReservationDAO();
        Reservation r = rdb.getReservation(id);

//        response.getWriter().print(r);
        double total = r.getDetails()
                .stream()
                .mapToDouble(d -> d.getPrice() * d.getQuantity())
                .sum();
        
        request.setAttribute("r", r);
        request.setAttribute("total", total);
        request.getRequestDispatcher("../reservation-info.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
}
