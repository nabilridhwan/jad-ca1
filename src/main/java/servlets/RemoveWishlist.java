package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.WishlistModel;
import utils.DatabaseConnection;
import utils.Util;

/**
 * Servlet implementation class RemoveWishlist
 */
@WebServlet("/removeWishlist")
public class RemoveWishlist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveWishlist() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DatabaseConnection connection = new DatabaseConnection();
		HttpSession session = request.getSession();
		
		// Get the user id
		int user_id = Util.getUserID(session);
		
		if(user_id == -1) {
//			Redirection
			response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
			return;
		}
			
		
		// Get the wishlist_id from the request
		String wishlist_id = request.getParameter("wishlist_id");
		
		if(wishlist_id == null) {
			response.sendRedirect("/CA1-Preparation/views/user/wishlist.jsp?message=An error occured while removing");
		}
		
		try {
			int wishlist_id_int = Integer.parseInt(wishlist_id);
			int affectedRows = WishlistModel.removeWishlistItem(wishlist_id_int, user_id).update(connection);
			
			response.sendRedirect("/CA1-Preparation/views/user/wishlist.jsp");
			return;
			
		}catch(NumberFormatException nfe) {
			response.sendRedirect("/CA1-Preparation/views/user/wishlist.jsp?message=Wishlist ID is not a number");
			return;
		}catch(Exception e) {
			response.sendRedirect("/CA1-Preparation/views/user/wishlist.jsp?message=An error occured while removing");
			return;
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
