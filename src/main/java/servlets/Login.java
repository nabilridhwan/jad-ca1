/*
 * 	Name: Nabil Ridhwanshah Bin Rosli , Xavier Tay Cher Yew
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */

package servlets;

import dataStructures.Cart;
import dataStructures.User;
import models.UserModel;
import org.mindrot.jbcrypt.BCrypt;
import utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        DatabaseConnection connection = new DatabaseConnection();
        User[] users = UserModel.getUserByEmail(email).query(connection);

//				Redirect
        String redirect = request.getParameter("redirect");
//			Check if the user exist

        System.out.println("================================");
        System.out.println(users.length);
        System.out.println(email);
        System.out.println(password);
        System.out.println("================================");
        
        if (users.length == 1) {
            User user = users[0];
            
            // Check if the password matches
            if(BCrypt.checkpw(password, user.getPassword())) {

                // Successful in login
//  				Get the user ID
                int userID = user.getUserID();

//  				Set in the session
                HttpSession session = request.getSession(true);
                session.setAttribute("userID", userID);

//  				Redirect

                System.out.println(redirect);
                if (redirect == null) {
                    redirect = "/views/index.jsp";
                }
                System.out.println(redirect);

                if (redirect.equals("null")) redirect = "/CA1-Preparation/views/index.jsp";
                Cart cart = Cart.GetExisting(session);
                if (cart != null) cart.linkToUser(userID, connection);

                response.sendRedirect(redirect);

                connection.close();
                return;
            }else {
                request.setAttribute("error", "invalid_credentials");
//				Dispatch
                String url = "/views/user/login.jsp?error=invalid_credentials";
                if (redirect != null) url += "&redirect=" + redirect;
                request.getRequestDispatcher(url).forward(request, response);

                connection.close();
            }
            

        } else {
//				If there is no user, dispatch the page back to the login page

//				Set the attribute of error to invalid_credentials
            request.setAttribute("error", "invalid_credentials");

//				Dispatch
            String url = "/views/user/login.jsp?error=invalid_credentials";
            if (redirect != null) url += "&redirect=" + redirect;
            request.getRequestDispatcher(url).forward(request, response);
        }
        doGet(request, response);
    }

}
