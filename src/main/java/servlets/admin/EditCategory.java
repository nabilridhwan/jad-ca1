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
 * Servlet implementation class AddNewCategory
 */
@WebServlet("/editCategory")
public class EditCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCategory() {
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
		
		String category_id = request.getParameter("category_id");
		String category_img = request.getParameter("category_img");
		String category_name = request.getParameter("category_name");
		String category_desc = request.getParameter("category_desc");
		
		int affectedRows = CategoryModel.updateCategory(category_id, category_img, category_name, category_desc).update(connection);
		connection.close();
		
		System.out.println(affectedRows);
		
		if(affectedRows > 0) {
//			page redirection
			response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
			return;
		}else if(affectedRows == -1) {
			response.sendRedirect("/CA1-Preparation/views/admin/edit_category.jsp?message=Category with that name already exists!");
			return;
		}
		
		// doGet(request, response);
	}

}
