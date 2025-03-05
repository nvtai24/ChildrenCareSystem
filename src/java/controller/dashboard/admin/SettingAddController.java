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
import java.util.ArrayList;
import model.Setting;
import model.SettingType;

/**
 *
 * @author admin
 */
public class SettingAddController extends HttpServlet {
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        SettingDAO settingDAO = new SettingDAO();
        ArrayList<SettingType> settingTypes = settingDAO.getAllSettingTypes();  
        request.setAttribute("settingTypes", settingTypes);
        request.getRequestDispatcher("../dashboard/settings-add.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String value = request.getParameter("value");
        String description = request.getParameter("description");
        int typeId = Integer.parseInt(request.getParameter("type"));
        boolean status = "0".equals(request.getParameter("status"));

        Setting setting = new Setting();
        setting.setSettingValue(value);
        setting.setDescription(description);
        setting.setStatus(status);
        SettingType type = new SettingType();
        type.setId(typeId);
        setting.setSettingType(type);

        SettingDAO settingDAO = new SettingDAO();
        settingDAO.addSetting(setting);  

        response.sendRedirect("../settings");  
    }

   
}
