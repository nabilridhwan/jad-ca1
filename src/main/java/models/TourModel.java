package models;

import dataStructures.Category;
import dataStructures.Tour;
import utils.IDatabaseQuery;
import utils.IDatabaseUpdate;

import javax.xml.crypto.Data;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TourModel {

    public static IDatabaseQuery<Tour> getUniqueToursByLowestPriceFirst() {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("SELECT t.*, a.price, b.url, b.alt_text\r\n"
                        + " FROM tour t"
                        + " LEFT JOIN ("
                        + " 	SELECT DISTINCT t.name, td.tour_id, td.price"
                        + "     FROM tour_date td"
                        + "     LEFT JOIN tour t ON td.tour_id = t.tour_id"
                        + "     WHERE td.show_tour = 1"
                        + "     ORDER BY td.price"
                        + " ) a ON a.tour_id = t.tour_id"
                        + " LEFT JOIN ("
                        + " 	SELECT DISTINCT tti.tour_id, ti.alt_text, ti.url"
                        + "     FROM tour_tour_image tti"
                        + "     LEFT JOIN tour_image ti ON ti.tour_image_id = tti.tour_image_id"
                        + " ) b  ON b.tour_id = t.tour_id LIMIT 5;");
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour> getTourById(String tourId) {
        try {
            int id = Integer.parseInt(tourId);
            return getTourById(id);
        } catch (Exception e) {
            return null;
        }
    }

    public static IDatabaseQuery<Tour> getTourById(int tourId) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("SELECT * FROM tour WHERE tour_id = ?;");

                prepStatement.setInt(1, tourId);
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour.Date> getTourDates(Tour tour) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("SELECT *" +
                        " FROM tour_date" +
                        " WHERE tour_id = ?;"
                );

                prepStatement.setInt(1, tour.getTour_id());
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Date> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Tour.Date(rs));

                return list.toArray(new Tour.Date[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour.Image> getTourImages(Tour tour) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("SELECT *" +
                        " FROM tour_image ti,tour_tour_image tti" +
                        " WHERE tti.tour_id = ? AND tti.tour_image_id = ti.tour_image_id;");

                prepStatement.setInt(1, tour.getTour_id());
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Image> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Tour.Image(rs));

                return list.toArray(new Tour.Image[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }


    public static IDatabaseQuery<Tour> getAllTours() {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT t.*, a.price, b.url, b.alt_text\r\n"
                        + "FROM tour t\r\n"
                        + "LEFT JOIN (\r\n"
                        + "	SELECT DISTINCT t.name, td.tour_id, td.price\r\n"
                        + "    FROM tour_date td\r\n"
                        + "    LEFT JOIN tour t ON td.tour_id = t.tour_id\r\n"
                        + "    WHERE td.show_tour = 1\r\n"
                        + "    ORDER BY td.price\r\n"
                        + ") a ON a.tour_id = t.tour_id\r\n"
                        + "LEFT JOIN (\r\n"
                        + "	SELECT DISTINCT tti.tour_id, ti.alt_text, ti.url\r\n"
                        + "    FROM tour_tour_image tti\r\n"
                        + "    LEFT JOIN tour_image ti ON ti.tour_image_id = tti.tour_image_id\r\n"
                        + ") b  ON b.tour_id = t.tour_id;");
                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }


    public static IDatabaseQuery<Tour.Review> getTourReviews(Tour tour) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM review WHERE tour_id = ?");
                pstmt.setInt(1, tour.getTour_id());
                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour.Review> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Tour.Review(rs));

                return list.toArray(new Tour.Review[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Double> getTourReviewAverage(Tour tour) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT AVG(rating) FROM review WHERE tour_id = ?");
                pstmt.setInt(1, tour.getTour_id());
                ResultSet rs = pstmt.executeQuery();

                Double[] average = new Double[1];
                rs.next();
                average[0] = rs.getDouble(1);
//                if (rs != null) while (rs.next()) list.add(rs.ge);

                return average;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour> getTourByName(String name) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT t.*, a.price, b.url, b.alt_text\r\n"
                        + "FROM tour t\r\n"
                        + "LEFT JOIN (\r\n"
                        + "	SELECT DISTINCT t.name, td.tour_id, td.price\r\n"
                        + "    FROM tour_date td\r\n"
                        + "    LEFT JOIN tour t ON td.tour_id = t.tour_id\r\n"
                        + "    WHERE td.show_tour = 1\r\n"
                        + "    ORDER BY td.price\r\n"
                        + ") a ON a.tour_id = t.tour_id\r\n"
                        + "LEFT JOIN (\r\n"
                        + "	SELECT DISTINCT tti.tour_id, ti.alt_text, ti.url\r\n"
                        + "    FROM tour_tour_image tti\r\n"
                        + "    LEFT JOIN tour_image ti ON ti.tour_image_id = tti.tour_image_id\r\n"
                        + ") b  ON b.tour_id = t.tour_id\r\n"
                        + "WHERE t.name LIKE '%" + name + "%'\r\n"
                        + ";");
                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseUpdate registerUserForTour(int userID, int tourDateID, int pax) {
        IDatabaseUpdate addUserToTour = databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO tour_registration (user_id, tour_date_id) VALUES (?, ?)");
                pstmt.setInt(1, userID);
                pstmt.setInt(2, tourDateID);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
        IDatabaseUpdate addPaxToTour = databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("UPDATE tour_date SET avail_slot = avail_slot - ? WHERE tour_date_id = ?");
                pstmt.setInt(1, pax);
                pstmt.setInt(2, tourDateID);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
        return databaseConnection -> {
            if (addUserToTour.update(databaseConnection) == 1 &&
                    addPaxToTour.update(databaseConnection) == 1) return 1;
            return -1;
        };
    }

    public static IDatabaseQuery<Tour> getToursFromCategory(Category category) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement preparedStatement = conn.prepareStatement(
                        "SELECT t.*  FROM tour t,tour_category tc WHERE t.tour_id = tc.tour_id And tc.category_id = ?;");
                preparedStatement.setInt(1, category.getCategory_id());
                ResultSet resultSet = preparedStatement.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (resultSet != null) while (resultSet.next()) list.add(new Tour(resultSet));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }
}
