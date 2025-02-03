/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.service.manager;

import dal.CategoryDAO;
import dal.ServiceDAO;
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
public class ServiceSortController extends HttpServlet {

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
        HttpSession session = request.getSession();

        // Lấy tham số từ request
        String field = request.getParameter("field");
        String raw_order = request.getParameter("order");

        // Kiểm tra và lấy sessionStatus (tránh NullPointerException)
        Double status = -1.0;
        Object sessionStatusObj = session.getAttribute("sessionStatus");
        if (sessionStatusObj != null) {
            try {
                status = (Double) sessionStatusObj;
            } catch (ClassCastException e) {
                System.out.println("Error casting sessionStatus: " + e.getMessage());
            }
        }

        // Kiểm tra và lấy idCategory (tránh NullPointerException & sửa tên sai)
        int idCategory = -1;
        Object sessionCategoryObj = session.getAttribute("sessionCategoryId"); // Fix tên sai
        if (sessionCategoryObj != null) {
            try {
                idCategory = (int) sessionCategoryObj;
            } catch (ClassCastException e) {
                System.out.println("Error casting sessionCategoryId: " + e.getMessage());
            }
        }

        // Xử lý order (tránh NullPointerException)
        boolean order = false; // Giá trị mặc định
        if (raw_order != null && raw_order.equalsIgnoreCase("asc")) {
            order = true;
        }

        // Lấy danh sách category
        CategoryDAO dbCategory = new CategoryDAO();
        ArrayList<Category> listCategory = dbCategory.list();
        request.setAttribute("listCategory", listCategory);

        // Lấy danh sách service theo điều kiện
        ServiceDAO db = new ServiceDAO();
        ArrayList<Service> list = db.getServiceListBySortByOrder(field, order, status, idCategory);

        // Đưa dữ liệu vào request
        request.setAttribute("list", list);
        request.setAttribute("status", status);
        request.setAttribute("field", field);

        // Chuyển hướng tới JSP
        request.getRequestDispatcher("./views/manager/serviceList.jsp").forward(request, response);
       
       response.getWriter().print(field +", " +order+", "+status+", "+idCategory);
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
        processRequest(request, response);
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
