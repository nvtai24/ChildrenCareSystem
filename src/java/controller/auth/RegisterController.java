/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import at.favre.lib.crypto.bcrypt.BCrypt;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.Date;
import model.auth.User;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author Nvtai
 */
public class RegisterController extends HttpServlet {

    private static final long TOKEN_EXPIRATION_HOURS = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *  
     * @param request servlet request
     * @param response servlet response
     * @throws ServletExce      tion if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("checkUsername".equals(action)) {

            String username = request.getParameter("username");
            boolean exists = userDAO.checkUsernameExists(username);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }

        if ("checkEmail".equals(action)) {

            String email = request.getParameter("email");
            boolean exists = userDAO.checkEmailExists(email);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }
        String username = request.getParameter("dzName");
        String password = request.getParameter("dzPassword");
        String email = request.getParameter("dzEmail");

        if (username.length() < 5 || username.length() > 30 || username.contains(" ")) {
            request.setAttribute("usernameError", "Username must be 5-30 characters and cannot contain spaces.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

                
        if (password.length() < 8 || password.length() > 15 || !password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,15}$")) {
            request.setAttribute("passwordError", "Password must be 8-15 characters with at least one uppercase letter, one lowercase letter, and one number.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (userDAO.checkUsernameExists(username)) {
            request.setAttribute("usernameError", "Username already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("emailError", "Email already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        String token = UUID.randomUUID().toString();
        //String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        long expirationTime = System.currentTimeMillis() + TimeUnit.HOURS.toMillis(TOKEN_EXPIRATION_HOURS);

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setVerificationToken(token);
        newUser.setTokenExpiration(new Timestamp(expirationTime));
        boolean isRegistered = userDAO.register(newUser);
        if (isRegistered) {
            String verificationLink = "http://localhost:8080/app/verify?token=" + token + "&redirect=login";
            EmailUtil.sendVerificationEmail(email, verificationLink);
            request.setAttribute("successMessage", "A verify link has been sent to your email.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("../register.jsp").forward(request, response);
        }
    }
}
