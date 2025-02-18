/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.dashboard.admin.user;

import dal.RoleDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import model.auth.Role;
import model.auth.User;

/**
 *
 * @author Admin
 */
public class UserSearch extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO dbUser = new UserDAO();
        RoleDAO dbRole = new RoleDAO();
        HttpSession session = req.getSession(false); // Không tạo mới nếu chưa có session
        if (session != null) {
            session.removeAttribute("sessionStatus");
            session.removeAttribute("sessionRoleId");
        }
        String titleSearch = req.getParameter("search").trim();

        ArrayList<Role> roles = dbRole.listAllAvailableRole();
        ArrayList<User> users = dbUser.getUserBySearch(titleSearch);

        req.setAttribute("users", users);
        req.setAttribute("roles", roles);
        req.setAttribute("title", titleSearch);
        req.getRequestDispatcher("dashboard/users.jsp").forward(req, resp);
    }

}
