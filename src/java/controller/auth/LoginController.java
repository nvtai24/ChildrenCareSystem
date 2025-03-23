/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dal.FeatureDAO;
import dal.ProfileDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Profile;
import model.auth.User;
import util.PasswordUtil;

/**
 *
 * @author Nvtai
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("dzName");
        String password = request.getParameter("dzPassword");
        boolean rememberMe = request.getParameter("customControlAutosizing") != null; 
        UserDAO udb = new UserDAO();
        String hashedPassword = PasswordUtil.toSHA1(password);
        User user = udb.get(usernameOrEmail, hashedPassword);
        boolean hasError = false;
        if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty()) {
            request.setAttribute("errorUsername", "Please enter your username.");
            hasError = true;
        }

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorPassword", "Please enter your password.");
            hasError = true;
        }

        if (user == null && !hasError) {
            request.setAttribute("errorLogin", "Incorrect username or password.");
            hasError = true;
        } else if (user != null && !user.isStatus()) {
            request.setAttribute("errorLogin", "Your account is inactive. Please contact support.");
            hasError = true;
        }

        if (hasError) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        if (user != null) {
            if (!user.isEmailVerified()) {
                request.setAttribute("error", "Tài khoản của bạn chưa được xác minh. Vui lòng kiểm tra email để xác thực.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            ProfileDAO pDB = new ProfileDAO();

            Profile p = pDB.getProfileByUserId(user.getId());
            user.setProfile(p);

            FeatureDAO fDB = new FeatureDAO();
            ArrayList<String> permissions = fDB.getPermissions(user.getRole().getId());

            request.getSession().setAttribute("permissions", permissions);
            request.getSession().setAttribute("account", user);
            request.getSession().setAttribute("password", user.getPassword());
            request.getSession().setAttribute("id", user.getId());
            if (rememberMe) {
            Cookie usernameCookie = new Cookie("username", usernameOrEmail);
            usernameCookie.setMaxAge(60 * 60 * 24 * 7);  
            response.addCookie(usernameCookie);

            Cookie passwordCookie = new Cookie("password", password);
            passwordCookie.setMaxAge(60 * 60 * 24 * 7);  
            response.addCookie(passwordCookie);
        }

            response.sendRedirect("/app");
        } else {
            response.sendRedirect("login");
        }
    }

}
