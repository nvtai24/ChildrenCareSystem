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
import model.Category;
import model.Service;

/**
 *
 * @author Admin
 */
public class ServiceFilterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServiceFilterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServiceFilterController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        ArrayList<Category> listCategory = dbCategory.list();
        // Đặt danh sách vào request scope để hiển thị trên JSP
        request.setAttribute("listCategory", listCategory);
        request.setAttribute("list", list);
        request.setAttribute("status", status);

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("./views/manager/serviceList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
