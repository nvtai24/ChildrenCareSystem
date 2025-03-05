/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package util;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class CheckLoginAjax extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);  // false để không tạo session mới nếu không tồn tại

        User account = (User) session.getAttribute("account");
        boolean isLoggedIn = account != null;
        Integer userId = isLoggedIn ? account.getId() : null; // Kiểm tra account != null trước khi lấy userId

        // Trả về JSON cho AJAX
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"isLoggedIn\": " + isLoggedIn + ", \"userId\": " + (userId != null ? userId : "null") + "}");
    }

}
