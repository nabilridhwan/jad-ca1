package models;
import java.sql.*;

import servlets.DatabaseConnection;

public class CategoryModel {
	static Connection conn = DatabaseConnection.getConnection();
	
	public static ResultSet getCategoriesWithListingCount() throws SQLException {
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
		return rs;
	}
	
}
