<!DOCTYPE html>
<%@page import="utils.Util" %>
<%@ page import="models.TourModel" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="utils.DatabaseConnection" %>
<html lang="en">
<head>
    <title>Edit Tour</title>
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
    String tour_idStr = request.getParameter("tourId");


    if (tour_idStr == null || tour_idStr.isEmpty()) {
        response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
        return;
    }
    DatabaseConnection connection = new DatabaseConnection();
    Tour[] tours;
    if (tour_idStr.equals("new")) {
        tours = new Tour[1];
        tours[0] = new Tour();
    } else {
        int tour_id = Integer.parseInt(tour_idStr);
        // Get the category from the database
        tours = TourModel.getTourById(tour_id).query(connection);

        if (request.getParameter("delete") != null) {
            //Double check if the user really wants to delete the category use an alert box
            if (request.getParameter("delete").equals("confirm")) {
                TourModel.deleteTour(tour_id).update(connection);
                response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
                return;
            }
%>
<script>
    //message box to confirm deletion
    let x = confirm("Are you sure you want to delete this tour?");
    if (x) {
        window.location.href = "/CA1-Preparation/views/admin/edit_tour.jsp?tourId=<%=tour_id%>&delete=confirm";
    } else {
        window.location.href = "/CA1-Preparation/views/admin/all_tours.jsp";
    }
</script>
<%
        }
    }


    if (tours == null || tours.length == 0) {
        response.sendRedirect("/CA1-Preparation/views/admin/all_tours.jsp");
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
                <div class="container px-5 ">
                    <div class="row d-flex contact-info">
                        <div class="col-md-12 mb-4">
                            <%
                                String headerText = tour_idStr.equals("new") ? "Add Tour" : "Edit " + tour.getTour_name() + " tour";
                            %>
                            <h2 class="h3"><%=headerText%>
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
                            <%
                                if (tour.getTour_id() != 0) {
//new tours won't be able to see this.
                            %>
                            <h4>
                                Tour Categories
                            </h4>
                            <div class="col-lg-12 my-3">
                                <a href="./edit_tourCategories.jsp?tourId=<%=tour.getTour_id()%>"
                                   class="btn btn-primary">
                                    Edit Categories
                                </a>
                            </div>

                            <h4>
                                Tour Images
                            </h4>
                            <div class="col-lg-12 my-3">
                                <a href="./edit_tourImages.jsp?tourId=<%=tour.getTour_id()%>&tourImageId=new"
                                   class="btn btn-primary">
                                    Add Image
                                </a>
                            </div>


                            <div class="col-md-4 ftco-animate">
                                <%
                                    Tour.Image[] images = tour.getImages();
                                    for (Tour.Image image : images) {
                                %>
                                <div class="destination">
                                    <div class="text p-3">
                                        <p>

                                            <img class="img-fluid" src="<%=image.getUrl()%>"
                                                 alt="<%=image.getAltText()%>">
                                            Alt text: <%=image.getAltText()%>
                                        </p>

                                        <div class="row my-3">
                                            <div class="col-md-12">
                                                <a href="./edit_tourImages.jsp?tourId=<%=tour.getTour_id()%>&tourImageId=<%=image.getId()%>"
                                                   class=" btn btn-primary w-100 mb-1">
                                                    Edit
                                                </a>

                                                <a href="./edit_tourImages.jsp?tourId=<%=tour.getTour_id()%>&tourImageId=<%=image.getId()%>&delete="
                                                   class="btn btn-secondary w-100">
                                                    Delete
                                                </a>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <%
                                    }
                                %>
                            </div>

                            <h4>
                                Tour Dates
                            </h4>


                            <div class="col-lg-12 my-3">
                                <a href="./edit_tourDates.jsp?tourId=<%=tour.getTour_id()%>&tourDateId=new"
                                   class="btn btn-primary">
                                    Add Tour Date
                                </a>
                            </div>

                            <div class="col-md-4 ftco-animate">
                                <%
                                    Tour.Date[] dates = tour.getDates();
                                    for (Tour.Date date : dates) {
                                %>
                                <div class="destination">
                                    <div class="text p-3">
                                        <p><%=date %>
                                        </p>
                                        <div class="two">
                                            <span class="price">$<%=date.getPrice() %></span>
                                        </div>
                                        <hr>
                                        <p class="bottom-area d-flex">
                                            <span><i
                                                    class="icon-map-o"></i> Slots <%=date.getAvail_slot() %>/<%=date.getMax_slot()%></span>
                                        </p>
                                        <div class="row my-3">
                                            <div class="col-md-12">
                                                <a href="./edit_tourDates.jsp?tourId=<%=tour.getTour_id()%>&tourDateId=<%=date.getId()%>"
                                                   class=" btn btn-primary w-100 mb-1">
                                                    Edit
                                                </a>

                                                <a href="./edit_tourDates.jsp?tourId=<%=tour.getTour_id()%>&tourDateId=<%=date.getId()%>&delete="
                                                   class="btn btn-secondary w-100">
                                                    Delete
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%
                                    }
                                %>
                            </div>
                            <%
                                }
                            %>

                            <h4>
                                Tour Details
                            </h4>

                            <form action="${pageContext.request.contextPath}/editTour" method="POST">


                                <input
                                        class="form-control"
                                        hidden
                                        name="id"
                                        type="text"
                                        value="<%=tour.getTour_id() %>"
                                />

                                <div class="form-group">

                                    <input
                                            type="text"
                                            class="form-control"
                                            placeholder="Tour Name"
                                            name="name"
                                            value="<%=tour.getTour_name() %>"
                                    />

                                </div>
                                <div class="form-group">

                                    <input
                                            type="text"
                                            class="form-control"
                                            placeholder="Brief Description"
                                            name="bDesc"
                                            value="<%=tour.getTour_brief_desc() %>"
                                    />

                                </div>

                                <div class="form-group">

                                    <input
                                            type="text"
                                            class="form-control"
                                            placeholder="Description"
                                            name="desc"
                                            value="<%=tour.getTour_desc() %>"
                                            required
                                    />

                                </div>
                                <div class="form-group">

                                    <input
                                            type="text"
                                            name="location"
                                            class="form-control"
                                            placeholder="Location"
                                            value="<%=tour.getTour_location() %>"
                                            required/>

                                </div>
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