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
public class UserFilterStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO dbUser = new UserDAO();
        RoleDAO dbRole = new RoleDAO();

        HttpSession session = req.getSession();

        // Lấy giá trị từ request parameter và session
        String Status_raw = req.getParameter("status");
        Integer RoleId_raw = (Integer) session.getAttribute("sessionRoleId");

        int statusSession = -1;
        int roleIdSession = -1;

        // Kiểm tra và gán giá trị cho statusSession
        if (Status_raw != null) {
            statusSession = Integer.parseInt(Status_raw);
        }

        // Kiểm tra và gán giá trị cho roleIdSession
        if (RoleId_raw != null) {
            roleIdSession = RoleId_raw; // Lấy giá trị từ session
        }

        // Lấy danh sách roles và users từ database
        ArrayList<Role> roles = dbRole.listAllAvailableRole();
        ArrayList<User> users = dbUser.getListUserByStatusAndRole(statusSession, roleIdSession);

        // Thiết lập các thuộc tính cho request và session
        req.setAttribute("users", users);
        req.setAttribute("roles", roles);
        session.setAttribute("sessionStatus", statusSession);
        session.setAttribute("sessionRoleId", roleIdSession);

        // Forward request đến trang JSP
        req.getRequestDispatcher("dashboard/users.jsp").forward(req, resp);
    }

}
