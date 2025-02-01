/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.slider;

import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Slider;

/**
 *
 * @author Nvtai
 */
public class SliderListController extends HttpServlet {

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
            out.println("<title>Servlet SliderListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SliderListController at " + request.getContextPath() + "</h1>");
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
        try {
            SliderDAO sliderDAO = new SliderDAO();

            // Lấy số trang từ request
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            // Lấy từ khóa tìm kiếm từ request
            String search = request.getParameter("search");
            if (search == null) {
                search = "";  // Nếu không có từ khóa tìm kiếm, mặc định là chuỗi rỗng
            }

            // Số slider tối đa trên mỗi trang
            int slidersPerPage = 5;

            // Tính tổng số slider
            int totalSliders = sliderDAO.getSliderCount(search);  // Cập nhật phương thức getSliderCount để nhận tham số search

            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalSliders / slidersPerPage);

            // Lấy danh sách slider cho trang hiện tại và tìm kiếm theo title
            List<Slider> listSliders = sliderDAO.getSlidersByPageAndSearch(page, slidersPerPage, search);  // Cập nhật phương thức getSlidersByPage để nhận tham số search

            // Gửi dữ liệu đến JSP
            request.setAttribute("SLIDERS", listSliders);
            request.setAttribute("CURRENT_PAGE", page);
            request.setAttribute("TOTAL_PAGES", totalPages);
            request.setAttribute("SEARCH", search);  // Gửi tham số tìm kiếm đến JSP

            // Chuyển đến trang JSP
            request.getRequestDispatcher("sliderlist.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }

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
        try {
            // Lấy thông tin từ form
            int sliderId = Integer.parseInt(request.getParameter("id"));
            boolean newStatus = "1".equals(request.getParameter("status"));

            // Cập nhật trạng thái slider
            SliderDAO sliderDAO = new SliderDAO();
            sliderDAO.updateStatus(sliderId, newStatus);

            // Quay lại danh sách slider
            response.sendRedirect("SliderListController"); // Tên mapping của Servlet
        } catch (Exception e) {
            e.printStackTrace();
        }
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
