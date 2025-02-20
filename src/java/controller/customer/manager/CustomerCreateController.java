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

        request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
    }

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
        // Tạo user mới
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password); // Không mã hóa mật khẩu (theo yêu cầu)
        newUser.setEmail(email);

        // Thực hiện đăng ký
        boolean isRegistered = userDAO.register(newUser, 3);
        if (isRegistered) {
            // Redirect to login with success message
            response.sendRedirect("../customers");
        } else {
            // Registration failed
            request.setAttribute("error", "Add user failed. Please try again.");
            request.getRequestDispatcher("customerCreate.jsp").forward(request, response);
        }
    }
}
