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

import models.UserModel;
import utils.DatabaseConnection;
import utils.Util;

/**
 * Servlet implementation class DeleteUser
 */
@WebServlet("/delete_user")
public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUser() {
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
		DatabaseConnection connection = new DatabaseConnection();
    	
    	HttpSession session = request.getSession(false);
    	
    	// Force admin
    	Util.forceAdmin(session, response);
		
		String user_id = request.getParameter("user_id");
        Integer intUserId = 0;
        
        try {
        	intUserId = Integer.parseInt(user_id);
        }catch(NumberFormatException nfe) {
        	nfe.printStackTrace();
        }
        
        // Delete the user
        int affectedRows = UserModel.deleteUserByUserId(intUserId).update(connection);
        
        connection.close();
        
     // Check if user was updated
        if (affectedRows > 0) {
            //Redirect to profile page again
            response.sendRedirect("/CA1-Preparation/views/admin/all_users.jsp");
            return;
        } else if (affectedRows == -1) {
            response.sendRedirect("/CA1-Preparation/views/admin/all_users.jsp?error=There was an error deleting the user");
            return;
        }
	}

}
