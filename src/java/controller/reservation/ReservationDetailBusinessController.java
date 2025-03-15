/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ReservationDAO;
import dal.ReservationDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Reservation;
import model.ReservationDetail;

/**
 *
 * @author milo9
 */
public class ReservationDetailBusinessController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ReservationDAO rDAO = new ReservationDAO();
        ReservationDetailDAO rdDAO = new ReservationDetailDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        Reservation list = rDAO.getReservation(id);
        ArrayList<ReservationDetail> rdList = rdDAO.getListReservationDetail(id);
        
        request.getRequestDispatcher("dashboard/reservationDetail.jsp").forward(request, response);

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
