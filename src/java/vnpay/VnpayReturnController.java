/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vnpay;

import dal.ReservationDAO;
import dal.WishListDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Enumeration;
import model.Reservation;
import model.WishList;
import util.EmailUtil;

/**
 *
 * @author Nvtai
 */
public class VnpayReturnController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        Enumeration<String> params = request.getParameterNames();
//        StringBuilder result = new StringBuilder();
//        while (params.hasMoreElements()) {
//            String paramName = params.nextElement();
//            String paramValue = request.getParameter(paramName);
//            result.append(paramName).append(": ").append(paramValue).append("\n");
//        }

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        if ("00".equals(vnp_ResponseCode)) {
            HttpSession session = request.getSession();

            Reservation r = (Reservation) session.getAttribute("r");

            r.setBanking(true);
            ReservationDAO rdb = new ReservationDAO();
            System.out.println(r);
            rdb.insertReservation(r);

            ArrayList<WishList> items = (ArrayList<WishList>) session.getAttribute("items");
            WishListDAO wlDB = new WishListDAO();

            for (WishList item : items) {
                wlDB.deleteWishlistItem(item.getUser().getId(), item.getService().getId());
            }

            session.removeAttribute("items");
            r.setDetails(null);

            String email = r.getEmail(); // Get user email from Reservation object
            String subject = "Reservation Successful!";
            String message = "Dear " + r.getFirstName() + " " + r.getLastName() + ",\n\n"
//                    + "Your reservation has been successfully processed for the service: " + r.getService().getName() + "\n"
                    + "Appointment Date: " + r.getReverseDate().toString() + "\n"
                    + "Reservation ID: " + r.getId() + "\n\n"
                    + "Thank you for using our service!";
            
             EmailUtil.sendReserveNotification(email, subject, message);

            session.setAttribute("r", r);

            request.getRequestDispatcher("../reservation-complete.jsp").forward(request, response);
//            response.getWriter().write("Success!\n " + result.toString());
        } else {
            request.getRequestDispatcher("../reservation-confirm.jsp").forward(request, response);
//            response.getWriter().write("Failed!\n " + result.toString());
        }
    }

}
