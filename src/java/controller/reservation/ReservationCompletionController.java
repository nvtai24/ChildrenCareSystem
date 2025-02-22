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
public class ReservationCompletionController extends HttpServlet {

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
        User current = (User) session.getAttribute("account");

        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String dateStr = request.getParameter("date");
        String timeStr = request.getParameter("time");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String note = request.getParameter("note");
//        String paymentStr = request.getParameter("payment");

        LocalDate date = LocalDate.parse(dateStr);
        LocalTime time = LocalTime.parse(timeStr);
        LocalDateTime reserveDate = LocalDateTime.of(date, time);

//        boolean payment = paymentStr.equalsIgnoreCase("banking");

        Reservation r = new Reservation().builder()
                .customer(current)
                .firstName(firstName)
                .lastName(lastName)
                .reverseDate(reserveDate)
                .phone(phone)
                .email(email != null ? email : "")
                .note(note != null ? note : "")
//                .banking(payment)
                .build();

        ArrayList<WishList> items = (ArrayList<WishList>) session.getAttribute("items");
        WishListDAO wlDB = new WishListDAO();

        ArrayList<ReservationDetail> details = new ArrayList<>();
        for (WishList item : items) {
            ReservationDetail rd = new ReservationDetail();
            rd.setService(item.getService());
            rd.setQuantity(item.getQuantity());
            rd.setPrice(item.getService().getPrice());
            details.add(rd);
//            wlDB.deleteWishlistItem(item.getUser().getId(), item.getService().getId());
        }

        r.setDetails(details);

//        ReservationDAO rDB = new ReservationDAO();
//        rDB.insertReservation(r);
        session.setAttribute("r", r);

        request.getRequestDispatcher("../reservation-completion.jsp").forward(request, response);
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
