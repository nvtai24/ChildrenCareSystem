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
import java.io.PrintWriter;
import model.PaymentHistory;
import util.Vnpay;

/**
 *
 * @author Nvtai
 */
public class PaymentRefundController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        int id = Integer.parseInt(request.getParameter("id"));

        PaymentHistoryDAO phdb = new PaymentHistoryDAO();
        PaymentHistory p = phdb.getPaymentHistoryInfo(id);

        String responseCode = Vnpay.refundTransaction(request, p.getTxnRef(), p.getAmount(), p.getTransactionDateString());
        ReservationDAO rdb = new ReservationDAO();
        rdb.cancelReservation2(id);
        if ("00".equals(responseCode)) {
            out.print("{\"success\": true, \"message\": \"Email sent successfully\"}");
            out.flush();
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            out.print("{\"success\": false, \"message\": \"Some thing wrong!\"}");
            out.flush();
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }

}
