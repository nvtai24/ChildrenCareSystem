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
import jakarta.servlet.http.HttpSession;
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
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("id");
        UserDAO uDB = new UserDAO();
        ArrayList<User> users = uDB.listAllUsersExcept(userId);

        RoleDAO rDB = new RoleDAO();
        ArrayList<Role> roles = rDB.listAllAvailableRole();

        request.setAttribute("users", users);
        request.setAttribute("roles", roles);

        request.getRequestDispatcher("dashboard/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("id");
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
                ArrayList<User> users = uDB.listAllUsersExcept(userId);

                RoleDAO rDB = new RoleDAO();
                ArrayList<Role> roles = rDB.listAllAvailableRole();

                request.setAttribute("users", users);
                request.setAttribute("roles", roles);
                request.getRequestDispatcher("dashboard/users.jsp").forward(request, response);
            }
        }

    }

    private class UserChangeStatus extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            UserDAO userDB = new UserDAO();
            RoleDAO dbRole = new RoleDAO();
            HttpSession session = req.getSession(); // Không tạo mới nếu chưa có session
            if (session != null) {
                session.removeAttribute("sessionStatus");
                session.removeAttribute("sessionRoleId");
            }
            int userId = (int) session.getAttribute("id");
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
            if (userDB.UpdateStatusByUser(id, status)) {
                req.setAttribute("notification", "successfull");
            } else {
                req.setAttribute("notification", "error");
            }

            // Fetch updated data
            ArrayList<User> users = userDB.listAllUsersExcept(userId);
            ArrayList<Role> roles = dbRole.listAllAvailableRole();

            // Set attributes for the request
            req.setAttribute("users", users);
            req.setAttribute("roles", roles);

            // Forward the request to the JSP
            req.getRequestDispatcher("dashboard/users.jsp").forward(req, resp);
        }

    }

    private class UserFilterStatus extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            UserDAO dbUser = new UserDAO();
            RoleDAO dbRole = new RoleDAO();

            HttpSession session = req.getSession();

            // Lấy giá trị từ request parameter và session
            String Status_raw = req.getParameter("status");
            Integer RoleId_raw = (Integer) session.getAttribute("sessionRoleId");
            int userId = (int) session.getAttribute("id");

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
            ArrayList<User> users = dbUser.getListUserByStatusAndRole(statusSession, roleIdSession, userId);

            // Thiết lập các thuộc tính cho request và session
            req.setAttribute("users", users);
            req.setAttribute("roles", roles);
            session.setAttribute("sessionStatus", statusSession);
            session.setAttribute("sessionRoleId", roleIdSession);

            // Forward request đến trang JSP
            req.getRequestDispatcher("dashboard/users.jsp").forward(req, resp);
        }

    }

    private class UserFilterRole extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            UserDAO dbUser = new UserDAO();
            RoleDAO dbRole = new RoleDAO();

            HttpSession session = req.getSession();

            // Thay đổi việc lấy giá trị từ session và đảm bảo kiểu dữ liệu đúng
            Integer Status_raw = (Integer) session.getAttribute("sessionStatus");
            String RoleId_raw = req.getParameter("role");
            int userId = (int) session.getAttribute("id");
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
            ArrayList<User> users = dbUser.getListUserByStatusAndRole(statusSession, roleIdSession, userId);

            // Thiết lập các thuộc tính cho request và session
            req.setAttribute("users", users);
            req.setAttribute("roles", roles);
            session.setAttribute("sessionStatus", statusSession);
            session.setAttribute("sessionRoleId", roleIdSession);

            // Forward request đến trang JSP
            req.getRequestDispatcher("dashboard/users.jsp").forward(req, resp);
        }

    }

    private class UserSearch extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            UserDAO dbUser = new UserDAO();
            RoleDAO dbRole = new RoleDAO();
            HttpSession session = req.getSession(false); // Không tạo mới nếu chưa có session
            int userId = (int) session.getAttribute("id");
            if (session != null) {
                session.removeAttribute("sessionStatus");
                session.removeAttribute("sessionRoleId");
            }
            String titleSearch = req.getParameter("search").trim();
            titleSearch = trimSpaces(titleSearch);

            ArrayList<Role> roles = dbRole.listAllAvailableRole();
            ArrayList<User> users = dbUser.getUserBySearch(titleSearch, userId);

            req.setAttribute("users", users);
            req.setAttribute("roles", roles);
            req.setAttribute("title", titleSearch);
            req.getRequestDispatcher("dashboard/users.jsp").forward(req, resp);
        }

    }

    // Dùng để validate khoảng trắng cách chữ trong string không cách nhau
    private static String trimSpaces(String input) {
        if (input == null) {
            return null;
        }
        return input.trim().replaceAll("\\s+", " ");
    }
}
