<%@page import="models.CategoryModel"%>
<%@page import="models.TourModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="ISO-8859-1">
        <title>DirEngine - Free Bootstrap 4 Template by Colorlib</title>
        <meta charset="utf-8" />
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

        <link rel="stylesheet" href="/CA1-Preparation/css/open-iconic-bootstrap.min.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/animate.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/owl.carousel.min.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/owl.theme.default.min.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/magnific-popup.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/aos.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/ionicons.min.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/bootstrap-datepicker.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/jquery.timepicker.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/flaticon.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/icomoon.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/style.css" />
    </head>
    <body>
        <%@ include file = "misc/navbar.jsp" %>
        <!-- END nav -->

        <div
            class="hero-wrap js-fullheight"
            style="background-image: url('images/bg_1.jpg')"
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
                            <strong>Explore <br /></strong> the world
                        </h1>
                        <p
                            data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"
                        >
                            Find great places to stay, eat, shop, or visit from
                            local experts
                        </p>
                        <div class="block-17 my-4">
                            <form
                                action=""
                                method="post"
                                class="d-block d-flex"
                            >
                                <div class="fields d-block d-flex">
                                    <div class="textfield-search one-third">
                                        <input
                                            type="text"
                                            class="form-control"
                                            placeholder="Ex: food, service, hotel"
                                        />
                                    </div>
                                    <div class="select-wrap one-third">
                                        <div class="icon">
                                            <span
                                                class="ion-ios-arrow-down"
                                            ></span>
                                        </div>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            placeholder="Keyword search"
                                        >
                                            <option value="">Where</option>
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
                                <input
                                    type="submit"
                                    class="search-submit btn btn-primary"
                                    value="Search"
                                />
                            </form>
                        </div>
                        <p>Or browse the highlights</p>
                        <p class="browse d-md-flex">
                            <span
                                class="d-flex justify-content-md-center align-items-md-center"
                                ><a href="#"
                                    ><i class="flaticon-fork"></i>Restaurant</a
                                ></span
                            >
                            <span
                                class="d-flex justify-content-md-center align-items-md-center"
                                ><a href="#"
                                    ><i class="flaticon-hotel"></i>Hotel</a
                                ></span
                            >
                            <span
                                class="d-flex justify-content-md-center align-items-md-center"
                                ><a href="#"
                                    ><i class="flaticon-meeting-point"></i
                                    >Places</a
                                ></span
                            >
                            <span
                                class="d-flex justify-content-md-center align-items-md- center"
                                ><a href="#"
                                    ><i class="flaticon-shopping-bag"></i
                                    >Shopping</a
                                ></span
                            >
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <section class="ftco-section services-section bg-light">
            <div class="container">
                <div class="row d-flex">
                    <div
                        class="col-md-3 d-flex align-self-stretch ftco-animate"
                    >
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
                                    A small river named Duden flows by their
                                    place and supplies.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div
                        class="col-md-3 d-flex align-self-stretch ftco-animate"
                    >
                        <div class="media block-6 services d-block text-center">
                            <div class="d-flex justify-content-center">
                                <div class="icon">
                                    <span class="flaticon-like"></span>
                                </div>
                            </div>
                            <div class="media-body p-2 mt-2">
                                <h3 class="heading mb-3">Travellers Love Us</h3>
                                <p>
                                    A small river named Duden flows by their
                                    place and supplies.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div
                        class="col-md-3 d-flex align-self-stretch ftco-animate"
                    >
                        <div class="media block-6 services d-block text-center">
                            <div class="d-flex justify-content-center">
                                <div class="icon">
                                    <span class="flaticon-detective"></span>
                                </div>
                            </div>
                            <div class="media-body p-2 mt-2">
                                <h3 class="heading mb-3">Best Travel Agent</h3>
                                <p>
                                    A small river named Duden flows by their
                                    place and supplies.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div
                        class="col-md-3 d-flex align-self-stretch ftco-animate"
                    >
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
                                    A small river named Duden flows by their
                                    place and supplies.
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
                        <div
                            class="destination-slider owl-carousel ftco-animate"
                        >
                        
                        <%
								ResultSet catRs = CategoryModel.getCategoriesWithListingCount();
                            	
                            	
                            	while(catRs.next()){
                            		int category_id = catRs.getInt(1);
                                	String category_name = catRs.getString(2);
                                	String desc = catRs.getString(3);
                                	String image = catRs.getString(4);
                                	int count = catRs.getInt(5);
                            	%>
                            	<div class="item">
                                <div class="destination">
                                    <a
                                        href="#"
                                        class="img d-flex justify-content-center align-items-center"
                                        style="
                                            background-image: url(<%=image %>);
                                        "
                                    >
                                        <div
                                            class="icon d-flex justify-content-center align-items-center"
                                        >
                                            <span class="icon-search2"></span>
                                        </div>
                                    </a>
                                    <div class="text p-3">
                                        <h3><a href="#"><%=category_name %></a></h3>
                                        <span class="listing"><%=desc %></span>
                                        
                                        <br />
                                        <span class="listing"><%=count %> Listing</span>
                                    </div>
                                </div>
                            </div>
                                <%}%>
                                
                           
                            
                            
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
								ResultSet rs = TourModel.getUniqueToursByLowestPriceFirst();
                            	
                            	
                            	while(rs.next()){
                            		int tour_id = rs.getInt("tour_id");
                                	String tour_name = rs.getString("name");
                                	String tour_brief_desc = rs.getString("brief_desc");
                                	double tour_price = rs.getDouble("price");
                                	String tour_image_url = rs.getString("url");
                                	String tour_image_alt_text = rs.getString("alt_text");
                                	String tour_location = rs.getString("location");
                            	%>
                            	<div class="col-sm col-md-6 col-lg ftco-animate">
                        <div class="destination">
                        
                        <a
                                href="#"
                                class="img img-2 d-flex justify-content-center align-items-center"
                                style="
                                    background-image: url(<%=tour_image_url %>);
                                "
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
                                            <h3><a href="#"><%=tour_name %></a></h3>
                                            <p class="rate">
                                                <i class="icon-star"></i>
                                                <i class="icon-star"></i>
                                                <i class="icon-star"></i>
                                                <i class="icon-star"></i>
                                                <i class="icon-star-o"></i>
                                                <span>8 Rating</span>
                                            </p>
                                        </div>
                                        <div class="two">
                                            <span class="price">$<%=tour_price %></span>
                                        </div>
                                    </div>
                                    <p>
                                        <%=tour_brief_desc %>
                                    </p>
                                    <p class="days"><span>2 days 3 nights</span></p>
                                    <hr />
                                    <p class="bottom-area d-flex">
                                        <span
                                            ><i class="icon-map-o"></i><%=tour_location %></span
                                        >
                                        
                                    </p>
                                </div>
                                 </div>
                    </div>
                                <%}%>
                
                <!-- Single Card -->
                    <div class="col-sm col-md-6 col-lg ftco-animate">
                        <div class="destination">
                            <a
                                href="#"
                                class="img img-2 d-flex justify-content-center align-items-center"
                                style="
                                    background-image: url(images/destination-1.jpg);
                                "
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
                                        <h3><a href="#">Paris, Italy</a></h3>
                                        <p class="rate">
                                            <i class="icon-star"></i>
                                            <i class="icon-star"></i>
                                            <i class="icon-star"></i>
                                            <i class="icon-star"></i>
                                            <i class="icon-star-o"></i>
                                            <span>8 Rating</span>
                                        </p>
                                    </div>
                                    <div class="two">
                                        <span class="price">$200</span>
                                    </div>
                                </div>
                                <p>
                                    Far far away, behind the word mountains, far
                                    from the countries
                                </p>
                                <p class="days"><span>2 days 3 nights</span></p>
                                <hr />
                                <p class="bottom-area d-flex">
                                    <span
                                        ><i class="icon-map-o"></i> San
                                        Franciso, CA</span
                                    >
                                    <span class="ml-auto"
                                        ><a href="#">Discover</a></span
                                    >
                                </p>
                            </div>
                            
                            
                        </div>
                    </div> <!-- End of card -->
                    
                            
            </div>
        </section>

        <!-- <section
            class="ftco-section ftco-counter img"
            id="section-counter"
            style="background-image: url(images/bg_1.jpg)"
        >
            <div class="container">
                <div class="row justify-content-center mb-5 pb-3">
                    <div
                        class="col-md-7 text-center heading-section heading-section-white ftco-animate"
                    >
                        <h2 class="mb-4">Some fun facts</h2>
                        <span class="subheading"
                            >More than 100,000 websites hosted</span
                        >
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <div class="row">
                            <div
                                class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate"
                            >
                                <div class="block-18 text-center">
                                    <div class="text">
                                        <strong
                                            class="number"
                                            data-number="100000"
                                            >0</strong
                                        >
                                        <span>Happy Customers</span>
                                    </div>
                                </div>
                            </div>
                            <div
                                class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate"
                            >
                                <div class="block-18 text-center">
                                    <div class="text">
                                        <strong
                                            class="number"
                                            data-number="40000"
                                            >0</strong
                                        >
                                        <span>Destination Places</span>
                                    </div>
                                </div>
                            </div>
                            <div
                                class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate"
                            >
                                <div class="block-18 text-center">
                                    <div class="text">
                                        <strong
                                            class="number"
                                            data-number="87000"
                                            >0</strong
                                        >
                                        <span>Hotels</span>
                                    </div>
                                </div>
                            </div>
                            <div
                                class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate"
                            >
                                <div class="block-18 text-center">
                                    <div class="text">
                                        <strong
                                            class="number"
                                            data-number="56400"
                                            >0</strong
                                        >
                                        <span>Restaurant</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section> -->

        <section class="ftco-section testimony-section bg-light">
            <div class="container">
                <div class="row justify-content-start">
                    <div class="col-md-5 heading-section ftco-animate">
                        <span class="subheading">Best Directory Website</span>
                        <h2 class="mb-4 pb-3">
                            <strong>Why</strong> Choose Us?
                        </h2>
                        <p>
                            Far far away, behind the word mountains, far from
                            the countries Vokalia and Consonantia, there live
                            the blind texts. Separated they live in
                            Bookmarksgrove right at the coast of the Semantics,
                            a large language ocean.
                        </p>
                        <p>
                            Even the all-powerful Pointing has no control about
                            the blind texts it is an almost unorthographic life.
                        </p>
                        <p>
                            <a
                                href="#"
                                class="btn btn-primary btn-outline-primary mt-4 px-4 py-3"
                                >Read more</a
                            >
                        </p>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-6 heading-section ftco-animate">
                        <span class="subheading">Testimony</span>
                        <h2 class="mb-4 pb-3">
                            <strong>Our</strong> Guests Says
                        </h2>
                        <div class="row ftco-animate">
                            <div class="col-md-12">
                                <div class="carousel-testimony owl-carousel">
                                    <div class="item">
                                        <div class="testimony-wrap d-flex">
                                            <div
                                                class="user-img mb-5"
                                                style="
                                                    background-image: url(images/person_1.jpg);
                                                "
                                            >
                                                <span
                                                    class="quote d-flex align-items-center justify-content-center"
                                                >
                                                    <i
                                                        class="icon-quote-left"
                                                    ></i>
                                                </span>
                                            </div>
                                            <div class="text ml-md-4">
                                                <p class="mb-5">
                                                    Far far away, behind the
                                                    word mountains, far from the
                                                    countries Vokalia and
                                                    Consonantia, there live the
                                                    blind texts.
                                                </p>
                                                <p class="name">Dennis Green</p>
                                                <span class="position"
                                                    >Guest from italy</span
                                                >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="testimony-wrap d-flex">
                                            <div
                                                class="user-img mb-5"
                                                style="
                                                    background-image: url(images/person_2.jpg);
                                                "
                                            >
                                                <span
                                                    class="quote d-flex align-items-center justify-content-center"
                                                >
                                                    <i
                                                        class="icon-quote-left"
                                                    ></i>
                                                </span>
                                            </div>
                                            <div class="text ml-md-4">
                                                <p class="mb-5">
                                                    Far far away, behind the
                                                    word mountains, far from the
                                                    countries Vokalia and
                                                    Consonantia, there live the
                                                    blind texts.
                                                </p>
                                                <p class="name">Dennis Green</p>
                                                <span class="position"
                                                    >Guest from London</span
                                                >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="testimony-wrap d-flex">
                                            <div
                                                class="user-img mb-5"
                                                style="
                                                    background-image: url(images/person_3.jpg);
                                                "
                                            >
                                                <span
                                                    class="quote d-flex align-items-center justify-content-center"
                                                >
                                                    <i
                                                        class="icon-quote-left"
                                                    ></i>
                                                </span>
                                            </div>
                                            <div class="text ml-md-4">
                                                <p class="mb-5">
                                                    Far far away, behind the
                                                    word mountains, far from the
                                                    countries Vokalia and
                                                    Consonantia, there live the
                                                    blind texts.
                                                </p>
                                                <p class="name">Dennis Green</p>
                                                <span class="position"
                                                    >Guest from
                                                    Philippines</span
                                                >
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                    stroke="#eeeeee"
                />
                <circle
                    class="path"
                    cx="24"
                    cy="24"
                    r="22"
                    fill="none"
                    stroke-width="4"
                    stroke-miterlimit="10"
                    stroke="#F96D00"
                />
            </svg>
        </div>

        <script src="/CA1-Preparation/js/jquery.min.js"></script>
        <script src="/CA1-Preparation/js/jquery-migrate-3.0.1.min.js"></script>
        <script src="/CA1-Preparation/js/popper.min.js"></script>
        <script src="/CA1-Preparation/js/bootstrap.min.js"></script>
        <script src="/CA1-Preparation/js/jquery.easing.1.3.js"></script>
        <script src="/CA1-Preparation/js/jquery.waypoints.min.js"></script>
        <script src="/CA1-Preparation/js/jquery.stellar.min.js"></script>
        <script src="/CA1-Preparation/js/owl.carousel.min.js"></script>
        <script src="/CA1-Preparation/js/jquery.magnific-popup.min.js"></script>
        <script src="/CA1-Preparation/js/aos.js"></script>
        <script src="/CA1-Preparation/js/jquery.animateNumber.min.js"></script>
        <script src="/CA1-Preparation/js/bootstrap-datepicker.js"></script>
        <script src="/CA1-Preparation/js/jquery.timepicker.min.js"></script>
        <script src="/CA1-Preparation/js/scrollax.min.js"></script>
        <script src="/CA1-Preparation/js/main.js"></script>
    </body>
</html>
