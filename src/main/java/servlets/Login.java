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
import utils.Password;

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

        // Hash the password
        password = Password.encryptThisString(password);

        DatabaseConnection connection = new DatabaseConnection();
        User[] users = UserModel.getUserByEmailAndPassword(email, password).query(connection);
        connection.close();

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
//				Get the user ID
            int userID = user.getUserID();

//				Set in the session
            HttpSession session = request.getSession(true);
            session.setAttribute("userID", userID);
            
//				Redirect

            System.out.println(redirect);
            if (redirect == null) {
                redirect = "/views/index.jsp";
            }
            System.out.println(redirect);

            if (redirect == null || redirect.equals("null")) redirect = "/CA1-Preparation/views/index.jsp";
            response.sendRedirect(redirect);
            return;
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
