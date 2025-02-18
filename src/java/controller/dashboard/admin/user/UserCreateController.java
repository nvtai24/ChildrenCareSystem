/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard.admin.user;

import dal.RoleDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.auth.Role;
import model.auth.User;

/**
 *
 * @author Admin
 */
public class UserCreateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RoleDAO rDB = new RoleDAO();
        ArrayList<Role> roles = rDB.listAllAvailableRole();
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("../dashboard/userCreate.jsp").forward(request, response);
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
        int role_id = Integer.parseInt(request.getParameter("role_id"));
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
        boolean isRegistered = userDAO.register(newUser, role_id);
        if (isRegistered) {
            // Redirect to login with success message
            response.sendRedirect("../users");
        } else {
            // Registration failed
            request.setAttribute("error", "Add user failed. Please try again.");
            request.getRequestDispatcher("userCreate.jsp").forward(request, response);
        }
    }

}
