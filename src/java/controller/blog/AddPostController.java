/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.blog;

import dal.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import model.auth.User;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddPostController extends HttpServlet {

    private static final String UPLOAD_DIR = "web\\assets\\images\\blog";

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
            out.println("<title>Servlet AddPostController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPostController at " + request.getContextPath() + "</h1>");
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
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String brief_info = request.getParameter("brief_info");

        HttpSession session = request.getSession();
        int currentUserId = 0;
        if (session != null && session.getAttribute("id") != null) {
            currentUserId = (int) session.getAttribute("id"); // Redirect về trang login nếu chưa đăng nhập

        } else {
            response.sendRedirect(request.getContextPath() + "/login"); // Redirect về trang login nếu chưa đăng nhập
            return;
        }

        Part filePart1 = request.getPart("thumbnail");
        if (filePart1 == null || filePart1.getSize() == 0) {
            request.setAttribute("MESSAGE", "Bạn chưa chọn ảnh!");

            return;
        }

        // Lấy tên file và chuẩn hóa
        String fileName1 = Paths.get(filePart1.getSubmittedFileName()).getFileName().toString();
        String sanitizedFileName1 = fileName1.replaceAll("\\s+", "_");

        // Định nghĩa thư mục cần lưu
        String appPath1 = getServletContext().getRealPath("/");
        String rootPath1 = new File(appPath1).getParentFile().getParent(); // Lấy thư mục gốc dự án

        String webUploadDir1 = rootPath1 + "/web/assets/images/blog";  // Thư mục gốc web
        String buildUploadDir1 = rootPath1 + "/build/web/assets/images/blog";  // Thư mục build

        File webFolder1 = new File(webUploadDir1);
        File buildFolder1 = new File(buildUploadDir1);

        // Tạo thư mục nếu chưa tồn tại
        if (!webFolder1.exists()) {
            webFolder1.mkdirs();
        }
        if (!buildFolder1.exists()) {
            buildFolder1.mkdirs();
        }

        // Lưu file vào cả thư mục `web` và `build`
        File webImageFile1 = new File(webFolder1, sanitizedFileName1);
        File buildImageFile1 = new File(buildFolder1, sanitizedFileName1);

        try {
            filePart1.write(webImageFile1.getAbsolutePath());
            Files.copy(webImageFile1.toPath(), buildImageFile1.toPath()); // Copy sang thư mục build
            System.out.println("File saved to: " + webImageFile1.getAbsolutePath());
            System.out.println("File also copied to: " + buildImageFile1.getAbsolutePath());
        } catch (IOException e) {
            System.out.println("Lỗi khi lưu file: " + e.getMessage());
            e.printStackTrace();
        }

        // Lưu vào database
        PostDAO postDAO = new PostDAO();
        boolean result1 = postDAO.AddNewPost(title, "assets/images/blog/" + fileName1, content, brief_info, currentUserId);

        if (result1) {
            session.setAttribute("MESSAGE", "Add post successfully!");
        } else {
            session.setAttribute("MESSAGE", "Add post failed!");
        }

        response.sendRedirect(request.getContextPath() + "/posts");

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
