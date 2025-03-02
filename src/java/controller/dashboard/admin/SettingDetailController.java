/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard.admin;

import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Setting;

/**
 *
 * @author admin
 */
public class SettingDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        SettingDAO settingDAO = new SettingDAO();

        if (id != null) {
            // Lấy chi tiết Setting theo ID
            Setting setting = settingDAO.getSettingById(Integer.parseInt(id));
            request.setAttribute("setting", setting);
        }

        request.getRequestDispatcher("dashboard/setting.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String value = request.getParameter("value");
        String description = request.getParameter("description");
        boolean status = "1".equals(request.getParameter("status"));

        SettingDAO settingDAO = new SettingDAO();

        if (id != null && !id.isEmpty()) {
            // Cập nhật setting
            settingDAO.updateSetting(new Setting(Integer.parseInt(id), null, value, description, status));
        } else {
            // Thêm mới setting
            settingDAO.addSetting(new Setting(0, null, value, description, status));
        }

        response.sendRedirect("settings");
    }
}
