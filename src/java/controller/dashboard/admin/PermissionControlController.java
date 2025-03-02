/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard.admin;

import dal.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.auth.Role;

/**
 *
 * @author Nvtai
 */
public class PermissionControlController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoleDAO rdb = new RoleDAO();
        ArrayList<Role> r = rdb.listAllRoleDashboard();

        request.setAttribute("r", r);
        request.getRequestDispatcher("dashboard/permissions.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int rid = Integer.parseInt(request.getParameter("rid"));
        int fid = Integer.parseInt(request.getParameter("fid"));

        boolean isRemoved = request.getParameter("remove") != null;
        RoleDAO rdb = new RoleDAO();

        if (isRemoved) {
            rdb.unassignPermission(rid, fid);
        } else {
            rdb.togglePermission(rid, fid);
        }
    }

}
