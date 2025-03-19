/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.http.HttpServletRequest;
import java.nio.charset.StandardCharsets;
import java.util.Random;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author Nvtai
 */
public class VnpayConfig {

    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl = "http://localhost:8082/app/reservation/return";
    public static String vnp_RefundUrl = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";
    public static String vnp_TmnCode = "F8A8DA01";
    public static String vnp_HashSecret = "VTKXJD7QEEMK1323DEH5LQ6KREB2P6PA";

    // Các phương thức utility
    public static String getRandomNumber(int len) {
        Random rnd = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAddrStr = request.getHeader("X-FORWARDED-FOR");
        if (ipAddrStr == null) {
            ipAddrStr = request.getRemoteAddr();
        }
        return ipAddrStr;
    }

    public static String hmacSHA512(String key, String data) {
        try {
            Mac sha512_HMAC = Mac.getInstance("HmacSHA512");
            byte[] hmacKeyBytes = key.getBytes();
            SecretKeySpec secretKey = new SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            sha512_HMAC.init(secretKey);
            byte[] messageBytes = data.getBytes(StandardCharsets.UTF_8);
            byte[] result = sha512_HMAC.doFinal(messageBytes);
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (Exception ex) {
            return "";
        }
    }
}
