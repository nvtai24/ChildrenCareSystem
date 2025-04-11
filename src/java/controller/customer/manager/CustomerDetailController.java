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
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB (threshold for buffering)
        maxFileSize = 1024 * 1024 * 50, // 50MB (maximum file size for a single file)
        maxRequestSize = 1024 * 1024 * 200 // 200MB (maximum size of the entire request)
)
public class CustomerDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDB = new UserDAO();
        RoleDAO rDB = new RoleDAO();

        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            User user = uDB.get(userId);

            request.setAttribute("user", user);
            request.setAttribute("roles", rDB.listAllAvailableRole());

            request.getRequestDispatcher("dashboard/manager/customerDetail.jsp").forward(request, response);
        } catch (Exception e) {
            request.getRequestDispatcher("dashboard/manager/customerDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstname").trim();
            String lastName = request.getParameter("lastname").trim();
            boolean gender = "1".equals(request.getParameter("gender"));
            String address = request.getParameter("address".trim());
            String phone = request.getParameter("phone").trim();
            String dob = request.getParameter("dob").trim();

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
                profileDAO.updateUserProfile(userId, trimSpaces(firstName), trimSpaces(lastName), gender ? "male" : "female", dob, trimSpaces(address), removeAllSpaces(phone), avatarPath);
            } else {
                // Tạo mới profile nếu chưa tồn tại
                Profile profile = Profile.builder()
                        .user(User.builder().id(userId).build())
                        .firstName(firstName != null ? firstName : "Unknown")
                        .lastName(lastName != null ? lastName : "Unknown")
                        .gender(gender)
                        .dob(dateOfBirth != null ? dateOfBirth : Date.valueOf("2000-01-01"))
                        .address(address != null ? address : "Not Available")
                        .phone(phone != null ? phone : "0000000000")
                        .avatar(avatarPath != null ? avatarPath : "assets/images/profile/default.jpg")
                        .createdDate(LocalDateTime.now())
                        .build();

                profileDAO.createProfile(profile);
            }

            // Cập nhật role của user
            UserDAO userDAO = new UserDAO();

            // Load dữ liệu và điều hướng về trang userDetail
            RoleDAO rDB = new RoleDAO();
            User user = userDAO.get(userId);

            request.setAttribute("user", user);
            request.setAttribute("roles", rDB.listAllAvailableRole());
            request.setAttribute("notification", "successfull");
            request.getRequestDispatcher("dashboard/manager/customerDetail.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(CustomerDetailController.class.getName()).log(Level.SEVERE, null, e);

            // Xử lý lỗi và giữ lại dữ liệu form
            int userId = Integer.parseInt(request.getParameter("id"));
            UserDAO uDB = new UserDAO();
            RoleDAO rDB = new RoleDAO();

            User user = uDB.get(userId);
            request.setAttribute("user", user);
            request.setAttribute("roles", rDB.listAllAvailableRole());
            request.setAttribute("notification", "false");

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
        if (!isValidImageExtension(fileName)) {
            throw new ServletException("Invalid file type! Only image files are allowed.");
        }
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

    // Dùng để validate khoảng trắng cách nhau cách chữ 1 khoảng trắng 
    private static String trimSpaces(String input) {
        if (input == null) {
            return null;
        }
        return input.trim().replaceAll("\\s+", " ");
    }

    // Dùng để validate khoảng trắng cách chữ trong string không cách nhau
    public static String removeAllSpaces(String input) {
        if (input == null) {
            return null;
        }
        return input.replaceAll("\\s+", "");
    }

    private boolean isValidImageExtension(String fileName) {
        // Các đuôi file hợp lệ
        String[] validExtensions = {"jpg", "jpeg", "png", "gif"};
        String fileExtension = getFileExtension(fileName);

        // Kiểm tra xem file có đuôi hợp lệ không
        for (String ext : validExtensions) {
            if (fileExtension.equalsIgnoreCase(ext)) {
                return true;
            }
        }
        return false;
    }

    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf(".");
        if (dotIndex > 0) {
            return fileName.substring(dotIndex + 1);
        }
        return "";
    }
}
