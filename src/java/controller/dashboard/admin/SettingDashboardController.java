/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard.admin;

import dal.RoleDAO;
import dal.SettingDAO;
import dal.SettingTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Setting;
import model.SettingType;
import model.auth.Role;

/**
 *
 * @author Nvtai
 */
public class SettingDashboardController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status");
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");

        SettingTypeDAO stdb = new SettingTypeDAO();
        ArrayList<SettingType> types = stdb.listAllTypes();

        SettingDAO sDB = new SettingDAO();
        ArrayList<Setting> settings = sDB.listAllSettings();

        if (status != null && type != null && keyword != null) {
            int sid = Integer.parseInt(status);
            int tid = Integer.parseInt(type);

            settings = sDB.filterSettings(sid, tid, keyword);
        }

        request.setAttribute("status", status);
        request.setAttribute("type", type);
        request.setAttribute("keyword", keyword);

        request.setAttribute("types", types);
        request.setAttribute("settings", settings);
        request.getRequestDispatcher("dashboard/settings.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
