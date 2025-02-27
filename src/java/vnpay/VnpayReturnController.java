/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vnpay;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Enumeration;

/**
 *
 * @author Nvtai
 */
public class VnpayReturnController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Enumeration<String> params = request.getParameterNames();
        StringBuilder result = new StringBuilder();
        while (params.hasMoreElements()) {
            String paramName = params.nextElement();
            String paramValue = request.getParameter(paramName);
            result.append(paramName).append(": ").append(paramValue).append("\n");
        }

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        if ("00".equals(vnp_ResponseCode)) {
            request.setAttribute("form1", true);
            request.getRequestDispatcher("../reservation-complete.jsp").forward(request, response);
//            response.getWriter().write("Thanh toan thanh cong!\n " + result.toString());
        } else {
//            request.getRequestDispatcher("../reservation-confirm.jsp").forward(request, response);
            response.getWriter().write("Thanh toan that bai!\n " + result.toString());
        }

    }

}
