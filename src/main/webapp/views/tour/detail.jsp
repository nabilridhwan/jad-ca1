<%@ page import="dataStructures.Category" %>
<%@ page import="utils.DatabaseConnection" %>
<%@ page import="models.CategoryModel" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="models.TourModel" %>
<%@ page import="utils.IDatabaseQuery" %>
<%@ page import="utils.Util" %>
<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<%
    String tour_id = request.getParameter("tour_id");
    IDatabaseQuery<Tour> tourQuery = TourModel.getTourById(tour_id);
    DatabaseConnection connection = new DatabaseConnection();
    if (tourQuery == null) {
        response.sendRedirect("/CA1-Preparation/views/tour/view_all.jsp?error=SQL");
        return;
    }
    Tour[] tours = tourQuery.query(connection);
    connection.close();
    if (tours == null || tours.length != 1) {
        response.sendRedirect("/CA1-Preparation/views/tour/view_all.jsp");
        return;
    }
    Tour tour = tours[0];
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
                        </p>

                        <p>
                            <%=tour.getTour_brief_desc()%>
                        </p>
                        <p>
                            <%=tour.getTour_desc()%>
                        </p>
                    </div>
                    <div
                            class="col-md-12 hotel-single ftco-animate mb-5 mt-4"
                    >
                        <h4 class="mb-4">Take A Tour</h4>
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
                                ><span class="icon-play"></span
                                ></a>
                            </figure>
                        </div>
                    </div>

                    <div
                            class="col-md-12 hotel-single ftco-animate mb-5 mt-4"
                    >
                        <%
                            if (Util.isUserLoggedIn(session)) {
                                Tour.Review[] reviews = tour.getReviews();
                        %>
                        <h4 class="mb-4">Reviews</h4>
                        <%
                            for (Tour.Review review : reviews) {
                        %>
                        Review by <%=review.getUser_id()%>
                        <%
                                }
                            }
                        %>
                    </div>
                    <div
                            class="col-md-12 hotel-single ftco-animate mb-5 mt-5"
                    >
                        <h4 class="mb-4">Related Hotels</h4>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="destination">
                                    <a
                                            href="hotel-single.html"
                                            class="img img-2"
                                            style="
                                                    background-image: url(${pageContext.request.contextPath}/images/hotel-1.jpg);
                                                    "
                                    ></a>
                                    <div class="text p-3">
                                        <div class="d-flex">
                                            <div class="one">
                                                <h3>
                                                    <a
                                                            href="hotel-single.html"
                                                    >Hotel, Italy</a
                                                    >
                                                </h3>
                                                <p class="rate">
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star-o"
                                                    ></i>
                                                    <span
                                                    >8 Rating</span
                                                    >
                                                </p>
                                            </div>
                                            <div class="two">
                                                        <span
                                                                class="price per-price"
                                                        >$40<br/><small
                                                        >/night</small
                                                        ></span
                                                        >
                                            </div>
                                        </div>
                                        <p>
                                            Far far away, behind the
                                            word mountains, far from the
                                            countries
                                        </p>
                                        <hr/>
                                        <p class="bottom-area d-flex">
                                                    <span
                                                    ><i
                                                            class="icon-map-o"
                                                    ></i>
                                                        Miami, Fl</span
                                                    >
                                            <span class="ml-auto"
                                            ><a href="#"
                                            >Book Now</a
                                            ></span
                                            >
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="destination">
                                    <a
                                            href="hotel-single.html"
                                            class="img img-2"
                                            style="
                                                    background-image: url(${pageContext.request.contextPath}/images/hotel-2.jpg);
                                                    "
                                    ></a>
                                    <div class="text p-3">
                                        <div class="d-flex">
                                            <div class="one">
                                                <h3>
                                                    <a
                                                            href="hotel-single.html"
                                                    >Hotel, Italy</a
                                                    >
                                                </h3>
                                                <p class="rate">
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star-o"
                                                    ></i>
                                                    <span
                                                    >8 Rating</span
                                                    >
                                                </p>
                                            </div>
                                            <div class="two">
                                                        <span
                                                                class="price per-price"
                                                        >$40<br/><small
                                                        >/night</small
                                                        ></span
                                                        >
                                            </div>
                                        </div>
                                        <p>
                                            Far far away, behind the
                                            word mountains, far from the
                                            countries
                                        </p>
                                        <hr/>
                                        <p class="bottom-area d-flex">
                                                    <span
                                                    ><i
                                                            class="icon-map-o"
                                                    ></i>
                                                        Miami, Fl</span
                                                    >
                                            <span class="ml-auto"
                                            ><a href="#"
                                            >Book Now</a
                                            ></span
                                            >
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="destination">
                                    <a
                                            href="hotel-single.html"
                                            class="img img-2"
                                            style="
                                                    background-image: url(images/hotel-3.jpg);
                                                "
                                    ></a>
                                    <div class="text p-3">
                                        <div class="d-flex">
                                            <div class="one">
                                                <h3>
                                                    <a
                                                            href="hotel-single.html"
                                                    >Hotel, Italy</a
                                                    >
                                                </h3>
                                                <p class="rate">
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star"
                                                    ></i>
                                                    <i
                                                            class="icon-star-o"
                                                    ></i>
                                                    <span
                                                    >8 Rating</span
                                                    >
                                                </p>
                                            </div>
                                            <div class="two">
                                                        <span
                                                                class="price per-price"
                                                        >$40<br/><small
                                                        >/night</small
                                                        ></span
                                                        >
                                            </div>
                                        </div>
                                        <p>
                                            Far far away, behind the
                                            word mountains, far from the
                                            countries
                                        </p>
                                        <hr/>
                                        <p class="bottom-area d-flex">
                                                    <span
                                                    ><i
                                                            class="icon-map-o"
                                                    ></i>
                                                        Miami, Fl</span
                                                    >
                                            <span class="ml-auto"
                                            ><a href="#"
                                            >Book Now</a
                                            ></span
                                            >
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                            Tour.Date[] dates = tour.getDates();

                                            if (dates.length > 0) {
                                        %>
                                        <option value="placeholder" selected="selected" disabled>
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
                                            for (Tour.Date date : dates) {
                                                if (!date.isShown())
                                                    continue;
                                        %>
                                        <option value="<%=date.getId()%>"
                                                <%
                                                    if (date.getAvail_slot() == 0) {
                                                %>
                                                disabled
                                                <%
                                                    }
                                                %>
                                        >
                                            <%=date.getStartString()%> - <%=date.getEndString()%>
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
                                            placeholder="Pax (Max 5)"
                                            min="1"
                                            max="5"
                                            <%
                                                if (request.getParameter("pax") != null) {
                                            %>
                                            value="<%=request.getParameter("pax")%>"
                                            <%
                                                }
                                            %>
                                    />
                                </div>
                            </div>

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
                                />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
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