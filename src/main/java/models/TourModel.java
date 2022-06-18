package models;

import dataStructures.Tour;
import utils.IDatabaseQuery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TourModel {

    public static IDatabaseQuery<Tour> getUniqueToursByLowestPriceFirst() {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT t.*, a.price, b.url, b.alt_text\r\n"
                        + "FROM tour t"
                        + "LEFT JOIN ("
                        + "	SELECT DISTINCT t.name, td.tour_id, td.price"
                        + "    FROM tour_date td"
                        + "    LEFT JOIN tour t ON td.tour_id = t.tour_id"
                        + "    WHERE td.show_tour = 1"
                        + "    ORDER BY td.price"
                        + ") a ON a.tour_id = t.tour_id"
                        + "LEFT JOIN ("
                        + "	SELECT DISTINCT tti.tour_id, ti.alt_text, ti.url"
                        + "    FROM tour_tour_image tti"
                        + "    LEFT JOIN tour_image ti ON ti.tour_image_id = tti.tour_image_id"
                        + ") b  ON b.tour_id = t.tour_id LIMIT 5;");
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
                PreparedStatement pstmt = conn.prepareStatement("SELECT t.*, a.price, b.url, b.alt_text\r\n"
                        + "FROM tour t"
                        + "LEFT JOIN ("
                        + "	SELECT DISTINCT t.name, td.tour_id, td.price"
                        + "    FROM tour_date td"
                        + "    LEFT JOIN tour t ON td.tour_id = t.tour_id"
                        + "    WHERE td.show_tour = 1"
                        + ") a ON a.tour_id = t.tour_id"
                        + "LEFT JOIN ("
                        + "	SELECT DISTINCT tti.tour_id, ti.alt_text, ti.url"
                        + "    FROM tour_tour_image tti"
                        + "    LEFT JOIN tour_image ti ON ti.tour_image_id = tti.tour_image_id"
                        + ") b  ON b.tour_id = t.tour_id LIMIT 5;"
                        + "WHERE t.tour_id = ?;");

                pstmt.setInt(1, tourId);
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

}
