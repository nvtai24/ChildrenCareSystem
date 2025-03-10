/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class GoogleLogin extends HttpServlet {
    private static final String CLIENT_ID = "481466145521-si59hh8m95j78lmurspingd4q14ffc4q.apps.googleusercontent.com";
    private static final String REDIRECT_URI = "http://localhost:8080/app/callback";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String googleAuthURL = "https://accounts.google.com/o/oauth2/auth"
                + "?scope=email%20profile"
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&response_type=code"
                + "&client_id=" + CLIENT_ID
                + "&approval_prompt=force"
                + "&access_type=offline";

        response.sendRedirect(googleAuthURL);
    }
}
