/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
 * */

package dataStructures;

import utils.DatabaseConnection;
import utils.Util;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

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
    }
}
