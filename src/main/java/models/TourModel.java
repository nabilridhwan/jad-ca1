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

import dataStructures.Cart;
import dataStructures.Category;
import dataStructures.Tour;
import utils.IDatabaseQuery;
import utils.IDatabaseUpdate;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;

public class TourModel {

    public static IDatabaseQuery<Tour> getUniqueToursByLowestPriceFirst() {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("SELECT t.*, a.price, b.url, b.alt_text\r\n"
                        + " FROM tour t" + " LEFT JOIN (" + " 	SELECT DISTINCT t.name, td.tour_id, td.price"
                        + "     FROM tour_date td" + "     LEFT JOIN tour t ON td.tour_id = t.tour_id"
                        + "     WHERE td.show_tour = 1" + "     ORDER BY td.price" + " ) a ON a.tour_id = t.tour_id"
                        + " LEFT JOIN (" + " 	SELECT DISTINCT tti.tour_id, ti.alt_text, ti.url"
                        + "     FROM tour_tour_image tti"
                        + "     LEFT JOIN tour_image ti ON ti.tour_image_id = tti.tour_image_id"
                        + " ) b  ON b.tour_id = t.tour_id LIMIT 5;");
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour.Registrations> getRegistrationsByTourDateId(String tour_date_id) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn
                        .prepareStatement("SELECT * FROM tour_registration WHERE tour_date_id = ?;");

                prepStatement.setString(1, tour_date_id);

                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Registrations> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Registrations(rs));

                return list.toArray(new Tour.Registrations[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour> getTourById(int tourId) {
        return databaseConnection -> {
            Client client = ClientBuilder.newClient();
            String restUrl = "http://localhost:8080/CA2-Webservices/tours";
            WebTarget target = client.target(restUrl).path("/").queryParam("id", tourId);

            Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
            Response resp = invocationBuilder.get();

            System.out.println("Web Service Response: " + resp.getStatus());
            if (resp.getStatus() != Response.Status.OK.getStatusCode()) return null;
            try {
                Tour[] tours = resp.readEntity(new GenericType<Tour[]>() {
                });
                System.out.println("Web Service Response: " + Arrays.toString(tours));
                if (tours == null) tours = new Tour[0];
                return tours;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour.Date> getTourDates(Tour tour) {
        return getTourDates(tour.getTour_id());
    }
    public static IDatabaseQuery<Tour.Date> getTourDates(int tourId) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn
                        .prepareStatement("SELECT *" + " FROM tour_date" + " WHERE tour_id = ?;");

                prepStatement.setInt(1, tourId);
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Date> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Date(rs));

                return list.toArray(new Tour.Date[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour.Date> getShownTourDates(Tour tour) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn
                        .prepareStatement("SELECT *" + " FROM tour_date" + " WHERE tour_id = ? AND show_tour = 1;");

                prepStatement.setInt(1, tour.getTour_id());
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Date> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Date(rs));

                return list.toArray(new Tour.Date[0]);
            } catch (Exception e) {
                System.out.println("Error in getShownTourDates");
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour.Image> getTourImages(Tour tour) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn
                        .prepareStatement("SELECT *" + " FROM tour_image ti,tour_tour_image tti"
                                + " WHERE tti.tour_id = ? AND tti.tour_image_id = ti.tour_image_id;");

                prepStatement.setInt(1, tour.getTour_id());
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Image> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Image(rs));

                return list.toArray(new Tour.Image[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour.Registrations> getTourRegistrationByTourDateId(Tour.Date tourDate) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn
                        .prepareStatement("SELECT *" + " FROM tour_registration tr WHERE tr.tour_date_id = ?");

                prepStatement.setInt(1, tourDate.getId());
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Registrations> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Registrations(rs));

                return list.toArray(new Tour.Registrations[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour.Image> getTourImageById(int id) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn
                        .prepareStatement("SELECT *" + " FROM tour_image " + " WHERE tour_image_id = ?;");

                prepStatement.setInt(1, id);
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Image> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Image(rs));

                return list.toArray(new Tour.Image[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour> getAllTours() {
        return databaseConnection -> {
            Client client = ClientBuilder.newClient();
            String restUrl = "http://localhost:8080/CA2-Webservices/tours";
            WebTarget target = client.target(restUrl).path("/all");

            Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
            Response resp = invocationBuilder.get();

            if (resp.getStatus() != Response.Status.OK.getStatusCode()) return null;
            try {
                Tour[] tours = resp.readEntity(new GenericType<Tour[]>() {
                });
                if (tours == null) tours = new Tour[0];
                for (Tour tour : tours) {
                    int tour_id = tour.getTour_id();
                    Tour.Image tour_image = tour.getFirstOrDefaultImage();
                    String tour_name = tour.getTour_name();
                    String tour_brief_desc = tour.getTour_brief_desc();
                    Tour.Date tour_date = tour.getFirstOrDefaultDate();
                    String tour_location = tour.getTour_location();
                    Tour.Review[] reviews = tour.getReviews();
                    double rating = tour.getAverage_rating();
                    System.out.println("Tour Details: " + tour_id + " | " + tour_name + " | " + tour_brief_desc + " | " + tour_date + " | " + tour_location + " | " + rating);
                }
                return tours;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour> getAllTours(int limit) {
        return databaseConnection -> Arrays.stream(getAllTours().query(databaseConnection)).limit(limit).toArray(Tour[]::new);
    }


    public static IDatabaseQuery<Tour.Date> getTourDateById(int tourDateID) {
        return databaseConnection -> {
            Client client = ClientBuilder.newClient();
            String restUrl = "http://localhost:8080/CA2-Webservices/tours";
            WebTarget target = client.target(restUrl).path("/date").queryParam("id", tourDateID);

            Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
            Response resp = invocationBuilder.get();
            System.out.println("Tour Date Webservice response: " + resp.getStatus());
            if (resp.getStatus() != Response.Status.OK.getStatusCode()) return null;
            try {
                Tour.Date[] tours = resp.readEntity(new GenericType<Tour.Date[]>() {
                });
                System.out.println("Tour Date Webservice tourDate: " + Arrays.toString(tours));

                if (tours == null) tours = new Tour.Date[0];
                return tours;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }


    public static IDatabaseQuery<Tour> getBestSellingTours(int limit) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT t.* FROM tour_date td\n" + "    	INNER JOIN tour t ON t.tour_id =  td.tour_id\n"
                                + "    	ORDER BY avail_slot DESC LIMIT ?;");

                pstmt.setInt(1, limit);

                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };

    }

    public static IDatabaseQuery<Tour.Registrations> getTourRegistrationByUserId(int userId) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM tour_registration WHERE user_id = ?");

                pstmt.setInt(1, userId);

                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour.Registrations> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Registrations(rs));

                return list.toArray(new Tour.Registrations[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };

    }

    public static IDatabaseQuery<Tour.Registrations> getTourRegistrationByTransactionId(String transaction_id) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn
                        .prepareStatement("SELECT * FROM tour_registration WHERE stripe_transaction_id = ?;");

                pstmt.setString(1, transaction_id);

                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour.Registrations> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Registrations(rs));

                return list.toArray(new Tour.Registrations[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };

    }

    public static IDatabaseQuery<Tour> getLowSlotTours(int below) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT t.* FROM tour_date td\n"
                        + "    	INNER JOIN tour t ON t.tour_id =  td.tour_id\n" + "    	WHERE avail_slot < ?;");

                pstmt.setInt(1, below);

                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };

    }

    public static IDatabaseQuery<Tour> getWorstSellingTours(int limit) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT t.* FROM tour_date td\n" + "    	INNER JOIN tour t ON t.tour_id =  td.tour_id\n"
                                + "    	ORDER BY avail_slot ASC LIMIT ?;");

                pstmt.setInt(1, limit);

                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour(rs));

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

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Review(rs));

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
                        + "FROM tour t\r\n" + "LEFT JOIN (\r\n" + "	SELECT DISTINCT t.name, td.tour_id, td.price\r\n"
                        + "    FROM tour_date td\r\n" + "    LEFT JOIN tour t ON td.tour_id = t.tour_id\r\n"
                        + "    WHERE td.show_tour = 1\r\n" + "    ORDER BY td.price\r\n"
                        + ") a ON a.tour_id = t.tour_id\r\n" + "LEFT JOIN (\r\n"
                        + "	SELECT DISTINCT tti.tour_id, ti.alt_text, ti.url\r\n" + "    FROM tour_tour_image tti\r\n"
                        + "    LEFT JOIN tour_image ti ON ti.tour_image_id = tti.tour_image_id\r\n"
                        + ") b  ON b.tour_id = t.tour_id\r\n" + "WHERE t.name LIKE '%" + name + "%'\r\n" + ";");
                ResultSet rs = pstmt.executeQuery();

                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    //TODO Integrate with Web Service
    public static IDatabaseUpdate registerUserForTour(int userID, int tourDateID, int pax,
                                                      String stripe_transaction_id) {
        IDatabaseUpdate addUserToTour = databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO tour_registration (user_id, tour_date_id, pax, stripe_transaction_id) VALUES (?, ?,?, ?)");
                pstmt.setInt(1, userID);
                pstmt.setInt(2, tourDateID);
                pstmt.setInt(3, pax);
                pstmt.setString(4, stripe_transaction_id);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
        IDatabaseUpdate addPaxToTour = databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn
                        .prepareStatement("UPDATE tour_date SET avail_slot = avail_slot - ? WHERE tour_date_id = ?");
                pstmt.setInt(1, pax);
                pstmt.setInt(2, tourDateID);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
        return databaseConnection -> {
            if (addUserToTour.update(databaseConnection) == 1 && addPaxToTour.update(databaseConnection) == 1)
                return 1;
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

                if (resultSet != null)
                    while (resultSet.next())
                        list.add(new Tour(resultSet));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseUpdate addReviewToTour(String tour_id, int user_id, int rating, String text) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO review (tour_id, user_id, rating, score, text) " + "VALUES (?, ?, ?, ?, ?)");
                pstmt.setString(1, tour_id);
                pstmt.setInt(2, user_id);
                pstmt.setInt(3, rating);
                pstmt.setInt(4, 0);
                pstmt.setString(5, text);

                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseQuery<Tour.Registrations> getTourRegistrations(int userID, int tourID) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("" + "SELECT tr.* "
                        + "FROM tour_registration tr,tour_date td  "
                        + "WHERE tr.user_id = ? AND td.tour_id = ? AND tr.stripe_transaction_id != '' AND tr.tour_date_id = td.tour_date_id");
                pstmt.setInt(1, userID);
                pstmt.setInt(2, tourID);

                ResultSet rs = pstmt.executeQuery();
                ArrayList<Tour.Registrations> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Registrations(rs));

                return list.toArray(new Tour.Registrations[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<Tour> getTourRegistrationsByUser(int userID) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT DISTINCT T.* "
                        + "FROM tour_registration tr, tour t, tour_date td "
                        + "WHERE tr.user_id = ? AND tr.tour_date_id = td.tour_date_id AND td.tour_id = t.tour_id");
                pstmt.setInt(1, userID);

                ResultSet rs = pstmt.executeQuery();
                ArrayList<Tour> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour(rs));

                return list.toArray(new Tour[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseUpdate deleteTour(int tour_id) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM tour WHERE tour_id = ?");
                pstmt.setInt(1, tour_id);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseQuery<Integer> getPaxForTour(int userID, int tourDataID) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT pax FROM tour_registration WHERE user_id = ? AND tour_date_id = ? AND stripe_transaction_id != ''");
                pstmt.setInt(1, userID);
                pstmt.setInt(2, tourDataID);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    Integer[] pax = new Integer[1];
                    pax[0] = rs.getInt(1);
                    return pax;
                }
                return new Integer[0];
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseUpdate insertNewTour(String tourName, String briefDesc, String description,
                                                String location) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO tour (name, brief_desc, detail_desc, location) " + "VALUES (?, ?, ?, ?)");
                pstmt.setString(1, tourName);
                pstmt.setString(2, briefDesc);
                pstmt.setString(3, description);
                pstmt.setString(4, location);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate updateTour(int tourID, String tourName, String briefDesc, String description,
                                             String location) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "UPDATE tour SET name = ?, brief_desc = ?, detail_desc = ?, location = ? WHERE tour_id = ?");
                pstmt.setString(1, tourName);
                pstmt.setString(2, briefDesc);
                pstmt.setString(3, description);
                pstmt.setString(4, location);
                pstmt.setInt(5, tourID);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate insertNewTourDate(int tourID, String dateStart, String dateEnd, double price,
                                                    int emptySlots, int maxSlots, boolean show) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO tour_date (tour_id, tour_start, tour_end, max_slot, show_tour, price, avail_slot) "
                                + "VALUES (?, ?, ?, ?, ?, ?, ?)");
                pstmt.setInt(1, tourID);
                pstmt.setString(2, dateStart);
                pstmt.setString(3, dateEnd);
                pstmt.setInt(4, maxSlots);
                pstmt.setByte(5, show ? (byte) 1 : (byte) 0);
                pstmt.setDouble(6, price);
                pstmt.setInt(7, emptySlots);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate updateTourDate(int tourDateID, String dateStart, String dateEnd, double price,
                                                 int emptySlots, int maxSlots, boolean show) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "UPDATE tour_date SET tour_start = ?, tour_end = ?, max_slot = ?, show_tour = ?, price = ?, avail_slot = ? WHERE tour_date_id = ?");
                pstmt.setString(1, dateStart);
                pstmt.setString(2, dateEnd);
                pstmt.setInt(3, maxSlots);
                pstmt.setByte(4, show ? (byte) 1 : (byte) 0);
                pstmt.setDouble(5, price);
                pstmt.setInt(6, emptySlots);
                pstmt.setInt(7, tourDateID);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate deleteTourDate(int tourDate_id) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM tour_date WHERE tour_date_id = ?");
                pstmt.setInt(1, tourDate_id);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate deleteTourImage(int tourImage_id) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM tour_image WHERE tour_image_id = ?");
                pstmt.setInt(1, tourImage_id);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate insertNewTourImage(int tourID, String url, String alt) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO tour_image (url, alt_text) " + "VALUES ( ?, ?)", Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, url);
                pstmt.setString(2, alt);
                pstmt.executeUpdate();
                ResultSet rs = pstmt.getGeneratedKeys();
                if (!rs.next())
                    return -1;
                int id = rs.getInt(1);
                pstmt = conn
                        .prepareStatement("INSERT INTO tour_tour_image (tour_id, tour_image_id) " + "VALUES ( ?, ?)");
                pstmt.setInt(1, tourID);
                pstmt.setInt(2, id);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate updateTourImage(int tourImageId, String url, String alt) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn
                        .prepareStatement("UPDATE tour_image SET url = ?, alt_text = ? WHERE tour_image_id = ?");
                pstmt.setString(1, url);
                pstmt.setString(2, alt);
                pstmt.setInt(3, tourImageId);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseQuery<Cart.Item> getCart(int userid) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT * FROM tour_registration WHERE user_id = ? AND stripe_transaction_id = ''");
                pstmt.setInt(1, userid);
                ResultSet rs = pstmt.executeQuery();
                ArrayList<Cart.Item> items = new ArrayList<Cart.Item>();
                while (rs.next()) {
                    int tourDateID = rs.getInt("tour_date_id");
                    int slot = rs.getInt("pax");
                    items.add(new Cart.Item(tourDateID, slot));
                }
                return items.toArray(new Cart.Item[0]);

            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseUpdate deleteCart(int userid) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "DELETE FROM tour_registration WHERE user_id = ? AND stripe_transaction_id = ''");
                pstmt.setInt(1, userid);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate updateCart(Cart cart) {
        return databaseConnection -> {
            int userid = cart.getUserid();
            Connection conn = databaseConnection.get();
            try {
                {
                    PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM tour_registration WHERE user_id = ? AND stripe_transaction_id = ''");
                    pstmt.setInt(1, userid);
                    pstmt.executeUpdate();
                }
                {
                    PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO tour_registration (user_id, tour_date_id, pax, stripe_transaction_id) VALUES ( ?, ?, ?, '')");
                    int i = 0;
                    Cart.Item[] items = cart.getAllItems();
                    for (Cart.Item item : items) {
                        pstmt.setInt(1, userid);
                        pstmt.setInt(2, item.getTourDateId());
                        pstmt.setInt(3, item.getPax());
                        pstmt.addBatch();
                        i++;

                        if (i % 1000 == 0 || i == items.length) {
                            pstmt.executeBatch(); // Execute every 1000 items.
                        }
                    }
                }
                return 1;
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate purchaseCart(Cart cart, String transactionId) {
        return databaseConnection -> {
            int userid = cart.getUserid();
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement pstmt = conn.prepareStatement(
                        "UPDATE tour_registration SET stripe_transaction_id = ? WHERE user_id = ? AND stripe_transaction_id = ''");
                pstmt.setString(1, transactionId);
                pstmt.setInt(2, userid);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }
    public static IDatabaseQuery<Tour.Registrations> getTourRegistrationsByTourDate(int tourDateId) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn
                        .prepareStatement("SELECT * FROM tour_registration WHERE tour_date_id = ?;");

                prepStatement.setInt(1, tourDateId);

                ResultSet rs = prepStatement.executeQuery();

                ArrayList<Tour.Registrations> list = new ArrayList<>();

                if (rs != null)
                    while (rs.next())
                        list.add(new Tour.Registrations(rs));

                return list.toArray(new Tour.Registrations[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }
}
