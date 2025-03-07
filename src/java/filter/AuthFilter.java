/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession();

        User account = (User) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login");
        } else {
            System.out.println(account.getId());
            ArrayList<String> permissions = (ArrayList<String>) session.getAttribute("permissions");

            String url = request.getServletPath();

            if (!permissions.contains(url)) {
                int statusCode = 403;
                String errorMessage = "Access Denied!";
                String noti1 = "You do not have permission to access this page.";
                String noti2 = "Please check with the administrator if you believe this is a mistake.";

                request.setAttribute("statusCode", statusCode);
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("noti1", noti1);
                request.setAttribute("noti2", noti2);

                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
        chain.doFilter(req, res);
    }

}
