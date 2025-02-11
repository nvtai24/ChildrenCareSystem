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

            // Khai báo DAO
            SliderDAO sliderDAO = new SliderDAO();
            Slider existingSlider = sliderDAO.GetSliderById(sliderId);

            String fileName = null;
            boolean isUpdatingImage = (filePart != null && filePart.getSize() > 0);

            if (isUpdatingImage) {
                // Lấy tên file mới
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String sanitizedFileName = fileName.replaceAll("\\s+", "_");

                // Đường dẫn thư mục lưu ảnh
                String appPath = getServletContext().getRealPath("/");
                String rootPath = new File(appPath).getParentFile().getParent();

                String webUploadDir = rootPath + "/web/" + UPLOAD_DIR;
                String buildUploadDir = rootPath + "/build/web/" + UPLOAD_DIR;

                File webFolder = new File(webUploadDir);
                File buildFolder = new File(buildUploadDir);

                // Tạo thư mục nếu chưa có
                if (!webFolder.exists()) {
                    webFolder.mkdirs();
                }
                if (!buildFolder.exists()) {
                    buildFolder.mkdirs();
                }

                // Kiểm tra xem ảnh đã tồn tại trong folder hay chưa
                File existingFile = new File(webFolder, sanitizedFileName);
                if (!existingFile.exists()) {
                    // Nếu ảnh mới chưa tồn tại, lưu nó
                    File webImageFile = new File(webFolder, sanitizedFileName);
                    File buildImageFile = new File(buildFolder, sanitizedFileName);

                    filePart.write(webImageFile.getAbsolutePath());
                    Files.copy(webImageFile.toPath(), buildImageFile.toPath());

                    System.out.println("File saved to: " + webImageFile.getAbsolutePath());
                    System.out.println("File also copied to: " + buildImageFile.getAbsolutePath());
                } else {
                    System.out.println("File already exists in folder: " + sanitizedFileName);
                }

                // Cập nhật fileName để lưu vào database
                fileName = sanitizedFileName;
            } else {
                // Không có ảnh mới, giữ nguyên ảnh cũ
                fileName = existingSlider.getImageUrl();
            }

            // Cập nhật thông tin vào database
            Slider slider = new Slider();
            slider.setTitle(title);
            slider.setId(sliderId);
            slider.setImageUrl(fileName);

            boolean result = sliderDAO.updateSlider(slider);

            HttpSession session = request.getSession();
            if (result) {
                session.setAttribute("MESSAGE", "Update slider successfully!");
            } else {
                session.setAttribute("MESSAGE", "Update slider failed");
            }

            response.sendRedirect("slider");
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
