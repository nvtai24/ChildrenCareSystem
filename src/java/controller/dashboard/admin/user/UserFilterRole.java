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
public class UserFilterRole extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO dbUser = new UserDAO();
        RoleDAO dbRole = new RoleDAO();

        HttpSession session = req.getSession();

        // Thay đổi việc lấy giá trị từ session và đảm bảo kiểu dữ liệu đúng
        Integer Status_raw = (Integer) session.getAttribute("sessionStatus");
        String RoleId_raw = req.getParameter("role");

        int statusSession = -1;
        int roleIdSession = -1;

        // Kiểm tra và xử lý giá trị statusSession
        if (Status_raw != null) {
            statusSession = Status_raw; // Đã là Integer, không cần ép kiểu thêm
        }

        // Kiểm tra và xử lý giá trị roleIdSession
        if (RoleId_raw != null) {
            roleIdSession = Integer.parseInt(RoleId_raw.trim()); // Ép kiểu String thành int
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
