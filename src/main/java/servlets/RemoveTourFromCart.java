/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

package servlets;

import dataStructures.Cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class RegisterForTour
 */
@WebServlet("/RemoveTourFromCart")
public class RemoveTourFromCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveTourFromCart() {
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
        String dateid = request.getParameter("date_id");

        Cart cart = Cart.getOrCreateCart(request.getSession());

        cart.removeItem(Integer.parseInt(dateid));
        String baseUrl = request.getHeader("Referer");
        int subStringIndex = baseUrl.indexOf("?");
        if (subStringIndex != -1) {
            baseUrl = baseUrl.substring(0, subStringIndex);
        }
        baseUrl = baseUrl.substring(0, subStringIndex);
        response.sendRedirect(baseUrl + "?CartRemoveSuccess=");
    }
}
