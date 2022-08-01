/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

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
@WebServlet("/TourPageAddWishlist")
public class TourPageAddWishlist extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public TourPageAddWishlist() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("TourPageAddWishlist");

        DatabaseConnection connection = new DatabaseConnection();
        HttpSession session = request.getSession();
        //previous page
        String previousPage = request.getHeader("Referer");
        //remove message parameter from the previous page if it exists
        int msgIndex = previousPage.indexOf("&message");
        if (msgIndex != -1) {
            previousPage = previousPage.substring(0, msgIndex);
        }

        // Get the user id
        int userId = Util.forceLogin(session, response, previousPage);

        if (userId == -1) {
//			Redirection
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
            return;
        }


        // Get the wishlist_id from the request
        String TourIdStr = request.getParameter("tourId");
        if (TourIdStr == null) {
            response.sendRedirect(previousPage + "&message=An error occurred while adding wishlist: tour not found");
            return;
        }

        try {
            int tourId = Integer.parseInt(TourIdStr);

            int affectedRows = WishlistModel.addTourToWishlist(userId, tourId).update(connection);

            response.sendRedirect(previousPage);
        } catch (Exception e) {
            response.sendRedirect(previousPage + "&message=An error occurred while adding wishlist");
        } finally {
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
