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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        try {

            if (request.getParameter("title") == null) {
                int sliderId = Integer.parseInt(request.getParameter("id"));
                SliderDAO sliderDAO = new SliderDAO();
                Slider slider = sliderDAO.GetSliderById(sliderId);
                if (slider != null) {
                    request.setAttribute("SLIDER", slider);
                }
                request.getRequestDispatcher("updateslider.jsp").forward(request, response);
                return;
            }

            int sliderId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title") != null ? request.getParameter("title").trim() : "";
            String backlink = request.getParameter("backlink") != null ? request.getParameter("backlink").trim() : "";

            Map<String, String> fieldErrors = new HashMap<>();
            if (title.isEmpty()) {
                fieldErrors.put("title", "Title must not be empty.");
            }
            if (backlink.isEmpty()) {
                fieldErrors.put("backlink", "Back link must not be empty.");
            }

            if (!fieldErrors.isEmpty()) {
                SliderDAO sliderDAO = new SliderDAO();
                Slider slider = sliderDAO.GetSliderById(sliderId);

                request.setAttribute("SLIDER", slider);
                request.setAttribute("fieldErrors", fieldErrors);
                request.setAttribute("title", title);
                request.setAttribute("backlink", backlink);

                request.getRequestDispatcher("updateslider.jsp").forward(request, response);
                return;
            }

            Part filePart = request.getPart("image");
            SliderDAO sliderDAO = new SliderDAO();
            Slider existingSlider = sliderDAO.GetSliderById(sliderId);

            String fileName = null;
            boolean isUpdatingImage = (filePart != null && filePart.getSize() > 0);

            if (isUpdatingImage) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String sanitizedFileName = fileName.replaceAll("\\s+", "_");

                String appPath = getServletContext().getRealPath("/");
                String rootPath = new File(appPath).getParentFile().getParent();

                String webUploadDir = rootPath + "/web/" + UPLOAD_DIR;
                String buildUploadDir = rootPath + "/build/web/" + UPLOAD_DIR;

                File webFolder = new File(webUploadDir);
                File buildFolder = new File(buildUploadDir);

                if (!webFolder.exists()) {
                    webFolder.mkdirs();
                }
                if (!buildFolder.exists()) {
                    buildFolder.mkdirs();
                }

                File existingFile = new File(webFolder, sanitizedFileName);
                if (!existingFile.exists()) {
                    File webImageFile = new File(webFolder, sanitizedFileName);
                    File buildImageFile = new File(buildFolder, sanitizedFileName);

                    filePart.write(webImageFile.getAbsolutePath());
                    Files.copy(webImageFile.toPath(), buildImageFile.toPath());
                }

                fileName = "assets/images/slider/" + sanitizedFileName;
            } else {
                fileName = existingSlider.getImageUrl();
            }

            Slider slider = new Slider();
            slider.setId(sliderId);
            slider.setTitle(title);
            slider.setBackLink(backlink);
            slider.setImageUrl(fileName);

            boolean result = sliderDAO.updateSlider(slider);

            HttpSession session = request.getSession();
            session.setAttribute("MESSAGE", result ? "Update slider successfully!" : "Update slider failed");

            response.sendRedirect("sliders");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý slider.");
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
