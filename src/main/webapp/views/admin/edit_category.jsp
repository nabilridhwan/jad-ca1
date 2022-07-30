<!-- 
	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 -->

<!DOCTYPE html>
<%@page import="dataStructures.Category"%>
<%@page import="models.CategoryModel"%>
<%@page import="utils.Util"%>
<html lang="en">
<head>
<title>Edit Category</title>
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


	<%@ include file="../misc/navbar.jsp"%>

	<%
	int userID = Util.getUserID(session);
	if (userID == -1) {
		response.sendRedirect("/CA1-Preparation/views/index.jsp");
		return;
	}

	if (!Util.isUserAdmin(userID)) {
		response.sendRedirect("/CA1-Preparation/views/index.jsp");
		return;
	}

	// Get the category_id from parameter
	String category_id = request.getParameter("id");

	if (category_id == null || category_id.isEmpty()) {
		response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
		return;
	}

	DatabaseConnection connection = new DatabaseConnection();

	// Get the category from the database
	Category[] categories = CategoryModel.getCategoryFromId(category_id).query(connection);
	connection.close();

	if (categories == null || categories.length == 0) {
		response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
		return;
	}

	Category cat = categories[0];

	String category_name = cat.getCategory_name();
	String category_desc = cat.getDesc();
	String category_img = cat.getImage();
	%>

	<div class="hero-wrap"
		style="background-image: url('${pageContext.request.contextPath}/images/bg_2.jpg')">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row no-gutters js-fullheight align-items-center justify-content-center"
				data-scrollax-parent="true">
				<section
					class="ftco-section contact-section ftco-degree-bg bg-white rounded">
					<div class="container px-5">
						<div class="row d-flex contact-info">
							<div class="col-md-12 mb-4">
								<h2 class="h4">
									Edit
									<%=category_name%>
									category
								</h2>
							</div>
							<div class="w-100"></div>
							<div class="col-md-12">
								<p class="text-danger">
									<%
									String message = request.getParameter("message") != null ? request.getParameter("message") : "";
									%>
									<%=message%>
								</p>
							</div>
						</div>

						<div class="row block-9">
							<div class="col-md-12">

								<img width="300" src="<%=category_img%>" />


								<form action="${pageContext.request.contextPath}/editCategory"
									method="POST" enctype="multipart/form-data">

									<input hidden="true" type="text" class="form-control"
										name="category_id" value="<%=category_id%>" />

									<div class="form-group">
										<input type="file" class="form-control" id="file_url"
											name="file" />
									</div>



									<div class="form-group">
										<input type="text" class="form-control"
											placeholder="Category Name" name="category_name"
											value="<%=category_name%>" required />
									</div>
									<div class="form-group">
										<input type="text" name="category_desc" class="form-control"
											placeholder="Description" value="<%=category_desc%>" required />
									</div>
									<div class="form-group">
										<input type="submit" value="Save"
											class="btn w-100 btn-primary py-3 px-5" />
									</div>
								</form>
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
                <circle class="path-bg" cx="24" cy="24" r="22"
				fill="none" stroke-width="4" stroke="#eeeeee" />
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


	<script src="https://widget.cloudinary.com/v2.0/global/all.js"
		type="text/javascript"></script>


</body>
</html>
