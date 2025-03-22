/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.PaymentHistoryDAO;
import dal.ReservationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PaymentHistory;
import model.Reservation;
import util.Vnpay;

/**
 *
 * @author Nvtai
 */
public class PaymentRefundController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        PaymentHistoryDAO phdb = new PaymentHistoryDAO();
        PaymentHistory p = phdb.getPaymentHistoryInfo(id);

        String responseCode = Vnpay.refundTransaction(request, p.getTxnRef(), p.getAmount(), p.getTransactionDateString());

        response.getWriter().print(responseCode);

        if ("00".equals(responseCode)) {
            ReservationDAO rdb = new ReservationDAO();
            rdb.cancelReservation(id);
        }

    }

}
