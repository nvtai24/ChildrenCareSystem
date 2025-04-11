/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.manager;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.auth.User;

/**
 *
 * @author milo9
 */
public class CustomerListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDB = new UserDAO();
        ArrayList<User> customers = uDB.getCustomerList();

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("dashboard/manager/customerList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDB = new UserDAO();
        String action = request.getParameter("action");

        switch (action) {
            case "status" -> {
                filterCustomerListByStatus(request, response);
            }
            case "change" -> {
                String id_raw = request.getParameter("id");
                String status_raw = request.getParameter("status");
                int id = Integer.parseInt(id_raw);
                int status = 0;
                if ("true".equalsIgnoreCase(status_raw)) {
                    status = 1;
                } else if ("false".equalsIgnoreCase(status_raw)) {
                    status = 0;
                }
                changeStatusCustomer(request, response, id, status);
            }
            case "search" -> {
                String title = request.getParameter("search").trim();
                title = trimSpaces(title);
                showCustomerByTitle(request, response, title);
            }
            default -> {
                showAllCustomers(request, response);
            }
        }
    }

    private void filterCustomerListByStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDB = new UserDAO();
        HttpSession session = request.getSession();

        // Get status from request and update session
        int status = Integer.parseInt(request.getParameter("status"));
        session.setAttribute("sessionStatus", status);  // Save the status in session

        // Retrieve the filtered customer list and forward to the JSP
        request.setAttribute("customers", uDB.getCustomerListByStatus(status));
        request.getRequestDispatcher("dashboard/manager/customerList.jsp").forward(request, response);
    }

    private void showAllCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO uDB = new UserDAO();
        ArrayList<User> customers = uDB.getCustomerList();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("dashboard/manager/customerList.jsp").forward(request, response);
    }

    private void changeStatusCustomer(HttpServletRequest request, HttpServletResponse response, int idUser, int status)
            throws ServletException, IOException {
        UserDAO uDB = new UserDAO();
        if (uDB.UpdateStatusByUser(idUser, status)) {
            request.setAttribute("notification", "successfull");
        } else {
            request.setAttribute("notification", "error");
        }

        ArrayList<User> customers = uDB.getCustomerList();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("dashboard/manager/customerList.jsp").forward(request, response);
    }

    private void showCustomerByTitle(HttpServletRequest request, HttpServletResponse response, String title)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAO uDB = new UserDAO();

        ArrayList<User> customers = uDB.searchCustomer(title);
        request.setAttribute("customers", customers);
        session.setAttribute("title", title);
        request.getRequestDispatcher("dashboard/manager/customerList.jsp").forward(request, response);
    }

    // Dùng để validate khoảng trắng cách chữ trong string không cách nhau
    private static String trimSpaces(String input) {
        if (input == null) {
            return null;
        }
        return input.trim().replaceAll("\\s+", " ");
    }

}
