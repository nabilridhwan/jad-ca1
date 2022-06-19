package servlets;

import models.UserModel;
import utils.DatabaseConnection;
import utils.IDatabaseUpdate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet implementation class ModifyUser
 */
@WebServlet("/modifyUser")
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

//		Get the full name, email and password

        String full_name = request.getParameter("full_name");
        String email = request.getParameter("email");
        
        String password = request.getParameter("password");
        String old_password = request.getParameter("old_password");
        String confirm_password = request.getParameter("confirm_password");
        
        

        HttpSession session = request.getSession(false);
        // Check if userID is null
        if (session.getAttribute("userID") == null) {
            // Send a redirect to login page
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
            return;
        }

        int userID = (int) session.getAttribute("userID");
        
//        Get the user
        User[] results = UserModel.getUserByUserID(userID).query(connection);
        
        if(results.length == 0 || results == null) {
        	return;
        }

//		Get the full name, email and password

<<<<<<< HEAD
        //populate user object
        User user = results[0];
        
        User newUpdateUser = new User(userID);
        
        newUpdateUser.setEmail(email);
        newUpdateUser.setFullName(full_name);
        
        
        if (!password.isEmpty() && !old_password.isEmpty() && !password.isEmpty() && !confirm_password.isEmpty()) {
        	
        	System.out.println(user.getEmail());
        	
        	// Check if old_password is equal to user password
        	if(!old_password.equals(user.getPassword())) {
        		response.sendRedirect("/CA1-Preparation/views/user/profile.jsp?error=incorrect_password&message=You entered an incorrect password!");
        		return;
        	}
        	
//        	Check if new password is equal to the confirm_password
        	if(!password.equals(confirm_password)) {
        		response.sendRedirect("/CA1-Preparation/views/user/profile.jsp?error=password_does_not_match&message=The new passwords does not match!");
        		return;
        	}
        	
//        	Set the password
        	newUpdateUser.setPassword(password);
            session.removeAttribute("userID");
        }

        //update
        int affectedRows = UserModel.updateUser(newUpdateUser).update(connection);
=======

        String full_name = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        IDatabaseUpdate databaseUpdate = password.isEmpty() ?
                UserModel.updateUser(userID, full_name, email) :
                UserModel.updateUser(userID, full_name, email, password);

        session.invalidate();

        //update
        DatabaseConnection connection = new DatabaseConnection();
        int affectedRows = databaseUpdate.update(connection);
>>>>>>> 8ecdcd52db6a0de2c3162954bae12d3c49c249ab
        connection.close();
        
        System.out.println(affectedRows);

        // Check if user was updated
        if (affectedRows > 0) {
            //Redirect to profile page again
            response.sendRedirect("/CA1-Preparation/views/user/profile.jsp");
        } else if (affectedRows == -1) {
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp?error=sql_error");
        }

    }

}
