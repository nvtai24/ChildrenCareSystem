/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import util.EmailUtil;
import at.favre.lib.crypto.bcrypt.BCrypt;
import dal.ProfileDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Period;
import java.util.Base64;
import java.util.Date;
import model.auth.User;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import model.Profile;
import util.PasswordUtil;

/**
 *
 * @author Nvtai
 */
public class RegisterController extends HttpServlet {

    private static final long TOKEN_EXPIRATION_HOURS = 2;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletExce tion if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
        String username = request.getParameter("dzName");
        String password = request.getParameter("dzPassword");
        String email = request.getParameter("dzEmail");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        if (username.length() < 5 || username.length() > 30 || username.contains(" ")) {
            request.setAttribute("usernameError", "Username must be 5-30 characters and cannot contain spaces.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8 || password.length() > 15 || !password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,15}$")) {
            request.setAttribute("passwordError", "Password must be 8-15 characters with at least one uppercase letter, one lowercase letter, and one number.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (userDAO.checkUsernameExists(username)) {
            request.setAttribute("usernameError", "Username already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("emailError", "Email already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (!isValidName(firstname)) {
            request.setAttribute("firstnameError", "First name must be 2-50 characters and contain only letters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!isValidName(lastname)) {
            request.setAttribute("lastnameError", "Last name must be 2-50 characters and contain only letters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!isValidPhone(phone)) {
            request.setAttribute("phoneError", "Phone must start with 0 and be 10-11 digits long.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!isValidDateOfBirth(dob)) {
            request.setAttribute("dobError", "You must be at least 5 years old and date must be valid.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        String token = UUID.randomUUID().toString();
        long expirationTime = System.currentTimeMillis() + TimeUnit.HOURS.toMillis(TOKEN_EXPIRATION_HOURS);
        String hashedPassword = PasswordUtil.toSHA1(password);
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(hashedPassword);
        newUser.setEmail(email);
        newUser.setVerificationToken(token);
        newUser.setTokenExpiration(new Timestamp(expirationTime));
        boolean isRegistered = userDAO.register(newUser);
        if (isRegistered) {
            User user = userDAO.get(username, hashedPassword);
            Profile newProfile = new Profile();
            newProfile.setUser(user); 
            newProfile.setFirstName(firstname);
            newProfile.setLastName(lastname);
            boolean genderValue = "1".equals(gender);
            newProfile.setGender(genderValue);
            newProfile.setDob(java.sql.Date.valueOf(dob));
            newProfile.setAddress(address);
            newProfile.setPhone(phone);

            ProfileDAO profileDAO = new ProfileDAO();
            boolean isProfileSaved = profileDAO.saveProfile(newProfile);

            if (isProfileSaved) {

                String serverPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
                String contextPath = request.getContextPath();
                String verificationLink = serverPath + contextPath + "/verify?token=" + token + "&redirect=login";
                EmailUtil.sendVerificationEmail(email, verificationLink);
                request.setAttribute("successMessage", "A verify link has been sent to your email.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Profile registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }

    }
    private boolean isValidName(String name) {
        if (name == null) return false;
        return Pattern.matches("^[A-Za-z\\s]{2,50}$", name);
    }

    private boolean isValidPhone(String phone) {
        if (phone == null) return false;
        return Pattern.matches("^(0[0-9]{9,10})$", phone);
    }

    private boolean isValidDateOfBirth(String dobString) {
        try {
            LocalDate dob = LocalDate.parse(dobString);
            LocalDate today = LocalDate.now();
            int age = Period.between(dob, today).getYears();
            return age >= 5 && age < 120 && dob.isBefore(today);
        } catch (Exception e) {
            return false;
        }
    }
}
