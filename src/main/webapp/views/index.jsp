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

<%@page import="models.CategoryModel" %>
<%@page import="models.TourModel" %>
<%@ page import="dataStructures.Category" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="utils.DatabaseConnection" %>
<%@ page import="dataStructures.CurrencyExchangeRates" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Tours R' Us</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Alex+Brush" rel="stylesheet"/>

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

<%--   TransparentHeader param Doesnt do anything yet--%>
<jsp:include page="/views/misc/navbar.jsp">
    <jsp:param name="transparentHeader" value="true"/>
</jsp:include>
<!-- END nav -->

<div
        class="hero-wrap js-fullheight"
        style="background-image: url('${pageContext.request.contextPath}/images/bg_1.jpg')"
>
    <div class="overlay"></div>
    <div class="container">
        <div
                class="row no-gutters slider-text js-fullheight align-items-center justify-content-start"
                data-scrollax-parent="true"
        >
            <div
                    class="col-md-9 ftco-animate"
                    data-scrollax=" properties: { translateY: '70%' }"
            >
                <h1
                        class="mb-4"
                        data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"
                >
                    <strong>Explore <br/></strong> the world
                </h1>
                <p
                        data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"
                >
                    Find great places to stay, eat, shop, or visit from
                    local experts
                </p>
                <div class="block-17 my-4">
                    <form
                            action="${pageContext.request.contextPath}/views/tour/view_all.jsp"
                            method="get"
                            class="d-block d-flex"
                    >
                        <div class="fields d-block d-flex">
                            <div class="textfield-search one-third">
                                <label>
                                    <input
                                            type="text"
                                            class="form-control"
                                            placeholder="Search for tours..."
                                            name="q"
                                    />
                                </label>
                            </div>

                        </div>
                        <input
                                type="submit"
                                class="search-submit btn btn-primary"
                                value="Search"
                        />
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>


<%--This part onwards doesn't load if error--%>
<section class="ftco-section services-section bg-light">
    <div class="container">
        <div class="row d-flex">
            <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services d-block text-center">
                    <div class="d-flex justify-content-center">
                        <div class="icon">
                            <span class="flaticon-guarantee"></span>
                        </div>
                    </div>
                    <div class="media-body p-2 mt-2">
                        <h3 class="heading mb-3">
                            Best Price Guarantee
                        </h3>
                        <p>
                            With Tours R' Us, you are sure to get the best price guaranteed!
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services d-block text-center">
                    <div class="d-flex justify-content-center">
                        <div class="icon">
                            <span class="flaticon-like"></span>
                        </div>
                    </div>
                    <div class="media-body p-2 mt-2">
                        <h3 class="heading mb-3">Travellers Love Us</h3>
                        <p> With over 20000+ Travellers, we are sure to give you the best experience ever!
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services d-block text-center">
                    <div class="d-flex justify-content-center">
                        <div class="icon">
                            <span class="flaticon-detective"></span>
                        </div>
                    </div>
                    <div class="media-body p-2 mt-2">
                        <h3 class="heading mb-3">Best Travel Agent</h3>
                        <p>
                            Rated the 1st by the AOTA, we pride ourselves in being the best.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services d-block text-center">
                    <div class="d-flex justify-content-center">
                        <div class="icon">
                            <span class="flaticon-support"></span>
                        </div>
                    </div>
                    <div class="media-body p-2 mt-2">
                        <h3 class="heading mb-3">
                            Our Dedicated Support
                        </h3>
                        <p>
                            Our toll free line are there to help you with any troubles!
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="ftco-section ftco-destination">
    <div class="container">
        <div class="row justify-content-start mb-5 pb-3">
            <div class="col-md-7 heading-section ftco-animate">
                <span class="subheading">Featured</span>
                <h2 class="mb-4">
                    <strong>Featured</strong> Categories
                </h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="destination-slider owl-carousel ftco-animate">
                    <%
                        DatabaseConnection connection = new DatabaseConnection();
                        Category[] categories = CategoryModel.getCategoriesWithListingCount().query(connection);

                        if (categories != null)
                            for (Category category : categories) {
                                String image = category.getImage();
                                String category_name = category.getCategory_name();
                                String desc = category.getDesc();
                                int count = category.getCount();
                    %>
                    <div class="item">
                        <div class="destination">
                            <a
                                    href="${pageContext.request.contextPath}/views/tour/categories.jsp?category_name=<%= category_name %>"
                                    class="img d-flex justify-content-center align-items-center"
                                    style="background-image: url(<%=image %>);"
                            >
                                <div class="icon d-flex justify-content-center align-items-center">
                                    <span class="icon-search2"></span>
                                </div>
                            </a>
                            <div class="text p-3">
                                <h3>
                                    <a href="${pageContext.request.contextPath}/views/tour/categories.jsp?category_name=<%= category_name %>"><%=category_name%>
                                    </a></h3>
                                <span class="listing"><%=desc%></span>

                                <br/>
                                <span class="listing"><%=count%> Listing</span>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                    %>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="ftco-section bg-light">
    <div class="container">
        <div class="row justify-content-start mb-5 pb-3">
            <div class="col-md-7 heading-section ftco-animate">
                <span class="subheading">Special Offers</span>
                <h2 class="mb-4"><strong>Top</strong> Tour Packages</h2>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row">

            <%
                    Tour[] tours = TourModel.getAllTours(5).query(connection);
                connection.close();

                String currency = (String) request.getSession().getAttribute("currency");
                double rates = Objects.requireNonNull(CurrencyExchangeRates.GetCurrentRates()).getRates().get(currency);
                if (tours != null)
                    for (Tour tour : tours) {
                        int tour_id = tour.getTour_id();
                        Tour.Image tour_image = tour.getFirstOrDefaultImage();
                        String tour_name = tour.getTour_name();
                        String tour_brief_desc = tour.getTour_brief_desc();
                        Tour.Date tour_date = tour.getFirstOrDefaultDate();
                        String tour_location = tour.getTour_location();
                        Tour.Review[] reviews = tour.getReviews();
                        double rating = tour.getAverage_rating();
                        System.out.println("Tour Details: " + tour_id + " | " + tour_name + " | " + tour_brief_desc + " | " + tour_date + " | " + tour_location + " | " + rating);

            %>
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
                            <div class="two">
                                                   <%
	                                    if(rates == -1){
	                                    	 
	                                    %>
	                                     <span class="price">Error Obtaining Price</span>
	                                     <%
	                                    }else{
	                                     %>
	                                
	                                        <span class="price">$<%=Math.round(tour_date.getPrice() * rates * 100) / 100d%></span>
	                                        <%
	                                    }
	                                        %>
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
            <%
                    }
            %>


        </div>
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
                        document.write(new Date().getFullYear().toLocaleString());
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
//This isn't found anywhere
<script src="${pageContext.request.contextPath}/js/scrollax.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
