/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.service.manager;

import dal.CategoryDAO;
import dal.ServiceManagerDAO;
import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.List;
import model.Category;
import model.Service;

/**
 *
 * @author Admin
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB (threshold for buffering)
        maxFileSize = 1024 * 1024 * 50, // 50MB (maximum file size for a single file)
        maxRequestSize = 1024 * 1024 * 200 // 200MB (maximum size of the entire request)
)
public class ServiceCreateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO dbCategory = new CategoryDAO();
        List<Category> list = dbCategory.getAllAvailabelCategories();
        request.setAttribute("listCategory", list);
        request.getRequestDispatcher("../dashboard/manager/serviceCreate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ServiceManagerDAO db = new ServiceManagerDAO();
        CategoryDAO dbCategory = new CategoryDAO();
        List<Category> list = dbCategory.getAllAvailabelCategories();
        request.setAttribute("listCategory", list);
        // check exist service name
        String action = request.getParameter("action");
        if ("checkServiceName".equals(action)) {
            String serviceName = request.getParameter("name");
            boolean exists = db.checkServiceName(serviceName);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }

        // Lấy dữ liệu từ form
        String raw_categoryId = request.getParameter("idCategory").trim();
        String raw_name = request.getParameter("name").trim();
        String raw_price = request.getParameter("price").trim();
        String raw_discount = request.getParameter("discount").trim();
        String raw_description = request.getParameter("description").trim();
        String raw_status = request.getParameter("status").trim();
        String raw_briefInfo = request.getParameter("briefInfo").trim();

        // Xử lý upload file ảnh
        Part filePart = request.getPart("thumbnail"); // Lấy file ảnh từ request
        String fileName = null;
        try {
            fileName = getFileName(filePart); // Lấy tên file
            if (!isValidImageExtension(fileName)) {
                throw new ServletException("Invalid file type! Only image files are allowed.");
            }
        } catch (Exception e) {
            request.setAttribute("notification", "false");
            request.setAttribute("listCategory", list);
            request.getRequestDispatcher("../dashboard/manager/serviceCreate.jsp").forward(request, response);
        }

        // Lấy đường dẫn thư mục lưu ảnh
        String uploadPath = request.getServletContext().getRealPath("/assets/images/services");
        String uploadPath2 = request.getServletContext().getRealPath("/assets/images/services");

        // Kiểm tra nếu đường dẫn chứa "/build", loại bỏ nó
        if (uploadPath.contains(File.separator + "build")) {
            StringBuilder sb = new StringBuilder(uploadPath);
            int index = sb.indexOf(File.separator + "build");
            if (index != -1) {
                sb.delete(index, index + 6); // Xóa phần "/build"
            }
            uploadPath = sb.toString();
        }

        //test 
        File uploadDir = new File(uploadPath);
        File uploadDir2 = new File(uploadPath2);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            uploadDir2.mkdirs();
            if (!created) {
                System.out.println("️khong the tao thu muc: " + uploadPath);
            }
        }

        // Lưu file vào server
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Tạo URL để lưu vào database
        if (fileName.isEmpty()) {
            fileName = "default-thumbnail.jpg";
        }
        String fileURL = "assets/images/services/" + fileName;
        // Khởi tạo đối tượng Service
        Service s = new Service();

        // Kiểm tra dữ liệu nhập vào
        String errorMessage = null;
        try {
            // Kiểm tra giá trị rỗng
            if (raw_name == null || raw_name.trim().isEmpty()
                    || raw_price == null || raw_price.trim().isEmpty()
                    || raw_discount == null || raw_discount.trim().isEmpty()
                    || raw_description == null || raw_description.trim().isEmpty()
                    || fileURL == null || fileURL.trim().isEmpty()
                    || raw_status == null || raw_status.trim().isEmpty()
                    || raw_briefInfo == null || raw_briefInfo.trim().isEmpty()) {

                errorMessage = "All fields are required!";
                throw new IllegalArgumentException(errorMessage);
            }

            // Chuyển đổi kiểu dữ liệu
            double price = Double.parseDouble(raw_price);
            double discount = Double.parseDouble(raw_discount);

            if (discount > price) {
                errorMessage = "Discount cannot be greater than price!";
                throw new IllegalArgumentException(errorMessage);
            }

            // Gán giá trị cho Service
            s.setName(raw_name.trim());
            s.setPrice(price);
            s.setDiscount(discount);
            s.setDescription(raw_description.trim());
            s.setThumbnail(fileURL); // Lưu URL ảnh vào database
            s.setStatus(Integer.parseInt(raw_status));
            s.setBriefInfo(raw_briefInfo.trim());

            // Gán Category
            Category c = new Category();
            c.setId(Integer.parseInt(raw_categoryId));
            s.setCategory(c);

            // Lưu vào database
            if (!db.createService(s)) {
                throw new IllegalArgumentException();
            }

            // Redirect về danh sách dịch vụ
            request.setAttribute("notification", "successfull");
            request.setAttribute("listCategory", list);
            request.getRequestDispatcher("../dashboard/manager/serviceCreate.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("notification", "false");
            request.setAttribute("listCategory", list);
            request.getRequestDispatcher("../dashboard/manager/serviceCreate.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("notification", "false");
            request.setAttribute("listCategory", list);
            request.getRequestDispatcher("../dashboard/manager/serviceCreate.jsp").forward(request, response);
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null; // Trả về null nếu không tìm thấy tên file
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
