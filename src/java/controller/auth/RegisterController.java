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
        request.getRequestDispatcher("register.jsp").forward(request, response);
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
        
        //String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        
        boolean isRegistered = userDAO.register(newUser);
        if (isRegistered) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("../register.jsp").forward(request, response);
        }
    }
}
