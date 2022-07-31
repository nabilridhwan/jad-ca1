<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Confirm to pay</h1>


	<ul>
		<li>Item 1 ($35)</li>

		<li>Item 2 ($40)</li>
	</ul>



	<form action="<%=request.getContextPath() %>/create_payment_intent">
		<button>Pay</button>
	</form>
</body>
</html>