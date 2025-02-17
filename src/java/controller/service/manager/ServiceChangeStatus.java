/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.service.manager;

import dal.ServiceManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class ServiceChangeStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // get Id 
        HttpSession session = request.getSession(false); // Không tạo mới nếu chưa có session
        if (session != null) {
            session.invalidate(); // Hủy toàn bộ session
        }
        String raw_id = request.getParameter("id");
        int id = Integer.parseInt(raw_id);
        ServiceManagerDAO db = new ServiceManagerDAO();
        db.updateStatusById(id);
        response.sendRedirect("../services/manager");
    }

}
