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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    String username = request.getParameter("dzName");
    String password = request.getParameter("dzPassword");
    String email = request.getParameter("dzEmail");

        UserDAO userDAO = new UserDAO();

        // Kiểm tra username đã tồn tại chưa
        if (userDAO.checkUsernameExists(username)) {
            request.setAttribute("error", "Username already exists. Please choose another one.");
            request.getRequestDispatcher("register.html").forward(request, response);
            return;
        }

        // Tạo user mới
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password); // Không mã hóa mật khẩu (theo yêu cầu)
        newUser.setEmail(email);

        // Thực hiện đăng ký
        boolean isRegistered = userDAO.register(newUser);
        if (isRegistered) {
            response.sendRedirect("login.html?success=1");
    } else {
        request.setAttribute("error", "Registration failed. Please try again.");
        request.getRequestDispatcher("register.html").forward(request, response);
    }
    }
}
