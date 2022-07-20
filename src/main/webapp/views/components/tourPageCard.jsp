<!--
Name: Xavier Tay Cher Yew
Admin No: P2129512
Class: DIT/FT/2A/01
Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
-->
<%@ page import="dataStructures.Tour" %>

<%--tour card--%>
<%
    Tour tour = (Tour) request.getAttribute("tour");
    if(tour == null) return;
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
                href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id%>"
                class="img img-2 d-flex justify-content-center align-items-center"
                style="background-image: url(<%=tour_image.getUrl() %>)"
        >
            <div
                    class="icon d-flex justify-content-center align-items-center"
            >
                <span class="icon-search2"></span>
            </div>
        </a>

        <div class="text p-3">
            <div class="d-flex">
                <div class="one">
                    <h3>
                        <a href="${pageContext.request.contextPath}/views/tour/detail.jsp?tour_id=<%=tour_id %>"><%=tour_name %>
                        </a></h3>
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
                        <span><%=rating%> Rating
<%--                                                (<%=reviews.length%> review(s))--%>
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

            <hr/>
            <p class="bottom-area d-flex">
                <span><i class="icon-map-o"></i> <%=tour_location %></span>

            </p>
        </div>
    </div>
</div>