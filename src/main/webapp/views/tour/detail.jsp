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

<%@page import="dataStructures.User" %>
<%@page import="models.UserModel" %>
<%@ page import="utils.DatabaseConnection" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="models.TourModel" %>
<%@ page import="utils.IDatabaseQuery" %>
<%@ page import="utils.Util" %>
<%@ page import="models.WishlistModel" %>
<%@ page import="dataStructures.Wishlist" %>
<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<%
    String tour_idStr = request.getParameter("tour_id");
    int tour_id;
    try {
        tour_id = Integer.parseInt(tour_idStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("/CA1-Preparation/views/tour/view_all.jsp");
        return;
    }
    IDatabaseQuery<Tour> tourQuery = TourModel.getTourById(tour_id);
    DatabaseConnection connection = new DatabaseConnection();

    Tour[] tours = tourQuery.query(connection);

    if (tours == null || tours.length != 1) {
        response.sendRedirect("/CA1-Preparation/views/tour/view_all.jsp");
        return;
    }
    Tour tour = tours[0];

    if (request.getParameter("success") != null) {
        out.print("<div class=\"alert alert-success\" role=\"alert\">");
        out.print("<strong>Success!</strong> You have successfully registered for this tour.");
        out.print("</div>");
    } else if (request.getParameter("alreadyRegistered") != null) {
        out.print("<div class=\"alert alert-danger\" role=\"alert\">");
        out.print("<strong>Error!</strong> You have already registered for this tour.");
        out.print("</div>");
    } else if (request.getParameter("error") != null) {
        out.print("<div class=\"alert alert-danger\" role=\"alert\">");
        out.print("<strong>Error!</strong> There was an error registering for this tour.");
        out.print("</div>");
    }
    {
        String msg = request.getParameter("message");
        if (msg != null) {
            out.print("<div class=\"alert alert-danger\" role=\"alert\">");
            out.print("<strong>Error!</strong> " + msg);
            out.print("</div>");
        }
    }
%>
<head>

    <title><%=tour.getTour_name()%>
    </title>

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
<%@ include file="../misc/navbar_dark.jsp" %>
<section class="ftco-section ftco-degree-bg">
    <div class="container">
        <div class="row">
            <!-- Main item -->
            <div class="col-lg-8">
                <div class="row">
                    <div class="col-md-12 ftco-animate">
                        <div class="single-slider owl-carousel">
                            <%
                                Tour.Image[] images = tour.getImages();
                                for (Tour.Image image : images) {
                            %>
                            <div class="item">
                                <div
                                        class="hotel-img"
                                        style="
                                                background-image: url(<%=image.getUrl()%>);
                                                "
                                ></div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div
                            class="col-md-12 hotel-single mt-4 mb-5 ftco-animate"
                    >
                        <span>Our Best tours</span>
                        <h2><%=tour.getTour_name()%>
                        </h2>
                        <p class="rate mb-5">
                                    <span class="loc"
                                    ><a href="#"><i class="icon-map"></i><%=tour.getTour_location()%>
                                    </span>
                            <%
                                if (tour.getReviews().length != 0) {

                                    Double rating = tour.getAverage_rating();
                            %>
                            <span class="star">
                                <%
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
                                        <%=rating%> Rating (<%=tour.getReviews().length%> review(s))</span>
                            <%
                            } else {
                            %>
                            No ratings yet
                            <%
                                }
                            %>
                            <br>
                            <%
                                int userId = Util.getUserID(session);
                                boolean isUserLoggedIn = userId != -1;
                                if (isUserLoggedIn) {
                                    Wishlist[] wishlists = WishlistModel.getWishlist(userId, tour_id).query(connection);
                                    if (wishlists.length == 0) {
                            %>
                            <a href="${pageContext.request.contextPath}/TourPageAddWishlist?tourId=<%=tour_id%>">
                                <i class="icon-heart-o"> Add to wishlist </i>
                            </a><%
                        } else {
                            Wishlist wishlist = wishlists[0];
                        %>
                            <a href="${pageContext.request.contextPath}/TourPageRemoveWishlist?wishlistId=<%=wishlist.getWishlist_id()%>">
                                <i class="icon-heart"> Remove from wishlist </i>
                            </a><%
                            }
                        } else {
                        %>
                            You must be logged in to add this tour to your wishlist.
                            <%
                                }
                            %>
                        </p>
                        <p>
                            <%=tour.getTour_brief_desc()%>
                        </p>
                        <p>
                            <%=tour.getTour_desc()%>
                        </p>
                    </div>
                    <div class="col-md-12 hotel-single ftco-animate mb-5 mt-4">
                        <h4 class="mb-4"></h4>
                        <div class="block-16">
                            <figure>
                                <img
                                        src="${pageContext.request.contextPath}/images/hotel-6.jpg"
                                        alt="Image placeholder"
                                        class="img-fluid"
                                />
                                <a
                                        href="https://vimeo.com/45830194"
                                        class="play-button popup-vimeo"
                                >
                                    <span class="icon-play"></span
                                    ></a>
                            </figure>
                        </div>
                    </div>

                    <div
                            class="col-md-12 hotel-single ftco-animate mb-5 mt-4"
                    >
                        <%
                            Tour.Review[] reviews = tour.getReviews();
                        %>
                        <h4 class="mb-4">Reviews</h4>

                        <%
                            if (isUserLoggedIn) {
                        %>
                        <h5>Leave a review</h5>
                        <form action="${pageContext.request.contextPath}/addReview" method="POST"
                              style="margin-bottom: 50px">
                            <div class="form-group">

                                <input
                                        type="text"
                                        hidden="true"
                                        class="form-control"
                                        placeholder="Enter your review"
                                        name="tour_id"
                                        value="<%=tour_id %>"
                                        required
                                />

                                <label for="review">Review</label>

                                <input
                                        type="text"
                                        class="form-control"
                                        placeholder="Enter your review"
                                        name="text"
                                        required
                                />
                            </div>

                            <div class="form-group">
                                <label for="rating">Rating</label>
                                <input
                                        type="number"
                                        class="form-control"
                                        min="1"
                                        max="5"
                                        name="rating"
                                        required
                                />
                            </div>

                            <div class="form-group">
                                <button class="btn btn-primary">
                                    Submit Review
                                </button>
                            </div>
                        </form>
                        <% }%>
                        <%
                            if (reviews.length > 0) {


                                for (Tour.Review review : reviews) {
                        %>
                        <div class="card" style="margin-bottom: 10px;">

                            <div class="card-body">
                                        <span>
	                                        <%for (int i = 0; i < review.getRating(); i++) {%>
	                        				 	<i class="icon-star"></i>
	                        				<%} %>
                                        </span>

                                <p class="font-weight-bold"><%=review.getReview_text() %>
                                </p>

                                <%
                                    // Get the name of the user
                                    User[] users = UserModel.getUserByUserID(review.getUser_id()).query(connection);
                                %>
                                <p class="muted">By <%= users[0].getFullName()%>
                                </p>
                            </div>
                        </div>
                        <%
                            }
                        } else {%>

                        <h5>No reviews yet :(</h5>
                        <%
                            }

                        %>
                    </div>
                </div>
            </div>
            <!-- .col-md-8 -->

            <!-- Sidebar -->
            <div class="col-lg-4 sidebar">
                <div class="sidebar-wrap bg-light ftco-animate">
                    <h3 class="heading mb-4">Book for tour</h3>
                    <form action="${pageContext.request.contextPath}/RegisterForTour" method="POST">
                        <div class="fields">
                            <div class="form-group">
                                <div class="select-wrap one-third">
                                    <div class="icon">
                                                <span
                                                        class="ion-ios-arrow-down"
                                                ></span>
                                    </div>
                                    <label for="date"></label>
                                    <select
                                            required
                                            name="date"
                                            id="date"
                                            class="form-control"
                                            placeholder="Keyword search"
                                    >
                                        <%
                                            Tour.Date[] dates = TourModel.getShownTourDates(tour).query(connection);
                                            boolean havePreviousDate = request.getParameter("date") != null;
                                            boolean HaveDates = dates.length > 0;
                                            if (HaveDates) {
                                        %>
                                        <option value="placeholder"
                                                <%
                                                    if (!havePreviousDate) {
                                                %>
                                                selected="selected"
                                                <%
                                                    }
                                                %>
                                                disabled>
                                            Select Date
                                        </option>
                                        <%
                                        } else {
                                        %>
                                        <option value="placeholder" selected="selected" disabled>
                                            No Dates Available
                                        </option>
                                        <%
                                            }
                                            int prevDateID = 0;
                                            if (havePreviousDate)
                                                prevDateID = Integer.parseInt(request.getParameter("date"));

                                            for (Tour.Date date : dates) {
                                        %>
                                        <option value="<%=date.getId()%>"
                                                <%
                                                    if (date.getAvail_slot() == 0) {
                                                %>
                                                disabled
                                                <%
                                                    }
                                                    if (date.getId() == prevDateID) {
                                                %>
                                                selected="selected"
                                                <%
                                                    }
                                                %>
                                        >
                                            <%=date.getStartString()%> - <%=date.getEndString()%>
                                            (<%=date.getAvail_slot()%> slots available)
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <%
                                if (request.getParameter("InvalidDate") != null) {
                            %>
                            <div class="alert alert-danger" role="alert">
                                <strong>Please select a valid date</strong>
                            </div>
                            <%
                                }
                            %>

                            <div class="form-group">
                                <div class="select-wrap">
                                    <label for="pax"></label>
                                    <input
                                            id="pax"
                                            required
                                            name="pax"
                                            type="number"
                                            class="form-control"
                                            <%
                                                if (!HaveDates) {
                                            %>
                                            placeholder="No Dates Available"
                                            <%
                                            } else {
                                            %>
                                            placeholder="Pax (Max 5)"
                                            <%
                                                }
                                            %>
                                            min="1"
                                            max="5"
                                            <%
                                                if (request.getParameter("pax") != null) {
                                            %>
                                            value="<%=request.getParameter("pax")%>"
                                            <%
                                                }
                                                if (!HaveDates) {
                                            %>
                                            disabled
                                            <%
                                                }
                                            %>
                                    />
                                </div>
                            </div>
                            <%
                                if (request.getParameter("InvalidPax") != null) {
                            %>
                            <div class="alert alert-danger" role="alert">
                                <strong>Please select a valid number</strong>
                            </div>
                            <%
                                }
                            %>

                            <label for="id"></label>
                            <input id="id"
                                   required
                                   name="id"
                                   hidden
                                   value="<%=tour.getTour_id()%>">

                            <div class="form-group">
                                <input
                                        type="submit"
                                        value="Book"
                                        class="btn btn-primary py-3 px-5"
                                        <%
                                            if (!HaveDates) {
                                        %>
                                        disabled
                                        <%
                                            }
                                        %>
                                />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<%connection.close(); %>
<!-- .section -->

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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="${pageContext.request.contextPath}/js/google-map.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>