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
import java.time.LocalDate;
import java.util.ArrayList;
import model.Profile;
import model.WishList;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class ReservationContactController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");
        int uid = account.getId();

        ProfileDAO pDB = new ProfileDAO();
        Profile p = pDB.getProfileByUserId(uid);

        String[] rawSids = request.getParameterValues("serviceId");
        if (rawSids != null) {
            ArrayList<WishList> wishlist = new ArrayList<>();

            WishListDAO wldb = new WishListDAO();

            for (int i = 0; i < rawSids.length; i++) {
                int sid = Integer.parseInt(rawSids[i]);
                WishList wl = wldb.getWishListItem(uid, sid);
                wishlist.add(wl);
            }
            session.setAttribute("items", wishlist);
        }

        LocalDate tomorrow = LocalDate.now().plusDays(1);

        request.setAttribute("tommorow", tomorrow);
        request.setAttribute("p", p);
        request.getRequestDispatcher("../reservation-contact.jsp").forward(request, response);
    }

}
