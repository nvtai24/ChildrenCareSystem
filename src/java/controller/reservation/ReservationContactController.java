/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ProfileDAO;
import dal.WishListDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Profile;
import model.WishList;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class ReservationContactController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");
        int uid = account.getId();

        ProfileDAO pDB = new ProfileDAO();
        Profile p = pDB.getProfileByUserId(uid);

        String[] rawSids = request.getParameterValues("serviceId");
        ArrayList<WishList> wishlist = new ArrayList<>();
        WishListDAO wldb = new WishListDAO();

        for (int i = 0; i < rawSids.length; i++) {
            int sid = Integer.parseInt(rawSids[i]);
            WishList wl = wldb.getWishListItem(uid, sid);
            wishlist.add(wl);
        }

        request.setAttribute("p", p);
        session.setAttribute("items", wishlist);
        request.getRequestDispatcher("../reservation-contact.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
