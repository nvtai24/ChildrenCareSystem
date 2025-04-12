/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.slider;

import dal.SliderDAO;
import model.Slider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class SliderListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SliderDAO sliderDAO = new SliderDAO();

            // Lấy số trang từ request (mặc định là trang 1)
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            // Lấy từ khóa tìm kiếm từ request (nếu không có thì mặc định là chuỗi rỗng)
            String search = request.getParameter("search") != null ? request.getParameter("search").trim().replaceAll("\\s+", " ") : "";

            // Lấy trạng thái filter từ request (nếu không có thì null -> hiển thị tất cả)
            String statusParam = request.getParameter("status");
            Boolean status = null;
            if (statusParam != null && !statusParam.isEmpty()) {
                status = Boolean.parseBoolean(statusParam);
            }

            // Số slider tối đa trên mỗi trang
            int slidersPerPage = 10;

            // Tính tổng số slider theo tìm kiếm & trạng thái
            int totalSliders = sliderDAO.getSliderCount(search, status);

            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalSliders / slidersPerPage);

            // Lấy danh sách slider theo trang, tìm kiếm và trạng thái
            List<Slider> listSliders = sliderDAO.getSlidersByPageSearchAndStatus(page, slidersPerPage, search, status);

            // Gửi dữ liệu đến JSP
            request.setAttribute("SLIDERS", listSliders);
            request.setAttribute("CURRENT_PAGE", page);
            request.setAttribute("TOTAL_PAGES", totalPages);
            request.setAttribute("SEARCH", search);
            request.setAttribute("STATUS", statusParam); // Gửi trạng thái filter để giữ lại giá trị trên UI

            // Chuyển đến trang JSP
            request.getRequestDispatcher("sliderlist.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

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
            response.sendRedirect("sliders");
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
