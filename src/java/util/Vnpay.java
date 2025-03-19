/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.http.HttpServletRequest;
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
import java.util.stream.Collectors;
import model.Reservation;

/**
 *
 * @author Nvtai
 */
public class Vnpay {

    // Phương thức tạo URL thanh toán cho VNPAY
    public static String createPaymentUrl(HttpServletRequest request, Reservation r, double amount) {
        try {
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";  // Hoặc lấy từ request parameter
            String vnp_TxnRef = VnpayConfig.getRandomNumber(8) + System.nanoTime(); // Tạo mã giao dịch ngẫu nhiên
            String vnp_IpAddr = VnpayConfig.getIpAddress(request);
            String vnp_TmnCode = VnpayConfig.vnp_TmnCode;

            // Tính số tiền thanh toán (lấy từ session hoặc tính từ các chi tiết)
            long totalAmount = (long) (amount * 100 * 23500); // Quy đổi tiền thành đơn vị VND (hệ số 100)

            // Tạo chuỗi mô tả dịch vụ
            String serviceContent = r.getDetails().stream()
                    .map(s -> s.getService().getName() + " x" + s.getQuantity())
                    .collect(Collectors.joining(", "));

            // Tạo map chứa tham số
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(totalAmount));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", "Transaction Reference: " + vnp_TxnRef + ", " + serviceContent);
            vnp_Params.put("vnp_OrderType", orderType);
            vnp_Params.put("vnp_Locale", "vn");
            vnp_Params.put("vnp_ReturnUrl", VnpayConfig.vnp_ReturnUrl);
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
            String vnp_SecureHash = VnpayConfig.hmacSHA512(VnpayConfig.vnp_HashSecret, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            return VnpayConfig.vnp_PayUrl + "?" + queryUrl;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Phương thức hoàn tiền cho giao dịch VNPAY
     *
     * @param txnRef Mã giao dịch gốc cần hoàn tiền
     * @param amount Số tiền cần hoàn (USD)
     * @param transactionDate Ngày giao dịch gốc (định dạng yyyyMMddHHmmss)
     * @return URL hoàn tiền hoặc null nếu xảy ra lỗi
     */
    public static String refundTransaction(HttpServletRequest request, String txnRef, double amount, String transactionDate) {
        try {
            String vnp_Version = "2.1.0";
            String vnp_Command = "refund";
            String vnp_TmnCode = VnpayConfig.vnp_TmnCode;
            String vnp_TxnRef = VnpayConfig.getRandomNumber(8); // Mã giao dịch hoàn tiền mới
            String vnp_IpAddr = VnpayConfig.getIpAddress(request);

            // Tạo map chứa tham số
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_OrderInfo", "Refund for transaction: " + txnRef);
            vnp_Params.put("vnp_TransactionNo", txnRef); // Mã giao dịch gốc
            vnp_Params.put("vnp_TransactionDate", transactionDate); // Ngày giao dịch gốc
            vnp_Params.put("vnp_CreateBy", "System"); // Người thực hiện hoàn tiền
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
            vnp_Params.put("vnp_TransactionType", "02"); // 02 là mã hoàn tiền
            vnp_Params.put("vnp_CurrCode", "VND");

            // Thêm thời gian tạo yêu cầu hoàn tiền
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
            String vnp_SecureHash = VnpayConfig.hmacSHA512(VnpayConfig.vnp_HashSecret, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            
            return VnpayConfig.vnp_RefundUrl + "?" + queryUrl;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
