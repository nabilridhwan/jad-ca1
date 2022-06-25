package models;

import dataStructures.AverageRatingAndNumberOfReview;
import dataStructures.Category;
import utils.IDatabaseQuery;
import utils.IDatabaseUpdate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReviewModel {

    public static IDatabaseQuery<AverageRatingAndNumberOfReview> getAverageRatingAndNumberOfReviewByTourID(String tour_id) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT CAST(AVG(rating) AS "
                		+ "DECIMAL(5,1)) AS average_rating, COUNT(rating) AS number_of_reviews "
                		+ "FROM sp_tour.review r\r\n"
                		+ "WHERE r.tour_id = ?;");
                
                pstmt.setString(1, tour_id);
                
                ResultSet rs = pstmt.executeQuery();
                

                ArrayList<AverageRatingAndNumberOfReview> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new AverageRatingAndNumberOfReview(rs));

                return list.toArray(new AverageRatingAndNumberOfReview[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }    
    

}
