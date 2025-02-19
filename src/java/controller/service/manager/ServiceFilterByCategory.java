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
public class ServiceFilterByCategory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session
        HttpSession session = request.getSession();
        ServiceManagerDAO db = new ServiceManagerDAO();
        CategoryDAO dbCategory = new CategoryDAO();

        // Lấy danh sách danh mục
        List<Category> listCategory = dbCategory.getAllAvailabelCategories();

        // Kiểm tra sessionStatus, tránh NullPointerException
        double status = -1; // Giá trị mặc định
        Object sessionStatusObj = session.getAttribute("sessionStatus");
        if (sessionStatusObj != null) {
            try {
                status = (double) sessionStatusObj;
            } catch (ClassCastException e) {
                System.out.println("Error casting sessionStatus: " + e.getMessage());
            }
        }

        // Xử lý categoryId từ request
        int categoryId = -1;
        try {
            String categoryParam = request.getParameter("idCategory");
            if (categoryParam != null && !categoryParam.isEmpty()) {
                categoryId = Integer.parseInt(categoryParam);
            }
        } catch (NumberFormatException e) {
            System.out.println("Error parsing categoryId: " + e.getMessage());
        }

        // Lấy danh sách dịch vụ theo status và categoryId
        ArrayList<Service> list = db.getListByStatusAndCategory(status, categoryId);

        // Lưu categoryId vào session
        session.setAttribute("sessionCategoryId", categoryId);

        // Đặt danh sách vào request để hiển thị trên JSP
        request.setAttribute("list", list);
        request.setAttribute("listCategory", listCategory);

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("../dashboard/manager/serviceList.jsp").forward(request, response);
    }

}
