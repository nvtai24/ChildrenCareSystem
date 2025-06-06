/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common;

import dal.PostDAO;
import dal.ServiceDAO;
import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post;
import model.Service;
import model.Slider;

/**
 *
 * @author Nvtai
 */
public class HomePageController extends HttpServlet {

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
            out.println("<title>Servlet HomePageController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePageController at " + request.getContextPath() + "</h1>");
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
            ServiceDAO serviceDAO = new ServiceDAO();
            List<Service> listService = serviceDAO.getAllServices();

            if (listService != null && listService.size() > 0) {
                request.setAttribute("SERVICES", listService);
            } else {
                System.out.println("Khong co service trong he thong");
            }

            SliderDAO sliderDAO = new SliderDAO();
            List<Slider> listSliderrs = sliderDAO.getAllSliders();
            if (listSliderrs != null && listSliderrs.size() > 0) {
                request.setAttribute("SLIDERS", listSliderrs);
            } else {
                System.out.println("Khong co sliders trong he thong");
            }

            PostDAO postDAO = new PostDAO();
            
            List<Post> listPost = postDAO.getAllPosts();
            if (listPost != null && listPost.size() > 0) {
                request.setAttribute("POSTS", listPost);
            } else {
                System.out.println("Khong co listPost trong he thong");
            }
            String search = request.getParameter("search") != null ? request.getParameter("search").trim().replaceAll("\\s+", " ") : "";

            if (!"".equals(search)) {
                List<Service> listServices = serviceDAO.getServicesBySearch(search);
                List<Post> listPosts = postDAO.getPostsBySearch(search);
                request.setAttribute("SEARCH", search);
                request.setAttribute("POSTS", listPosts);
                request.setAttribute("SERVICES", listServices);
            }
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e);
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
