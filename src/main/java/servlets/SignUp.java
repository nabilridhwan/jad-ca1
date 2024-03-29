/*
 * 	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */

package servlets;

import models.UserModel;
import org.mindrot.jbcrypt.BCrypt;
import utils.DatabaseConnection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/signup")
public class SignUp extends HttpServlet {
    private static final long serialVersionUID = 1L;


    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/user/signup.jsp");

        // TODO Auto-generated method stub
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        
        String phone = request.getParameter("phone") == null ? "" : request.getParameter("phone");
        
        String address_1 = request.getParameter("address_1") == null ? "" : request.getParameter("address_1");
    	String address_2 = request.getParameter("address_2") == null ? "" : request.getParameter("address_2");
    	String apt_suite = request.getParameter("apt_suite") == null ? "" : request.getParameter("apt_suite");
    	String postal_code = request.getParameter("postal_code") == null ? "" : request.getParameter("postal_code");
        

        System.out.println(password);
        System.out.println(confirmPassword);

        if (!password.equals(confirmPassword)) {
            // Set the attribute of error to invalid_credentials
            request.setAttribute("error", "password_match");

            // Dispatch
            dispatcher.forward(request, response);
            return;
        }

        DatabaseConnection connection = new DatabaseConnection();
        
        // Hash the password using BCrypt
        password = BCrypt.hashpw(password, BCrypt.gensalt());

        int rowsAffected = UserModel.insertNewUser(name, email, password, address_1, address_2, apt_suite, postal_code, phone).update(connection);

        connection.close();

        // Check if the user is inserted
        if (rowsAffected > 0) {
            // Redirect to login page
            if (request.getParameter("redirect") != null || request.getParameter("redirect").equals(""))
                response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
            else
                response.sendRedirect("/CA1-Preparation/views/user/login.jsp?redirect=" + request.getParameter("redirect"));

        } else if (rowsAffected == -1) {
            System.out.println("SQL Error has occured");
            // e.printStackTrace();

            // Set the attribute of error to invalid_credentials
            request.setAttribute("error", "user_exists");

            // Dispatch
            dispatcher.forward(request, response);
        }
    }

}
