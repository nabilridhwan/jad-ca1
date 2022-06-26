<!DOCTYPE html>
<%@page import="utils.Util" %>
<%@page import="dataStructures.User" %>
<%@page import="models.UserModel" %>
<%@page import="utils.DatabaseConnection" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="models.TourModel" %>
<html lang="en">
<head>
    <title>DirEngine - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />

    <link
            href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
            rel="stylesheet"
    />
    <link
            href="https://fonts.googleapis.com/css?family=Alex+Brush"
            rel="stylesheet"
    />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/open-iconic-bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.theme.default.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/magnific-popup.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aos.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ionicons.min.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datepicker.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.timepicker.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/flaticon.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icomoon.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>


<%
    // Check if userID is null
    int userID = Util.forceLogin(session, response);

    DatabaseConnection connection = new DatabaseConnection();
    User[] users = UserModel.getUserByUserID(userID).query(connection);

    if (users == null) {
        response.sendRedirect("./login.jsp?error=sql_error");
        return;
    }

    if (users.length != 1) {
        //			If there is no user, dispatch the page back to the login page

        //			Set the attribute of error to invalid_credentials
        request.setAttribute("error", "invalid_credentials");

        //			Dispatch
        RequestDispatcher dispatcher = request.getRequestDispatcher("./login.jsp?error=invalid_credentials");
        dispatcher.forward(request, response);
    }
    User user = users[0];
    //			Get the user ID
    String fullName = user.getFullName();
    String profilePicUrl = user.getPfpUrl();
    String email = user.getEmail();
%>

<%@ include file="../misc/navbar.jsp" %>
<body>
<div class="hero-wrap" style="background-image: url('${pageContext.request.contextPath}/images/bg_2.jpg')">
    <div class="overlay"></div>

    <%--    Tours--%>
    <div class="container" style="padding: 7em 0">
        <div
                class="row no-gutters js-fullheight align-items-center justify-content-center"
                data-scrollax-parent="true"
        >
            <section
                    class="ftco-section contact-section ftco-degree-bg bg-white rounded"
            >
                <div class="container px-5">
                    <div class="row d-flex contact-info">
                        <div class="col-md-12 mb-4 text-center">
                            <h2 class="h3 font-weight-bold">
                                Your Tours
                            </h2>
                            <%
                                Tour[] tours = TourModel.getTourRegistrationsByUser(userID).query(connection);
                                if (tours.length == 0) {
                            %>
                            <h3>You have not registered for any tours</h3>
                            <%
                            } else {
                            %>
                            <h3>Your registered tours</h3>
                            <%
                                for (Tour tour : tours) {
                                    Tour.Registrations[] registrations = TourModel.getTourRegistrations(userID, tour.getTour_id()).query(connection);
                                    if (registrations.length == 0) continue;
                            %>
                            <div class="row">
                                <div class="col-md-12">
                                    <h4>
                                        <%= tour.getTour_name() %>
                                    </h4>
                                    <p>
                                        <%= tour.getTour_brief_desc() %>
                                    </p>
                                </div>
                            </div>

                            <%

                                for (Tour.Registrations registration : registrations) {
                                    int tourDateId = registration.getTour_date_id();
                                    Tour.Date[] tourDates = TourModel.getTourDateById(tourDateId).query(connection);
                                    if (tourDates == null || tourDates.length == 0) {
                            %>
                            There was an error retrieving this entry.
                            <%
                                    continue;
                                }

                                Tour.Date tourDate = tourDates[0];
                                if (!tourDate.isShown()) continue;
                            %>
                            <div>
                                Date: <%= tourDate.getStartString() %> - <%= tourDate.getEndString() %>
                                (<%= tourDate.getDuration() %>)
                                Pax: <%= registration.getPax() %>
                                <br>
                            </div>
                            <%
                                }
                            %>
                            
                            <br>
                            <br>
                            <br>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>

            </section>
        </div>
    </div>

    <%--    Profile--%>
    <div class="container" style="padding: 7em 0">
        <div
                class="row no-gutters js-fullheight align-items-center justify-content-center"
                data-scrollax-parent="true"
        >
            <section
                    class="ftco-section contact-section ftco-degree-bg bg-white rounded"
            >
                <div class="container px-5">
                    <div class="row d-flex contact-info">
                        <div class="col-md-12 mb-4 text-center">
                            <h2 class="h3 font-weight-bold">
                                Edit your profile
                            </h2>

                            <img
                                    src="<%=profilePicUrl %>"
                                    alt="Image"
                                    class="rounded-circle img-fluid"
                                    width="150"
                            />

                            <h2 class="h4">Hi, <%=fullName %>
                            </h2>
                        </div>
                        <div class="w-100"></div>
                        <div class="col-md-12">
                            <p class="text-danger">
                                <%
                                    String message = request.getParameter("message") != null ? request.getParameter("message") : "";
                                %>

                                <%=message %>
                            </p>
                        </div>
                    </div>

                    <div class="row block-9">
                        <div class="col-md-12">

                            <form method="POST" action="${pageContext.request.contextPath}/modifyUser">
                                <h2 class="h5">Details</h2>
                                <div class="form-group">
                                    <label for="name">Full Name</label>
                                    <input
                                            type="text"
                                            class="form-control"
                                            placeholder="Full Name"
                                            name="name"
                                            value="<%=fullName%>" name="full_name"
                                    />
                                </div>

                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input
                                            type="email"
                                            class="form-control"
                                            placeholder="Email"
                                            name="email"
                                            value="<%=email%>" name="email"
                                    />
                                </div>

                                <h2 class="h5">Change your password</h2>

                                <div class="form-group">
                                    <label for="old_password"
                                    >Old Password</label
                                    >
                                    <input
                                            type="password"
                                            class="form-control"
                                            placeholder="Old Password"
                                            name="old_password"
                                    />
                                </div>

                                <div class="form-group">
                                    <label for="password"
                                    >Password</label
                                    >
                                    <input
                                            type="password"
                                            class="form-control"
                                            placeholder="Password"
                                            name="password"
                                    />
                                </div>

                                <div class="form-group">
                                    <label for="confirm_password"
                                    >Confirm Password</label
                                    >
                                    <input
                                            type="password"
                                            class="form-control"
                                            placeholder="Confirm Password"
                                            name="confirm_password"
                                    />
                                </div>

                                <div class="form-group">
                                    <input
                                            type="submit"
                                            value="Save Profile"
                                            class="btn w-100 btn-primary py-3 px-5"
                                    />
                                </div>
                            </form>
                        </div>
                        <!-- <div class="col-md-6" id="map"></div> -->
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>

<footer class="ftco-footer ftco-bg-dark ftco-section">
    <div class="container">
        <div class="row mb-5">
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">dirEngine</h2>
                    <p>
                        Far far away, behind the word mountains, far
                        from the countries Vokalia and Consonantia,
                        there live the blind texts.
                    </p>
                    <ul
                            class="ftco-footer-social list-unstyled float-md-left float-lft mt-5"
                    >
                        <li class="ftco-animate">
                            <a href="#"
                            ><span class="icon-twitter"></span
                            ></a>
                        </li>
                        <li class="ftco-animate">
                            <a href="#"
                            ><span class="icon-facebook"></span
                            ></a>
                        </li>
                        <li class="ftco-animate">
                            <a href="#"
                            ><span class="icon-instagram"></span
                            ></a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4 ml-md-5">
                    <h2 class="ftco-heading-2">Information</h2>
                    <ul class="list-unstyled">
                        <li>
                            <a href="#" class="py-2 d-block">About</a>
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block">Service</a>
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block"
                            >Terms and Conditions</a
                            >
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block"
                            >Become a partner</a
                            >
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block"
                            >Best Price Guarantee</a
                            >
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block"
                            >Privacy and Policy</a
                            >
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">Customer Support</h2>
                    <ul class="list-unstyled">
                        <li>
                            <a href="#" class="py-2 d-block">FAQ</a>
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block"
                            >Payment Option</a
                            >
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block"
                            >Booking Tips</a
                            >
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block"
                            >How it works</a
                            >
                        </li>
                        <li>
                            <a href="#" class="py-2 d-block"
                            >Contact Us</a
                            >
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">Have a Questions?</h2>
                    <div class="block-23 mb-3">
                        <ul>
                            <li>
                                        <span
                                                class="icon icon-map-marker"
                                        ></span
                                        ><span class="text"
                            >203 Fake St. Mountain View, San
                                            Francisco, California, USA</span
                            >
                            </li>
                            <li>
                                <a href="#"
                                ><span
                                        class="icon icon-phone"
                                ></span
                                ><span class="text"
                                >+2 392 3929 210</span
                                ></a
                                >
                            </li>
                            <li>
                                <a href="#"
                                ><span
                                        class="icon icon-envelope"
                                ></span
                                ><span class="text"
                                >info@yourdomain.com</span
                                ></a
                                >
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-md-12 text-center">
                <p>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    Copyright &copy;
                    <script>
                        document.write(new Date().getFullYear());
                    </script>
                    All rights reserved | This template is made with
                    <i class="icon-heart" aria-hidden="true"></i> by
                    <a href="https://colorlib.com" target="_blank"
                    >Colorlib</a
                    >
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                </p>
            </div>
        </div>
    </div>
</footer>

<!-- loader -->
<div id="ftco-loader" class="show fullscreen">
    <svg class="circular" width="48px" height="48px">
        <circle
                class="path-bg"
                cx="24"
                cy="24"
                r="22"
                fill="none"
                stroke-width="4"
                stroke="#eeeeee"></circle>
        <circle
                class="path"
                cx="24"
                cy="24"
                r="22"
                fill="none"
                stroke-width="4"
                stroke-miterlimit="10"
                stroke="#F96D00"></circle>
    </svg>
</div>

<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-migrate-3.0.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.stellar.min.js"></script>
<script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/js/aos.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.animateNumber.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.timepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scrollax.min.js"></script>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
<%
    connection.close();
%>