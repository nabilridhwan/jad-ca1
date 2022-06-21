<%@page import="utils.DatabaseConnection" %>
<%@page import="dataStructures.User" %>
<%@page import="models.UserModel" %>
<%@page import="utils.Util" %>

<%
    {
        int navbarUserID = Util.getUserID(session);
        boolean darkTheme = request.getParameter("darkTheme") != null && !request.getParameter("darkTheme").equals("false");
        boolean sticky = !(request.getParameter("dontStick") != null && !request.getParameter("dontStick").equals("false"));
        boolean transparentHeader = request.getParameter("transparentHeader") != null && !request.getParameter("transparentHeader").equals("false");
%>
<nav
        class="
        <%
        //todo wip
            {
                String classes = "navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark";
                classes += darkTheme?" ftco-navbar-dark":" ftco-navbar-light";
        %>
        <%=classes %>
        <%
            }
        %>
        "
        id="ftco-navbar"
>
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/views/index.jsp">Tours R' Us.</a>
        <button
                class="navbar-toggler"
                type="button"
                data-toggle="collapse"
                data-target="#ftco-nav"
                aria-controls="ftco-nav"
                aria-expanded="false"
                aria-label="Toggle navigation"
        >
            <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/views/index.jsp" class="nav-link">Home</a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/views/tour/view_all.jsp" class="nav-link">Tours</a>
                </li>

                <%

                    if (navbarUserID == -1) {%>
                <li class="nav-item cta">
                    <a href="${pageContext.request.contextPath}/views/user/login.jsp" class="nav-link"
                    ><span>Login</span></a
                    >
                </li>

                <li class="nav-item cta">
                    <a href="${pageContext.request.contextPath}/views/user/signup.jsp" class="nav-link"
                    ><span>Sign up</span></a
                    >
                </li>
                <%
                } else {
                    // Get role
                    DatabaseConnection navbarConnection = new DatabaseConnection();
                    User[] navbarUsers = UserModel.getUserByUserID(navbarUserID).query(navbarConnection);

                    if (navbarUsers == null || navbarUsers.length == 0) {
                        navbarUserID = -1;
                    } else {
                        User navbarUser = navbarUsers[0];

                        if (navbarUser.getRole().equals("admin")) {
                %>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/views/admin/all_tours.jsp" class="nav-link">Admin</a>
                </li>
                <%}%>


                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/views/user/wishlist.jsp" class="nav-link">Wishlist</a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/views/user/profile.jsp" class="nav-link">Profile</a>
                </li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a>
                </li>
                <%
                        }
                    }
                %>


            </ul>
        </div>
    </div>
</nav>
<%
    }
%>