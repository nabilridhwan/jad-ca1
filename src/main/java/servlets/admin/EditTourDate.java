package servlets.admin;

import models.TourModel;
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
 * Servlet implementation class AddNewCategory
 */
@WebServlet("/editTourDate")
public class EditTourDate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditTourDate() {
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

        DatabaseConnection connection = new DatabaseConnection();
        // Get the current session
        HttpSession session = request.getSession(false);

        Util.forceAdmin(session, response);

        try {
            String tourIdStr = request.getParameter("id");
            String tourDateIdStr = request.getParameter("dateId");
            String start = request.getParameter("start");
            String end = request.getParameter("end");
            double price = Double.parseDouble(request.getParameter("price"));
            int slots = Integer.parseInt(request.getParameter("slots"));
            int emptySlots = Integer.parseInt(request.getParameter("emptySlots"));
            boolean show = request.getParameter("shown") != null;

            System.out.println("tourIdStr: " + tourIdStr);
            System.out.println("tourDateIdStr: " + tourDateIdStr);
            System.out.println("start: " + start);
            System.out.println("end: " + end);
            System.out.println("price: " + price);
            System.out.println("slots: " + emptySlots + "/" + slots);
            System.out.println("show: " + show);
            System.out.println("show: " + request.getParameter("shown"));

            int tourDateID = Integer.parseInt(tourDateIdStr);
            int tourID = Integer.parseInt(tourIdStr);
            if (tourDateID == 0) {
                int affectedRows = TourModel.insertNewTourDate(tourID, start, end, price, emptySlots, slots, show).update(connection);

                connection.close();
                if (affectedRows > 0) {
//			TODO: Change page redirection
                    response.sendRedirect(request.getContextPath() + "/views/admin/edit_tourDates.jsp?tourId=" + tourID);
                    return;
                }
                response.sendRedirect(request.getContextPath() + "/views/admin/edit_tour.jsp?message=Error adding new tour date&tourId=" + tourID);


                return;
            }

            int affectedRows = TourModel.updateTourDate(tourDateID, start, end, price, emptySlots, slots, show).update(connection);
            if (affectedRows > 0) {
//			TODO: Change page redirection
                response.sendRedirect(request.getContextPath() + "/views/admin/edit_tourDates.jsp?tourId=" + tourID);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/views/admin/edit_tour.jsp?message=Tour with that name already exists!&tourId=" + tourID);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/admin/all_tours.jsp?message=Error");
        } finally {
            connection.close();
        }
    }

}
