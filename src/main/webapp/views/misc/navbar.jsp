<%@page import="models.UserModel"%>
<%@page import="utils.Util"%>
<%@page import="java.sql.*"%>
<nav class="flex items-center">
	<ul class="flex text-center space-x-5">
		<li>
			<a href="/CA1-Preparation/views/index.jsp">
				Home
			</a>
		</li>
		
		<%
			boolean userLoggedIn = Util.isUserLoggedIn(session);
		
			// User is signed in
			if(userLoggedIn){
				int userID = (int) session.getAttribute("userID");
				ResultSet rs = UserModel.getUserByUserID(userID);
				
				String name = "";
				
				if(rs.next()){
					name = rs.getString("full_name");
				}
				
			%>
				<li>
					<a href="/CA1-Preparation/views/user/profile.jsp">
						Profile <%=name %>
					</a>
				</li>
			<%}else{%>
				<li>
					<a href="/CA1-Preparation/views/user/login.jsp">
						Log In
					</a>
				</li>
				
				<li>
					<a href="/CA1-Preparation/views/user/signup.jsp">
						Sign Up
					</a>
				</li>
			<%}%>
	</ul>
</nav>