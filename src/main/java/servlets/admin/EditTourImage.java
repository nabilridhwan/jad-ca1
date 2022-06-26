/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

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
@WebServlet("/editTourImage")
public class EditTourImage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditTourImage() {
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
            String tourImageIdStr = request.getParameter("imageId");
            String url = request.getParameter("url");
            String alt = request.getParameter("alt");

            System.out.println("tourIdStr: " + tourIdStr);
            System.out.println("tourImageIdStr: " + tourImageIdStr);

            int tourImageId = Integer.parseInt(tourImageIdStr);
            int tourID = Integer.parseInt(tourIdStr);
            if (tourImageId == 0) {
                int affectedRows = TourModel.insertNewTourImage(tourID, url, alt).update(connection);

                connection.close();
                if (affectedRows > 0) {
//			TODO: Change page redirection
                    response.sendRedirect(request.getContextPath() + "/views/admin/edit_tourImages.jsp?tourId=" + tourID);
                    return;
                }
                response.sendRedirect(request.getContextPath() + "/views/admin/edit_tour.jsp?message=Error adding new tour date&tourId=" + tourID);


                return;
            }

            int affectedRows = TourModel.updateTourImage(tourImageId, url, alt).update(connection);
            if (affectedRows > 0) {
//			TODO: Change page redirection
                response.sendRedirect(request.getContextPath() + "/views/admin/edit_tourImages.jsp?tourId=" + tourID);
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
