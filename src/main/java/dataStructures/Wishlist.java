package dataStructures;

import java.sql.ResultSet;

public class Wishlist {
    int wishlist_id;
    int user_id;
    int tour_id;

    public Wishlist(ResultSet rs) {
        try {
        	wishlist_id = rs.getInt(1);
        	user_id = rs.getInt(2);
        	tour_id = rs.getInt(3);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getWishlist_id() {
        return wishlist_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public int getTour_id() {
        return tour_id;
    }
}



