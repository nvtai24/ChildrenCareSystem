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
import jakarta.servlet.http.HttpSession;
import java.util.stream.Collectors;
import model.PaymentHistory;
import model.Reservation;
import util.EmailUtil;

/**
 *
 * @author Nvtai
 */
public class BookNowReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String amount = request.getParameter("vnp_Amount");
        String transactionDate = request.getParameter("vnp_PayDate");
        String txnRef = request.getParameter("vnp_TxnRef");
        String transactionNo = request.getParameter("vnp_TransactionNo");

        if ("00".equals(vnp_ResponseCode)) {
            HttpSession session = request.getSession();

            Reservation r = (Reservation) session.getAttribute("r");

            r.setBanking(true);
            ReservationDAO rdb = new ReservationDAO();
            int id = rdb.insertReservation(r);

            request.setAttribute("rid", id);

            PaymentHistory ph = new PaymentHistory().builder()
                    .rid(id)
                    .amount(Integer.parseInt(amount))
                    .transactionDateString(transactionDate)
                    .txnRef(txnRef)
                    .transactionNo(transactionNo)
                    .build();

            System.out.println(ph.toString());

            PaymentHistoryDAO phdb = new PaymentHistoryDAO();
            phdb.insertPayment(ph);

            String email = r.getEmail(); // Get user email from Reservation object
            String subject = "Reservation Successful!";
            String serviceContent = r.getDetails().stream()
                    .map(s -> s.getService().getName() + " x" + s.getQuantity())
                    .collect(Collectors.joining(", "));

            double total = r.getDetails().stream().mapToDouble(d -> d.getPrice() * d.getQuantity()).sum();

            String message = String.format(
                    "Dear %s %s,\n\n"
                    + "🎉 Your reservation has been successfully processed! 🎉\n\n"
                    + "--------------------------------------------------\n"
                    + "🗓 Appointment Date: %s %s\n"
                    + "📞 Phone: %s\n"
                    + "📧 Email: %s\n"
                    + "📌 Reservation ID: %d\n"
                    + "💰 Total: $%.2f\n"
                    + "💳 Payment Method: Online Banking\n"
                    + "✅ Payment Status: Success\n"
                    + "--------------------------------------------------\n\n"
                    + "🛎️ Services Reserved:\n%s\n\n"
                    + "Thank you for using our service! We look forward to serving you.\n\n"
                    + "Best regards,\nYour Service Team",
                    r.getFirstName(), r.getLastName(),
                    r.getReverseDate().toLocalDate(), r.getReverseDate().toLocalTime(),
                    r.getPhone(), r.getEmail(),
                    id, total,
                    serviceContent
            );

            EmailUtil.sendReserveNotification(email, subject, message);

            request.getRequestDispatcher("../booknow_success.jsp").forward(request, response);
        } else {
            response.sendRedirect("/app/services");
        }

    }

}
