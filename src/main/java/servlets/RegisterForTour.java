/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

package servlets;

import dataStructures.Tour;
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
        String paxStr = request.getParameter("pax");

        String baseUrl = request.getHeader("Referer");
        //remove all the parameters from the url
        baseUrl = baseUrl.substring(0, baseUrl.indexOf("?"));

        String originalURL = baseUrl + "?tour_id=" + request.getParameter("id");
        String previousURL = originalURL;
        if (paxStr == null) {
            previousURL += "&InvalidPax=true";
            response.sendRedirect(previousURL);
            return;
        }
        int pax = Integer.parseInt(paxStr);
        previousURL += "&pax=" + pax;

        if (date == null || date.equals("placeholder")) {
            previousURL += "&InvalidDate=";
            response.sendRedirect(previousURL);
            return;
        }
        previousURL += "&date=" + date;
        int tourDateID = Integer.parseInt(date);

        int userID = Util.forceLogin(request.getSession(), response, previousURL);
        if (userID == -1) {
            return;
        } //doesn't work sometimes if you don't return

        DatabaseConnection conn = new DatabaseConnection();

        Tour.Date[] tourDate = TourModel.getTourDateById(tourDateID).query(conn);

        System.out.println("length:" + tourDate.length);
        System.out.println("id: " + tourDateID);
        if (tourDate.length != 1) {
            response.sendRedirect(previousURL + "&InvalidDate=");
            return;
        }

        if (tourDate[0].getAvail_slot() < pax) {
            response.sendRedirect(previousURL + "&InvalidPax=");
            return;
        }

        boolean registered = TourModel.getPaxForTour(userID, tourDateID).query(conn).length > 0;
        conn.close();

        if (registered) {
            previousURL += "&alreadyRegistered=";
            response.sendRedirect(previousURL);
            return;
        }

        boolean success = TourModel.registerUserForTour(userID, tourDateID, pax).update(conn) == 1;
        
        if (!success) {
            originalURL += "&error=";
            response.sendRedirect(originalURL);
            return;
        }
        originalURL += "&success=";
        response.sendRedirect(originalURL);
    }

}
