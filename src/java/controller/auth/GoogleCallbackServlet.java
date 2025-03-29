/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dal.UserDAO;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.auth.User;
import org.json.JSONObject;
import util.PasswordUtil;

public class GoogleCallbackServlet extends HttpServlet {
    private static final String CLIENT_ID = "481466145521-si59hh8m95j78lmurspingd4q14ffc4q.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serverPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        String contextPath = request.getContextPath();
        String redirectUri = serverPath + contextPath + "/callback";
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            response.getWriter().println("Login failed!");
            return;
        }

        String tokenEndpoint = "https://oauth2.googleapis.com/token";
        String params = "code=" + code
                + "&client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&redirect_uri=" + redirectUri
                + "&grant_type=authorization_code";

        URL url = new URL(tokenEndpoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes());
        }

        Scanner scanner = new Scanner(conn.getInputStream());
        StringBuilder responseBody = new StringBuilder();
        while (scanner.hasNext()) {
            responseBody.append(scanner.nextLine());
        }
        scanner.close();

        JSONObject json = new JSONObject(responseBody.toString());
        String accessToken = json.getString("access_token");

        URL userInfoURL = new URL("https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + accessToken);
        conn = (HttpURLConnection) userInfoURL.openConnection();
        conn.setRequestMethod("GET");

        scanner = new Scanner(conn.getInputStream());
        responseBody = new StringBuilder();
        while (scanner.hasNext()) {
            responseBody.append(scanner.nextLine());
        }
        scanner.close();

        JSONObject userJson = new JSONObject(responseBody.toString());
        String email = userJson.getString("email");
        String name = userJson.getString("name");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);
        if (user == null) {
            String defaultPassword = "123456";
            String hashedPassword = PasswordUtil.toSHA1(defaultPassword);
            userDAO.createUser(email, email, hashedPassword);
            user = userDAO.getUserByEmail(email);
        }

        HttpSession session = request.getSession();
        session.setAttribute("account", user);

        response.sendRedirect("/app");
    }
}
