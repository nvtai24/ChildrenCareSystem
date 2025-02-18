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
import java.util.List;
import model.Category;
import model.Service;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ServiceUpdateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServiceManagerDAO db = new ServiceManagerDAO();
        CategoryDAO dbCategory = new CategoryDAO();

        int serviceId = Integer.parseInt(request.getParameter("id"));
        Service service = db.getServiceByID(serviceId);
        List<Category> listCategory = dbCategory.getAllAvailabelCategories();

        request.setAttribute("s", service);
        request.setAttribute("listCategory", listCategory);
        request.getRequestDispatcher("../dashboard/manager/serviceDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Service service = extractServiceFromRequest(request);
            ServiceManagerDAO db = new ServiceManagerDAO();
            db.updateService(service);
            HttpSession session = request.getSession(false); // Không tạo mới nếu chưa có session
            if (session != null) {
                session.removeAttribute("sessionStatus");
                session.removeAttribute("sessionCaterogyId");
            }
            response.sendRedirect("../services/manager");
        } catch (Exception e) {
            ServiceManagerDAO db = new ServiceManagerDAO();
            CategoryDAO dbCategory = new CategoryDAO();
            int id = Integer.parseInt(request.getParameter("id"));

            Service service = db.getServiceByID(id);
            List<Category> listCategory = dbCategory.getAllAvailabelCategories();

            request.setAttribute("s", service);
            request.setAttribute("listCategory", listCategory);

            request.setAttribute("error", e.getMessage());
            HttpSession session = request.getSession(false); // Không tạo mới nếu chưa có session
            if (session != null) {
                session.invalidate(); // Hủy toàn bộ session
            }

            request.getRequestDispatcher("../dashboard/manager/serviceDetail.jsp").forward(request, response);
        }
    }

    private Service extractServiceFromRequest(HttpServletRequest request) throws Exception {
        int serviceId = Integer.parseInt(request.getParameter("id"));
        ServiceManagerDAO db = new ServiceManagerDAO();
        Service service = db.getServiceByID(serviceId);

        String name = request.getParameter("name").trim();
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
        String uploadPath = request.getServletContext().getRealPath("/assets/images/services").replace("/build", "");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        return  "assets/images/services/" + fileName;
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
}
