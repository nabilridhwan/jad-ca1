package dataStructures;

import java.sql.ResultSet;

public class Tour { //implements IPreviewCard {
    int tour_id;
    String tour_name;
    String tour_brief_desc;
    double tour_price;
    String tour_image_url;
    String tour_image_alt_text;
    String tour_location;

    public Tour(ResultSet rs) {
        try {
            tour_id = rs.getInt("tour_id");
            tour_name = rs.getString("name");
            tour_brief_desc = rs.getString("brief_desc");
            tour_price = rs.getDouble("price");
            tour_image_url = rs.getString("url");
            tour_image_alt_text = rs.getString("alt_text");
            tour_location = rs.getString("location");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getTour_id() {
        return tour_id;
    }

    public String getTour_name() {
        return tour_name;
    }

    public String getTour_brief_desc() {
        return tour_brief_desc;
    }

    public double getTour_price() {
        return tour_price;
    }

    public String getTour_image_url() {
        return tour_image_url;
    }

    public String getTour_image_alt_text() {
        return tour_image_alt_text;
    }

    public String getTour_location() {
        return tour_location;
    }

//    @Override
//    public String GenerateCard() {
//        return "            <div class=\"col-sm col-md-6 col-lg ftco-animate\">\n" +
//                "                <div class=\"destination\">\n" +
//                "\n" +
//                "                    <a\n" +
//                "                            href=\"#\"\n" +
//                "                            class=\"img img-2 d-flex justify-content-center align-items-center\"\n" +
//                "                            style=\"\n" +
//                "                                    background-image: url(<%=tour_image_url %>);\n" +
//                "                                    \"\n" +
//                "                    >\n" +
//                "                        <div\n" +
//                "                                class=\"icon d-flex justify-content-center align-items-center\"\n" +
//                "                        >\n" +
//                "                            <span class=\"icon-search2\"></span>\n" +
//                "                        </div>\n" +
//                "                    </a>\n" +
//                "\n" +
//                "                    <div class=\"text p-3\">\n" +
//                "                        <div class=\"d-flex\">\n" +
//                "                            <div class=\"one\">\n" +
//                "                                <h3><a href=\"#\"><%=tour_name %>\n" +
//                "                                </a></h3>\n" +
//                "                                <p class=\"rate\">\n" +
//                "                                    <i class=\"icon-star\"></i>\n" +
//                "                                    <i class=\"icon-star\"></i>\n" +
//                "                                    <i class=\"icon-star\"></i>\n" +
//                "                                    <i class=\"icon-star\"></i>\n" +
//                "                                    <i class=\"icon-star-o\"></i>\n" +
//                "                                    <span>8 Rating</span>\n" +
//                "                                </p>\n" +
//                "                            </div>\n" +
//                "                            <div class=\"two\">\n" +
//                "                                <span class=\"price\">$<%=tour_price %></span>\n" +
//                "                            </div>\n" +
//                "                        </div>\n" +
//                "                        <p>\n" +
//                "                            <%=tour_brief_desc %>\n" +
//                "                        </p>\n" +
//                "                        <p class=\"days\"><span>2 days 3 nights</span></p>\n" +
//                "                        <hr/>\n" +
//                "                        <p class=\"bottom-area d-flex\"> \\\n" +
//                "                            <span><i class=\"icon-map-o\"></i> <%=tour_location %></span>\n" +
//                "\n" +
//                "                        </p>\n" +
//                "                    </div>\n" +
//                "                </div>\n" +
//                "            </div>";
//    }
}
