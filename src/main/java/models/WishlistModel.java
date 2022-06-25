package models;

import dataStructures.Tour;
import dataStructures.User;
import dataStructures.Wishlist;
import utils.DatabaseConnection;
import utils.IDatabaseQuery;
import utils.IDatabaseUpdate;

import java.sql.*;
import java.util.ArrayList;

public class WishlistModel {

    public static IDatabaseQuery<Wishlist> getUserWishlistItems(int user_id) {

        return databaseConnection -> {
            try {
                Connection conn = databaseConnection.get();
                PreparedStatement prepStatement = conn.prepareStatement("SELECT * FROM wishlist WHERE user_id = ?;");
                prepStatement.setInt(1, user_id);
                
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Wishlist> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Wishlist(rs));

                return list.toArray(new Wishlist[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }
    
    public static IDatabaseUpdate addTourToWishlist(int user_id, int tour_id) {

        return databaseConnection -> {
            try {
                Connection conn = databaseConnection.get();
                PreparedStatement prepStatement = conn.prepareStatement("INSERT INTO wishlist(user_id, tour_id) VALUES(?, ?)");
                prepStatement.setInt(1, user_id);
                prepStatement.setInt(2, tour_id);
                
                int affectedRows = prepStatement.executeUpdate();

                return affectedRows > 0 ? affectedRows : -1;

            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }
    
    public static IDatabaseUpdate removeWishlistItem(int wishlist_id) {

        return databaseConnection -> {
            try {
                Connection conn = databaseConnection.get();
                PreparedStatement prepStatement = conn.prepareStatement("DELETE FROM wishlist WHERE wishlist_id = ?");
                prepStatement.setInt(1, wishlist_id);
                
                int affectedRows = prepStatement.executeUpdate();

                return affectedRows > 0 ? affectedRows : -1;

            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    
}
