<!--
Name: Nabil Ridhwanshah Bin Rosli
Admin No: P2007421
Class: DIT/FT/2A/01
Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
-->

<!DOCTYPE html>
<%@page import="dataStructures.Tour" %>
<%@page import="utils.DatabaseConnection" %>
<%@page import="utils.Util" %>
<%@ page import="dataStructures.Cart" %>
<%@ page import="java.util.*" %>
<html lang="en">
<head>
    <title>Wishlist</title>
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
<body>

<%
    String currency = "SGD";
    DatabaseConnection connection = new DatabaseConnection();
    Cart cart = Cart.getOrCreateCart(session, connection);
%>

<%@ include file="../misc/navbar_dark.jsp" %>
<%
    if (!Util.isUserLoggedIn(session)) {%>
<div class="alert alert-danger" role="alert">
    <strong>You are not logged in!</strong>
    <br>
    <a href="${pageContext.request.contextPath}/views/user/login.jsp?redirect=${pageContext.request.contextPath}/views/user/cart.jsp">Login</a> or
    <a href="${pageContext.request.contextPath}/views/user/signup.jsp?redirect=${pageContext.request.contextPath}/views/user/cart.jsp">Register</a> to save your cart or checkout.
</div>
<%
    }

    if (request.getParameter("error_cartEmpty") != null) {
%>
<div class="alert alert-danger" role="alert">
    <strong> Your cart is empty ! </strong>
</div>
<%
    }
    if (request.getParameter("success_purchase") != null) {
%>
<div class="alert alert-success" role="alert">
    <strong> Successfully purchased ! </strong>
</div>
<%
    }
    if (request.getParameter("CartRemoveSuccess") != null) {
%>
<div class="alert alert-success" role="alert">
    <strong> Successfully removed from cart ! </strong>
</div>
<%
    }
    if (request.getParameter("success_save") != null) {
%>
<div class="alert alert-success" role="alert">
    <strong> Cart saved successfully </strong>
</div>
<%
    }
    if (request.getParameter("error_save") != null) {
%>
<div class="alert alert-danger" role="alert">
    <strong> Error: You need be signed in to save</strong>
</div>
<%
    }
    if (request.getParameter("error") != null) {
%>
<div class="alert alert-danger" role="alert">
    <strong> Error: <%=request.getParameter("error")%></strong>
</div>
<%
    }
%>
<section class="ftco-section bg-light">
    <div class="container">
        <div class="row justify-content-start mb-5 pb-3">
            <div class="col-md-7 heading-section ftco-animate">
                <span class="subheading">Cart</span>
                <h2 class="mb-4">
                    <strong>Your Cart</strong>
                </h2>
            </div>
        </div>
    </div>
    <div class="container">

        <%

            Cart.Item[] cartItems = cart.getAllItems();

            if (cartItems.length == 0) {
        %>
        <h3>No Tours added to cart :( </h3>
        Click <a href="${pageContext.request.contextPath}/views/tour/view_all.jsp">here</a> to add tours to your cart.
        <%
        } else {
            HashMap<Tour, Tour.Date.Pair[]> hashMap = cart.toHashMap(connection);
            Set<Tour> keySet = hashMap.keySet();
            for (Tour tour : keySet) {
                Tour.Date.Pair[] dates = hashMap.get(tour);
                int tour_id = tour.getTour_id();
                Tour.Image tour_image = tour.getFirstOrDefaultImage();
                String tour_name = tour.getTour_name();
                String tour_brief_desc = tour.getTour_brief_desc();
                String tour_location = tour.getTour_location();
                Tour.Review[] reviews = tour.getReviews();
                double rating = tour.getAverage_rating();
        %>
        <div class="row">
            <div class="col-sm col-md-6 col-lg ftco-animate">
                <div class="destination">

                    <a
                            href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour.getTour_id()%>"
                            class="img img-2 d-flex justify-content-center align-items-center"
                            style="background-image: url(<%=tour_image.getUrl() %>)"
                    >
                        <div
                                class="icon d-flex justify-content-center align-items-center"
                        >
                            <span class="icon-search2"></span>
                        </div>
                    </a>

                    <div class="text p-3">
                        <div class="d-flex">
                            <div class="one">
                                <h3>
                                    <a href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id %>"><%=tour_name %>
                                    </a></h3>
                                <p class="rate">
                                    <%
                                        if (reviews.length != 0) {
                                            double minFilled = Math.floor(rating);
                                            for (double i = 0d; i < minFilled; i++) {
                                    %>
                                    <i class="icon-star"></i>
                                    <%
                                        }
                                        double maxEmpty = 5 - minFilled;
                                        for (double i = 0d; i < maxEmpty; i++) {
                                    %>
                                    <i class="icon-star-o"></i>
                                    <%
                                        }
                                    %>
                                    <span><%=rating%> Rating
<%--                                                (<%=reviews.length%> review(s))--%>
                                            </span>
                                    <%
                                    } else {
                                    %>
                                    No ratings yet.
                                    <%
                                        }
                                    %>
                                </p>
                            </div>
                        </div>
                        <p>
                            <%=tour_brief_desc %>
                        </p>

                        <hr/>
                        <p class="bottom-area d-flex">
                            <span><i class="icon-map-o"></i> <%=tour_location %></span>

                        </p>
                    </div>
                </div>
            </div>
            <%=dates.length%> date bookings: <br>

            <%
                for (Tour.Date.Pair date : dates) {
            %>
            <br>
            <%=date.getDate().getStartString()%> - <%=date.getDate().getEndString()%> <br>
            pax: <%=date.getPax()%> <br>
            <br>
            <form action="${pageContext.request.contextPath}/RemoveTourFromCart" method="post">
                <input type="hidden" name="date_id" value="<%=date.getDate().getId() %>">
                <input type="submit" value="Remove">
            </form>
            <%
                }
            %>
        </div>
        <%
                }
            }
        %>
        <br><br><br><br><br>
    </div>
    <div class="container">
        <%
            if (!Util.isUserLoggedIn(session)) {
        %>
        please <a href="${pageContext.request.contextPath}/views/user/login.jsp?redirect=${pageContext.request.contextPath}/views/user/cart.jsp">Login</a> or
        <a href="${pageContext.request.contextPath}/views/user/signup.jsp?redirect=${pageContext.request.contextPath}/views/user/cart.jsp">Register</a> to save your cart or checkout.
        <%
            }
        %>
        <form action="${pageContext.request.contextPath}/SaveCart" method="post">
            <input type="submit" value="Save"
                <%
                     if (!Util.isUserLoggedIn(session))
                     {
               %>
                   disabled
                <%
                        }
                %>
            >
        </form>

        <%
            if (cartItems.length == 0) {
        %>
        You have no tours in your cart.
        <%
            }
        %>
        <form action="${pageContext.request.contextPath}/create_payment_intent" method="post">
            <input type="submit" value="Checkout (<%=cart.getTotalPriceString(connection,currency)%>)"
                <%
                     if (cartItems.length == 0 || !Util.isUserLoggedIn(session))
                     {
               %>
                   disabled
                <%
                        }
                %>
            >
        </form>
    </div>
</section>

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