package servlets;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		
		int userID = -1;
		
		
		HttpSession session = request.getSession(false);
		Connection conn = DatabaseConnection.getConnection();
		
		// Check if userID is null
		if(session.getAttribute("userID") != null){
			userID = (int) session.getAttribute("userID");
		}else{
			// Send a redirect to login page
			response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
			return;
		}
		
		try {
			PreparedStatement pstmt = null;
			
			if(password.isEmpty()) {
				pstmt = conn.prepareStatement("UPDATE user SET full_name = ?, email = ? WHERE user_id = ?");
				pstmt.setString(1, full_name);
				pstmt.setString(2, email);
				pstmt.setInt(3, userID);
			}else {
				pstmt = conn.prepareStatement("UPDATE user SET full_name = ?, email = ?, password = ? WHERE user_id = ?");
				pstmt.setString(1, full_name);
				pstmt.setString(2, email);
				pstmt.setString(3, password);
				pstmt.setInt(4, userID);
				
//				Because password changed, so remove session
				session.removeAttribute("userID");
			}
			
			int affectedRows = pstmt.executeUpdate();
			
	//		Check if the user exist
			if(affectedRows > 0) {
	//			Redirect to profile page again
				response.sendRedirect("/CA1-Preparation/views/user/profile.jsp");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			response.sendRedirect("/CA1-Preparation/views/user/login.jsp?error=sql_error");
		}
		
	}

}
