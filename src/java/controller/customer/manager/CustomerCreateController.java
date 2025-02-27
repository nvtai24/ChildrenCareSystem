/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.manager;

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
 * @author milo9
 */
public class CustomerCreateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("dzName").trim();
        String password = request.getParameter("dzPassword").trim();
        String email = request.getParameter("dzEmail").trim();

        UserDAO userDAO = new UserDAO();

        if (userDAO.checkUsernameExists(username)) {
            request.setAttribute("error", "Username already exists.");
            request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
            return;
        }

        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Email already exists.");
            request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password); // Không mã hóa mật khẩu (theo yêu cầu)
        newUser.setEmail(email);

        boolean isRegistered = userDAO.register(newUser, 3);
        if (isRegistered) {
            response.sendRedirect("../customers");
        } else {
            request.setAttribute("error", "Add user failed. Please try again.");
            request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
        }
    }
}
