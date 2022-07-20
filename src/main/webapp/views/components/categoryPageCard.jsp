<%@ page import="dataStructures.Category" %>
<%
    Category category = (Category) request.getAttribute("category");
    if(category == null) return;
    String image = category.getImage();
    String category_name = category.getCategory_name();
    String desc = category.getDesc();
    int count = category.getCount();
%>
<div class="item">
    <div class="destination">
        <a
                href="${pageContext.request.contextPath}/views/tour/categories.jsp?category_name=<%= category_name %>"
                class="img d-flex justify-content-center align-items-center"
                style="background-image: url(<%=image %>);"
        >
            <div class="icon d-flex justify-content-center align-items-center">
                <span class="icon-search2"></span>
            </div>
        </a>
        <div class="text p-3">
            <h3>
                <a href="${pageContext.request.contextPath}/views/tour/categories.jsp?category_name=<%= category_name %>"><%=category_name%>
                </a></h3>
            <span class="listing"><%=desc%></span>

            <br/>
            <span class="listing"><%=count%> Listing</span>
        </div>
    </div>
</div>