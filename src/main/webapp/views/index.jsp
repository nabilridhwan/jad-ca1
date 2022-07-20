<!--
Name: Nabil Ridhwanshah Bin Rosli
Admin No: P2007421
Class: DIT/FT/2A/01
Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
-->


<!--
Name: Xavier Tay Cher Yew
Admin No: P2129512
Class: DIT/FT/2A/01
Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
-->

<%@page import="models.CategoryModel" %>
<%@page import="models.TourModel" %>
<%@ page import="dataStructures.Category" %>
<%@ page import="dataStructures.Tour" %>
<%@ page import="utils.DatabaseConnection" %>
<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Tours R' Us</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <jsp:include page="components/stylesheets.jsp"/>
</head>
<body>

<%--   TransparentHeader param Doesnt do anything yet--%>
<jsp:include page="/views/misc/navbar.jsp">
    <jsp:param name="transparentHeader" value="true"/>
</jsp:include>
<!-- END nav -->

<div
        class="hero-wrap js-fullheight"
        style="background-image: url('${pageContext.request.contextPath}/images/bg_1.jpg')"
>
    <div class="overlay"></div>
    <div class="container">
        <div
                class="row no-gutters slider-text js-fullheight align-items-center justify-content-start"
                data-scrollax-parent="true"
        >
            <div
                    class="col-md-9 ftco-animate"
                    data-scrollax=" properties: { translateY: '70%' }"
            >
                <h1
                        class="mb-4"
                        data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"
                >
                    <strong>Explore <br/></strong> the world
                </h1>
                <p
                        data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"
                >
                    Find great places to stay, eat, shop, or visit from
                    local experts
                </p>
                <div class="block-17 my-4">
                    <form
                            action="${pageContext.request.contextPath}/views/tour/view_all.jsp"
                            method="get"
                            class="d-block d-flex"
                    >
                        <div class="fields d-block d-flex">
                            <div class="textfield-search one-third">
                                <label>
                                    <input
                                            type="text"
                                            class="form-control"
                                            placeholder="Search for tours..."
                                            name="q"
                                    />
                                </label>
                            </div>

                        </div>
                        <input
                                type="submit"
                                class="search-submit btn btn-primary"
                                value="Search"
                        />
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>


<%--This part onwards doesn't load if error--%>
<section class="ftco-section services-section bg-light">
    <div class="container">
        <div class="row d-flex">
            <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services d-block text-center">
                    <div class="d-flex justify-content-center">
                        <div class="icon">
                            <span class="flaticon-guarantee"></span>
                        </div>
                    </div>
                    <div class="media-body p-2 mt-2">
                        <h3 class="heading mb-3">
                            Best Price Guarantee
                        </h3>
                        <p>
                            With Tours R' Us, you are sure to get the best price guaranteed!
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services d-block text-center">
                    <div class="d-flex justify-content-center">
                        <div class="icon">
                            <span class="flaticon-like"></span>
                        </div>
                    </div>
                    <div class="media-body p-2 mt-2">
                        <h3 class="heading mb-3">Travellers Love Us</h3>
                        <p> With over 20000+ Travellers, we are sure to give you the best experience ever!
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services d-block text-center">
                    <div class="d-flex justify-content-center">
                        <div class="icon">
                            <span class="flaticon-detective"></span>
                        </div>
                    </div>
                    <div class="media-body p-2 mt-2">
                        <h3 class="heading mb-3">Best Travel Agent</h3>
                        <p>
                            Rated the 1st by the AOTA, we pride ourselves in being the best.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services d-block text-center">
                    <div class="d-flex justify-content-center">
                        <div class="icon">
                            <span class="flaticon-support"></span>
                        </div>
                    </div>
                    <div class="media-body p-2 mt-2">
                        <h3 class="heading mb-3">
                            Our Dedicated Support
                        </h3>
                        <p>
                            Our toll free line are there to help you with any troubles!
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="ftco-section ftco-destination">
    <div class="container">
        <div class="row justify-content-start mb-5 pb-3">
            <div class="col-md-7 heading-section ftco-animate">
                <span class="subheading">Featured</span>
                <h2 class="mb-4">
                    <strong>Featured</strong> Categories
                </h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="destination-slider owl-carousel ftco-animate">
                    <%
                        DatabaseConnection connection = new DatabaseConnection();
                        Category[] categories = CategoryModel.getCategoriesWithListingCount().query(connection);

                        if (categories != null)
                            for (Category category : categories) {
                                request.setAttribute("category", category);
                    %>
                    <jsp:include page="components/categoryPageCard.jsp"/>
                    <%
                            }
                        request.removeAttribute("category");
                    %>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="ftco-section bg-light">
    <div class="container">
        <div class="row justify-content-start mb-5 pb-3">
            <div class="col-md-7 heading-section ftco-animate">
                <span class="subheading">Special Offers</span>
                <h2 class="mb-4"><strong>Top</strong> Tour Packages</h2>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row">

            <%
                Tour[] tours = TourModel.getAllTours(5).query(connection);
                connection.close();

                if (tours != null)
                    for (Tour tour : tours) {
                        request.setAttribute("tour", tour);
            %>
            <jsp:include page="components/tourPageCard.jsp"/>
            <%
                    }
                request.removeAttribute("tour");
            %>


        </div>
    </div>
</section>

<jsp:include page="components/footer.jsp"/>

<!-- loader -->
<jsp:include page="components/loader.jsp"/>
</body>
</html>
