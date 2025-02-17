/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.blog;

import dal.PostDAO;
import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post;
import model.Service;

/**
 *
 * @author Nvtai
 */
public class BlogListController extends HttpServlet {

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
            out.println("<title>Servlet BlogListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogListController at " + request.getContextPath() + "</h1>");
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
            // Lấy số trang từ request (mặc định là trang 1)
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            // Lấy từ khóa tìm kiếm từ request (nếu không có thì mặc định là chuỗi rỗng)
            String search = request.getParameter("search") != null ? request.getParameter("search") : "";

            // Lấy trạng thái filter từ request (nếu không có thì null -> hiển thị tất cả)
            String statusParam = request.getParameter("status");
            Boolean status = null;
            if (statusParam != null && !statusParam.isEmpty()) {
                status = Boolean.parseBoolean(statusParam);
            }

            // Lấy danh sách dịch vụ nếu có (không liên quan đến bài post nhưng bạn đang load nó)
            

            // Số bài viết tối đa trên mỗi trang
            int postsPerPage = 6;

            PostDAO postDAO = new PostDAO();
            // Tính tổng số bài viết theo tìm kiếm & trạng thái
            int totalPosts = postDAO.getPostCount(search, status);

            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);
            
            // Lấy danh sách bài viết theo trang, tìm kiếm và trạng thái
            List<Post> listPosts = postDAO.getPostsByPageSearchAndStatus(page, postsPerPage, search, status);
            
            // Gửi dữ liệu lên JSP
            
            request.setAttribute("POSTS", listPosts);
            
            request.setAttribute("CURRENT_PAGE", page);
            request.setAttribute("TOTAL_PAGES", totalPages);
            request.setAttribute("SEARCH", search);
            request.setAttribute("STATUS", statusParam); // Giữ trạng thái filter

            // Chuyển hướng đến trang blogs.jsp
            request.getRequestDispatcher("blogs.jsp").forward(request, response);

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
