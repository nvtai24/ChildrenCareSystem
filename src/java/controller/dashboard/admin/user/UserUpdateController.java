package controller.dashboard.admin.user;

import dal.ProfileDAO;
import dal.RoleDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.File;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.time.LocalDateTime;
import java.util.ArrayList;
import model.Profile;
import model.auth.Role;
import model.auth.User;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UserUpdateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDB = new UserDAO();
        RoleDAO rDB = new RoleDAO();

        int userId = Integer.parseInt(request.getParameter("id"));
        User user = uDB.get(userId);

        request.setAttribute("user", user);
        request.setAttribute("roles", rDB.listAllAvailableRole());

        request.getRequestDispatcher("../dashboard/userDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstname").trim();
            String lastName = request.getParameter("lastname").trim();
            boolean gender = "1".equals(request.getParameter("gender"));
            String address = request.getParameter("address").trim();
            String phone = request.getParameter("phone").trim();
            int roleId = Integer.parseInt(request.getParameter("role"));
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
                profileDAO.updateUserProfile(userId, firstName, lastName, gender ? "male" : "female", dob, address, phone, avatarPath);
            } else {
                // Tạo mới profile nếu chưa tồn tại
                Profile profile = Profile.builder()
                        .user(User.builder().id(userId).build())
                        .firstName(firstName != null ? firstName : "Unknown") // Nếu null, đặt tên mặc định
                        .lastName(lastName != null ? lastName : "Unknown") // Nếu null, đặt tên mặc định
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
            userDAO.updateRoleUser(userId, roleId);

            // Load dữ liệu và điều hướng về trang userDetail
            RoleDAO rDB = new RoleDAO();
            User user = userDAO.get(userId);
            request.setAttribute("user", user);
            request.setAttribute("roles", rDB.listAllAvailableRole());
            request.setAttribute("notification", "successfull");
            request.getRequestDispatcher("../dashboard/userDetail.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(UserUpdateController.class.getName()).log(Level.SEVERE, null, e);

            // Xử lý lỗi và giữ lại dữ liệu form
            int userId = Integer.parseInt(request.getParameter("id"));
            UserDAO uDB = new UserDAO();
            RoleDAO rDB = new RoleDAO();

            User user = uDB.get(userId);
            request.setAttribute("user", user);
            request.setAttribute("roles", rDB.listAllAvailableRole());
            request.setAttribute("error", e.getMessage());
            request.setAttribute("notification", "false");
            response.getWriter().print(e.getMessage());
            request.getRequestDispatcher("../dashboard/userDetail.jsp").forward(request, response);
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
}
