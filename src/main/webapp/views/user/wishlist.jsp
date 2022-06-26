<!DOCTYPE html>
<%@page import="models.TourModel"%>
<%@page import="dataStructures.Tour"%>
<%@page import="utils.DatabaseConnection"%>
<%@page import="dataStructures.Wishlist"%>
<%@page import="models.WishlistModel"%>
<%@page import="utils.Util"%>
<html lang="en">
    <head>
        <title>Wishlist</title>
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
    		int user_id = Util.getUserID(session);
    	
	    	if (user_id == -1) {
	            response.sendRedirect("./login.jsp");
	            return;
	        }
    	%>
    
        <%@ include file="../misc/navbar_dark.jsp" %>

        <section class="ftco-section bg-light">
            <div class="container">
                <div class="row justify-content-start mb-5 pb-3">
                    <div class="col-md-7 heading-section ftco-animate">
                        <span class="subheading">Wishlist</span>
                        <h2 class="mb-4">
                            <strong>Your wishlist tours</strong>
                        </h2>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                
                	<%
                		DatabaseConnection connection = new DatabaseConnection();
                	
                		Wishlist[] wishlistItems = WishlistModel.getUserWishlistItems(user_id).query(connection);
                		
                		if(wishlistItems.length == 0){%>
                			<h3>No wishlist tours :(</h3>
                		<%}else{
                			for(Wishlist wishlistItem : wishlistItems){
                				// Get the tour_id
                				
                				int wishlist_id = wishlistItem.getWishlist_id();
                				int tour_id = wishlistItem.getTour_id();
                				
                				// For each of the tour id, query the tour
                				
                				Tour[] tours = TourModel.getTourById(tour_id).query(connection);
                				
                				// Get the first tour
                				
                				Tour tour = tours[0];
                				
                				// Get details of the tour
		                        String tour_image_url = tour.getImages()[0].getUrl();
		                        String tour_name = tour.getTour_name();
		                        String tour_brief_desc = tour.getTour_brief_desc();
		                        Tour.Date tour_date = tour.getDates()[0];
		                        double tour_price = tour_date.getPrice();
		                        String tour_location = tour.getTour_location();
		                        %>
		                                  <!-- Begin Card -->
						                <div class="col-sm col-md-4 ftco-animate">
						                    <div class="destination">
						                        <a href="/CA1-Preparation/views/tour/detail.jsp?tour_id=<%=tour_id%>" class="img img-2 d-flex justify-content-center align-items-center" style="
						                                    background-image: url(<%=tour_image_url%>);
						                                ">
						                            <div class="icon d-flex justify-content-center align-items-center">
						                                <span class="icon-search2"></span>
						                            </div>
						                        </a>
						                        <div class="text p-3">
						                            <div class="d-flex">
						                                <div class="one">
						                                    <h3><a href="/CA1-Preparation/views/tour/detail.jsp?tour_id=<%=tour_id%>"><%=tour_name %></a></h3>
						                                </div>
						                                <div class="two">
						                                    <span class="price">$<%=tour_price %></span>
						                                </div>
						                            </div>
						                            <p>
						                                <%=tour_brief_desc %>
						                            </p>
						
						                            <hr />
						                            <p class="bottom-area d-flex">
						                                <span><i class="icon-map-o"></i> <%=tour_location %></span>
						                            </p>
						
						                            <div class="row my-3">
						                                <div class="col-md-12">
						                                    <a href="${pageContext.request.contextPath}/removeWishlist?wishlist_id=<%=wishlist_id %>" class="btn btn-primary w-100">
						                                        Remove
						                                    </a>
						                                </div>
						
						                            </div>
						                        </div>
						                    </div>
						                </div>
						                <!--End Card-->
		                        
                			<%}
                			
                			connection.close();
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
