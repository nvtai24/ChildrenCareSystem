/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.wishlist;

import dal.WishListDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Nvtai
 */
public class DeleteItemController extends HttpServlet {

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
        String raw_uid = request.getParameter("uid");
        String raw_sid = request.getParameter("sid");

        int uid = Integer.parseInt(raw_uid);
        int sid = Integer.parseInt(raw_sid);

        WishListDAO wldb = new WishListDAO();
        wldb.deleteWishlistItem(uid, sid);

        response.sendRedirect("/app/reservation/detail");
    }

}
