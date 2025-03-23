/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.PasswordUtil;

/**
 *
 * @author admin
 */
public class ResetPasswordController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String token = request.getParameter("token");
        if (token == null || token.isEmpty()) {
            response.sendRedirect("forget-password.jsp");
        } else {
            request.setAttribute("token", token);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    } 
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("confirmPasswordError", "Passwords do not match.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }
        String hashedPassword = PasswordUtil.toSHA1(newPassword);
        UserDAO userDAO = new UserDAO();
        boolean isPasswordUpdated = userDAO.resetPassword(token, hashedPassword);

        if (isPasswordUpdated) {
            request.setAttribute("successMessage", "Password has been reset successfully.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid or expired token.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }
    
}
