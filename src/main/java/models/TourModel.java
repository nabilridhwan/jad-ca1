package models;
import java.sql.*;

import servlets.DatabaseConnection;

public class TourModel {
	static Connection conn = DatabaseConnection.getConnection();
	
	public static ResultSet getUniqueToursByLowestPriceFirst() throws SQLException {
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
				+ ") b  ON b.tour_id = t.tour_id LIMIT 5;");
		ResultSet rs = pstmt.executeQuery();
		return rs;
	}
	
}
