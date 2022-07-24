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
import java.util.HashMap;

public class Cart {
    int user_id;
    //    ArrayList<Item> items;
    HashMap<Integer, Item> items;

    public Cart(int userID, DatabaseConnection connection) {
        items = new HashMap<>();
        linkToUser(userID, connection);
    }

    public void linkToUser(int userID, DatabaseConnection connection) {
        user_id = userID;
        if (userID == -1) {
            return;
        }
        //TODO find a better way to do this
        Cart.Item[] items = TourModel.getCart(userID).query(connection);
        for (Cart.Item item : items) {
            this.items.put(item.getTourDateId(), item);
        }
    }

    public int getUserid() {
        return user_id;
    }

    public void addItem(Item item) {
        if (items.containsKey(item.tourDateId)) items.merge(item.tourDateId, item, (oldValue, newValue) -> newValue);
        else items.put(item.tourDateId, item);
    }
public void removeItem(int tourDateId) {
        items.remove(tourDateId);
    }
    public Item[] getAllItems() {
        return items.values().toArray(new Item[0]);
    }

    public double getTotalPrice(DatabaseConnection connection) {
        double total = 0;
        Item[] itemsArray = getAllItems();
        for (Item item : itemsArray) total += item.getPrice(connection);
        return total;
    }

    public String getTotalPriceString(DatabaseConnection connection) {
        return '$' + String.format("%.2f", getTotalPrice(connection));
    }

    public static Cart GetExisting(HttpSession session) {
        return (Cart) session.getAttribute("cart");
    }

    public static Cart getOrCreateCart(HttpSession session, DatabaseConnection connection) {
        int userid = Util.getUserID(session);
        //check if cart is in session
        Cart cart = GetExisting(session);
        if (cart == null) {
            cart = new Cart(userid, connection);
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
            cart = new Cart(userid, connection);
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
        TourModel.updateCart(this).update(connection);
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

        Item[] itemsArray = getAllItems();
        for (Item item : itemsArray) {
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
