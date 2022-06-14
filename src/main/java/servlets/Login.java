package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataStructures.User;
import models.UserModel;
import utils.DatabaseConnection;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        DatabaseConnection connection = new DatabaseConnection();
        User[] users = UserModel.getUserByEmailAndPassword(email, password).query(connection);
        connection.close();

//			Check if the user exist
        if (users.length == 1) {
            User user = users[0];
//				Get the user ID
            int userID = user.getUserID();

//				Set in the session
            HttpSession session = request.getSession(true);
            session.setAttribute("userID", userID);

//				Redirect
            response.sendRedirect("/CA1-Preparation/views/index.jsp");
        } else {
//				If there is no user, dispatch the page back to the login page

//				Set the attribute of error to invalid_credentials
            request.setAttribute("error", "invalid_credentials");

//				Dispatch
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/user/login.jsp?error=invalid_credentials");
            dispatcher.forward(request, response);

        }
        doGet(request, response);
    }

}
