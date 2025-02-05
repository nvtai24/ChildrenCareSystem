/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.service.publi;

import dal.CategoryDAO;
import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;
import model.Service;

/**
 *
 * @author Nvtai
 */
public class ServiceListPublicController extends HttpServlet {

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
        CategoryDAO cDB = new CategoryDAO();
        List<Category> categories = cDB.getAllAvailabelCategories();
        request.setAttribute("categories", categories);

        ServiceDAO sDB = new ServiceDAO();
        String info = request.getParameter("info");
        String raw_cid = request.getParameter("cid");

        // Phân trang
        int pageSize = 6; // Số lượng dịch vụ hiển thị trên mỗi trang
        int page = 1; // Mặc định trang đầu tiên

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Service> services;
        int totalServices;
        int totalPages;

        if (info != null && !info.isBlank()) {
            services = sDB.getAllAvailableServicesByInfo(info);
            totalServices = services.size(); // Không phân trang nếu tìm kiếm
            request.setAttribute("info", info);
        } else if (raw_cid != null) {
            int cid = Integer.parseInt(raw_cid);
            services = sDB.getAllAvailableServicesByCategoryId(cid);
            totalServices = services.size();
            request.setAttribute("cid", cid);
        } else {
            services = sDB.getAllAvailableServicesWithPagination(page, pageSize);
            sDB = new ServiceDAO();
            totalServices = sDB.countAllAvailableServices();
        }

        totalPages = (int) Math.ceil((double) totalServices / pageSize);

        request.setAttribute("services", services);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        sDB = new ServiceDAO();
        List<Service> recents = sDB.getThreeRecentServices();
        request.setAttribute("recents", recents);

        request.getRequestDispatcher("services.jsp").forward(request, response);
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

    }

}
