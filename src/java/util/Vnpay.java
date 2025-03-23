/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
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
import org.json.JSONObject;

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

        } catch (UnsupportedEncodingException e) {
            return null;
        }
    }

    public static String refundTransaction(HttpServletRequest request, String txnRef, long amount, String transactionDate) {
        try {
            // Tạo requestId duy nhất
            String vnp_RequestId = VnpayConfig.getRandomNumber(16);
            String vnp_Version = "2.1.0";
            String vnp_Command = "refund";
            String vnp_TmnCode = VnpayConfig.vnp_TmnCode;
            String vnp_TransactionType = "02"; // 02: Hoàn trả toàn phần
            String vnp_TxnRef = txnRef; // Mã giao dịch thanh toán gốc
            String vnp_Amount = String.valueOf(amount);
            String vnp_TransactionNo = ""; // Có thể để trống nếu là tham số tùy chọn
            String vnp_OrderInfo = "Refund for transaction: " + txnRef;
            String vnp_IpAddr = VnpayConfig.getIpAddress(request);
            String vnp_CreateBy = "System"; // Người thực hiện hoàn tiền

            // Thêm thời gian tạo yêu cầu hoàn tiền
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());

            // Tạo chuỗi dữ liệu để tính toán checksum theo đúng định dạng yêu cầu
            String data = vnp_RequestId + "|" + vnp_Version + "|" + vnp_Command + "|" + vnp_TmnCode + "|"
                    + vnp_TransactionType + "|" + vnp_TxnRef + "|" + vnp_Amount + "|" + vnp_TransactionNo + "|"
                    + transactionDate + "|" + vnp_CreateBy + "|" + vnp_CreateDate + "|" + vnp_IpAddr + "|"
                    + vnp_OrderInfo;

            // Tạo checksum với secret key
            String vnp_SecureHash = VnpayConfig.hmacSHA512(VnpayConfig.vnp_HashSecret, data);

            // Tạo JSON body cho request POST
            JSONObject requestData = new JSONObject();
            requestData.put("vnp_RequestId", vnp_RequestId);
            requestData.put("vnp_Version", vnp_Version);
            requestData.put("vnp_Command", vnp_Command);
            requestData.put("vnp_TmnCode", vnp_TmnCode);
            requestData.put("vnp_TransactionType", vnp_TransactionType);
            requestData.put("vnp_TxnRef", vnp_TxnRef);
            requestData.put("vnp_Amount", vnp_Amount);
            requestData.put("vnp_OrderInfo", vnp_OrderInfo);

            if (vnp_TransactionNo != null && !vnp_TransactionNo.isEmpty()) {
                requestData.put("vnp_TransactionNo", vnp_TransactionNo);
            }

            requestData.put("vnp_TransactionDate", transactionDate);
            requestData.put("vnp_CreateBy", vnp_CreateBy);
            requestData.put("vnp_CreateDate", vnp_CreateDate);
            requestData.put("vnp_IpAddr", vnp_IpAddr);
            requestData.put("vnp_SecureHash", vnp_SecureHash);

            // Thực hiện HTTP POST request
            URL url = new URL(VnpayConfig.vnp_RefundUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = requestData.toString().getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Đọc response
            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }
            }
//                        return response.toString();

            JSONObject jsonRes = new JSONObject(response.toString());
            String vnp_ResponseCode = jsonRes.optString("vnp_ResponseCode");
            return vnp_ResponseCode;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
