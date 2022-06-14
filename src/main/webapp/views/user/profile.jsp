<%@page import="models.UserModel" %>
<%@ page import="utils.DatabaseConnection" %>
<%@ page import="dataStructures.User" %>
<%@ page contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
    <link href="${pageContext.request.contextPath}/views/output.css" rel="stylesheet"/>
</head>
<body>

<%
    String fullName = "";
    String profilePicUrl = "";
    String email = "";

    // Check if userID is null
    if (session.getAttribute("userID") == null) {
        // Send a redirect to login page
        response.sendRedirect("${pageContext.request.contextPath}/views/user/login.jsp");
        return;
    }
    int userID = (int) session.getAttribute("userID");

    DatabaseConnection connection = new DatabaseConnection();
    User[] users = UserModel.getUserByUserID(userID).query(connection);
    connection.close();

    if (users == null) {
        response.sendRedirect("${pageContext.request.contextPath}/views/user/login.jsp?error=sql_error");
        return;
    }

    if (users.length == 1) {
        User user = users[0];
        //			Get the user ID
        fullName = user.getFullName();
        profilePicUrl = user.getPfpUrl();
        email = user.getEmail();

    } else {
        //			If there is no user, dispatch the page back to the login page

        //			Set the attribute of error to invalid_credentials
        request.setAttribute("error", "invalid_credentials");

        //			Dispatch
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/user/login.jsp?error=invalid_credentials");
        dispatcher.forward(request, response);

    }
%>

<div class="text-center">
    <img class="w-48 rounded-full" src="<%=profilePicUrl %>" alt=""/>

    <h1 class="text-4xl font-extrabold">
        <%=fullName %>
    </h1>

    <form method="POST" action="${pageContext.request.contextPath}/modifyUser">
        <label>Full Name</label>
        <label>
            <input type="text" value="<%=fullName%>" name="full_name"/>
        </label>

        <label>Email</label>
        <label>
            <input type="text" value="<%=email%>" name="email"/>
        </label>

        <label>Password</label>
        <label>
            <input type="password" value="" name="password"/>
        </label>

        <button>Submit</button>
    </form>
</div>

</body>
</html>