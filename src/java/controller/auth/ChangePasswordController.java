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

        if (!newPassword.equals(confirmNewPassword)) {
            hasError = true;
            request.setAttribute("errorConfirmPassword", "New passwords do not match.");
        }

        int userId = (Integer) request.getSession().getAttribute("userId");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(userId);

        if (user == null || !user.getPassword().equals(oldPassword)) {
            hasError = true;
            request.setAttribute("errorOldPassword", "Incorrect current password.");
        }

        if (hasError) {
            request.setAttribute("errorNewPassword", "Password cannot be empty or invalid.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        boolean isUpdated = userDAO.updatePassword(userId, newPassword);

        if (isUpdated) {
            request.setAttribute("successMessage", "Password changed successfully.");
            response.sendRedirect("profile.jsp");  // Chuyển hướng về trang profile
        } else {
            request.setAttribute("errorMessage", "Failed to change password.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}