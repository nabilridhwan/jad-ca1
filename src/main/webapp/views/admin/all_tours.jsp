<!-- 
	Name: Nabil Ridhwanshah Bin Rosli , Xavier Tay Cher Yew
	Admin No: P2007421, P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 -->

<!DOCTYPE html>
<%@page import="models.TourModel"%>
<%@page import="dataStructures.Tour"%>
<%@page import="dataStructures.Category"%>
<%@page import="models.CategoryModel"%>
<%@page import="utils.DatabaseConnection"%>
<%@ page import="utils.Util"%>
<html lang="en">

<head>
<title>Admin Page</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Alex+Brush"
	rel="stylesheet" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/open-iconic-bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/animate.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/owl.carousel.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/owl.theme.default.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/magnific-popup.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/aos.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/ionicons.min.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap-datepicker.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery.timepicker.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/flaticon.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/icomoon.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
</head>

<body>

	<%@ include file="../misc/navbar_dark.jsp"%>


	<!-- Categories -->
	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row justify-content-start mb-5 pb-3">
				<div class="col-md-7 heading-section ftco-animate">
					<span class="subheading">Administrator</span>
					<h2 class="mb-4">
						<strong>Categories</strong>
					</h2>

					<a
						href="${pageContext.request.contextPath}/views/admin/add_category.jsp"
						class="btn btn-primary"> Add Category </a>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">

				<%
				Util.forceAdmin(session, response);
				DatabaseConnection connection = new DatabaseConnection();
				Category[] categories = CategoryModel.getCategoriesWithListingCount().query(connection);

				if (categories != null)
					for (Category category : categories) {
						int id = category.getCategory_id();
						String image = category.getImage();
						String category_name = category.getCategory_name();
						String desc = category.getDesc();
						int count = category.getCount();
				%>
				<!-- Start Card -->
				<div class="col-sm col-md-2 ftco-animate">
					<div class="item">
						<div class="destination">
							<a href="#"
								class="img d-flex justify-content-center align-items-center"
								style="
                                background-image: url(<%=image%>">
								<div
									class="icon d-flex justify-content-center align-items-center">
									<span class="icon-search2"></span>
								</div>
							</a>
							<div class="text p-3">
								<h3>
									<a href="#"><%=category_name%> </a>
								</h3>
								<span class="listing"><%=desc%></span> <span class="listing"><%=count%>
									Listing</span>
							</div>

							<div class="row my-3">
								<div class="col-md-12">
									<a
										href="${pageContext.request.contextPath}/views/admin/edit_category.jsp?id=<%=id %>"
										class="btn btn-primary w-100 mb-1"> Edit </a> <a
										href="${pageContext.request.contextPath}/deleteCategory?id=<%=id %>"
										class="btn btn-secondary w-100"> Delete </a>
								</div>
							</div>


						</div>
					</div>
				</div>
				<!-- End Card -->
				<%
				}
				%>


			</div>
		</div>
	</section>

	<!-- Tour Packages -->
	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row justify-content-start mb-5 pb-3">
				<div class="col-md-7 heading-section ftco-animate">
					<span class="subheading">Administrator</span>
					<h2 class="mb-4">
						<strong>Tours</strong>
					</h2>

					<a href="./edit_tour.jsp?tourId=new" class="btn btn-primary">
						Add Tour </a>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">

				<%
				Tour[] tours = TourModel.getAllTours().query(connection);
				connection.close();

				if (tours != null)
					for (Tour tour : tours) {
						int tour_id = tour.getTour_id();
						Tour.Image tour_image = tour.getFirstOrDefaultImage();
						String tour_name = tour.getTour_name();
						String tour_brief_desc = tour.getTour_brief_desc();
						Tour.Date tour_date = tour.getFirstOrDefaultDate();
						Tour.Review[] reviews = tour.getReviews();
						double rating = tour.getAverage_rating();
						String tour_location = tour.getTour_location();
				%>

				<div class="col-sm col-md-2 ftco-animate">
					<div class="destination">

						<a
							href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id %>"
							class="img img-2 d-flex justify-content-center align-items-center"
							style="background-image: url(<%=tour_image.getUrl()%>);">
							<div
								class="icon d-flex justify-content-center align-items-center">
								<span class="icon-search2"></span>
							</div>
						</a>


						<div class="text p-3">
							<div class="d-flex">
								<div class="one">
									<h3>
										<a
											href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id %>"><%=tour_name%>
										</a>
									</h3>

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
										<span><%=rating%> Rating <%--                                                (<%=reviews.length%> review(s))--%>
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
									<span class="price">$<%=tour_date.getPrice()%></span>
								</div>
							</div>

							<p>
								<%=tour_brief_desc%>
							</p>

							<p class="days"><%=tour_date.getDuration()%></p>

							<hr />
							<p class="bottom-area d-flex">
								<span><i class="icon-map-o"></i> <%=tour_location%></span>
							</p>

							<div class="row my-3">
								<div class="col-md-12">

									<%
									if (tour.getDates().length > 0) {
									%>
									<a href="./userRegistrations.jsp?tourId=<%=tour_id%>"
										class="btn btn-primary w-100  mb-1"> View registered users
									</a>
									<%
									}
									%>


									<a href="./edit_tour.jsp?tourId=<%=tour_id%>"
										class="btn btn-primary w-100  mb-1"> Edit </a> <a
										href="./edit_tour.jsp?tourId=<%=tour_id%>&delete="
										class="btn btn-secondary w-100"> Delete </a>
								</div>

							</div>
						</div>
					</div>
				</div>




				<!--End Card-->
				<%
				}
				%>
			</div>
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

	<footer class="ftco-footer ftco-bg-dark ftco-section">
		<div class="container">
			<div class="row mb-5">
				<div class="col-md">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">dirEngine</h2>
						<p>Far far away, behind the word mountains, far from the
							countries Vokalia and Consonantia, there live the blind texts.</p>
						<ul
							class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
							<li class="ftco-animate"><a href="#"><span
									class="icon-twitter"></span></a></li>
							<li class="ftco-animate"><a href="#"><span
									class="icon-facebook"></span></a></li>
							<li class="ftco-animate"><a href="#"><span
									class="icon-instagram"></span></a></li>
						</ul>
					</div>
				</div>
				<div class="col-md">
					<div class="ftco-footer-widget mb-4 ml-md-5">
						<h2 class="ftco-heading-2">Information</h2>
						<ul class="list-unstyled">
							<li><a href="#" class="py-2 d-block">About</a></li>
							<li><a href="#" class="py-2 d-block">Service</a></li>
							<li><a href="#" class="py-2 d-block">Terms and
									Conditions</a></li>
							<li><a href="#" class="py-2 d-block">Become a partner</a></li>
							<li><a href="#" class="py-2 d-block">Best Price
									Guarantee</a></li>
							<li><a href="#" class="py-2 d-block">Privacy and Policy</a>
							</li>
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
								<li><span class="icon icon-map-marker"></span><span
									class="text">203 Fake St. Mountain View, San Francisco,
										California, USA</span></li>
								<li><a href="#"><span class="icon icon-phone"></span><span
										class="text">+2 392 3929 210</span></a></li>
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
						<script>
							document.write(new Date().getFullYear());
						</script>
						All rights reserved | This template is made with <i
							class="icon-heart" aria-hidden="true"></i> by <a
							href="https://colorlib.com" target="_blank">Colorlib</a>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
        <circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
        <circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" />
    </svg>
	</div>

	<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.stellar.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/aos.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.animateNumber.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/bootstrap-datepicker.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.timepicker.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/scrollax.min.js"></script>

	<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>