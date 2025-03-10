/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard.admin.user;

import util.EmailUtil;
import dal.ProfileDAO;
import dal.RoleDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Profile;
import model.auth.Role;
import model.auth.User;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author Admin
 */
public class UserCreateController extends HttpServlet {

    private static final long TOKEN_EXPIRATION_HOURS = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String action = request.getParameter("action");
        RoleDAO rDB = new RoleDAO();
        ArrayList<Role> roles = rDB.listAllAvailableRole();

        if ("checkUsername".equals(action)) {
            // Kiểm tra username có tồn tại không
            String username = request.getParameter("username");
            boolean exists = userDAO.checkUsernameExists(username);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }

        if ("checkEmail".equals(action)) {
            // Kiểm tra email có tồn tại không
            String email = request.getParameter("email");
            boolean exists = userDAO.checkEmailExists(email);
            response.getWriter().write(exists ? "exists" : "available");
            return;
        }

        request.setAttribute("roles", roles);
        request.getRequestDispatcher("../dashboard/userCreate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // DAO 
        UserDAO userDAO = new UserDAO();
        ProfileDAO profileDAO = new ProfileDAO();
        RoleDAO rDB = new RoleDAO();

        String username = request.getParameter("dzName").trim();
        String password = request.getParameter("dzPassword").trim();
        String email = request.getParameter("dzEmail").trim();
        int role_id = Integer.parseInt(request.getParameter("role_id"));
        String firstName = request.getParameter("firstname").trim();
        String lastName = request.getParameter("lastname").trim();
        String dob = request.getParameter("dob").trim();
        String gender = request.getParameter("gender").trim();
        String address = request.getParameter("address").trim();
        String phone = request.getParameter("phone").trim();

        // Kiểm tra username đã tồn tại chưa
        if (userDAO.checkUsernameExists(username)) {
            response.getWriter().write("<script>alert('Username already exists!'); window.location='register.html';</script>");
            return;
        }

        if (userDAO.checkEmailExists(email)) {
            response.getWriter().write("<script>alert('Email already exists!'); window.location='register.html';</script>");
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

        // Thực hiện đăng ký
        boolean isRegistered = userDAO.register(newUser,role_id);

        if (isRegistered) {
            // Redirect to create user with success message
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
            // Chuyển đến trang userCreate
            ArrayList<Role> roles = rDB.listAllAvailableRole();
            request.setAttribute("roles", roles);
            request.setAttribute("notification", "successfull");
            request.getRequestDispatcher("../dashboard/userCreate.jsp").forward(request, response);

        } else {
            // Registration failed
            ArrayList<Role> roles = rDB.listAllAvailableRole();
            request.setAttribute("roles", roles);
            request.setAttribute("notification", "false");
            request.getRequestDispatcher("../dashboard/userCreate.jsp").forward(request, response);
        }
    }

}
