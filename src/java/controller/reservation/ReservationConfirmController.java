/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ReservationDAO;
import dal.WishListDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import model.Reservation;
import model.ReservationDetail;
import model.WishList;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class ReservationConfirmController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        User current = (User) session.getAttribute("account");

        String firstName = req.getParameter("firstname");
        String lastName = req.getParameter("lastname");
        String dateStr = req.getParameter("date");
        String timeStr = req.getParameter("time");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String note = req.getParameter("note");

        LocalDate date = LocalDate.parse(dateStr);
        LocalTime time = LocalTime.parse(timeStr);
        LocalDateTime reserveDate = LocalDateTime.of(date, time);

        Reservation r = new Reservation().builder()
                .customer(current)
                .firstName(firstName)
                .lastName(lastName)
                .reverseDate(reserveDate)
                .phone(phone)
                .email(email != null ? email : "")
                .note(note != null ? note : "")
                .build();

        ArrayList<WishList> items = (ArrayList<WishList>) session.getAttribute("items");

        ArrayList<ReservationDetail> details = new ArrayList<>();
        for (WishList item : items) {
            ReservationDetail rd = new ReservationDetail();
            rd.setService(item.getService());
            rd.setQuantity(item.getQuantity());
            rd.setPrice(item.getService().getPrice());
            details.add(rd);
        }

        r.setDetails(details);
        double amount = details.stream()
                .mapToDouble(d -> d.getPrice() * d.getQuantity())
                .sum();

        session.setAttribute("r", r);
        session.setAttribute("amount", amount);
        req.getRequestDispatcher("../reservation-confirm.jsp").forward(req, resp);
    }

}
