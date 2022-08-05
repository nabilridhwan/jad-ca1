<!--
Name: Nabil Ridhwanshah Bin Rosli
Admin No: P2007421
Class: DIT/FT/2A/01
Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
-->


<!--
Name: Xavier Tay Cher Yew
Admin No: P2129512
Class: DIT/FT/2A/01
Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
-->

<%@page import="utils.DatabaseConnection" %>
<%@page import="dataStructures.User" %>
<%@page import="models.UserModel" %>
<%@page import="utils.Util" %>
<%@ page import="dataStructures.CurrencyExchangeRates" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.mysql.cj.Session" %>

<%
    {
        int navbarUserID = Util.getUserID(session);
        boolean darkTheme = request.getParameter("darkTheme") != null && !request.getParameter("darkTheme").equals("false");
        boolean sticky = !(request.getParameter("dontStick") != null && !request.getParameter("dontStick").equals("false"));
        boolean transparentHeader = request.getParameter("transparentHeader") != null
                && !request.getParameter("transparentHeader").equals("false");
%>
<nav
        class="
        <%//todo wip
{
	String classes = "navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark";
	classes += darkTheme ? " ftco-navbar-dark" : " ftco-navbar-light";%>
        <%=classes%>
        <%}%>
        "
        id="ftco-navbar">
    <div class="container">
        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/views/index.jsp">Tours R' Us.</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
                data-target="#ftco-nav" aria-controls="ftco-nav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a
                        href="${pageContext.request.contextPath}/views/index.jsp"
                        class="nav-link">Home</a></li>

                <li class="nav-item"><a
                        href="${pageContext.request.contextPath}/views/tour/view_all.jsp"
                        class="nav-link">Tours</a></li>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/views/tour/categoryListing.jsp" class="nav-link">Categories</a>
                </li>
                <li class="nav-item">
                    <a href=${pageContext.request.contextPath}/views/user/cart.jsp class="nav-link">Cart</a>
                </li>
                <%
                    if (navbarUserID == -1) {
                %>
                <li class="nav-item cta"><a
                        href="${pageContext.request.contextPath}/views/user/login.jsp"
                        class="nav-link"><span>Login</span></a></li>
                <li class="nav-item cta"><a
                        href="${pageContext.request.contextPath}/views/user/signup.jsp"
                        class="nav-link"><span>Sign up</span></a></li>
                <%
                } else {
                    // Get role
                    DatabaseConnection navbarConnection = new DatabaseConnection();
                    User[] navbarUsers = UserModel.getUserByUserID(navbarUserID).query(navbarConnection);

                    if (navbarUsers != null && navbarUsers.length != 0) {
                        User navbarUser = navbarUsers[0];

                        if (navbarUser.getRole().equals("admin")) {
                %>
                <li class="nav-item"><a
                        href="${pageContext.request.contextPath}/views/admin/all_tours.jsp"
                        class="nav-link">Admin</a></li>

                <li class="nav-item"><a
                        href="${pageContext.request.contextPath}/views/admin/analytics.jsp"
                        class="nav-link">Analytics</a></li>

                <li class="nav-item"><a
                        href="${pageContext.request.contextPath}/views/admin/all_users.jsp"
                        class="nav-link">User Management</a></li>
                <%
                    }
                %>

                <li class="nav-item"><a
                        href="${pageContext.request.contextPath}/views/user/wishlist.jsp"
                        class="nav-link">Wishlist</a></li>

                <li class="nav-item"><a
                        href="${pageContext.request.contextPath}/views/user/profile.jsp"
                        class="nav-link">Profile</a></li>

                <li class="nav-item"><a
                        href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a>
                </li>
                <%
                        }
                    }
                    //Start currency drop down menu
                    {
                        CurrencyExchangeRates currencyExchangeRates = CurrencyExchangeRates.GetCurrentRates();
                        assert currencyExchangeRates != null;
                        Set<String> currencies = currencyExchangeRates.getRates().keySet();
                        {
                            String currentCurrency = request.getParameter("currency");
                            if (currentCurrency != null) {
                                //set new session
                                if (currencies.contains(currentCurrency))
                                    session.setAttribute("currency", currentCurrency);
                            }
                        }
                        {
                            String currentCurrency = (String) request.getSession().getAttribute("currency");
                            if (currentCurrency == null)
                                currentCurrency = currencyExchangeRates.getBase();
                        }


                        if (currencyExchangeRates.isSuccess()) {
                            String currentCurrency = (String) request.getSession().getAttribute("currency");
                %>
                <%--                drop down menu--%>
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="false">
                        <%=currentCurrency%>
                    </a>
                    <div class="dropdown-menu">
                        <%
                            //check if url contains any parameter
                            Map<String, String[]> map = request.getParameterMap();
                            StringBuilder redirect = new StringBuilder();
                            for (Map.Entry<String, String[]> entry : map.entrySet()) {
                                String k = entry.getKey();
                                if (k.equals("currency")) continue;
                                String[] v = entry.getValue();
                                if (redirect.length() > 1) redirect.append("&");
                                else redirect.append("?");
                                redirect.append(k).append("=").append(v[0]);
                            }
                            for (String currency : currencies) {
                                if (!currency.equals(currentCurrency)) {
                                    String href = redirect.toString();
                                    href += href.length() > 1 ? "&" : "?";
                                    href += "currency=" + currency;
                        %>
                        <a href="<%=href%>" class="dropdown-item">
                            <%=currency%>
                        </a>
                        <%
                                }
                            }
                        %>
                    </div>
                        <%
                        }else{
                            System.out.println("Currency exchange rates not successfully retrieved");
                        }
                    //End currency drop down menu
                %>
            </ul>
        </div>
    </div>
</nav>
<%
        }
    }
%>
