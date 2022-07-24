/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
 * */

package dataStructures;

import models.TourModel;
import utils.DatabaseConnection;
import utils.Util;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

public class Cart {
    int user_id;
    ArrayList<Item> items;

    public Cart(DatabaseConnection connection, int userID) {
        items = new ArrayList<>();
        user_id = userID;
        if (userID == -1) {
            return;
        }
        Collections.addAll(items, TourModel.getCart(userID).query(connection));
    }

    public void linkToUser(int userID, DatabaseConnection connection) {
        user_id = userID;
        Collections.addAll(items, TourModel.getCart(userID).query(connection));
    }

    public void addItem(Item item) {
        items.add(item);
    }

    public Item[] getAllItems() {
        return items.toArray(new Item[0]);
    }

    public double getTotalPrice(DatabaseConnection connection) {
        double total = 0;
        for (Item item : items) total += item.getPrice(connection);
        return total;
    }

    public static Cart GetExisting(HttpSession session) {
        return (Cart) session.getAttribute("cart");
    }

    public static Cart getOrCreateCart(HttpSession session, DatabaseConnection connection) {
        int userid = Util.getUserID(session);
        //check if cart is in session
        Cart cart = GetExisting(session);
        if (cart == null) {
            cart = new Cart(connection, userid);
            session.setAttribute("cart", cart);
        }
        return cart;
    }


    public static Cart getOrCreateCart(HttpSession session) {
        int userid = Util.getUserID(session);
        //check if cart is in session
        Cart cart = GetExisting(session);
        if (cart == null) {
            DatabaseConnection connection = new DatabaseConnection();
            cart = new Cart(connection, userid);
            connection.close();
            session.setAttribute("cart", cart);
        }
        return cart;
    }


    public boolean save() {
        if (user_id == -1) return false;
        DatabaseConnection connection = new DatabaseConnection();
        boolean result = save(connection);
        connection.close();
        return result;
    }

    public boolean save(DatabaseConnection connection) {
        if (user_id == -1) return false;
        //TODO: insert cart in db
        return true;
    }

    public void delete(HttpSession session, DatabaseConnection connection) {
        session.removeAttribute("cart");
        if (user_id == -1) return;
        TourModel.deleteCart(user_id).update(connection);

    }

    public int Size() {
        return items.size();
    }


    public HashMap<Tour, Tour.Date.Pair[]> toHashMap(DatabaseConnection connection) {
        HashMap<Integer, ArrayList<Tour.Date.Pair>> dateDictionary = new HashMap<>();
        for (Item item : items) {
            // Get the tour_id

            int tourDateId = item.getTourDateId();

            Tour.Date[] tours = TourModel.getTourDateById(tourDateId).query(connection);

            if (tours.length != 1) continue;
            Tour.Date.Pair pair = new Tour.Date.Pair(tours[0], item.getPax());
            int tourId = tours[0].getTour_id();
            if (dateDictionary.containsKey(tourId)) {
                dateDictionary.get(tourId).add(pair);
            } else {
                ArrayList<Tour.Date.Pair> dates = new ArrayList<>();
                dates.add(pair);
                dateDictionary.put(tourId, dates);
            }
        }
        HashMap<Tour, Tour.Date.Pair[]> result = new HashMap<>();
        for (Integer key : dateDictionary.keySet()) {
            Tour[] tours = TourModel.getTourById(key).query(connection);
            if (tours.length != 1) continue;
            result.put(tours[0], dateDictionary.get(key).toArray(new Tour.Date.Pair[0]));
        }
        return result;
    }

    public static class Item {
        int tourDateId;
        int pax;

        public Item(int tourDateId, int pax) {
            this.tourDateId = tourDateId;
            this.pax = pax;
        }

        public double getPrice(DatabaseConnection connection) {
            Tour.Date[] dates = TourModel.getTourDateById(tourDateId).query(connection);
            if (dates.length != 1) return 0;
            return dates[0].getPrice() * pax;
        }

        public int getTourDateId() {
            return tourDateId;
        }

        public int getPax() {
            return pax;
        }
    }
}
