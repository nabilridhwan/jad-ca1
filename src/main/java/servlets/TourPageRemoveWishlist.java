package servlets;

import models.WishlistModel;
import utils.DatabaseConnection;
import utils.Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet implementation class RemoveWishlist
 */
@WebServlet("/TourPageRemoveWishlist")
public class TourPageRemoveWishlist extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public TourPageRemoveWishlist() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("TourPageRemoveWishlist");

        DatabaseConnection connection = new DatabaseConnection();
        HttpSession session = request.getSession();
        //previous page
        String previousPage = request.getHeader("Referer");
        //remove message parameter from the previous page if it exists
        if (previousPage.contains("&message")) {
            previousPage = previousPage.substring(0, previousPage.indexOf("&message"));
        }

        // Get the user id
        int userId = Util.forceLogin(session, response, previousPage);

        if (userId == -1) {
//			Redirection
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
            return;
        }


        // Get the wishlist_id from the request
        String wishlistidStr = request.getParameter("wishlistId");

        if (wishlistidStr == null) {
            response.sendRedirect(previousPage + "&message=An error occured while removing wishlist: wishlist not found");
            return;
        }

        try {
            int wishlistId = Integer.parseInt(wishlistidStr);

            int affectedRows = WishlistModel.removeWishlistItem(wishlistId, userId).update(connection);

            response.sendRedirect(previousPage);
        } catch (Exception e) {
            response.sendRedirect(previousPage + "&message=An error occured while removing wishlist");
        }
        finally {
            connection.close();
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
