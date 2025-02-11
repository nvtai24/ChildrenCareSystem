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
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import model.Slider;
import org.apache.tomcat.jakartaee.commons.io.FileUtils;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddSliderController extends HttpServlet {

    private static final String UPLOAD_DIR = "web\\assets\\images\\slider";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String backLink = request.getParameter("backLink");

        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("MESSAGE", "Bạn chưa chọn ảnh!");
            
            return;
        }

        // Lấy tên file và chuẩn hóa
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String sanitizedFileName = fileName.replaceAll("\\s+", "_");

        // Định nghĩa thư mục cần lưu
        String appPath = getServletContext().getRealPath("/");
        String rootPath = new File(appPath).getParentFile().getParent(); // Lấy thư mục gốc dự án

        String webUploadDir = rootPath + "/web/assets/images/slider";  // Thư mục gốc web
        String buildUploadDir = rootPath + "/build/web/assets/images/slider";  // Thư mục build

        File webFolder = new File(webUploadDir);
        File buildFolder = new File(buildUploadDir);

        // Tạo thư mục nếu chưa tồn tại
        if (!webFolder.exists()) {
            webFolder.mkdirs();
        }
        if (!buildFolder.exists()) {
            buildFolder.mkdirs();
        }

        // Lưu file vào cả thư mục `web` và `build`
        File webImageFile = new File(webFolder, sanitizedFileName);
        File buildImageFile = new File(buildFolder, sanitizedFileName);

        try {
            filePart.write(webImageFile.getAbsolutePath());
            Files.copy(webImageFile.toPath(), buildImageFile.toPath()); // Copy sang thư mục build
            System.out.println("File saved to: " + webImageFile.getAbsolutePath());
            System.out.println("File also copied to: " + buildImageFile.getAbsolutePath());
        } catch (IOException e) {
            System.out.println("Lỗi khi lưu file: " + e.getMessage());
            e.printStackTrace();
        }

        // Lưu vào database
        SliderDAO sliderDAO = new SliderDAO();
        boolean result = sliderDAO.AddNewSlider(title, "assets/images/slider/" + fileName, backLink);

        HttpSession session = request.getSession();
        if (result) {
            session.setAttribute("MESSAGE", "Add slider successfully!");
        } else {
            session.setAttribute("MESSAGE", "Add slider failed!");
        }

        response.sendRedirect("slider");

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
