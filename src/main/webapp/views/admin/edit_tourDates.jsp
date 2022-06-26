<!DOCTYPE html>
<%@page import="utils.Util" %>
<%@ page import="models.TourModel" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="utils.DatabaseConnection" %>
<html lang="en">
<head>
    <title>DirEngine - Free Bootstrap 4 Template by Colorlib</title>
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


<%@ include file="../misc/navbar_dark.jsp" %>

<%

    Util.forceAdmin(session, response);

    // Get the category_id from parameter
    String tourDateIdStr = request.getParameter("tourDateId");
    String tourIdStr = request.getParameter("tourId");


    if (tourDateIdStr == null || tourDateIdStr.isEmpty()) {
        response.sendRedirect("/CA1-Preparation/views/admin/edit_tour.jsp?tourId=" + tourIdStr);
        return;
    }
    DatabaseConnection connection = new DatabaseConnection();
    Tour.Date[] tourDates;
    int tourId = Integer.parseInt(tourIdStr);
    Tour[] tours = TourModel.getTourById(tourId).query(connection);
    if (tours.length != 1) {
        response.sendRedirect("/CA1-Preparation/views/admin/edit_tour.jsp");
        return;
    }
    Tour tour = tours[0];

    if (tourDateIdStr.equals("new")) {
        tourDates = new Tour.Date[1];
        tourDates[0] = new Tour.Date();
    } else {
        int tourDate_id = Integer.parseInt(tourDateIdStr);
        // Get the category from the database
        tourDates = TourModel.getTourDateById(tourDate_id).query(connection);

        if (request.getParameter("delete") != null) {
            //Double check if the user really wants to delete the category use an alert box
            if (request.getParameter("delete").equals("confirm")) {
                TourModel.deleteTourDate(tourDate_id).update(connection);
                response.sendRedirect("/CA1-Preparation/views/admin/edit_tour.jsp?tourId=" + tourId);
                return;
            }
%>
<script>
    //message box to confirm deletion
    let x = confirm("Are you sure you want to delete this tour date?");
    if (x) {
        window.location.href = "/CA1-Preparation/views/admin/edit_tourDates.jsp?tourId=<%=tourId%>&tourDateId=<%=tourDate_id%>&delete=confirm";
    } else {
        window.location.href = "/CA1-Preparation/views/admin/edit_tourDates.jsp?tourId=<%=tourId%>";
    }
</script>
<%
        }
    }


    if (tourDates == null || tourDates.length == 0) {
        response.sendRedirect("/CA1-Preparation/views/admin/edit_tour.jsp?tourId=" + tourId);
        return;
    }

    Tour.Date tourDate = tourDates[0];
%>

<div class="hero-wrap" style="background-image: url('${pageContext.request.contextPath}/images/bg_2.jpg')">
    <div class="overlay"></div>
    <div class="container">
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
                            <h2 class="h4">Edit tour Date for <%=tour.getTour_name()%>  <%=tourDate%>
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

                            <form action="${pageContext.request.contextPath}/editTourDate" method="POST">

									<input
                                            class="form-control"
                                            hidden
                                            name="dateId"
                                            type="text"
                                            value="<%=tourDate.getId() %>"
                                    />
                                    
                                    <input
                                            class="form-control"
                                            hidden
                                            name="id"
                                            type="text"
                                            value="<%=tour.getTour_id()%>"
                                    />


                                <div class="form-group">
                                    <label> Start Date</label>
                                        <input
                                                type="text"
                                                class="form-control"
                                                placeholder="start"
                                                name="start"
                                                value="<%=tourDate.getStart() %>"
                                        />
                                    
                                </div>
                                <div class="form-group">
                                    <label> End Date</label>
                                        <input
                                                type="text"
                                                class="form-control"
                                                placeholder="end"
                                                name="end"
                                                value="<%=tourDate.getEnd() %>"
                                        />
                                    
                                </div>

                                <div class="form-group">
                                    <label> Price</label>
                                        <input
                                                type="number"
                                                class="form-control"
                                                placeholder="Price"
                                                name="price"
                                                min="0"
                                                step="0.1"
                                                value="<%=tourDate.getPrice()%>"
                                                required
                                        />
                                    
                                </div>
                                <div class="form-group">
                                    <label> Available Slots</label>
                                        <input
                                                type="number"
                                                name="emptySlots"
                                                class="form-control"
                                                placeholder="Available Slots"
                                                value="<%=tourDate.getAvail_slot() %>"
                                                required/>
                                    
                                </div>
                                <div class="form-group">
                                    <label> Max Slots</label>
                                        <input
                                                type="number"
                                                name="slots"
                                                class="form-control"
                                                placeholder="Max Slots"
                                                min="0"
                                                value="<%=tourDate.getMax_slot() %>"
                                                required/>
                                    
                                </div>
                                
                                <h5>Tour Date Visibility</h5>
                                <div class="form-check">
                                        <input
                                                type="checkbox"
                                                id="shown"
                                                name="shown"
                                                class="form-check-input"
                                                placeholder="Visible?"
                                                value="shown"
                                                checked="<%=tourDate.isShown() %>"
                                        />
                                        <label class="form-check-label" for="shown"> Make tour date visible</label>
                                    
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