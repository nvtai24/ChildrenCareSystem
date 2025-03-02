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
import model.auth.User;

/**
 *
 * @author admin
 */
public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        boolean hasError = false;
        String errorMessage = "";
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,15}$";

        int userId = (Integer) request.getSession().getAttribute("id");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(userId);

        if (user == null || !user.getPassword().equals(oldPassword)) {
            hasError = true;
            errorMessage = "Incorrect current password.";
        } else if (!newPassword.matches(passwordPattern)) {
            hasError = true;
            errorMessage = "Password must be 8-15 characters with at least one uppercase letter, one lowercase letter, and one number.";
        } else if (newPassword.equals(oldPassword)) {
            hasError = true;
            errorMessage = "New password cannot be the same as the old password.";
        } else if (!newPassword.equals(confirmNewPassword)) {
            hasError = true;
            errorMessage = "New passwords do not match.";
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (hasError) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"" + errorMessage + "\"}");
        } else {
            boolean isUpdated = userDAO.updatePassword(userId, newPassword);
            if (isUpdated) {
                response.getWriter().write("{\"status\":\"success\", \"message\":\"Password changed successfully.\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Failed to change password.\"}");
            }
        }
    }
}
