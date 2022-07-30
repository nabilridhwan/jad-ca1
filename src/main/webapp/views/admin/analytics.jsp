<!DOCTYPE html>
<%@page import="models.TourModel"%>
<%@page import="dataStructures.Tour"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="utils.Util"%>
<%@page import="utils.DatabaseConnection"%>
<html lang="en">
<head>
<title>Admin - Analytics/Report</title>
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


	<%
	Util.forceAdmin(session, response);
	String q = request.getParameter("search") != null ? request.getParameter("search") : "";
	%>


	<%
	DatabaseConnection connection = new DatabaseConnection();
	String sql = "SELECT u.user_id, u.full_name, profile_pic_url, email, phone, SUM(td.price * tr.pax) AS total_amount FROM tour_registration tr LEFT JOIN tour_date td ON tr.tour_date_id = td.tour_date_id LEFT JOIN `user` u ON tr.user_id = u.user_id GROUP BY tr.user_id ORDER BY total_amount DESC LIMIT 10;";
	System.out.println(sql);
	PreparedStatement pstmt = connection.get().prepareStatement(sql);
	ResultSet usersRs = pstmt.executeQuery();
	%>

	<%@ include file="../misc/navbar_dark.jsp"%>
	<!-- END nav -->




	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row justify-content-start mb-5 pb-3">
				<div class="col-md-7 heading-section ftco-animate">
					<span class="subheading">Report</span>
					<h2 class="mb-4">
						<strong>Best Selling Tours</strong>
					</h2>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">

				<%
                    Tour[] bestSellingTours = TourModel.getBestSellingTours(5).query(connection);
                

                if (bestSellingTours != null)
                    for (Tour tour : bestSellingTours) {
                        int tour_id = tour.getTour_id();
                        Tour.Image tour_image = tour.getFirstOrDefaultImage();
                        String tour_name = tour.getTour_name();
                        String tour_brief_desc = tour.getTour_brief_desc();
                        Tour.Date tour_date = tour.getFirstOrDefaultDate();
                        String tour_location = tour.getTour_location();
                        Tour.Review[] reviews = tour.getReviews();
                        double rating = tour.getAverage_rating();
            %>
				<div class="col-sm col-md-6 col-lg ftco-animate">
					<div class="destination">

						<a
							href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour.getTour_id()%>"
							class="img img-2 d-flex justify-content-center align-items-center"
							style="background-image: url(<%=tour_image.getUrl() %>)">
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
											href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id %>"><%=tour_name %>
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
									<span class="price">$<%=tour_date.getPrice() %></span>
								</div>
							</div>
							<p>
								<%=tour_brief_desc %>
							</p>

							<hr />
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



	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row justify-content-start mb-5 pb-3">
				<div class="col-md-7 heading-section ftco-animate">
					<span class="subheading">Report</span>
					<h2 class="mb-4">
						<strong>Worst Selling Tours</strong>
					</h2>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">

				<%
                    Tour[] tours = TourModel.getWorstSellingTours(5).query(connection);
                

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
            %>
				<div class="col-sm col-md-6 col-lg ftco-animate">
					<div class="destination">

						<a
							href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour.getTour_id()%>"
							class="img img-2 d-flex justify-content-center align-items-center"
							style="background-image: url(<%=tour_image.getUrl() %>)">
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
											href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id %>"><%=tour_name %>
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
									<span class="price">$<%=tour_date.getPrice() %></span>
								</div>
							</div>
							<p>
								<%=tour_brief_desc %>
							</p>

							<hr />
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

	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row justify-content-start mb-5 pb-3">
				<div class="col-md-7 heading-section ftco-animate">
					<span class="subheading">Report</span>
					<h2 class="mb-4">
						<strong>Low Slot Tours</strong>
					</h2>

					<p class="muted text-bold">Showing tours with below 5 slots
						available</p>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">

				<%
                    Tour[] lowSlotTours = TourModel.getLowSlotTours(5).query(connection);
                

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
            %>
				<div class="col-sm col-md-6 col-lg ftco-animate">
					<div class="destination">

						<a
							href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour.getTour_id()%>"
							class="img img-2 d-flex justify-content-center align-items-center"
							style="background-image: url(<%=tour_image.getUrl() %>)">
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
											href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id %>"><%=tour_name %>
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
									<span class="price">$<%=tour_date.getPrice() %></span>
								</div>
							</div>
							<p>
								<%=tour_brief_desc %>
							</p>

							<hr />
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

	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row justify-content-start mb-5 pb-3">
				<div class="col-md-7 heading-section ftco-animate">
					<span class="subheading">Report</span>
					<h2 class="mb-4">
						<strong>Top Customers</strong>
					</h2>

					<p class="muted text-bold">Showing top customers by money spent
					</p>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<%
				while (usersRs.next()) {
					int user_id = usersRs.getInt("user_id");
					String full_name = usersRs.getString("full_name");
					String profile_pic_url = usersRs.getString("profile_pic_url");
					String email = usersRs.getString("email");
					double total_amount = usersRs.getDouble("total_amount");
					
				%>
				<div class="col-sm-4 col-lg-3 ftco-animate">
					<div class="card">

						<img class="card-img-top img-fluid" src="<%=profile_pic_url%>"
							alt="" />

						<div class="card-body">
							<h4 class="card-title"><%=full_name%></h4>
							<h5>
								$<%=total_amount %></h5>
							<p class="card-text muted"><%=email%></p>

							<!-- 
							
							
							<a
								href="<%=request.getContextPath()%>/views/admin/edit_user.jsp?user_id=<%=user_id%>"
								class="btn btn-primary"> Edit User </a>
								
								 -->
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