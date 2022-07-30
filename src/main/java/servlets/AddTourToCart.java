/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

package servlets;

import dataStructures.Cart;
import models.TourModel;
import utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class RegisterForTour
 */
@WebServlet("/AddTourToCart")
public class AddTourToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTourToCart() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String paxStr = request.getParameter("pax");

        String baseUrl = request.getHeader("Referer");
        //remove all the parameters from the url
        baseUrl = baseUrl.substring(0, baseUrl.indexOf("?"));

        String originalURL = baseUrl + "?tour_id=" + request.getParameter("id");
        String previousURL = originalURL;

        boolean isValid = true;
        int pax = 0;
        int tourDateID = 0;

        if (paxStr == null) {
            isValid = false;
            previousURL += "&InvalidPax=true";
        } else {
            try {
                pax = Integer.parseInt(paxStr);
                previousURL += "&pax=" + pax;
            } catch (NumberFormatException e) {
                isValid = false;
                previousURL += "&InvalidPax=true";
            }
        }

        if (date == null || date.equals("placeholder")) {
            previousURL += "&InvalidDate=";
            isValid = false;
        } else {
            try {
                tourDateID = Integer.parseInt(date);
                previousURL += "&date=" + date;
            } catch (NumberFormatException e) {
                previousURL += "&InvalidDate=";
                isValid = false;
            }
        }

        if (!isValid) {
            response.sendRedirect(previousURL);
            return;
        }


        DatabaseConnection db = new DatabaseConnection();

        Cart cart = Cart.getOrCreateCart(request.getSession(), db);

        //check if tour is in database
        if (TourModel.getPaxForTour(cart.getUserid(), tourDateID).query(db).length > 0) {
            db.close();
            response.sendRedirect(originalURL + "&alreadyRegistered=");
            return;
        }

        db.close();
        boolean editMode = request.getParameter("edit_mode") != null;
        if (!cart.addItem(new Cart.Item(tourDateID, pax), editMode)) {
            response.sendRedirect(originalURL + "&alreadyInCart=");
            return;
        }
        if(editMode) {
            response.sendRedirect(originalURL + "&EditSuccess=");
        } else {
            response.sendRedirect(originalURL + "&CartSuccess= ");
        }

    }
}
