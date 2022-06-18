<%@ page import="dataStructures.Category" %>
<%@ page import="utils.DatabaseConnection" %>
<%@ page import="models.CategoryModel" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="models.TourModel" %>
<%@ page import="utils.IDatabaseQuery" %>
<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<%
    String tour_id = request.getParameter("tour_id");
    IDatabaseQuery<Tour> tourQuery = TourModel.getTourById(tour_id);
    if (tourQuery == null) {
        //tourId is not valid
        return;
    }
    DatabaseConnection connection = new DatabaseConnection();
    Tour[] tours = tourQuery.query(connection);
    connection.close();
    if (tours == null || tours.length != 1) {
        response.sendRedirect("/CA1-Preparation/views/tour/categoryListing.jsp");
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
<%@ include file="../misc/navbar.jsp" %>

<section class="ftco-section ftco-degree-bg">
    <div class="container">
        <div class="row">
            <!-- Main item -->
            <div class="col-lg-9">
                <div class="row">
                    <div class="col-md-12 ftco-animate">
                        <div class="single-slider owl-carousel">
                            <div class="item">
                                <div
                                        class="hotel-img"
                                        style="
                                                background-image: url(${pageContext.request.contextPath}/images/hotel-2.jpg);
                                                "
                                ></div>
                            </div>
                            <div class="item">
                                <div
                                        class="hotel-img"
                                        style="
                                                background-image: url(${pageContext.request.contextPath}/images/hotel-3.jpg);
                                                "
                                ></div>
                            </div>
                            <div class="item">
                                <div
                                        class="hotel-img"
                                        style="
                                                background-image: url(${pageContext.request.contextPath}/images/hotel-4.jpg);
                                                "
                                ></div>
                            </div>
                        </div>
                    </div>
                    <div
                            class="col-md-12 hotel-single mt-4 mb-5 ftco-animate"
                    >
                        <span>Our Best hotels &amp; Rooms</span>
                        <h2>Luxury Hotel in Paris</h2>
                        <p class="rate mb-5">
                                    <span class="loc"
                                    ><a href="#"
                                    ><i class="icon-map"></i> 291 South
                                            21th Street, Suite 721 New York NY
                                            10016</a
                                    ></span
                                    >
                            <span class="star">
                                        <i class="icon-star"></i>
                                        <i class="icon-star"></i>
                                        <i class="icon-star"></i>
                                        <i class="icon-star"></i>
                                        <i class="icon-star-o"></i>
                                        8 Rating</span
                            >
                        </p>
                        <p>
                            When she reached the first hills of the
                            Italic Mountains, she had a last view back
                            on the skyline of her hometown
                            Bookmarksgrove, the headline of Alphabet
                            Village and the subline of her own road, the
                            Line Lane. Pityful a rethoric question ran
                            over her cheek, then she continued her way.
                        </p>
                        <div class="d-md-flex mt-5 mb-5">
                            <ul>
                                <li>
                                    The Big Oxmox advised her not to do
                                    so
                                </li>
                                <li>
                                    When she reached the first hills of
                                    the Italic Mountains
                                </li>
                                <li>
                                    She had a last view back on the
                                    skyline of her hometown
                                </li>
                                <li>
                                    Bookmarksgrove, the headline of
                                    Alphabet
                                </li>
                            </ul>
                            <ul class="ml-md-5">
                                <li>
                                    Question ran over her cheek, then
                                    she continued
                                </li>
                                <li>Pityful a rethoric question ran</li>
                                <li>
                                    Mountains, she had a last view back
                                    on the skyline
                                </li>
                                <li>
                                    Headline of Alphabet Village and the
                                    subline
                                </li>
                            </ul>
                        </div>
                        <p>
                            When she reached the first hills of the
                            Italic Mountains, she had a last view back
                            on the skyline of her hometown
                            Bookmarksgrove, the headline of Alphabet
                            Village and the subline of her own road, the
                            Line Lane. Pityful a rethoric question ran
                            over her cheek, then she continued her way.
                        </p>
                    </div>
                    <div
                            class="col-md-12 hotel-single ftco-animate mb-5 mt-4"
                    >
                        <h4 class="mb-4">Take A dataStructures.Tour</h4>
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
                        <h4 class="mb-4">Review &amp; Ratings</h4>
                        <div class="row">
                            <div class="col-md-6">
                                <form method="post" class="star-rating">
                                    <div class="form-check">
                                        <input
                                                type="checkbox"
                                                class="form-check-input"
                                                id="exampleCheck1"
                                        />
                                        <label
                                                class="form-check-label"
                                                for="exampleCheck1"
                                        >
                                            <p class="rate">
                                                        <span
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i>
                                                            100 Ratings</span
                                                        >
                                            </p>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input
                                                type="checkbox"
                                                class="form-check-input"
                                                id="exampleCheck1"
                                        />
                                        <label
                                                class="form-check-label"
                                                for="exampleCheck1"
                                        >
                                            <p class="rate">
                                                        <span
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i>
                                                            30 Ratings</span
                                                        >
                                            </p>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input
                                                type="checkbox"
                                                class="form-check-input"
                                                id="exampleCheck1"
                                        />
                                        <label
                                                class="form-check-label"
                                                for="exampleCheck1"
                                        >
                                            <p class="rate">
                                                        <span
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i>
                                                            5 Ratings</span
                                                        >
                                            </p>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input
                                                type="checkbox"
                                                class="form-check-input"
                                                id="exampleCheck1"
                                        />
                                        <label
                                                class="form-check-label"
                                                for="exampleCheck1"
                                        >
                                            <p class="rate">
                                                        <span
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i>
                                                            0 Ratings</span
                                                        >
                                            </p>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input
                                                type="checkbox"
                                                class="form-check-input"
                                                id="exampleCheck1"
                                        />
                                        <label
                                                class="form-check-label"
                                                for="exampleCheck1"
                                        >
                                            <p class="rate">
                                                        <span
                                                        ><i
                                                                class="icon-star"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i
                                                        ><i
                                                                class="icon-star-o"
                                                        ></i>
                                                            0 Ratings</span
                                                        >
                                            </p>
                                        </label>
                                    </div>
                                </form>
                            </div>
                        </div>
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
            <div class="col-lg-3 sidebar">
                <div class="sidebar-wrap bg-light ftco-animate">
                    <h3 class="heading mb-4">Book for tour</h3>
                    <form action="#">
                        <div class="fields">
                            <div class="form-group">
                                <div class="select-wrap one-third">
                                    <div class="icon">
                                                <span
                                                        class="ion-ios-arrow-down"
                                                ></span>
                                    </div>
                                    <label for=""></label><select
                                        name=""
                                        id=""
                                        class="form-control"
                                        placeholder="Keyword search"
                                >
                                    <option value="">
                                        Select Date
                                    </option>
                                    <option value="">
                                        San Francisco USA
                                    </option>
                                    <option value="">
                                        Berlin Germany
                                    </option>
                                    <option value="">
                                        Lodon United Kingdom
                                    </option>
                                    <option value="">
                                        Paris Italy
                                    </option>
                                </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>
                                    <input
                                            type="number"
                                            class="form-control"
                                            placeholder="Pax (Max 5)"
                                            min="1"
                                            max="5"
                                    />
                                </label>
                            </div>

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