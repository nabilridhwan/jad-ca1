/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

package servlets.admin;

import dataStructures.Category;
import models.CategoryModel;
import models.TourModel;
import utils.DatabaseConnection;
import utils.IDatabaseUpdate;
import utils.Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class AddNewCategory
 */
@WebServlet("/editTourCategory")
public class EditTourCategory extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditTourCategory() {
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

            System.out.println("tourIdStr: " + tourIdStr);

            DatabaseConnection conn = new DatabaseConnection();
            Category[] categories = CategoryModel.getAllCategories().query(conn);

            ArrayList<Integer> CategoryIds = new ArrayList<>();
            for (Category category : categories) {
                boolean hasCategory = request.getParameter("category" + category.getCategory_id()) != null;
                if (hasCategory) CategoryIds.add(category.getCategory_id());
                System.out.println("category" + category.getCategory_id() + ": " + hasCategory);
            }

            int tourID = Integer.parseInt(tourIdStr);
            if (tourID <= 0) {
                response.sendRedirect("/views/admin/edit_tour.jsp");
                return;
            }
            Integer[] categoryIdArray = CategoryIds.toArray(new Integer[0]);
            IDatabaseUpdate sql = CategoryModel.removeAndReAddCategoriesToTour(tourID, categoryIdArray);
            boolean errored = sql.update(connection) == -1;

            conn.close();

            if (errored) {
                response.sendRedirect(request.getContextPath() + "/views/admin/edit_tour.jsp?message=Error adding new tour date&tourId=" + tourID);
//			TODO: Change page redirection
                return;
            }
            response.sendRedirect(request.getContextPath() + "/views/admin/edit_tour.jsp?tourId=" + tourID);


        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/admin/all_tours.jsp?message=Error");
        } finally {
            connection.close();
        }
    }

}
