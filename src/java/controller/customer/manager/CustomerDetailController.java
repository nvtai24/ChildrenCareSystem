/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.manager;

import dal.ProfileDAO;
import dal.RoleDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Profile;
import model.auth.User;

/**
 *
 * @author milo9
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class CustomerDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDB = new UserDAO();
        RoleDAO rDB = new RoleDAO();

        int userId = Integer.parseInt(request.getParameter("id"));
        User user = uDB.get(userId);

        request.setAttribute("user", user);
        request.setAttribute("roles", rDB.listAllAvailableRole());

        request.getRequestDispatcher("dashboard/manager/customerDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullname");
            boolean gender = "1".equals(request.getParameter("gender"));
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
//            int roleId = Integer.parseInt(request.getParameter("role"));
            String dob = request.getParameter("dob");

            // Lấy avatar cũ nếu không thay đổi ảnh
            String oldAvatar = request.getParameter("oldAvatar");
            String avatarPath = handleFileUpload(request, oldAvatar);

            // Xử lý ngày sinh (dob), tránh lỗi khi giá trị null hoặc rỗng
            Date dateOfBirth = (dob != null && !dob.isEmpty()) ? Date.valueOf(dob) : null;

            // Kiểm tra xem profile đã tồn tại hay chưa
            ProfileDAO profileDAO = new ProfileDAO();
            boolean profileExists = profileDAO.existsProfile(userId);

            if (profileExists) {
                // Cập nhật profile nếu đã tồn tại
                profileDAO.updateUserProfile(userId, fullName, gender ? "male" : "female", dob, address, phone, avatarPath);
            } else {
                // Tạo mới profile nếu chưa tồn tại
                Profile profile = Profile.builder()
                        .user(User.builder().id(userId).build())
                        .fullName(fullName != null ? fullName : "Unknown") // Nếu null, đặt tên mặc định
                        .gender(gender)
                        .dob(dateOfBirth != null ? dateOfBirth : Date.valueOf("2000-01-01")) // Nếu null, đặt ngày sinh mặc định
                        .address(address != null ? address : "Not Available") // Nếu null, đặt địa chỉ mặc định
                        .phone(phone != null ? phone : "0000000000") // Nếu null, đặt số điện thoại mặc định
                        .avatar(avatarPath != null ? avatarPath : "assets/images/profile/default.jpg") // Nếu null, đặt ảnh mặc định
                        .createdDate(LocalDateTime.now())
                        .build();

                profileDAO.createProfile(profile);
            }

            // Cập nhật role của user
            UserDAO userDAO = new UserDAO();
//            userDAO.updateRoleUser(userId, roleId);

            // Load dữ liệu và điều hướng về trang userDetail
            RoleDAO rDB = new RoleDAO();
            User user = userDAO.get(userId);
            request.setAttribute("user", user);
            request.setAttribute("roles", rDB.listAllAvailableRole());

            request.getRequestDispatcher("../dashboard/manager/customerDetail.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(CustomerDetailController.class.getName()).log(Level.SEVERE, null, e);

            // Xử lý lỗi và giữ lại dữ liệu form
            int userId = Integer.parseInt(request.getParameter("id"));
            UserDAO uDB = new UserDAO();
            RoleDAO rDB = new RoleDAO();

            User user = uDB.get(userId);
            request.setAttribute("user", user);
            request.setAttribute("roles", rDB.listAllAvailableRole());
            request.setAttribute("error", e.getMessage());

            request.getRequestDispatcher("/dashboard/manager/customerDetail.jsp").forward(request, response);
        }
    }

    /**
     * Xử lý upload ảnh, nếu không có ảnh mới, giữ nguyên ảnh cũ.
     */
    private String handleFileUpload(HttpServletRequest request, String oldAvatar) throws IOException, ServletException {
        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            return oldAvatar;
        }

        String fileName = getFileName(filePart);
        String uploadPath = request.getServletContext().getRealPath("/assets/images/profile").replace("/build", "");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        return "assets/images/profile/" + fileName;
    }

    /**
     * Trích xuất tên file từ Part.
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 2, content.length() - 1);
            }
        }
        return null;
    }
}
