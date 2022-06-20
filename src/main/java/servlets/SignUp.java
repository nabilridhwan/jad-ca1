package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.UserModel;
import utils.DatabaseConnection;
import utils.Password;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/signup")
public class SignUp extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUp() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

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
        
        // Hash the password
        password = Password.encryptThisString(password);

        int rowsAffected = UserModel.insertNewUser(name, email, password).update(connection);

        connection.close();

        // Check if the user is inserted
        if (rowsAffected > 0) {
            // Redirect to login page
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
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
