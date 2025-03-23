/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ReservationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import model.Reservation;

/**
 *
 * @author Nvtai
 */
public class ReservationEditController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        ReservationDAO rdb = new ReservationDAO();
        Reservation r = rdb.getReservation(id);
        
        double total = r.getDetails()
                .stream()
                .mapToDouble(d -> d.getPrice() * d.getQuantity())
                .sum();

        request.setAttribute("r", r);
        request.setAttribute("total", total);
        
        request.getRequestDispatcher("../reservation-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String dateStr = request.getParameter("date");
        String timeStr = request.getParameter("time");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String note = request.getParameter("note");

        LocalDate date = LocalDate.parse(dateStr);
        LocalTime time = LocalTime.parse(timeStr);
        LocalDateTime reserveDate = LocalDateTime.of(date, time);

        Reservation r = new Reservation().builder()
                .id(id)
                .firstName(firstName)
                .lastName(lastName)
                .reverseDate(reserveDate)
                .phone(phone)
                .email(email != null ? email : "")
                .note(note != null ? note : "")
                .build();
                
        ReservationDAO rdb = new ReservationDAO();
        rdb.updateReservationContact(r);
        
        response.sendRedirect("/app/history");
    }

}
