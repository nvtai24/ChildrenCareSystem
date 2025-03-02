/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard.admin;

import dal.FeatureDAO;
import dal.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.auth.Feature;
import model.auth.Role;

/**
 *
 * @author Nvtai
 */
public class PermissionAssignController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int rid = Integer.parseInt(request.getParameter("rid"));

        FeatureDAO fdb = new FeatureDAO();
        ArrayList<Feature> allF = fdb.listAllFeatures();
        ArrayList<String> roleF = fdb.getPermissions(rid);

        RoleDAO rdb = new RoleDAO();
        Role r = rdb.getRoleById(rid);

        request.setAttribute("allF", allF);
        request.setAttribute("roleF", roleF);
        request.setAttribute("r", r);
        request.getRequestDispatcher("../dashboard/permission-list.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int rid = Integer.parseInt(request.getParameter("rid"));
        int fid = Integer.parseInt(request.getParameter("fid"));

        RoleDAO rdb = new RoleDAO();
        
        rdb.assignPermission(rid, fid);

    }

   
}
