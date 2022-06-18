package models;

import dataStructures.Category;
import utils.IDatabaseQuery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CategoryModel {

    public static IDatabaseQuery<Category> getCategoriesWithListingCount() {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT c.*, a.count\r\n"
                        + "FROM category c\r\n"
                        + "LEFT JOIN (\r\n"
                        + "	SELECT tc.category_id, COUNT(tc.category_id) AS count\r\n"
                        + "    FROM tour_category tc\r\n"
                        + "    LEFT JOIN tour t ON tc.tour_id = t.tour_id\r\n"
                        + "    LEFT JOIN category c ON tc.category_id = c.category_id\r\n"
                        + "    GROUP BY tc.category_id\r\n"
                        + ") a ON a.category_id = c.category_id;");
                ResultSet rs = pstmt.executeQuery();

                ArrayList<Category> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Category(rs));

                return list.toArray(new Category[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Category> getCategoryFromName(String name) {
        return databaseConnection -> {
            if (name == null) return null;
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM category WHERE name = ?;");
                pstmt.setString(1, name);
                ResultSet rs = pstmt.executeQuery();

                ArrayList<Category> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new Category(rs));

                return list.toArray(new Category[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

}