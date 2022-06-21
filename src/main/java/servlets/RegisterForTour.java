package servlets;

import models.TourModel;
import utils.DatabaseConnection;
import utils.Util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterForTour
 */
@WebServlet("/RegisterForTour")
public class RegisterForTour extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterForTour() {
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
        // TODO Auto-generated method stub
        String date = request.getParameter("date");
        int pax = Integer.parseInt(request.getParameter("pax"));
        String previousURL = request.getHeader("Referer") + "?pax=" + pax;

        if (date == null || date.equals("placeholder")) {
            previousURL += "&InvalidDate=";
            response.sendRedirect(previousURL);
            return;
        }

        int tourDateID = Integer.parseInt(date);

        //Debug
//        response.getWriter().append("Tour ID: ").append(tour_id).append("\n").append("Date ID: ").append(date).append("\n").append("Pax: ").append(pax);


        int userID = Util.forceLogin(request.getSession(), response, previousURL);

        DatabaseConnection conn = new DatabaseConnection();
        boolean success = TourModel.registerUserForTour(userID, tourDateID, pax).update(conn) == 1;
        conn.close();

        if (success) {
            response.getWriter().append("You have successfully registered for this tour\n");
        } else {
            response.getWriter().append("There was an error registering for this tour\n");
        }

    }

}
