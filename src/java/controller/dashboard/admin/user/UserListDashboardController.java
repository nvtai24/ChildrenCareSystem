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
 * @author Nvtai
 */
public class UserListDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO uDB = new UserDAO();
        ArrayList<User> users = uDB.listAllUsers();

        RoleDAO rDB = new RoleDAO();
        ArrayList<Role> roles = rDB.listAllAvailableRole();

        request.setAttribute("users", users);
        request.setAttribute("roles", roles);

        request.getRequestDispatcher("dashboard/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action) {
            case "status" -> {
                UserFilterStatus ufs = new UserFilterStatus();
                ufs.doPost(request, response);
            }

            case "role" -> {
                UserFilterRole ufr = new UserFilterRole();
                ufr.doPost(request, response);
            }
            case "search" -> {
                UserSearch us = new UserSearch();
                us.doPost(request, response);
            }
            case "change" -> {
                UserChangeStatus ucs = new UserChangeStatus();
                ucs.doPost(request, response);
            }
            default -> {
                UserDAO uDB = new UserDAO();
                ArrayList<User> users = uDB.listAllUsers();

                RoleDAO rDB = new RoleDAO();
                ArrayList<Role> roles = rDB.listAllAvailableRole();

                request.setAttribute("users", users);
                request.setAttribute("roles", roles);
                request.getRequestDispatcher("dashboard/users.jsp").forward(request, response);
            }
        }

    }

}
