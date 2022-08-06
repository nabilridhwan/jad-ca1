<!-- 
	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 -->

<!DOCTYPE html>
<%@page import="utils.DatabaseConnection"%>
<%@page import="models.UserModel"%>
<%@page import="dataStructures.User"%>
<%@page import="utils.Util"%>
<html lang="en">
<head>
<title>Admin - Edit User</title>
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
	<!-- END nav -->

	<%
	String errorMessage = request.getParameter("message") != null ? request.getParameter("message") : "";
	// Force admin
	Util.forceAdmin(session, response);

	String user_id = request.getParameter("user_id");

	if (user_id == null || user_id.isEmpty()) {
		response.sendRedirect(request.getContextPath() + "/views/admin/all_users.jsp");
		return;
	}

	// Database Connection
	DatabaseConnection connection = new DatabaseConnection();

	// Get the user
	User[] users = UserModel.getUserByUserID(Integer.parseInt(user_id)).query(connection);
	if (users.length == 0) {
		response.sendRedirect(request.getContextPath() + "/views/admin/all_users.jsp");
		return;
	}

	User user = users[0];

	String fullName = user.getFullName();
	String profilePicUrl = user.getPfpUrl();
	String email = user.getEmail();

	String phone = user.getPhone();
	String address_1 = user.getAddress1();
	String address_2 = user.getAddress2();
	String apt_suite = user.getAptSuite();
	String postal_code = user.getPostalCode();

	String role = user.getRole();
	%>

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
								<h2 class="h3 font-weight-bold">Edit your profile</h2>

								<img src="<%=profilePicUrl%>" alt="Image"
									class="rounded-circle img-fluid" width="150" />

								<h2 class="h4"><%=fullName%></h2>
							</div>
							<div class="w-100"></div>

						</div>

						<div class="row block-9">
							<div class="col-md-12">
								<form
									action="${pageContext.request.contextPath}/admin_modify_user"
									method="POST">

									<input type="text" class="form-control" placeholder="Full Name"
										name="user_id" value="<%=user_id%>" hidden />

									<h2 class="h5">Details</h2>

									<div class="form-group">
										<label for="name">Profile Picture URL</label> <input
											type="text" class="form-control" placeholder="URL"
											name="image" value="<%=profilePicUrl%>" />
									</div>

									<div class="form-group">
										<label for="name">Full Name</label> <input type="text"
											class="form-control" placeholder="Full Name" name="name"
											value="<%=fullName%>" />
									</div>

									<div class="form-group">
										<label for="email">Email</label> <input type="email"
											class="form-control" placeholder="Email" name="email"
											value="<%=email%>" />
									</div>

									<div class="form-group">
										<label for="email">Phone</label> <input type="text"
											class="form-control" placeholder="Phone" name="phone"
											value="<%=phone%>" />
									</div>

									<div class="form-group">
										<label for="email">Address 1</label> <input type="text"
											class="form-control" placeholder="Address 1" name="address_1"
											value="<%=address_1%>" />
									</div>

									<div class="form-group">
										<label for="email">Address 2</label> <input type="text"
											class="form-control" placeholder="Address 2" name="address_2"
											value="<%=address_2%>" />
									</div>

									<div class="form-group">
										<label for="email">Apt/Suite</label> <input type="text"
											class="form-control" placeholder="Apt/Suite" name="apt_suite"
											value="<%=apt_suite%>" />
									</div>

									<div class="form-group">
										<label for="email">Postal Code</label> <input type="text"
											class="form-control" placeholder="Postal Code"
											name="postal_code" value="<%=postal_code%>" />
									</div>

									<div class="form-group">
										<label for="role">Role</label> <select class="form-control"
											id="role" name="role">
											<option value="user"
												<%=role.equals("user") ? "selected" : ""%>>User</option>
											<option value="admin"
												<%=role.equals("admin") ? "selected" : ""%>>Admin</option>
										</select>
									</div>

									<h2 class="h5">Change your password</h2>

									<div class="col-md-12 error">
										<p class="text-danger"><%=errorMessage%></p>
									</div>

									<div class="alert alert-danger" role="alert">Only change
										the password when required!</div>

									<div class="form-group">
										<label for="password">New Password</label> <input
											type="password" class="form-control" placeholder="Password"
											name="password" />
									</div>

									<div class="form-group">
										<label for="confirm_password">Confirm Password</label> <input
											type="password" class="form-control"
											placeholder="Confirm Password" name="confirm_password" />
									</div>

									<!-- Button Buttons -->


									<div class="form-group">
										<input type="submit" value="Save User"
											class="btn w-100 btn-primary py-3 px-5" />

									</div>
								</form>

								<form action="${pageContext.request.contextPath}/delete_user"
									method="post">
									<input type="text" class="form-control" placeholder="Full Name"
										name="user_id" value="<%=user_id%>" hidden />

									<div class="form-group">
										<input type="submit" value="Delete User"
											class="btn w-100 btn-secondary py-3 px-5" />
									</div>
								</form>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>

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
