/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.service.manager;

import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Service;

/**
 *
 * @author Admin
 */
public class ServiceCreateController extends HttpServlet {
   


 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        
        request.getRequestDispatcher("./views/manager/serviceCreate.jsp").forward(request, response);
    } 

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        ServiceDAO db = new ServiceDAO();
        String raw_name = request.getParameter("name");
        String raw_price = request.getParameter("price");
        String raw_discount = request.getParameter("discount");
        String raw_description = request.getParameter("description");
        String raw_thumbnail = request.getParameter("thumbnail");
        String raw_status = request.getParameter("status");
        String raw_briefInfo = request.getParameter("briefInfo");
        
        Service s = new Service();
        
        s.setName(raw_name);
        s.setPrice(Double.parseDouble(raw_price));
        s.setDiscount(Double.parseDouble(raw_discount));
        s.setDescription(raw_description);
        s.setThumbnail(raw_thumbnail);
        s.setStatus(Double.parseDouble(raw_status));
        s.setBriefInfo(raw_briefInfo);
        
        db.createService(s);
        response.sendRedirect("ServiceListController");
        
        
        
        
        
    }


}
