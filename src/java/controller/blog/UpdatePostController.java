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
import java.util.HashMap;
import java.util.Map;
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
        String action = request.getParameter("action");

        try {

            if (request.getParameter("title") == null) {
                int postId = Integer.parseInt(request.getParameter("id"));
                PostDAO postDAO = new PostDAO();
                Post post = postDAO.GetPostById(postId);
                if (post != null) {
                    request.setAttribute("POST", post);
                }
                request.getRequestDispatcher("post-update.jsp").forward(request, response);
                return;
            }

            int postId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String briefInfo = request.getParameter("brief_info");

            Map<String, String> fieldErrors = new HashMap<>();

            if (title == null || title.trim().isEmpty()) {
                fieldErrors.put("title", "Title must not be empty.");
            }
            if (briefInfo == null || briefInfo.trim().isEmpty()) {
                fieldErrors.put("brief_info", "Brief info must not be empty.");
            }
            String contentForCheck = content != null
                    ? content.replaceAll("<[^>]*>", "") // nếu có HTML thì loại tag
                            .replaceAll("\\s+", "") // loại khoảng trắng, tab, newline
                            .replaceAll("&nbsp;", "") // loại &nbsp;
                    : "";
            if (contentForCheck.isEmpty()) {
                fieldErrors.put("content", "Content must not be empty.");
            }

            if (!fieldErrors.isEmpty()) {
                PostDAO postDAO = new PostDAO();
                Post post = postDAO.GetPostById(postId);

                request.setAttribute("POST", post);
                request.setAttribute("fieldErrors", fieldErrors);
                request.setAttribute("title", title);
                request.setAttribute("briefInfo", briefInfo);
                request.setAttribute("content", content);
                request.getRequestDispatcher("/post-update.jsp").forward(request, response);
                return;
            }

            Part filePart = request.getPart("thumbnail");

            PostDAO postDAO = new PostDAO();
            Post existingPost = postDAO.GetPostById(postId);

            String fileName = null;
            boolean isUpdatingImage = (filePart != null && filePart.getSize() > 0);

            if (isUpdatingImage) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String sanitizedFileName = fileName.replaceAll("\\s+", "_");

                String appPath = getServletContext().getRealPath("/");
                String rootPath = new File(appPath).getParentFile().getParent();

                String webUploadDir = rootPath + "/web/" + UPLOAD_DIR;
                String buildUploadDir = rootPath + "/build/web/" + UPLOAD_DIR;

                File webFolder = new File(webUploadDir);
                File buildFolder = new File(buildUploadDir);

                if (!webFolder.exists()) {
                    webFolder.mkdirs();
                }
                if (!buildFolder.exists()) {
                    buildFolder.mkdirs();
                }

                File existingFile = new File(webFolder, sanitizedFileName);
                if (!existingFile.exists()) {
                    File webImageFile = new File(webFolder, sanitizedFileName);
                    File buildImageFile = new File(buildFolder, sanitizedFileName);

                    filePart.write(webImageFile.getAbsolutePath());
                    Files.copy(webImageFile.toPath(), buildImageFile.toPath());
                }

                fileName = "assets/images/blog/" + sanitizedFileName;
            } else {

                fileName = existingPost.getThumbnail();
            }

            Post post = new Post();
            post.setId(postId);
            post.setTitle(title);
            post.setContent(content);
            post.setBriefInfo(briefInfo);
            post.setThumbnail(fileName);

            boolean result = postDAO.updatePost(post);

            HttpSession session = request.getSession();
            session.setAttribute("MESSAGE", result ? "Update post successfully!" : "Update post failed");

            response.sendRedirect("posts");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý bài viết.");
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
