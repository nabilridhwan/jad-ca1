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

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class Cart {
    int id;
    ArrayList<Item> items;

    public Cart(DatabaseConnection connection, int userID) {
        items = new ArrayList<>();
        if (userID == -1) {
            id = -1;
            return;
        }

        //TODO Get cart from DB

        //TODO Create cart to DB
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


    public void save(HttpSession session, DatabaseConnection connection, HttpServletResponse response) throws IOException {
        int userID = Util.forceLogin(session, response);
        if (id == -1) {
            //TODO: update cart in db
        } else {
            //TODO: insert cart in db
        }
    }

    public void delete(HttpSession session, DatabaseConnection connection) {
        session.removeAttribute("cart");
        if (id == -1) {
            //TODO delete cart from db
        }
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
            //TODO get price from db
            return 1 * pax;
        }

        public int getTourDateId() {
            return tourDateId;
        }

        public int getPax() {
            return pax;
        }
    }
}
