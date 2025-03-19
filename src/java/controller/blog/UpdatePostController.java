/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.blog;

import dal.PostDAO;
import java.io.IOException;
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
import model.Post;
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
public class UpdatePostController extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/images/blog";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int postId = Integer.parseInt(request.getParameter("id"));
            PostDAO postDAO = new PostDAO();
            Post post = postDAO.GetPostById(postId);
            if (post != null) {
                request.setAttribute("POST", post);
            }
            request.getRequestDispatcher("post-update.jsp").forward(request, response);
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
            // Lấy ID slider từ request
            int postId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String brief_info = request.getParameter("brief_info");
            
            HttpSession session = request.getSession();
            int currentUserId = 0;
            if (session != null && session.getAttribute("id") != null) {
                currentUserId = (int) session.getAttribute("id"); 
            } else {
                response.sendRedirect(request.getContextPath() + "/login"); // Redirect về trang login nếu chưa đăng nhập
                return;
            }
            // Lấy phần thông tin ảnh (nếu có)
            Part filePart = request.getPart("thumbnail"); // Lấy file ảnh từ form

            // Khai báo DAO
            PostDAO postDAO = new PostDAO();
            Post existingPost = postDAO.GetPostById(postId);

            String fileName = null;
            boolean isUpdatingImage = (filePart != null && filePart.getSize() > 0); // Kiểm tra nếu có file ảnh mới

            // Nếu có ảnh mới được chọn, xử lý lưu ảnh mới
            if (isUpdatingImage) {
                // Lấy tên file mới
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String sanitizedFileName = fileName.replaceAll("\\s+", "_"); // Đảm bảo tên file không có khoảng trắng

                // Đường dẫn thư mục lưu ảnh
                String appPath = getServletContext().getRealPath("/");
                String rootPath = new File(appPath).getParentFile().getParent();

                String webUploadDir = rootPath + "/web/" + UPLOAD_DIR;
                String buildUploadDir = rootPath + "/build/web/" + UPLOAD_DIR;

                File webFolder = new File(webUploadDir);
                File buildFolder = new File(buildUploadDir);

                // Tạo thư mục nếu chưa có
                if (!webFolder.exists()) {
                    webFolder.mkdirs();
                }
                if (!buildFolder.exists()) {
                    buildFolder.mkdirs();
                }

                // Kiểm tra xem ảnh đã tồn tại trong folder hay chưa
                File existingFile = new File(webFolder, sanitizedFileName);
                if (!existingFile.exists()) {
                    // Nếu ảnh mới chưa tồn tại, lưu nó vào thư mục
                    File webImageFile = new File(webFolder, sanitizedFileName);
                    File buildImageFile = new File(buildFolder, sanitizedFileName);

                    filePart.write(webImageFile.getAbsolutePath());
                    Files.copy(webImageFile.toPath(), buildImageFile.toPath()); // Sao chép file vào thư mục build

                    System.out.println("File saved to: " + webImageFile.getAbsolutePath());
                    System.out.println("File also copied to: " + buildImageFile.getAbsolutePath());
                } else {
                    System.out.println("File already exists in folder: " + sanitizedFileName);
                }

                // Cập nhật fileName để lưu vào database
                fileName = "assets/images/blog/" + sanitizedFileName;
            } else {
                // Nếu không có ảnh mới, sử dụng ảnh cũ mà không thay đổi đường dẫn "assets/images/slider/"
                fileName = existingPost.getThumbnail();  // Giữ nguyên ảnh cũ
            }

            
            Post post = new Post();
            post.setTitle(title);
            post.setId(postId);
            post.setContent(content);
            post.setBriefInfo(brief_info);
            post.setThumbnail(fileName); // Lưu đường dẫn ảnh vào database

            
            
            boolean result = postDAO.updatePost(post);

            if (result) {
                session.setAttribute("MESSAGE", "Update post successfully!");
            } else {
                session.setAttribute("MESSAGE", "Update post failed");
            }

            
            response.sendRedirect(request.getContextPath() + "/posts");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi cập nhật post.");
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
