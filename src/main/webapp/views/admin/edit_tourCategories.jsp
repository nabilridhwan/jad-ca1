<!-- 
	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 -->

<!DOCTYPE html>
<%@page import="utils.Util" %>
<%@ page import="models.TourModel" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="utils.DatabaseConnection" %>
<%@ page import="dataStructures.Category" %>
<%@ page import="models.CategoryModel" %>
<html lang="en">
<head>
    <title>Edit Tour Category</title>
    <meta charset="utf-8"/>
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


<%@ include file="../misc/navbar.jsp" %>

<%

    Util.forceAdmin(session, response);

    // Get the category_id from parameter
    String tourIdStr = request.getParameter("tourId");


    DatabaseConnection connection = new DatabaseConnection();
    int tourId = Integer.parseInt(tourIdStr);
    Tour[] tours = TourModel.getTourById(tourId).query(connection);
    if (tours.length != 1) {
        response.sendRedirect("/CA1-Preparation/views/admin/edit_tour.jsp");
        return;
    }
    Tour tour = tours[0];

%>

<div class="hero-wrap" style="background-image: url('${pageContext.request.contextPath}/images/bg_2.jpg')">
    <div class="overlay"></div>
    <div class="container" style="padding: 7em 0">
        <div
                class="row no-gutters js-fullheight align-items-center justify-content-center"
                data-scrollax-parent="true"
        >
            <section
                    class="ftco-section contact-section ftco-degree-bg bg-white rounded"
            >
                <div class="container px-5">
                    <div class="row d-flex contact-info">
                        <div class="col-md-12 mb-4">
                            <h2 class="h4">Edit tour image for <%=tour.getTour_name()%>
                            </h2>
                        </div>
                        <div class="w-100"></div>
                        <div class="col-md-12">
                            <p class="text-danger">
                                <%String message = request.getParameter("message") != null ? request.getParameter("message") : ""; %>
                                <%=message %>
                            </p>
                        </div>
                    </div>

                    <div class="row block-9">
                        <div class="col-md-12">

                            <form action="${pageContext.request.contextPath}/editTourCategory" method="POST">

                                <label>
                                    <input
                                            class="form-control"
                                            hidden
                                            name="id"
                                            type="text"
                                            value="<%=tour.getTour_id()%>"
                                    />
                                </label>

                                <h5>Tour Categories</h5>
                                <%
                                    Category[] includedCategories = CategoryModel.getAllCategoriesInTour(tour).query(connection);
                                    for (Category category : includedCategories) {
                                %>
                                <div class="form-check">
                                    <input
                                            checked
                                            class="form-check-input"
                                            id="incCategory"
                                            name="category<%=category.getCategory_id()%>"
                                            type="checkbox"
                                    />
                                    <label for="incCategory">
                                        <%=category.getCategory_name()%>
                                    </label>

                                </div>
                                <%
                                    }
                                    Category[] excludedCategories = CategoryModel.getAllCategoriesExcludedInTour(tour).query(connection);
                                    for (Category category : excludedCategories) {
                                %>
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            id="excCategory"
                                            name="category<%=category.getCategory_id()%>"
                                            type="checkbox"
                                    />
                                    <label for="excCategory">
                                        <%=category.getCategory_name()%>
                                    </label>

                                </div>
                                <%
                                    }
                                %>


                                <div class="form-group">
                                    <input
                                            type="submit"
                                            value="Save"
                                            class="btn w-100 btn-primary py-3 px-5"
                                    />
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
<script src="${pageContext.request.contextPath}/js/scrollax.min.js"></script>

<script src="${pageContext.request.contextPath}/js/main.js"></script>

</body>
</html>

<%
    connection.close();
%>