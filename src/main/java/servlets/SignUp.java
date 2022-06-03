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
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/views/user/signup.jsp");
		
		// TODO Auto-generated method stub
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				String confirmPassword = request.getParameter("confirm_password");
				
				System.out.println(password);
				System.out.println(confirmPassword);
				
				if(!password.equals(confirmPassword)) {
					// Set the attribute of error to invalid_credentials
					request.setAttribute("error", "password_match");
					
//					Dispatch
					dispatcher.forward(request, response);
					return;
				}
				
				Connection conn = DatabaseConnection.getConnection();
				
				try {
					PreparedStatement pstmt = conn.prepareStatement("INSERT INTO user(full_name, email, password, profile_pic_url) VALUES(?, ?, ?, ?)");
					
//					Set the variables
					pstmt.setString(1, name);
					pstmt.setString(2, email);
					pstmt.setString(3, password);
					
//					Default profile picture image
					pstmt.setString(4, "https://via.placeholder.com/400");
					
					int rowsAffected = pstmt.executeUpdate();
					
//					Check if the user is inserted
					if(rowsAffected > 0) {
						// Redirect to login page
						response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
					}

				} catch (SQLException e) {
					System.out.println("SQL Error has occured");
					// e.printStackTrace();
					
//					Set the attribute of error to invalid_credentials
					request.setAttribute("error", "user_exists");
					
//					Dispatch
					dispatcher.forward(request, response);
				}
	}

}
