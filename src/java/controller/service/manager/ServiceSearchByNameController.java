/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.service.manager;

import dal.CategoryDAO;
import dal.ServiceManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Category;
import model.Service;

/**
 *
 * @author Admin
 */
public class ServiceSearchByNameController extends HttpServlet {
   



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String nameService = request.getParameter("nameService");
        if(nameService == null){
            response.sendRedirect("ServiceListController");
        }
        
        ServiceManagerDAO db = new ServiceManagerDAO();
        ArrayList<Service> list  = db.getListByName(nameService);
        CategoryDAO dbCategory = new CategoryDAO();
        ArrayList<Category> listCategory = dbCategory.list();
        request.setAttribute("listCategory", listCategory);
        
        request.setAttribute("list", list);
        request.setAttribute("nameService", nameService);
        request.getRequestDispatcher("./views/manager/serviceList.jsp").forward(request, response);
        
        
    } 


}
