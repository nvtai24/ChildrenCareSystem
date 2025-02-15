/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package exception;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Nvtai
 */
public class ErrorHandleController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleError(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleError(request, response);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");

        String errorMessage = "Something went wrong!";
        String noti1 = "An unexpected error occurred.";
        String noti2 = "Please try again later or contact support if the issue persists.";

        if (statusCode != null) {
            switch (statusCode) {
                case 403:
                    errorMessage = "Access Denied!";
                    noti1 = "You do not have permission to access this page.";
                    noti2 = "Please check with the administrator if you believe this is a mistake.";
                    break;
                case 404:
                    errorMessage = "Page Not Found!";
                    noti1 = "The page you were looking for couldn't be found.";
                    noti2 = "It might have been removed, had its name changed, or is temporarily unavailable.";
                    break;
                case 500:
                    errorMessage = "Internal Server Error!";
                    noti1 = "Something went wrong on our end.";
                    noti2 = "We're experiencing technical difficulties. Please try again later.";
                    break;
            }
        }

        request.setAttribute("statusCode", statusCode != null ? statusCode : "Unknown Error");
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("noti1", noti1);
        request.setAttribute("noti2", noti2);


        request.getRequestDispatcher("error.jsp").forward(request, response);
    }

}
