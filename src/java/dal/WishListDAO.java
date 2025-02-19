/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Service;
import model.WishList;
import model.auth.User;

/**
 *
 * @author Nvtai
 */
public class WishListDAO extends DBContext {

    public WishList getWishListItem(int userId, int serviceId) {
        WishList wishlist = null;

        String query = "SELECT `wishlist`.`user_id`,\n"
                + "    `wishlist`.`service_id`,\n"
                + "    `wishlist`.`quantity`\n"
                + "FROM `childrencare`.`wishlist`"
                + "WHERE user_id = ? and service_id = ?";

        try {
            ResultSet rs = executeQuery(query, userId, serviceId);

            if (rs.next()) {
                int quantity = rs.getInt("quantity");

                User u = new User();
                u.setId(userId);

                Service s = new Service();
                s.setId(serviceId);

                wishlist = new WishList(u, s, quantity);
            }
        } catch (SQLException ex) {
            Logger.getLogger(WishListDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return wishlist;
    }

    public void AddToWishList(int userId, int serviceId) {
        WishList wishlistItem = getWishListItem(userId, serviceId);

        if (wishlistItem == null) {
            // Nếu sản phẩm chưa có trong wishlist, thêm mới vào
            String query = "INSERT INTO `childrencare`.`wishlist` (`user_id`, `service_id`, `quantity`) VALUES (?, ?, ?)";
            try {
                executeUpdate(query, userId, serviceId, 1);
            } catch (SQLException ex) {
                Logger.getLogger(WishListDAO.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(WishListDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } else {
            // Nếu sản phẩm đã tồn tại, tăng quantity thêm 1
            String query = "UPDATE `childrencare`.`wishlist` SET `quantity` = `quantity` + 1 WHERE `user_id` = ? AND `service_id` = ?";
            try {
                executeUpdate(query, userId, serviceId);
            } catch (SQLException ex) {
                Logger.getLogger(WishListDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public ArrayList<WishList> listAllWishlistItems(int userId) {
        ArrayList<WishList> wishlist = new ArrayList<>();

        String query = "select s.id, s.thumbnail,s.name, s2.value, s.price, s.discount, wl.quantity from wishlist wl\n"
                + "join service s on wl.service_id = s.id\n"
                + "join setting s2 on s.category_id = s2.setting_id\n"
                + "where wl.user_id = ?";

        try {
            ResultSet rs = executeQuery(query, userId);

            while (rs.next()) {
                int sid = rs.getInt("id");
                String thumbnail = rs.getString("thumbnail");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                double discount = rs.getDouble("discount");
                int quantity = rs.getInt("quantity");
                String categoryName = rs.getString("value");

                Service s = new Service().builder()
                        .id(sid)
                        .name(name)
                        .thumbnail(thumbnail)
                        .price(price)
                        .discount(discount)
                        .build();

                Category c = new Category();
                c.setName(categoryName);
                s.setCategory(c);

                User u = new User();
                u.setId(userId);

                WishList wl = new WishList(u, s, quantity);

                wishlist.add(wl);
            }

        } catch (SQLException ex) {
            Logger.getLogger(WishListDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return wishlist;
    }

    public void deleteWishlistItem(int userId, int serviceId) {

        String query = "DELETE FROM `childrencare`.`wishlist`\n"
                + "WHERE user_id = ? and service_id = ?";
        try {
            executeUpdate(query, userId, serviceId);
        } catch (SQLException ex) {
            Logger.getLogger(WishListDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateQuantity(int userId, int serviceId, int quantity) {
        String query = "UPDATE `childrencare`.`wishlist`\n"
                + "SET\n"
                + "`quantity` = ?\n"
                + "WHERE `user_id` = ? AND `service_id` = ?";

        try {
            executeUpdate(query, quantity, userId, serviceId);
        } catch (SQLException ex) {
            Logger.getLogger(WishListDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
