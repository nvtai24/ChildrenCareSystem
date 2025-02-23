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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Profile;
import model.auth.User;

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
        String username = request.getParameter("dzName");
        String password = request.getParameter("dzPassword");
        
        UserDAO udb = new UserDAO();
        User user = udb.get(username, password);
        
        if (user != null) {
            ProfileDAO pDB = new ProfileDAO();
            
            Profile p = pDB.getProfileByUserId(user.getId());
            user.setProfile(p);
            
            FeatureDAO fDB = new FeatureDAO();
            ArrayList<String> permissions = fDB.getPermissions(user.getRole().getId());
            
            request.getSession().setAttribute("permissions", permissions);
            request.getSession().setAttribute("account", user);
            
            request.getSession().setAttribute("id", user.getId());
            
            response.sendRedirect("/app");
        } else {
            response.sendRedirect("login");
        }
    }
    
}
