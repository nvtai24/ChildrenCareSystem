/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vnpay;

import dal.ReservationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Reservation;

/**
 *
 * @author Nvtai
 */
public class BookNowReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        if ("00".equals(vnp_ResponseCode)) {
            HttpSession session = request.getSession();

            Reservation r = (Reservation) session.getAttribute("r");

            r.setBanking(true);
            ReservationDAO rdb = new ReservationDAO();
            rdb.insertReservation(r);

            request.getRequestDispatcher("../booknow_success.jsp").forward(request, response);
        } else {
            response.sendRedirect("/app/services");
        }

    }

}
