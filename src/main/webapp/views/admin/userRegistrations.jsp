<!-- 
	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 -->

<!DOCTYPE html>
<%@page import="utils.Util"%>
<%@ page import="models.TourModel"%>
<%@ page import="dataStructures.Tour"%>
<%@ page import="utils.DatabaseConnection"%>
<%@ page import="java.util.Arrays" %>
<html lang="en">
<head>
<title>Registrations</title>
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
		Util.forceAdmin(session, response);

		int tourId = -1;
		int tourDateId = -1;
		String tourIdStr = request.getParameter("tourId");
		String tourDateIdStr = request.getParameter("tourDateId");

		if (tourIdStr == null || tourIdStr.isEmpty()) {
			response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
			return;
		}

		try {
			tourId = Integer.parseInt(tourIdStr);
		} catch (NumberFormatException e) {
			response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
			return;
		}
		try {
			if (tourDateIdStr != null && !tourDateIdStr.isEmpty()) tourDateId = Integer.parseInt(tourDateIdStr);
		} catch (NumberFormatException ignored) {
		}

		if (tourId < 0) {
			response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
			return;
		}

		DatabaseConnection connection = new DatabaseConnection();

		Tour.Date selectedDate = null;
		Tour.Date[] dates = TourModel.getTourDates(tourId).query(connection);
		if (tourDateId < 0) {
			//use the first date
			tourDateId = dates[0].getId();
			selectedDate = dates[0];
		} else {
			for (Tour.Date date : dates) {
				if (date.getId() == tourDateId) {
					selectedDate = date;
					break;
				}
			}
		}


		Tour.Registrations[] tourRegistrations = TourModel.getTourRegistrationsByTourDate(tourDateId).query(connection);

		if (tourRegistrations == null) {
			response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
			return;
		}
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
					<div class="nav-item dropdown" style="margin: 25%; outline: #0b0b0b;">
						<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button"
						   aria-haspopup="true" aria-expanded="false" style="margin: auto; outline: #0b0b0b;">
							<%=selectedDate.getStartString() + " - " + selectedDate.getEndString()%>
						</a>
						<div class="dropdown-menu">
							<%--					dropdown--%>
							<%
								//dropdown menu with tour dates as values
								for (Tour.Date date : dates) {
									if (date.getId() == tourDateId) continue;
									String dateStr = date.getStartString() + " - " + date.getEndString();
									String dateUrl = "?tourId=" + tourId + "&tourDateId=" + date.getId();
							%>
							<a href="${pageContext.request.contextPath}/views/admin/userRegistrations.jsp<%=dateUrl%>"
							   class="dropdown-item"><%=dateStr%>
							</a>
							<%
								}
							%>
						</div>
					</div>
					<div class="container px-5 ">
						<div class="row d-flex contact-info">
							<div class="col-md-12 mb-4">
								<h2 class="h3">Registrations</h2>
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


							<%
								if (tourRegistrations.length == 0) {
							%>
							<div class="col-md-12">

								<div class="card">
									<div class="card-body">
										<h5>There are no registrations for this tour</h5>
									</div>
								</div>

							</div>
							<%
							} else {
								for (Tour.Registrations tourRegistration : tourRegistrations) {
							%>
							<div class="col-md-12">

								<div class="card">
									<div class="card-body">


										<%
											int userId = tourRegistration.getUser_id();

											User[] users = UserModel.getUserByUserID(userId).query(connection);

											if (users == null || users.length == 0) {
										%>

										<p>Problem Loading User</p>

										<%
										} else {
											User user = users[0];
										%>


										<h5><%=user.getFullName()%>
										</h5>
										<p class="muted font-bold text-bold bold">
											Email:
											<%=user.getEmail()%>
										</p>
										<p class="muted">
											Pax:
											<%=tourRegistration.getPax()%>
										</p>

										<p class="muted">
											Transaction ID:
											<%=tourRegistration.getStripe_transaction_id()%>
										</p>

										<a class="btn btn-primary"
										   href="${pageContext.request.contextPath}/views/admin/transaction_details.jsp?tourDateId=<%=tourDateId %>&transaction_id=<%=tourRegistration.getStripe_transaction_id()%>">
											View transaction details </a>
									</div>
								</div>

							</div>
							<%
										}
									}
								}
							%>
							<!-- <div class="col-md-6" id="map"></div> -->
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
					stroke-width="4" stroke="#eeeeee"></circle>
			<circle class="path" cx="24" cy="24" r="22" fill="none"
					stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"></circle>
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

<%
	connection.close();
%>