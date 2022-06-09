<%@page import="models.UserModel"%>
<%@page import="utils.Util"%>
<%@page import="java.sql.*"%>


<nav
            class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
            id="ftco-navbar"
        >
            <div class="container">
                <a class="navbar-brand" href="index.html">Tours R' Us.</a>
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
                        <li class="nav-item active">
                            <a href="index.html" class="nav-link">Home</a>
                        </li>

                        <li class="nav-item cta">
                            <a href="/CA1-Preparation/views/user/login.jsp" class="nav-link"
                                ><span>Login</span></a
                            >
                        </li>
                        
                        <li class="nav-item cta">
                            <a href="/CA1-Preparation/views/user/signup.jsp" class="nav-link"
                                ><span>Sign up</span></a
                            >
                        </li>
                    </ul>
                </div>
            </div>
        </nav>