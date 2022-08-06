<!-- 
	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 -->

<!DOCTYPE html>
<%@page import="com.stripe.exception.StripeException"%>
<%@page import="com.stripe.model.PaymentMethod"%>
<%@page import="com.stripe.model.PaymentIntent"%>
<%@page import="payment.StripePayment"%>
<%@page import="models.TourModel"%>
<%@page import="dataStructures.Tour"%>
<html lang="en">
<head>
<title>Transaction Details</title>
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
	// Check if userID is null
	int userID = Util.forceLogin(session, response);

	String transaction_id = request.getParameter("transaction_id");

	if (transaction_id == null) {
		response.sendRedirect(request.getContextPath() + "/views/user/profile.jsp");
		return;
	}

	DatabaseConnection connection = new DatabaseConnection();

	// Get tour_registration from the id
	Tour.Registrations[] registrations = TourModel.getTourRegistrationByTransactionId(transaction_id).query(connection);

	if (registrations.length == 0) {
		response.sendRedirect(request.getContextPath() + "/views/user/profile.jsp");
		return;
	}

	Tour.Registrations registration = registrations[0];

	// Check if the registration's user id is equal to the current user id
	if (registration.getUser_id() != userID) {
		response.sendRedirect(request.getContextPath() + "/views/user/profile.jsp");
		return;
	}

	User[] users = UserModel.getUserByUserID(userID).query(connection);

	if (users == null) {
		response.sendRedirect("./login.jsp?error=sql_error");
		return;
	}

	if (users.length != 1) {
		response.sendRedirect("./login.jsp");
		return;
	}
	User user = users[0];
	//			Get the user ID
	String fullName = user.getFullName();
	String email = user.getEmail();
	String phone = user.getPhone();
	String address_1 = user.getAddress1();
	String address_2 = user.getAddress2();
	String apt_suite = user.getAptSuite();
	String postal_code = user.getPostalCode();

	PaymentIntent transaction;
	PaymentMethod paymentMethod;

	try {
		transaction = StripePayment.retrievePayment(registration.getStripe_transaction_id());
		paymentMethod = StripePayment.retrievePaymentMethod(transaction.getPaymentMethod());
	} catch (StripeException se) {
		response.sendRedirect(request.getContextPath() + "/views/user/profile.jsp");
		return;
	}
	%>

	<%@ include file="../misc/navbar.jsp"%>


	<div class="hero-wrap"
		style="background-image: url('${pageContext.request.contextPath}/images/bg_2.jpg')">
		<div class="overlay"></div>
		<div class="container" style="padding: 7em 0">
			<div
				class="row no-gutters js-fullheight align-items-center justify-content-center"
				data-scrollax-parent="true">
				<section
					class="ftco-section contact-section ftco-degree-bg bg-white rounded">
					<div class="container px-5">
						<div class="row d-flex contact-info">
							<div class="col-md-12 mb-4 text-center">
								<h2 class="h3 font-weight-bold">Transaction Details</h2>
							</div>
							<div class="w-100"></div>
						</div>

						<div class="row block-9">
							<div class="col-md-12">
								<div class="details">
									<h6>Customer Name</h6>
									<p><%=fullName%></p>
								</div>

								<div class="details">
									<h6>Customer Email</h6>
									<p><%=email%></p>
								</div>

								<div class="details">
									<h6>Customer Phone Number</h6>
									<p><%=phone%></p>
								</div>

								<div class="details">
									<h6>Customer Address</h6>
									<p><%=address_1 + " " + address_2 + " " + apt_suite + " " + postal_code%></p>
								</div>

								<div class="details">
									<h6>Transaction ID</h6>
									<p><%=transaction.getId()%></p>
								</div>

								<div class="details">
									<h6>Payment Method</h6>

									<p><%=paymentMethod.getType().toUpperCase()%></p>
									<p>
										****
										<%=paymentMethod.getCard().getLast4()%></p>
								</div>

								<div class="details">
									<h6>Status</h6>
									<p><%=transaction.getStatus()%></p>
								</div>

								<div class="details">
									<h6>Amount</h6>
									<p><%=transaction.getCurrency().toUpperCase() + " " + (transaction.getAmount() / 100)%></p>
								</div>

								<div class="details">
									<h6>Date Created</h6>
									<p><%=registration.getCreatedAt()%></p>
								</div>
							</div>
							<!-- <div class="col-md-6" id="map"></div> -->
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>

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
