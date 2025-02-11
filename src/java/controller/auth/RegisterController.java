/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.auth.User;
import java.util.UUID;

/**
 *
 * @author Nvtai
 */
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.html").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("checkUsername".equals(action)) {
            // Kiểm tra username có tồn tại không
            String username = request.getParameter("username");
            boolean exists = userDAO.checkUsernameExists(username);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }

        if ("checkEmail".equals(action)) {
            // Kiểm tra email có tồn tại không
            String email = request.getParameter("email");
            boolean exists = userDAO.checkEmailExists(email);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }
        String username = request.getParameter("dzName");
        String password = request.getParameter("dzPassword");
        String email = request.getParameter("dzEmail");

        // Kiểm tra username đã tồn tại chưa
        if (userDAO.checkUsernameExists(username)) {
            response.getWriter().write("<script>alert('Username already exists!'); window.location='register.html';</script>");
            return;
        }

        if (userDAO.checkEmailExists(email)) {
            response.getWriter().write("<script>alert('Email already exists!'); window.location='register.html';</script>");
            return;
        }
        String verificationToken = UUID.randomUUID().toString();
        // Tạo user mới
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password); // Không mã hóa mật khẩu (theo yêu cầu)
        newUser.setEmail(email);
        newUser.setVerificationToken(verificationToken);
        newUser.setVerified(false);
        // Thực hiện đăng ký
        boolean isRegistered = userDAO.register(newUser);
        if (isRegistered) {
            // Send verification email
            String verificationLink = "http://localhost:8080/app/verify?token=" + verificationToken;
            OAuth2EmailService.sendVerificationEmail(email, verificationLink);

            // Redirect to login with success message
            response.sendRedirect("login.html?success=1");
        } else {
            // Registration failed
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.html").forward(request, response);
        }
    }
}
