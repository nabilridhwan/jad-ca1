package models;

import java.sql.*;
import java.util.ArrayList;

import dataStructures.Tour;
import utils.IDatabaseQuery;

public class TourModel {

    public static IDatabaseQuery<Tour> getUniqueToursByLowestPriceFirst() {
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
    
    public static IDatabaseQuery<Tour> getAllTours() {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT t.*, a.price, b.url, b.alt_text\r\n"
                		+ "FROM sp_tour.tour t\r\n"
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
    
    public static IDatabaseQuery<Tour> getTourByName(String name) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT t.*, a.price, b.url, b.alt_text\r\n"
                		+ "FROM sp_tour.tour t\r\n"
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

}
