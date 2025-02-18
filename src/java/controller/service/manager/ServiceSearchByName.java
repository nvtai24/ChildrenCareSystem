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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Service;

/**
 *
 * @author Admin
 */
public class ServiceSearchByName extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Không tạo mới nếu chưa có session
        if (session != null) {
            session.removeAttribute("sessionStatus");
            session.removeAttribute("sessionCaterogyId");
        }
        String nameService = request.getParameter("nameService").trim();
        if (nameService == null) {
            response.sendRedirect("services-manager");
        }

        ServiceManagerDAO db = new ServiceManagerDAO();
        ArrayList<Service> list = db.getListByName(nameService);
        CategoryDAO dbCategory = new CategoryDAO();
        List<Category> listCategory = dbCategory.getAllAvailabelCategories();
        request.setAttribute("listCategory", listCategory);

        request.setAttribute("list", list);
        request.setAttribute("nameService", nameService);
        request.getRequestDispatcher("../dashboard/manager/serviceList.jsp").forward(request, response);

    }

}
