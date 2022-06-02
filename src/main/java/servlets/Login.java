package servlets;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		
		Connection conn = DatabaseConnection.getConnection();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");
			
//			Set the variables
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			
			ResultSet rs = pstmt.executeQuery();
			
//			Check if the user exist
			if(rs.next()) {
//				Get the user ID
				int userID = rs.getInt("user_id");
				
//				Set in the session
				HttpSession session = request.getSession(true);
				session.setAttribute("userID", userID);
				
//				Redirect
				response.sendRedirect("/CA1-Preparation/views/index.jsp");
			}else {
//				TODO: If there is no user, dispatch the page back to the login page
				response.sendRedirect("/CA1-Preparation/views/user/login.jsp?error=invalid_credentials");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("/CA1-Preparation/views/user/login.jsp?error=sql_error");
		}
		
		
		
		doGet(request, response);
	}

}
