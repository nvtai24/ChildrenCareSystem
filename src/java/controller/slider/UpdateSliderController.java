/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.slider;

import dal.SliderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import model.Slider;
import org.apache.tomcat.jakartaee.commons.io.FileUtils;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateSliderController extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/images/slider";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int sliderId = Integer.parseInt(request.getParameter("id"));
            SliderDAO sliderDAO = new SliderDAO();
            Slider slider = sliderDAO.GetSliderById(sliderId);
            if (slider != null) {
                request.setAttribute("SLIDER", slider);
            }
            request.getRequestDispatcher("updateslider.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID slider từ request
            int sliderId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");

            Part filePart = request.getPart("image"); // Lấy file ảnh

            // Kiểm tra nếu không có file mới được chọn
            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("MESSAGE", "Bạn chưa chọn ảnh mới!");
                request.getRequestDispatcher("editSlider.jsp").forward(request, response);
                return;
            }

            // Lấy tên file và chuẩn hóa
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String sanitizedFileName = fileName.replaceAll("\\s+", "_");

            // Lấy đường dẫn gốc của dự án
            String appPath = getServletContext().getRealPath("/");
            String rootPath = new File(appPath).getParentFile().getParent(); // Lấy thư mục gốc dự án

            // Xác định đường dẫn thư mục `web` và `build`
            String webUploadDir = rootPath + "/web/" + UPLOAD_DIR;
            String buildUploadDir = rootPath + "/build/web/" + UPLOAD_DIR;

            File webFolder = new File(webUploadDir);
            File buildFolder = new File(buildUploadDir);

            // Tạo thư mục nếu chưa tồn tại
            if (!webFolder.exists()) {
                webFolder.mkdirs();
            }
            if (!buildFolder.exists()) {
                buildFolder.mkdirs();
            }

            // Tạo file mới để lưu ảnh
            File webImageFile = new File(webFolder, sanitizedFileName);
            File buildImageFile = new File(buildFolder, sanitizedFileName);

            // Ghi file vào thư mục web
            filePart.write(webImageFile.getAbsolutePath());

            // Copy file từ web sang build
            Files.copy(webImageFile.toPath(), buildImageFile.toPath());

            System.out.println("File saved to: " + webImageFile.getAbsolutePath());
            System.out.println("File also copied to: " + buildImageFile.getAbsolutePath());

            // Cập nhật thông tin vào database
            Slider slider = new Slider();
            slider.setTitle(title);
            slider.setId(sliderId);
            slider.setImageUrl(sanitizedFileName);

            SliderDAO sliderDAO = new SliderDAO();
            boolean result = sliderDAO.updateSlider(slider);

            HttpSession session = request.getSession();
            if (result) {
                session.setAttribute("MESSAGE", "Cập nhật slider thành công!");
            } else {
                session.setAttribute("MESSAGE", "Cập nhật slider thất bại!");
            }

            response.sendRedirect("SliderListController");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi cập nhật slider.");
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
