/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ProfileDAO;
import dal.ReservationDAO;
import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.util.stream.Collectors;
import model.Profile;
import model.Reservation;
import model.ReservationDetail;
import model.Service;
import model.auth.User;
import util.EmailUtil;
import vnpay.Config;

/**
 *
 * @author Nvtai
 */
public class BookNowController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        ServiceDAO sdb = new ServiceDAO();
        Service s = sdb.getServiceById(id);

        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");
        int uid = account.getId();

        ProfileDAO pDB = new ProfileDAO();
        Profile p = pDB.getProfileByUserId(uid);

        session.setAttribute("s", s);
        request.setAttribute("p", p);

        LocalDate tomorrow = LocalDate.now().plusDays(1);

        request.setAttribute("tommorow", tomorrow);
        request.getRequestDispatcher("booknow.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        Service s = (Service) session.getAttribute("s");

        ReservationDetail rd = new ReservationDetail().builder()
                .service(s)
                .quantity(1)
                .price(s.getPrice() * (1 - s.getDiscount() / 100))
                .build();

        session.setAttribute("amount", rd.getPrice());

        ArrayList<ReservationDetail> details = new ArrayList<>();
        details.add(rd);
        r.setDetails(details);

        String payment = request.getParameter("payment");
        if (payment.equals("banking")) {
            r.setBanking(true);

            session.setAttribute("r", r);

            try {
                String vnp_Version = "2.1.0";
                String vnp_Command = "pay";
                String orderType = "other";  // Hoặc lấy từ request parameter
                String vnp_TxnRef;  // Tạo mã giao dịch ngẫu nhiên
                vnp_TxnRef = Config.getRandomNumber(8);
                String vnp_IpAddr = Config.getIpAddress(request);
                String vnp_TmnCode = Config.vnp_TmnCode;

                long amount = (long) rd.getPrice() * 100 * 25000;

                // Tạo map chứa tham số
                Map<String, String> vnp_Params = new HashMap<>();
                vnp_Params.put("vnp_Version", vnp_Version);
                vnp_Params.put("vnp_Command", vnp_Command);
                vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                vnp_Params.put("vnp_Amount", String.valueOf(amount));
                vnp_Params.put("vnp_CurrCode", "VND");
                vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang: " + vnp_TxnRef);
                vnp_Params.put("vnp_OrderType", orderType);
                vnp_Params.put("vnp_Locale", "vn");
                vnp_Params.put("vnp_ReturnUrl", "http://localhost:8082/app/book/success");
                vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

                // Thêm thời gian tạo giao dịch
                Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                String vnp_CreateDate = formatter.format(cld.getTime());
                vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                // Tạo chuỗi hash và query
                List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
                Collections.sort(fieldNames);
                StringBuilder hashData = new StringBuilder();
                StringBuilder query = new StringBuilder();
                Iterator<String> itr = fieldNames.iterator();
                while (itr.hasNext()) {
                    String fieldName = itr.next();
                    String fieldValue = vnp_Params.get(fieldName);
                    if ((fieldValue != null) && (fieldValue.length() > 0)) {
                        // Build hash data
                        hashData.append(fieldName);
                        hashData.append('=');
                        hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        // Build query
                        query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                        query.append('=');
                        query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                        if (itr.hasNext()) {
                            query.append('&');
                            hashData.append('&');
                        }
                    }
                }

                // Tạo secure hash
                String queryUrl = query.toString();
                String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
                queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

                // Chuyển hướng đến trang thanh toán VNPAY
                response.sendRedirect(paymentUrl);

            } catch (Exception e) {
                e.printStackTrace();
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("Errror: " + e.getMessage());
            }

        } else {
            r.setBanking(false);

            ReservationDAO rdb = new ReservationDAO();
            int id = rdb.insertReservation(r);

            String subject = "Reservation Successful!";
            String serviceContent = r.getDetails().stream()
                    .map(s2 -> s2.getService().getName() + " x" + s2.getQuantity())
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
            request.getRequestDispatcher("booknow_success.jsp").forward(request, response);
        }

    }

}
