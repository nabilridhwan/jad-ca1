package utils;

import javax.servlet.http.HttpSession;

import dataStructures.User;
import models.UserModel;

public class Util {
	
	public static boolean isUserLoggedIn(HttpSession session) {
		Integer user = (Integer) session.getAttribute("userID");
		
		System.out.println(user);
		
		if(user == null) {
			return false;
		}
		
		return true;
	}
	
	public static int getUserIDFromSession(HttpSession session) {
		Integer userID = -1;
		
		if(isUserLoggedIn(session)) {
			userID = (Integer) session.getAttribute("userID");
		};
		
		return userID;
	}
	
	public static boolean isUserAdmin(int userID) {
		DatabaseConnection connection = new DatabaseConnection();
		
		User[] results = UserModel.getUserByUserID(userID).query(connection);
		connection.close();
		
		if(results == null) {
			return false;
		}
		
		if(results.length == 0) {
			return false;
		}
		
		// Get first user
		
		User user = results[0];
		
		System.out.println(user.getRole());
		
		
		return user.getRole().equals("admin");
		
		
	}

}
