/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.dashboard.admin.user;

import dal.CategoryDAO;
import dal.RoleDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.auth.Role;
import model.auth.User;

/**
 *
 * @author Admin
 */
public class UserChangeStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDB = new UserDAO();
        RoleDAO dbRole = new RoleDAO();
        HttpSession session = req.getSession(false); // Không tạo mới nếu chưa có session
        if (session != null) {
            session.removeAttribute("sessionStatus");
            session.removeAttribute("sessionRoleId");
        }

        // Get parameters from the request
        String id_raw = req.getParameter("id");
        String status_raw = req.getParameter("status");

        // Parse the user id
        int id = Integer.parseInt(id_raw);

        // Convert status from "true" / "false" to 1 / 0
        int status = 0;  // Default to 0 (inactive)
        if ("true".equalsIgnoreCase(status_raw)) {
            status = 1; // Active
        } else if ("false".equalsIgnoreCase(status_raw)) {
            status = 0; // Inactive
        }

        // Update the status in the database
        userDB.UpdateStatusByUser(id, status);

        // Fetch updated data
        ArrayList<User> users = userDB.listAllUsers();
        ArrayList<Role> roles = dbRole.listAllAvailableRole();

        // Set attributes for the request
        req.setAttribute("users", users);
        req.setAttribute("roles", roles);

        // Forward the request to the JSP
        req.getRequestDispatcher("dashboard/users.jsp").forward(req, resp);
    }

}
