package dataStructures;

import models.TourModel;
import utils.DatabaseConnection;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Calendar;

public class Tour {
    int tour_id;
    String tour_name;
    String tour_brief_desc;
    String tour_desc;
    String tour_location;
    Image[] images;
    Date[] dates;
    double average_rating;
    Review[] reviews;

    public Tour(ResultSet rs) {
        try {
            tour_id = rs.getInt("tour_id");
            tour_name = rs.getString("name");
            tour_brief_desc = rs.getString("brief_desc");
            tour_desc = rs.getString("detail_desc");
            tour_location = rs.getString("location");
            refreshTour();
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

    public String getTour_desc() {
        return tour_desc;
    }

    public String getTour_location() {
        return tour_location;
    }


    public Date[] getDates() {
        return dates;
    }

    public Image[] getImages() {
        return images;
    }

    public double getAverage_rating() {
        return average_rating;
    }

    public Review[] getReviews() {
        return reviews;
    }

    public void refreshTour(DatabaseConnection conn) {
        dates = TourModel.getTourDates(this).query(conn);
        images = TourModel.getTourImages(this).query(conn);
        reviews = TourModel.getTourReviews(this).query(conn);
        average_rating = TourModel.getTourReviewAverage(this).query(conn)[0];
    }

    public void refreshTour() {
        DatabaseConnection DB = new DatabaseConnection();
        refreshTour(DB);
        DB.close();
    }

    public static class Image {
        String altText;
        String url;

        public Image(ResultSet rs) {
            try {
                altText = rs.getString("alt_text");
                url = rs.getString("url");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public String getAltText() {
            return altText;
        }

        public String getUrl() {
            return url;
        }
    }

    public static class Date {
        int id;

        public int getId() {
            return id;
        }

        Timestamp start;
        Timestamp end;
        boolean shown;
        double price;
        int avail_slot;
        int max_slot;

        public Date(ResultSet rs) {
            try {
                id = rs.getInt("tour_date_id");
                start = rs.getTimestamp("tour_start");
                end = rs.getTimestamp("tour_end");
                shown = rs.getBoolean("show_tour");
                price = rs.getDouble("price");
                avail_slot = rs.getInt("avail_slot");
                max_slot = rs.getInt("max_slot");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public Timestamp getStart() {
            return start;
        }

        public String getStartString() {
            return ParseTimeStamp(start);
        }

        public Timestamp getEnd() {
            return end;
        }

        public String getEndString() {
            return ParseTimeStamp(end);
        }

        private static String ParseTimeStamp(Timestamp timestamp) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(timestamp);
            //2 digit
            int day = calendar.get(Calendar.DAY_OF_MONTH);
            String month = calendar.getDisplayName(Calendar.MONTH, Calendar.LONG, java.util.Locale.getDefault());
            int year = calendar.get(Calendar.YEAR);
            int hour = calendar.get(Calendar.HOUR_OF_DAY);
            int minute = calendar.get(Calendar.MINUTE);
            return String.format("%02d", day) + " " + month + " " + year + " " + String.format("%02d", hour) + ":" + String.format("%02d", minute);
        }

        public boolean isShown() {
            return shown;
        }

        public double getPrice() {
            return price;
        }

        public int getAvail_slot() {
            return avail_slot;
        }

        public int getMax_slot() {
            return max_slot;
        }
    }

    public static class Review {
        int user_id;
        String review_text;
        int rating;
        int helpful_score;

        public Review(ResultSet rs) {
            try {
                user_id = rs.getInt("user_id");
                review_text = rs.getString("text");
                rating = rs.getInt("rating");
                helpful_score = rs.getInt("score");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public int getUser_id() {
            return user_id;
        }

        public String getReview_text() {
            return review_text;
        }

        public int getRating() {
            return rating;
        }

        public int getHelpful_score() {
            return helpful_score;
        }
    }
}
