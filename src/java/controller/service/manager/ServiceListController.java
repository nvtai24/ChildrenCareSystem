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

    private class ServiceChangeStatus extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            // get Id 
            HttpSession session = request.getSession(false); // Không tạo mới nếu chưa có session
            if (session != null) {
                session.invalidate(); // Hủy toàn bộ session
            }
            String raw_id = request.getParameter("id");
            int id = Integer.parseInt(raw_id);
            ServiceManagerDAO db = new ServiceManagerDAO();
            db.updateStatusById(id);
            response.sendRedirect("../services/manager");
        }

    }

    private class ServiceFilterByCategory extends HttpServlet {

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

    private class ServiceSearchByName extends HttpServlet {

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

    private class ServiceFilterStatus extends HttpServlet {

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
}
