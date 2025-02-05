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
public class ServiceFilterByCategoryController extends HttpServlet {

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
            out.println("<title>Servlet ServiceFilterByCategoryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServiceFilterByCategoryController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session
        HttpSession session = request.getSession();
        ServiceManagerDAO db = new ServiceManagerDAO();
        CategoryDAO dbCategory = new CategoryDAO();

        // Lấy danh sách danh mục
        ArrayList<Category> listCategory = dbCategory.list();

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
        request.getRequestDispatcher("./views/manager/serviceList.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
