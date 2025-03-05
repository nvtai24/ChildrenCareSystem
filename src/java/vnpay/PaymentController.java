/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vnpay;

import dal.ReservationDAO;
import dal.WishListDAO;
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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import model.Reservation;
import model.ReservationDetail;
import model.WishList;

/**
 *
 * @author Nvtai
 */
public class PaymentController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String payment = request.getParameter("payment");
        HttpSession session = request.getSession();
        Reservation r = (Reservation) session.getAttribute("r");

        if (!payment.equals("banking")) {
            r.setBanking(false);
            ReservationDAO rdb = new ReservationDAO();
            rdb.insertReservation(r);

            ArrayList<WishList> items = (ArrayList<WishList>) session.getAttribute("items");
            WishListDAO wlDB = new WishListDAO();

            for (WishList item : items) {
                wlDB.deleteWishlistItem(item.getUser().getId(), item.getService().getId());
            }

            session.removeAttribute("items");
            r.setDetails(null);
            session.setAttribute("r", r);

            request.getRequestDispatcher("../reservation-complete.jsp").forward(request, response);
            return;
        }

        try {
            // Lấy các tham số
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";  // Hoặc lấy từ request parameter
            String vnp_TxnRef;  // Tạo mã giao dịch ngẫu nhiên
            vnp_TxnRef = Config.getRandomNumber(8);
            String vnp_IpAddr = Config.getIpAddress(request);
            String vnp_TmnCode = Config.vnp_TmnCode;

            long amount = (long) ((double) session.getAttribute("amount") * 100 * 25000);

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
            vnp_Params.put("vnp_ReturnUrl", Config.vnp_Returnurl);
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
    }
}
