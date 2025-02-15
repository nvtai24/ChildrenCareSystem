/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common;

import dal.ProfileDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import model.Profile;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
@MultipartConfig
public class AjaxProfileController extends HttpServlet {

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

        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("account");

        int id = currentUser.getId();

        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String raw_dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Lấy phần ảnh tải lên từ form
        Part filePart = request.getPart("avatar");

        String newFileName = null;
        String avatarPath = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Lấy tên file gốc
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Tạo tên ảnh mới để tránh trùng lặp
            newFileName = "profile_" + currentUser.getId() + ".jpg"; // Tạo tên ảnh duy nhất

            // Đường dẫn ảnh trong thư mục build
            String buildUploadDir = getServletContext().getRealPath("/") + "assets/images/profile/";

            // Lưu ảnh vào thư mục build để load tạm
            File fileToSave = new File(buildUploadDir + newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Đường dẫn ảnh trong thư mục không có build
            String uploadDir = getServletContext().getRealPath("/") + "assets/images/profile/";

            if (uploadDir.contains(File.separator + "build")) {
                StringBuilder sb = new StringBuilder(uploadDir);
                int index = sb.indexOf(File.separator + "build");
                if (index != -1) {
                    sb.delete(index, index + 6); // Xóa phần "/build"
                }
                uploadDir = sb.toString();
            }

            // Tạo thư mục nếu chưa tồn tại
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            // Lưu file vào thư mục
            fileToSave = new File(uploadDir + newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Đặt đường dẫn avatar mới
            avatarPath = "assets/images/profile/" + newFileName;
        } else {
            // Nếu không có ảnh tải lên, giữ lại ảnh cũ
            // Lấy thông tin profile từ cơ sở dữ liệu để giữ đường dẫn ảnh cũ
            ProfileDAO pDB = new ProfileDAO();
            Profile profile = pDB.getProfileByUserId(id);
            avatarPath = profile.getAvatar(); // Giữ lại đường dẫn ảnh cũ
        }

        // Cập nhật các thông tin khác vào cơ sở dữ liệu
        ProfileDAO pDB = new ProfileDAO();
        pDB.updateUserProfile(id, fullname, gender, raw_dob, address, phone, avatarPath);

        // Lấy lại profile cập nhật và gửi qua request
        pDB = new ProfileDAO();
        Profile updatedProfile = pDB.getProfileByUserId(id);
        currentUser.setProfile(updatedProfile);

        session.setAttribute("account", currentUser);

//        response.sendRedirect("/app");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("{\"status\": \"success\", \"message\": \"Profile updated successfully.\", \"avatar\": \"" + avatarPath + "\"}");
    }

}
