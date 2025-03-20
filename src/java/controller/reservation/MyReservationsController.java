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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Reservation;
import model.ReservationDetail;
import model.ReservationStatus;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class MyReservationsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User current = (User) session.getAttribute("account");

        ReservationDAO rdb = new ReservationDAO();
        ArrayList<Reservation> r = rdb.listMyReservations(current.getId());

        System.out.println(current.getId());

        for (Reservation reservation : r) {
            int quantiy = 0;
            double total = 0;

            for (ReservationDetail detail : reservation.getDetails()) {
                quantiy += detail.getQuantity();
                total += detail.getPrice() * detail.getQuantity();
            }
            reservation.setTotalQuantity(quantiy);
            reservation.setTotalPrice(total);
        }

        request.setAttribute("r", r);

        ArrayList<ReservationStatus> status = rdb.listStatus();
        request.setAttribute("stt", status);
        request.getRequestDispatcher("my-reservations.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
