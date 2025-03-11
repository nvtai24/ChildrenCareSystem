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
import java.util.ArrayList;
import model.Reservation;
import model.ReservationDetail;
import model.ReservationStatus;

/**
 *
 * @author Admin
 */
public class ReservationListController extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        RoleDAO rDAO = new RoleDAO();
        ReservationDAO reservationDAO = new ReservationDAO();
        ReservationStatusDAO rsDAO = new ReservationStatusDAO();

        // Fetch status list
        ArrayList<ReservationStatus> statusList = rsDAO.list();
        request.setAttribute("statusList", statusList);

        // Check if the user is a staff or not
        if (rDAO.checkStaffRole((int) session.getAttribute("id"))) {
            // If staff, redirect to staff dashboard or reservation list
            request.getRequestDispatcher("dashboard/reservationList.jsp").forward(request, response);
        } else {
            // If not staff, get all reservations and show them
            ArrayList<Reservation> list = reservationDAO.listAllReservations();
            request.setAttribute("reservations", countTotalForReservation(list));
            request.getRequestDispatcher("dashboard/reservationList.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);  // Forward to doPost logic for simplicity
    }
    
    public ArrayList<Reservation> countTotalForReservation(ArrayList<Reservation> list) {
        for (Reservation reservation : list) {
            int totalQuantity = 0;
            double totalPrice = 0;
            for (ReservationDetail reservationDetail : reservation.getDetails()) {
                totalQuantity += reservationDetail.getQuantity();
                totalPrice += reservationDetail.getPrice();
            }
            reservation.setTotalPrice(totalPrice);
            reservation.setTotalQuantity(totalQuantity);
        }
        
        return list;
    }
    
}
