/*
 * 	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */


package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataStructures.Tour;
import models.TourModel;
import utils.DatabaseConnection;
import utils.Util;

/**
 * Servlet implementation class AddReview
 */
@WebServlet("/addReview")
public class LeaveAReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LeaveAReview() {
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
		
		
		HttpSession session = request.getSession(false);
		DatabaseConnection connection = new DatabaseConnection();
		
		String tour_id = request.getParameter("tour_id");
		String text = request.getParameter("text");
		String rating = request.getParameter("rating");
		
		
		int userID = Util.getUserID(session);
		
		if(userID == -1) {
//			TODO: Redirection
			response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
			return;
		}
		
		int ratingInt = Integer.parseInt(rating);
		
		int affectedRows = TourModel.addReviewToTour(tour_id, userID, ratingInt, text).update(connection);
		
		if(affectedRows > 0) {
//			TODO: Redirection
			response.sendRedirect("/CA1-Preparation/views/tour/detail.jsp?tour_id=" + tour_id);
			return;
		}else {
//			TODO: Redirection error
			response.sendRedirect("/CA1-Preparation/views/tour/detail.jsp?tour_id=" + tour_id + "&message=There was an error submitting your review. Please try agian later.");
			return;
		}
		
	}

}
