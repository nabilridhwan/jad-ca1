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
@WebServlet("/editTour")
public class EditTour extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditTour() {
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
        String tourIdStr = request.getParameter("id");
        String tourName = request.getParameter("name");
        String description = request.getParameter("desc");
        String briefDesc = request.getParameter("bDesc");
        String location = request.getParameter("location");

        int tourID = Integer.parseInt(tourIdStr);
        if (tourID == 0) {
            int affectedRows = TourModel.insertNewTour(tourName, briefDesc, description, location).update(connection);

            connection.close();
            if (affectedRows > 0) {
//			TODO: Change page redirection
                response.sendRedirect(request.getContextPath() + "/views/admin/all_tours.jsp");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/views/admin/edit_tour.jsp?message=Tour with that name already exists!");


            return;
        }

        int affectedRows = TourModel.updateTour(tourID, tourName, briefDesc, description, location).update(connection);
        if (affectedRows > 0) {
//			TODO: Change page redirection
            response.sendRedirect(request.getContextPath() + "/views/admin/all_tours.jsp");
            return;
        }
        response.sendRedirect(request.getContextPath() + "/views/admin/edit_tour.jsp?message=Tour with that name already exists!");
    }

}
