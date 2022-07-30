package servlets.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import dataStructures.User;
import models.UserModel;
import utils.DatabaseConnection;
import utils.IDatabaseUpdate;

/**
 * Servlet implementation class ModifyUser
 */
@WebServlet(name = "AdminModifyUser", urlPatterns = { "/admin_modify_user" })
public class ModifyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ModifyUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DatabaseConnection connection = new DatabaseConnection();
    	
    	HttpSession session = request.getSession(false);
		
		String user_id = request.getParameter("user_id");
		String full_name = request.getParameter("name");
        String email = request.getParameter("email");
        String profile_pic_url = request.getParameter("image");
        
        
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");
        
        String phone = request.getParameter("phone") == null ? "" : request.getParameter("phone");
        
        String address_1 = request.getParameter("address_1") == null ? "" : request.getParameter("address_1");
        String address_2 = request.getParameter("address_2") == null ? "" : request.getParameter("address_2");
        String apt_suite = request.getParameter("apt_suite") == null ? "" : request.getParameter("apt_suite");
        String postal_code = request.getParameter("postal_code") == null ? "" : request.getParameter("postal_code");
        
        String role = request.getParameter("role");
        
        System.out.println(password);
        System.out.println(confirm_password);
        
        
        Integer intUserId = 0;
        
        try {
        	intUserId = Integer.parseInt(user_id);
        }catch(NumberFormatException nfe) {
        	nfe.printStackTrace();
        }
        
        String finalPassword = null;
        // Get the user
        User[] results = UserModel.getUserByUserID(intUserId).query(connection);
        
        if(results.length == 0 || results == null) {
        	return;
        }
        
        User user = results[0];
        
        
        // Set the finalPassword initially
        finalPassword = user.getPassword();
        System.out.print("Getting default password");
        
        // Check if old_passowrd, password or confirm_password is empty
        if(!password.isEmpty() && !confirm_password.isEmpty()) {
        	System.out.print("Updating password");
        	
        	// Check if password and confirm_password is empty
        	if(!password.equals(confirm_password)) {
        		System.out.print("Passwords does not match");
        		response.sendRedirect("/CA1-Preparation/views/admin/edit_user.jsp?user_id=" + user_id + "&message=Passwords does not match!");
        		return;
        	}
        	
        	// Set final password to be password
        	finalPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        	
        	
        }
        
        IDatabaseUpdate databaseUpdate = UserModel.updateUser(intUserId, profile_pic_url, full_name, email, finalPassword, address_1, address_2, apt_suite, postal_code, phone, role);
                

        int affectedRows = databaseUpdate.update(connection);
        connection.close();
        
        System.out.println(affectedRows);

        // Check if user was updated
        if (affectedRows > 0) {
            //Redirect to profile page again
            response.sendRedirect("/CA1-Preparation/views/admin/all_users.jsp");
        } else if (affectedRows == -1) {
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp?error=sql_error");
        }
	}

}
