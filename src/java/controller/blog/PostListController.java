/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.blog;

import dal.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post;

/**
 *
 * @author ADMIN
 */
public class PostListController extends HttpServlet {

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
            out.println("<title>Servlet PostListController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostListController at " + request.getContextPath() + "</h1>");
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
        try{
            PostDAO postDAO = new PostDAO();
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            String search = request.getParameter("search") != null ? request.getParameter("search") : "";
            String statusParam = request.getParameter("status");
            Boolean status = null;
            if (statusParam != null && !statusParam.isEmpty()) {
                status = Boolean.parseBoolean(statusParam);
            }
            int postsPerPage = 10;

            // Tính tổng số slider theo tìm kiếm & trạng thái
            int totalPosts = postDAO.getPostCount(search, status);

            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);
            List<Post> listPosts = postDAO.getPostsPageSearchAndStatus(page, postsPerPage, search, status);
            request.setAttribute("POSTS", listPosts);
            request.setAttribute("CURRENT_PAGE", page);
            request.setAttribute("TOTAL_PAGES", totalPages);
            request.setAttribute("SEARCH", search);
            request.setAttribute("STATUS", statusParam);
            
            request.getRequestDispatcher("postlist.jsp").forward(request, response);
        } catch(Exception e){
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
        try{
            // Lấy thông tin từ form
            int postId = Integer.parseInt(request.getParameter("id"));
            boolean newStatus = "1".equals(request.getParameter("status"));

            // Cập nhật trạng thái slider
            PostDAO postDAO = new PostDAO();
            postDAO.updateStatus(postId, newStatus);

            // Quay lại danh sách slider
            response.sendRedirect("posts");
        } catch(Exception e){
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
