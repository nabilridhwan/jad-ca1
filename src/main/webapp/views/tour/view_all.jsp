<!DOCTYPE html>
<%@page import="dataStructures.Tour" %>
<%@page import="utils.DatabaseConnection" %>
<%@page import="models.TourModel" %>
<html lang="en">

<head>
    <title>DirEngine - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Alex+Brush" rel="stylesheet">

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
    DatabaseConnection connection = new DatabaseConnection();
    Tour[] tours = (request.getParameter("q") != null) ?
            TourModel.getTourByName(request.getParameter("q")).query(connection) :
            TourModel.getAllTours().query(connection);
    connection.close();
%>


<%@ include file="../misc/navbar_dark.jsp" %>


<!-- 



<div class="hero-wrap js-fullheight"
     style="background-image: url('${pageContext.request.contextPath}/images/bg_5.jpg');">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center"
             data-scrollax-parent="true">
            <div class="col-md-9 ftco-animate text-center" data-scrollax=" properties: { translateY: '70%' }">
                <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">
                    <span class="mr-2">Tours</span>
                    <span>
                        <a href="${pageContext.request.contextPath}/views/tour/categoryListing.jsp">Categories</a>
                    </span>
                </p>
                <h1 class="mb-3 bread"
                    data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Tours
                </h1>
            </div>
        </div>
    </div>
</div>
 -->


<section class="ftco-section ftco-degree-bg">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 sidebar ftco-animate">
                <div class="sidebar-wrap bg-light ftco-animate">
                    <h3 class="heading mb-4">Search</h3>

                    <%
                        String q = (request.getParameter("q") != null) ? request.getParameter("q") : "";
                    %>

                    <form action="${pageContext.request.contextPath}/views/tour/view_all.jsp" method="GET">
                        <div class="fields">
                            <div class="form-group">
                                <label>
                                    <input type="text" class="form-control" placeholder="Search for tours..." name="q"
                                           value="<%=q%>">
                                </label>
                            </div>
                            
                            <div class="form-group">
                                <input type="submit" value="Search" class="btn btn-primary py-3 px-5">
                            </div>
                        </div>
                    </form>

                </div>
            </div>
            <div class="col-lg-9" id="tourbody">
                <div class="row"> <!-- Start tour body -->

                    <%
                        if (tours.length == 0) {%>
                    <h3>No tour found</h3>
                    <%
                    } else {


                        for (Tour tour : tours) {
                            int tour_id = tour.getTour_id();
                            Tour.Image tour_image = tour.getFirstOrDefaultImage();
                            String tour_name = tour.getTour_name();
                            String tour_brief_desc = tour.getTour_brief_desc();
                            Tour.Date tour_date = tour.getFirstOrDefaultDate();
                            String tour_location = tour.getTour_location();
                            Double rating = tour.getAverage_rating();
                            Tour.Review[] reviews = tour.getReviews();

                    %>

                    <div class="col-md-4 ftco-animate"> <!--Start Tour-->
                        <div class="destination">
                            <a href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id %>"
                               class="img img-2 d-flex justify-content-center align-items-center"
                               style="background-image: url(<%=tour_image.getUrl()%>);">
                                <div class="icon d-flex justify-content-center align-items-center">
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
                                    <span class="star">
	                                    <div class="two">
	                                        <span class="price">$<%=tour_date.getPrice() %></span>
	                                    </div>
                                    </span>
                                </div>
                                <p><%=tour_brief_desc %>
                                </p>
                                <p class="days"><span><%=tour_date.getDuration()%></span></p>
                                <hr>
                                <p class="bottom-area d-flex">
                                    <span><i class="icon-map-o"></i> <%=tour_location %></span>
                                </p>
                            </div>
                        </div>
                    </div> <!--End Tour-->
                    <%
                            }
                        }
                    %>
                </div> <!-- End tour body -->


            </div> <!-- .col-md-8 -->
        </div>
    </div>
</section> <!-- .section -->

<footer class="ftco-footer ftco-bg-dark ftco-section">
    <div class="container">
        <div class="row mb-5">
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">dirEngine</h2>
                    <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,
                        there live the blind texts.</p>
                    <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                        <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                        <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                        <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4 ml-md-5">
                    <h2 class="ftco-heading-2">Information</h2>
                    <ul class="list-unstyled">
                        <li><a href="#" class="py-2 d-block">About</a></li>
                        <li><a href="#" class="py-2 d-block">Service</a></li>
                        <li><a href="#" class="py-2 d-block">Terms and Conditions</a></li>
                        <li><a href="#" class="py-2 d-block">Become a partner</a></li>
                        <li><a href="#" class="py-2 d-block">Best Price Guarantee</a></li>
                        <li><a href="#" class="py-2 d-block">Privacy and Policy</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">Customer Support</h2>
                    <ul class="list-unstyled">
                        <li><a href="#" class="py-2 d-block">FAQ</a></li>
                        <li><a href="#" class="py-2 d-block">Payment Option</a></li>
                        <li><a href="#" class="py-2 d-block">Booking Tips</a></li>
                        <li><a href="#" class="py-2 d-block">How it works</a></li>
                        <li><a href="#" class="py-2 d-block">Contact Us</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">Have a Questions?</h2>
                    <div class="block-23 mb-3">
                        <ul>
                            <li><span class="icon icon-map-marker"></span><span class="text">203 Fake St. Mountain
										View, San Francisco, California, USA</span></li>
                            <li><a href="#"><span class="icon icon-phone"></span><span class="text">+2 392 3929
											210</span></a></li>
                            <li><a href="#"><span class="icon icon-envelope"></span><span
                                    class="text">info@yourdomain.com</span></a></li>
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
                    <script>document.write(new Date().getFullYear().toLocaleString());</script>
                    All rights reserved | This template
                    is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com"
                                                                                     target="_blank">Colorlib</a>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                </p>
            </div>
        </div>
    </div>
</footer>


<!-- loader -->
<div id="ftco-loader" class="show fullscreen">
    <svg class="circular" width="48px" height="48px">
        <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"></circle>
        <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10"
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
//This isn't found anywhere
<script src="${pageContext.request.contextPath}/js/scrollax.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>

</body>

</html>