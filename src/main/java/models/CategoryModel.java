/*
 * 	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */


/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

package models;

import dataStructures.Category;
import dataStructures.Tour;
import utils.IDatabaseQuery;
import utils.IDatabaseUpdate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

    public static IDatabaseQuery<Category> getCategoryFromId(String id) {
        return databaseConnection -> {
            if (id == null) return null;
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM category WHERE category_id = ?;");
                pstmt.setString(1, id);
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

    public static IDatabaseQuery<Category> getAllCategories() {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM category;");
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

    public static IDatabaseUpdate removeAndReAddCategoriesToTour(int tourID, Integer[] categoryIDs) {
        IDatabaseUpdate removeCategories = databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM tour_category WHERE tour_id = ?;");
                pstmt.setInt(1, tourID);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
        IDatabaseUpdate addCategories = databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO tour_category (tour_id, category_id) VALUES (?, ?);");
                for (int categoryID : categoryIDs) {
                    pstmt.setInt(1, tourID);
                    pstmt.setInt(2, categoryID);
                    pstmt.executeUpdate();
                }
                return categoryIDs.length;
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
        return databaseConnection -> {
            int remove = removeCategories.update(databaseConnection);
            if (remove == -1) return -1;
            return addCategories.update(databaseConnection);
        };
    }

    public static IDatabaseQuery<Category> getAllCategoriesInTour(Tour tour) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT c.* " +
                                " FROM tour_category tc , category c " +
                                " WHERE tc.category_id = c.category_id AND tc.tour_id = ?");

                pstmt.setInt(1, tour.getTour_id());
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

    public static IDatabaseQuery<Category> getAllCategoriesExcludedInTour(Tour tour) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT c.* " +
                                " FROM category c " +
                                " WHERE c.category_id NOT IN (SELECT tc.category_id FROM tour_category tc WHERE tc.tour_id = ?)");

                pstmt.setInt(1, tour.getTour_id());
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


    public static IDatabaseUpdate insertNewCategory(String img_url, String name, String desc) {
        return databaseConnection -> {

            String input_img_url;


            if (img_url.isEmpty()) {
                input_img_url = null;
            } else {
                input_img_url = img_url;
            }

            if (name == null) return 0;
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO category(name, `desc`, image) VALUES(?,?,?);");
                pstmt.setString(1, name);
                pstmt.setString(2, desc);
                pstmt.setString(3, input_img_url);

                System.out.println("Inserting Category");
                System.out.println(pstmt.toString());


                int affectedRows = pstmt.executeUpdate();


                return affectedRows;
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            } finally {
                try {
                    conn.close();
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }


        };
    }

    public static IDatabaseUpdate updateCategory(String category_id, String img_url, String name, String desc) {
        return databaseConnection -> {

            String input_img_url;


            if (img_url.isEmpty()) {
                input_img_url = null;
            } else {
                input_img_url = img_url;
            }

            if (name == null) return 0;
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("UPDATE category SET name = ?, `desc` = ?, image = ? WHERE category_id = ?;");
                pstmt.setString(1, name);
                pstmt.setString(2, desc);
                pstmt.setString(3, input_img_url);
                pstmt.setString(4, category_id);

                System.out.println("Updating Category");
                System.out.println(pstmt.toString());


                int affectedRows = pstmt.executeUpdate();


                return affectedRows;
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            } finally {
                try {
                    conn.close();
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }


        };
    }

    public static IDatabaseUpdate deleteCategory(String category_id) {
        return databaseConnection -> {


            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM category WHERE category_id = ?;");
                pstmt.setString(1, category_id);


                System.out.println("Deleting Category");
                System.out.println(pstmt.toString());


                int affectedRows = pstmt.executeUpdate();


                return affectedRows;
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            } finally {
                try {
                    conn.close();
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }


        };
    }


}
