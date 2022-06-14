package servlets;

import dataStructures.User;
import models.UserModel;
import utils.DatabaseConnection;

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

//		Get the full name, email and password

        String full_name = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession(false);

        // Check if userID is null
        if (session.getAttribute("userID") == null) {
            // Send a redirect to login page
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
            return;
        }

        int userID = (int) session.getAttribute("userID");


        //populate user object
        User user = new User(userID);
        user.setEmail(email);
        user.setFullName(full_name);
        if (!password.isEmpty()) {
            user.setPassword(password);
            session.removeAttribute("userID");
        }

        //update
        DatabaseConnection connection = new DatabaseConnection();
        int affectedRows = UserModel.updateUser(user).update(connection);
        connection.close();

        // Check if user was updated
        if (affectedRows > 0) {
            //Redirect to profile page again
            response.sendRedirect("/CA1-Preparation/views/user/profile.jsp");
        } else if (affectedRows == -1) {
            response.sendRedirect("/CA1-Preparation/views/user/login.jsp?error=sql_error");
        }

    }

}
