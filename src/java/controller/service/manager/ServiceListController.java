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
import java.util.List;
import model.Category;
import model.Service;

/**
 *
 * @author Nvtai
 */
public class ServiceListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        getListServiceAndCate(request, response);
        request.getRequestDispatcher("../dashboard/manager/serviceList.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String getAct = req.getParameter("action");

        switch (getAct) {
            case "search" -> {
                ServiceSearchByName ssbnc = new ServiceSearchByName();
                ssbnc.doGet(req, resp);
            }
            case "category" -> {
                ServiceFilterByCategory sfbcc = new ServiceFilterByCategory();
                sfbcc.doGet(req, resp);
            }
            case "status" -> {
                ServiceFilterStatus sfc = new ServiceFilterStatus();
                sfc.doGet(req, resp);
            }
            case "change" -> {
                ServiceChangeStatus scsc = new ServiceChangeStatus();
                scsc.doPost(req, resp);
            }
            default -> {
                getListServiceAndCate(req, resp);
                req.getRequestDispatcher("../dashboard/manager/serviceList.jsp").forward(req, resp);
            }

        }

    }

    private void getListServiceAndCate(HttpServletRequest request, HttpServletResponse response) {

        ServiceManagerDAO db = new ServiceManagerDAO();
        CategoryDAO dbCategory = new CategoryDAO();
        ArrayList<Service> list = db.list();
        List<Category> listCategory = dbCategory.getAllAvailabelCategories();

        request.setAttribute("listCategory", listCategory);
        request.setAttribute("list", list);
    }
    
    
}
