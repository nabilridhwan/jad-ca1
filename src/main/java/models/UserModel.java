package models;
import java.sql.*;

import servlets.DatabaseConnection;

public class UserModel {
	static Connection conn = DatabaseConnection.getConnection();
	
	public static ResultSet getUserByEmailAndPassword(String email, String password) throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");
		pstmt.setString(1, email);
		pstmt.setString(2, password);
		ResultSet rs = pstmt.executeQuery();
		return rs;
	}
	
	public static ResultSet getUserByUserID(int userID) throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE user_id = ?;");
		pstmt.setInt(1, userID);
		ResultSet rs = pstmt.executeQuery();
		return rs;
	}
	
	public static int insertNewUser(String name, String email, String password) throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement("INSERT INTO user(full_name, email, password, profile_pic_url) VALUES(?, ?, ?, ?)");
		
//		Set the variables
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		pstmt.setString(3, password);
		
//		Default profile picture image
		pstmt.setString(4, "https://via.placeholder.com/400");
		
		int rowsAffected = pstmt.executeUpdate();
		return rowsAffected;
	}
	
	public static int updateUserWithoutPassword(String name, String email, int userID) throws SQLException{
		PreparedStatement pstmt = conn.prepareStatement("UPDATE user SET full_name = ?, email = ? WHERE user_id = ?");
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setInt(3, userID);
		
		
		int affectedRows = pstmt.executeUpdate();
		
		return affectedRows;
	}
	
	public static int updateUserWithPassword(String name, String email, String password, int userID) throws SQLException{
		PreparedStatement pstmt = conn.prepareStatement("UPDATE user SET full_name = ?, email = ?, password = ? WHERE user_id = ?");
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, password);
			pstmt.setInt(4, userID);
		
		
		int affectedRows = pstmt.executeUpdate();
		
		return affectedRows;
	}
}
