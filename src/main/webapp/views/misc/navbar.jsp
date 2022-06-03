<nav class="flex items-center">
	<ul class="flex text-center space-x-5">
		<li>
			<a href="/CA1-Preparation/views/index.jsp">
				Home
			</a>
		</li>
		
		<%
			Integer user = (Integer) session.getAttribute("userID");
		
			// User is signed in
			if(user != null){%>
				<li>
					<a href="/CA1-Preparation/views/user/profile.jsp">
						Profile
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