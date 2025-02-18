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
public class ServiceFilterStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session
        HttpSession session = request.getSession();
        ServiceManagerDAO db = new ServiceManagerDAO();
        CategoryDAO dbCategory = new CategoryDAO();

        // Lấy tham số từ request
        String raw_status = request.getParameter("status");

        // Khởi tạo giá trị mặc định
        int categoryId = -1;
        double status = -1;

        try {
            // Kiểm tra session có giá trị không trước khi ép kiểu
            Object categoryIdObj = session.getAttribute("sessionCategoryId");
            if (categoryIdObj != null) {
                categoryId = (int) categoryIdObj;  // Ép kiểu nếu không phải null
            }

            // Kiểm tra raw_status có hợp lệ không trước khi parse
            if (raw_status != null && !raw_status.isEmpty()) {
                status = Double.parseDouble(raw_status);
            }
        } catch (NumberFormatException e) {
            System.out.println("Error parsing status: " + e.getMessage());
        }

        // Lưu status vào session
        session.setAttribute("sessionStatus", status);

        // Lấy danh sách dịch vụ theo categoryId và status
        ArrayList<Service> list = db.getListByStatusAndCategory(status, categoryId);
        List<Category> listCategory = dbCategory.getAllAvailabelCategories();
        // Đặt danh sách vào request scope để hiển thị trên JSP
        request.setAttribute("listCategory", listCategory);
        request.setAttribute("list", list);
        request.setAttribute("status", status);

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("../dashboard/manager/serviceList.jsp").forward(request, response);
    }

}
