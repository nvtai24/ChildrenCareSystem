/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import util.EmailUtil;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import model.auth.User;
import java.sql.Timestamp;

/**
 *
 * @author admin
 */
public class ForgetPasswordController extends HttpServlet {
   
    private static final long TOKEN_EXPIRATION_HOURS = 10; 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forget-password.jsp").forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO userDAO = new UserDAO();

        User user = userDAO.getUserByEmail(email);
        if (user != null) {
            String token = UUID.randomUUID().toString();
            long expirationTime = System.currentTimeMillis() + TimeUnit.HOURS.toMillis(TOKEN_EXPIRATION_HOURS);
            boolean isTokenGenerated = userDAO.generatePasswordResetToken(user.getId(), token, new Timestamp(expirationTime));

            if (isTokenGenerated) {
                String serverPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
                String contextPath = request.getContextPath();
                String resetLink = serverPath + contextPath + "/reset?token=" + token;
                EmailUtil.sendResetPasswordEmail(email, resetLink);
                request.setAttribute("successMessage", "A reset password link has been sent to your email.");
                request.getRequestDispatcher("forget-password.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to generate reset link. Please try again.");
                request.getRequestDispatcher("forget-password.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Email not exist in system.");
            request.getRequestDispatcher("forget-password.jsp").forward(request, response);
        }
    }
}