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

/**
 *
 * @author Admin
 */
public class ServiceChangeStatusController extends HttpServlet {
   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          // get Id 
        String raw_id =  request.getParameter("id");
        int id = Integer.parseInt(raw_id);
        ServiceManagerDAO db = new ServiceManagerDAO();
        db.updateStatusById(id);
        response.sendRedirect("ServiceListController");
    }



}
