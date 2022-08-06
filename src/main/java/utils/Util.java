/*
 * 	Name: Nabil Ridhwanshah Bin Rosli , Xavier Tay Cher Yew
	Admin No: P2007421, P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */

package utils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataStructures.User;
import models.UserModel;

import java.io.IOException;

public class Util {

    public static boolean isUserLoggedIn(HttpSession session) {
        return getUserID(session) != -1;
    }

    public static int getUserID(HttpSession session) {
        Integer userID = (Integer) session.getAttribute("userID");
        if (userID == null) userID = -1;
        return userID;
    }

    public static boolean isUserAdmin(int userID) {
        DatabaseConnection connection = new DatabaseConnection();
        User[] results = UserModel.getUserByUserID(userID).query(connection);
        connection.close();

        if (results == null || results.length != 1) return false;

        // Get first user
        User user = results[0];
        String role = user.getRole();

        System.out.println(role);
        return role.equals("admin");
    }

    public static int forceLogin(HttpSession session, HttpServletResponse response, String redirectUrl) throws IOException {
        int userid = getUserID(session);
        if (userid > 0) return userid;
        if (response != null) response.sendRedirect("/CA1-Preparation/views/user/login.jsp?redirect=" + redirectUrl);
        return -1;
    }

    public static int forceLogin(HttpSession session, HttpServletResponse response) throws IOException {
        return forceLogin(session, response, "/CA1-Preparation/views/user/login.jsp");
    }

    public static int forceAdmin(HttpSession session, HttpServletResponse response, String redirectUrl) throws IOException {
        int userid = getUserID(session);
        if (userid > 0 && isUserAdmin(userid)) return userid;
        if (response != null)    response.sendRedirect("/CA1-Preparation/views/user/login.jsp?redirect=" + redirectUrl);
        return -1;
    }

    public static int forceAdmin(HttpSession session, HttpServletResponse response) throws IOException {
        return forceAdmin(session, response, "/CA1-Preparation/views/user/login.jsp");
    }
}
