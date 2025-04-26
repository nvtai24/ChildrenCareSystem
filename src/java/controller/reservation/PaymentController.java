package controller.reservation;

import dal.ReservationDAO;
import dal.WishListDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.stream.Collectors;
import model.Reservation;
import model.WishList;
import util.EmailUtil;
import util.Vnpay;

public class PaymentController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String payment = request.getParameter("payment");
        HttpSession session = request.getSession();
        Reservation r = (Reservation) session.getAttribute("r");

        if (!payment.equals("banking")) {
            r.setBanking(false);
            ReservationDAO rdb = new ReservationDAO();
            int id = rdb.insertReservation(r);

            // Giảm số lượng wishlist
            ArrayList<WishList> items = (ArrayList<WishList>) session.getAttribute("items");
            WishListDAO wlDB = new WishListDAO();
            for (WishList item : items) {
                wlDB.deleteWishlistItem(item.getUser().getId(), item.getService().getId());
            }

            String email = r.getEmail();
            String subject = "Reservation Successful!";
            String serviceContent = r.getDetails().stream()
                    .map(s -> s.getService().getName() + " x" + s.getQuantity())
                    .collect(Collectors.joining(", "));

            double total = r.getDetails().stream().mapToDouble(d -> d.getPrice() * d.getQuantity()).sum();

            String message = String.format(
                    "Dear %s %s,\n\n"
                    + "Your reservation has been successfully processed.\n\n"
                    + "-----------------------------------------\n"
                    + "🗓 Appointment Date: %s %s\n"
                    + "📞 Phone: %s\n"
                    + "📧 Email: %s\n"
                    + "📌 Reservation ID: %d\n"
                    + "💰 Total: $%.2f\n"
                    + "💳 Payment Method: On Arrival\n"
                    + "-----------------------------------------\n\n"
                    + "Services:\n%s\n\n"
                    + "Thank you for using our service!\n"
                    + "Best regards,\nYour Service Team",
                    r.getFirstName(), r.getLastName(),
                    r.getReverseDate().toLocalDate(), r.getReverseDate().toLocalTime(),
                    r.getPhone(), r.getEmail(),
                    id, total,
                    serviceContent
            );

            EmailUtil.sendReserveNotification(email, subject, message);

            session.setAttribute("r", r);

            session.setAttribute("rid", id);
            request.getRequestDispatcher("../reservation-complete.jsp").forward(request, response);
            return;
        }

        try {
            // Lấy số tiền từ session
            double amount = (double) session.getAttribute("amount");

            // Tạo URL thanh toán VNPAY từ lớp Vnpay
            String paymentUrl = Vnpay.createPaymentUrl(request, r, amount);

            // Chuyển hướng người dùng đến VNPAY để thanh toán
            response.sendRedirect(paymentUrl);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
