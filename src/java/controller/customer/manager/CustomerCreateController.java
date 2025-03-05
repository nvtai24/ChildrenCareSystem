/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.manager;

import util.EmailUtil;
import dal.ProfileDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Profile;
import model.auth.User;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author milo9
 */
public class CustomerCreateController extends HttpServlet {

    private static final long TOKEN_EXPIRATION_HOURS = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("checkUsername".equals(action)) {
            String username = request.getParameter("username");
            boolean exists = userDAO.checkUsernameExists(username);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }

        if ("checkEmail".equals(action)) {
            String email = request.getParameter("email");
            boolean exists = userDAO.checkEmailExists(email);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }

        request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAO();
        ProfileDAO profileDAO = new ProfileDAO();

        String username = request.getParameter("dzName").trim();
        String password = request.getParameter("dzPassword").trim();
        String email = request.getParameter("dzEmail").trim();
        String firstName = request.getParameter("firstname").trim();
        String lastName = request.getParameter("lastname").trim();
        String dob = request.getParameter("dob").trim();
        String gender = request.getParameter("gender").trim();
        String address = request.getParameter("address").trim();
        String phone = request.getParameter("phone").trim();

        if (userDAO.checkUsernameExists(username)) {
            request.setAttribute("error", "Username already exists.");
            request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
            return;
        }

        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Email already exists.");
            request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
            return;
        }

        String token = UUID.randomUUID().toString();
        //String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        long expirationTime = System.currentTimeMillis() + TimeUnit.HOURS.toMillis(TOKEN_EXPIRATION_HOURS);

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setVerificationToken(token);
        newUser.setTokenExpiration(new Timestamp(expirationTime));

        boolean isRegistered = userDAO.register(newUser);
        if (isRegistered) {

            User user = userDAO.get(username, password);

            // Tạo profile cho user nếu đã tạo user thành công 
            Profile profile = new Profile();
            profile.setUser(user);
            profile.setFirstName(firstName);
            profile.setLastName(lastName);
            profile.setGender(gender.equalsIgnoreCase("1"));
            profile.setDob(Date.valueOf(dob));
            profile.setAddress(address);
            profile.setPhone(phone);
            profile.setAvatar("assets/images/profile/default.jpg");

            profileDAO.createProfile(profile);
            String verificationLink = "http://localhost:8080/app/verify?token=" + token + "&redirect=login";
            EmailUtil.sendVerificationEmail(email, verificationLink);
            request.setAttribute("notification", "successfull");
            request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);

        } else {

            request.setAttribute("notification", "false");
            request.getRequestDispatcher("../dashboard/manager/customerCreate.jsp").forward(request, response);
        }
    }
}
