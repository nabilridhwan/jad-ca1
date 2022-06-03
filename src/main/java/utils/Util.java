package utils;

import javax.servlet.http.HttpSession;

public class Util {
	
	public static boolean isUserLoggedIn(HttpSession session) {
		Integer user = (Integer) session.getAttribute("userID");
		
		return user != null;
	}

}
