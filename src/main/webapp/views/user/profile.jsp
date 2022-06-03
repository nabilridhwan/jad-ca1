<%@page import="models.UserModel"%>
<%@page import="org.bouncycastle.crypto.generators.BCrypt"%>
<%@page import="servlets.DatabaseConnection, java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="/CA1-Preparation/views/output.css" rel="stylesheet" />
</head>
<body>

	<%
		Connection conn = DatabaseConnection.getConnection();
		int userID = -1;
		
		String fullName = "";
		String profilePicUrl = "";
		String email = "";
		
		// Check if userID is null
		if(session.getAttribute("userID") != null){
			userID = (int) session.getAttribute("userID");
		}else{
			// Send a redirect to login page
			response.sendRedirect("/CA1-Preparation/views/user/login.jsp");
			return;
		}
		
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE user_id = ?;");
			
	//		Set the variables
			pstmt.setInt(1, userID);
			
			ResultSet rs = UserModel.getUserByUserID(userID);
			
	//		Check if the user exist
			if(rs.next()) {
	//			Get the user ID
				fullName = rs.getString("full_name");
				profilePicUrl = rs.getString("profile_pic_url");
				email = rs.getString("email");
				
			}else {
	//			If there is no user, dispatch the page back to the login page
				
	//			Set the attribute of error to invalid_credentials
				request.setAttribute("error", "invalid_credentials");
				
	//			Dispatch
				RequestDispatcher dispatcher = request.getRequestDispatcher("/views/user/login.jsp?error=invalid_credentials");
				dispatcher.forward(request, response);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			response.sendRedirect("/CA1-Preparation/views/user/login.jsp?error=sql_error");
			
		}
	%>
	
	<div class="text-center">
		<img class="w-48 rounded-full" src="<%=profilePicUrl %>" />
	
		<h1 class="text-4xl font-extrabold">
			<%=fullName %>
		</h1>
		
		<form method="POST" action="/CA1-Preparation/modifyUser">
			<label>Full Name</label>
			<input type="text" value="<%=fullName%>" name="full_name"/>
			
			<label>Email</label>
			<input type="text" value="<%=email%>" name="email" />
			
			<label>Password</label>
			<input type="password" value="" name="password"/>
			
			<button>Submit</button>
		</form>
	</div>

</body>
</html>