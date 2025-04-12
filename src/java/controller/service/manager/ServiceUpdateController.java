package controller.service.manager;

import dal.CategoryDAO;
import dal.ServiceManagerDAO;
import java.io.IOException;
import java.io.File;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Service;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB (threshold for buffering)
        maxFileSize = 1024 * 1024 * 50, // 50MB (maximum file size for a single file)
        maxRequestSize = 1024 * 1024 * 200 // 200MB (maximum size of the entire request)
)
public class ServiceUpdateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ServiceManagerDAO db = new ServiceManagerDAO();
        CategoryDAO dbCategory = new CategoryDAO();
        try {
            int serviceId = Integer.parseInt(request.getParameter("id"));
            Service service = db.getServiceByID(serviceId);
            List<Category> listCategory = dbCategory.getAllAvailabelCategories();

            request.setAttribute("s", service);
            request.setAttribute("listCategory", listCategory);
            request.getRequestDispatcher("../dashboard/manager/serviceDetail.jsp").forward(request, response);
        } catch (Exception e) {
            request.getRequestDispatcher("../dashboard/manager/serviceDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ServiceManagerDAO db = new ServiceManagerDAO();
        CategoryDAO dbCategory = new CategoryDAO();
        String action = request.getParameter("action");
        if ("checkServiceName".equals(action)) {
            String serviceName = trimSpaces(request.getParameter("name"));
            boolean exists = db.checkServiceName(serviceName);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }
        try {
            Service service = extractServiceFromRequest(request);

            db.updateService(service);

            int serviceId = Integer.parseInt(request.getParameter("id"));

            Service serviceRecover = db.getServiceByID(serviceId);
            List<Category> listCategory = dbCategory.getAllAvailabelCategories();

            request.setAttribute("notification", "successfull");
            request.setAttribute("s", serviceRecover);
            request.setAttribute("listCategory", listCategory);

            request.getRequestDispatcher("../dashboard/manager/serviceDetail.jsp").forward(request, response);
        } catch (Exception e) {

            ArrayList<Service> list = db.list();
            List<Category> listCategory = dbCategory.getAllAvailabelCategories();

            request.setAttribute("list", db.list());
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("notification", "false");
            request.getRequestDispatcher("../dashboard/manager/serviceList.jsp").forward(request, response);
        }
    }

    private Service extractServiceFromRequest(HttpServletRequest request) throws Exception {
        int serviceId = Integer.parseInt(request.getParameter("id"));
        ServiceManagerDAO db = new ServiceManagerDAO();
        Service service = db.getServiceByID(serviceId);

        String name = trimSpaces(request.getParameter("name"));
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));

        if (discount > price) {
            throw new IllegalArgumentException("Discount cannot be greater than price!");
        }

        service.setName(name);
        service.setPrice(price);
        service.setDiscount(discount);
        service.setDescription(request.getParameter("description").trim());
        service.setBriefInfo(request.getParameter("briefInfo").trim());
        service.setStatus(Integer.parseInt(request.getParameter("status")));

        String fileURL = handleFileUpload(request, request.getParameter("oldThumbnail"));
        service.setThumbnail(fileURL);

        Category category = new Category();
        category.setId(Integer.parseInt(request.getParameter("idCategory")));
        service.setCategory(category);

        return service;
    }

    private String handleFileUpload(HttpServletRequest request, String oldThumbnail) throws IOException, ServletException {
        Part filePart = request.getPart("thumbnail");
        if (filePart == null || filePart.getSize() == 0) {
            return oldThumbnail;
        }

        String fileName = getFileName(filePart);
        if (!isValidImageExtension(fileName)) {
            throw new ServletException("Invalid file type! Only image files are allowed.");
        }
        String uploadPath = request.getServletContext().getRealPath("/assets/images/services").replace("/build", "");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        return "assets/images/services/" + fileName;
    }

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
