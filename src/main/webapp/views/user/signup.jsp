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
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String error = "";
		
		if(email == null){
			email = "";
		}
		
		if(password == null){
			password = "";
		}
		
		if(name == null){
			name = "";
		}
		
		if(request.getAttribute("error") != null){
			error = (String) request.getAttribute("error");
		}
	%>
	
	
	
	<div class="grid grid-cols-2 login-card">
	
		<div class="flex items-center justify-center">
		
			<div>
			
				<h1 class="text-3xl font-extrabold">
					Already have an account?
				</h1>
				
				<button class="inversed">Login</button>
			</div>
		
		</div>
		
		
		
		<div class="flex items-center justify-center">
		
			<div>
			
				<h1 class="text-3xl font-extrabold">
					Sign up
				</h1>
				
				<%if(!error.isEmpty()){%>
				
					<div class="inline-error">
				
					<%if(error.equals("password_match")){ %>
						<p>Your password doesn't match</p>
					<%}else if(error.equals("user_exists")){%>
						<p>User already exists!</p>
					<%}%>
					
						
					</div>	
				<%}%>
			
				<form action="/CA1-Preparation/signup" method="POST">	
				
					<label>Full Name</label>
					<input placeholder="Full Name" type="text" required name="name" value="<%=name %>"/>
				
					<label>Email</label>
					<input placeholder="Email" type="email" required name="email" value="<%=email %>"/>
					
					
					<label>Password</label>
					<input placeholder="Password" type="password" required name="password"/>
					<input placeholder="Confirm Password" type="password" required name="confirm_password"/>
					
					<button class="inversed">Sign Up</button>
				</form>
			</div>
		
		</div>
	
	</div>
	
	

</body>
</html>