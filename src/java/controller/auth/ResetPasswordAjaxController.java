/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import model.auth.User;
import util.EmailUtil;

/**
 *
 * @author Nvtai
 */
public class ResetPasswordAjaxController extends HttpServlet {

    private static final long TOKEN_EXPIRATION_HOURS = 10;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");

        String email = request.getParameter("email");
        UserDAO userDAO = new UserDAO();

        User user = userDAO.getUserByEmail(email);

        String token = UUID.randomUUID().toString();
        long expirationTime = System.currentTimeMillis() + TimeUnit.HOURS.toMillis(TOKEN_EXPIRATION_HOURS);
        boolean isTokenGenerated = userDAO.generatePasswordResetToken(user.getId(), token, new Timestamp(expirationTime));

        if (isTokenGenerated) {
            String serverPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
            String contextPath = request.getContextPath();
            String resetLink = serverPath + contextPath + "/reset?token=" + token;
            EmailUtil.sendResetPasswordEmail(email, resetLink);

            out.print("{\"success\": true, \"message\": \"Email sent successfully\"}");
            out.flush();

            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            out.print("{\"success\": false, \"message\": \"Some thing wrong!\"}");
            out.flush();
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
    }

}
