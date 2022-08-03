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
    boolean updatedSinceLastSave;

    int user_id;
    //    ArrayList<Item> items;
    HashMap<Integer, Item> items;

    public Cart(int userID, DatabaseConnection connection) {
        items = new HashMap<>();
        linkToUser(userID, connection);
    }

    public void linkToUser(int userID, DatabaseConnection connection) {
        user_id = userID;
        if (userID == -1) return;
        Cart.Item[] items = TourModel.getCart(userID).query(connection);
        for (Cart.Item item : items) addItem(item);
        if (items.length > 0) save(connection);
    }

    public int getUserid() {
        return user_id;
    }

    public boolean addItem(Item item) {
        return addItem(item, false);
    }

    public boolean addItem(Item item, boolean override) {
        if (!items.containsKey(item.tourDateId)) {
            items.put(item.tourDateId, item);
            updatedSinceLastSave = true;
            save();
            return true;
        }
        if (override) {
            items.merge(item.tourDateId, item, (oldValue, newValue) -> newValue);
            updatedSinceLastSave = true;
            save();
            return true;
        }
        return false;
    }

    public void removeItem(int tourDateId) {
        items.remove(tourDateId);
        updatedSinceLastSave = true;
    }

    public Item[] getAllItems() {
        return items.values().toArray(new Item[0]);
    }

    public double getTotalPrice(DatabaseConnection connection, String currency) {
        try {
            double total = 0;
            Item[] itemsArray = getAllItems();
            for (Item item : itemsArray) total += item.getPrice(connection);
            return total * CurrencyExchangeRates.GetCurrentRates().getRates().get(currency) * 100;
        } catch (Exception e) {
            return -1;
        }
    }

    public double getTotalPrice(String currency) {
        DatabaseConnection connection = new DatabaseConnection();
        double price = getTotalPrice(connection, currency);
        connection.close();
        return price;
    }

    public String getTotalPriceString(DatabaseConnection connection, String currency) {
        double total = getTotalPrice(connection, currency);
        if (total == -1) return "Error Please Try Again";
        double gst = total * 1.07;
        return '$' + String.format("%.2f", total / 100)  + " ($" + String.format("%.2f", gst / 100) + " with gst)";
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
        if (!updatedSinceLastSave) return true;
        DatabaseConnection connection = new DatabaseConnection();
        TourModel.updateCart(this).update(connection);
        updatedSinceLastSave = false;
        connection.close();
        return true;
    }

    public boolean save(DatabaseConnection connection) {
        if (user_id == -1) return false;
        if (!updatedSinceLastSave) return true;
        TourModel.updateCart(this).update(connection);
        updatedSinceLastSave = false;
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
            if (!dateDictionary.containsKey(tourId)) dateDictionary.put(tourId, new ArrayList<>());

            dateDictionary.get(tourId).add(pair);
        }
        HashMap<Tour, Tour.Date.Pair[]> result = new HashMap<>();
        for (Integer key : dateDictionary.keySet()) {
            Tour[] tours = TourModel.getTourById(key).query(connection);
            if (tours.length != 1) continue;
            result.put(tours[0], dateDictionary.get(key).toArray(new Tour.Date.Pair[0]));
        }
        return result;
    }

    public void clear() {
        items.clear();
        save();
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
