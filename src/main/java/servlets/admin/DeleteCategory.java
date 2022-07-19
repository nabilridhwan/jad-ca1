/*
 * 	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */

package servlets.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.CategoryModel;
import utils.DatabaseConnection;
import utils.Util;

/**
 * Servlet implementation class AddCategory
 */
@WebServlet("/deleteCategory")
public class DeleteCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCategory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		DatabaseConnection connection = new DatabaseConnection();
		// Get the current session
		HttpSession session = request.getSession(false);
		
		if(!Util.isUserLoggedIn(session)) {
//			TODO: Send error back
			response.sendRedirect("/CA1-Preparation/views/index.jsp");
			return;
		}
		
		Integer userID = (Integer) session.getAttribute("userID");
		
		if(!Util.isUserAdmin(userID)) {
//			Redirect to the home page
			response.sendRedirect("/CA1-Preparation/views/index.jsp");
			return;
		}
		
		String category_id = request.getParameter("id");
		
		int affectedRows = CategoryModel.deleteCategory(category_id).update(connection);
		connection.close();
		
		System.out.println(affectedRows);
		
		if(affectedRows > 0) {
//			page redirection
			response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
			return;
		}else if(affectedRows == -1) {
			response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
