/*
 * 	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */

package servlets;

import models.UserModel;
import utils.DatabaseConnection;
import utils.IDatabaseUpdate;
import utils.Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import dataStructures.User;

import java.io.IOException;

/**
 * Servlet implementation class ModifyUser
 */
@WebServlet("/modifyUser")
public class ModifyUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    	
    	DatabaseConnection connection = new DatabaseConnection();
    	
    	HttpSession session = request.getSession(false);
        
        int userID = Util.getUserID(session);
        // Check if userID is null
        if (userID == -1) {
            // Send a redirect to login page
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
            return;
        }

//		Get the full name, email and password

        String full_name = request.getParameter("name");
        String email = request.getParameter("email");
        String profile_pic_url = request.getParameter("image");
        
        
        String password = request.getParameter("password");
        String old_password = request.getParameter("old_password");
        String confirm_password = request.getParameter("confirm_password");
        
        String phone = request.getParameter("phone") == null ? "" : request.getParameter("phone");
        
        String address_1 = request.getParameter("address_1") == null ? "" : request.getParameter("address_1");
        String address_2 = request.getParameter("address_2") == null ? "" : request.getParameter("address_2");
        String apt_suite = request.getParameter("apt_suite") == null ? "" : request.getParameter("apt_suite");
        String postal_code = request.getParameter("postal_code") == null ? "" : request.getParameter("postal_code");
        
        String finalPassword = null;
        
        System.out.println(userID);
        System.out.println(full_name);
        System.out.println(email);
        System.out.println(password);
        System.out.println(old_password);
        System.out.println(confirm_password);
        
        System.out.println(address_1);
        System.out.println(address_2);
        System.out.println(apt_suite);
        System.out.println(postal_code);
        
        
        
        

        
        
        
//        Get the user
        User[] results = UserModel.getUserByUserID(userID).query(connection);
        
        if(results.length == 0 || results == null) {
        	return;
        }
        
        User user = results[0];
        
        
        // Set the finalPassword initially
        finalPassword = user.getPassword();
        
        // Check if old_passowrd, password or confirm_password is empty
        if(!old_password.isEmpty() && !password.isEmpty() && !confirm_password.isEmpty()) {
        	
        	// Check if old_password matches the old user password
        	
        	if(!BCrypt.checkpw(old_password, user.getPassword())) {
        		response.sendRedirect("/CA1-Preparation/views/user/profile.jsp?message=You have entered an incorrect password!");
        		return;
        	}
        	
        	// Check if password and confirm_password is empty
        	if(!password.equals(confirm_password)) {
        		response.sendRedirect("/CA1-Preparation/views/user/profile.jsp?message=You passwords does not match!");
        		return;
        	}
        	
        	// Set final password to be password
        	finalPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        	
        	
        }
        
        // Invalidate session when user change email or password
        if(!user.getEmail().equals(email) || !finalPassword.equals(user.getPassword())) {
        	session.invalidate();
        }


        IDatabaseUpdate databaseUpdate = UserModel.updateUser(userID, profile_pic_url, full_name, email, finalPassword, address_1, address_2, apt_suite, postal_code, phone, user.getRole());
                

        int affectedRows = databaseUpdate.update(connection);
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
