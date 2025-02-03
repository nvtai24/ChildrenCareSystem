/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.service.manager;

import dal.CategoryDAO;
import dal.ServiceDAO;
import java.io.File;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import model.Category;
import model.Service;
import java.nio.file.Paths;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ServiceCreateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO dbCategory = new CategoryDAO();
        ArrayList<Category> list = dbCategory.list();
        request.setAttribute("listCategory", list);
        request.getRequestDispatcher("./views/manager/serviceCreate.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ServiceDAO db = new ServiceDAO();

        // Lấy dữ liệu từ form
        String raw_categoryId = request.getParameter("idCategory");
        String raw_name = request.getParameter("name");
        String raw_price = request.getParameter("price");
        String raw_discount = request.getParameter("discount");
        String raw_description = request.getParameter("description");
        String raw_status = request.getParameter("status");
        String raw_briefInfo = request.getParameter("briefInfo");

        // Xử lý upload file ảnh
        Part filePart = request.getPart("thumbnail"); // Lấy file ảnh từ request
        String fileName = getFileName(filePart); // Lấy tên file

        // Đường dẫn thư mục lưu ảnh
        String uploadPath = "C:\\Users\\Admin\\Documents\\GitHub\\ChildrenCareSystem\\web\\uploads\\profile";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            if (!created) {
                System.out.println("️khong the tao thu muc: " + uploadPath);
            }
        }

        // Lưu file vào server
        String filePath = uploadPath + File.separator + fileName;
        try {
            filePart.write(filePath);
            System.out.println(" anh da luu tai: " + filePath);
        } catch (IOException e) {
            System.out.println(" Loi khi tai anh: " + e.getMessage());
        }

        // Tạo URL để lưu vào database
        String fileURL = request.getContextPath() + "/uploads/profile/" + fileName;

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
            db.createService(s);

            // Redirect về danh sách dịch vụ
            response.sendRedirect("ServiceListController");

        } catch (NumberFormatException e) {
            errorMessage = "Invalid number format!";
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("./views/manager/serviceCreate.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("./views/manager/serviceCreate.jsp").forward(request, response);
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
}
