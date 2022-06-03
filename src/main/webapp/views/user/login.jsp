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
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String error = "";
		
		if(email == null){
			email = "";
		}
		
		if(password == null){
			password = "";
		}
		
		if(request.getAttribute("error") != null){
			error = (String) request.getAttribute("error");
		}
	%>
	
	
	
	<div class="grid grid-cols-2 login-card">
	
		<div class="flex items-center justify-center">
		
			<div>
			
				<h1 class="text-3xl font-extrabold">
					New here?
				</h1>
				
				<button class="inversed">Sign Up</button>
			</div>
		
		</div>
		
		
		
		<div class="flex items-center justify-center">
		
			<div>
			
				<h1 class="text-3xl font-extrabold">
					Log In
				</h1>
				
				<%if(!error.isEmpty()){%>
					
					<div class="inline-error">
						<p>Invalid Credentials!</p>
					</div>	
				<%}%>
			
				<form action="/CA1-Preparation/login" method="POST">	
					<input placeholder="Email" type="email" required name="email" value="<%=email %>"/>
					<input placeholder="Password" type="password" required name="password" value="<%=password %>"/>
					<button class="inversed">Login</button>
				</form>
			</div>
		
		</div>
	
	</div>
	
	

</body>
</html>