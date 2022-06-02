package servlets;
import java.sql.*;

public class DatabaseConnection {
	
	public static Connection getConnection() {
		Connection conn = null;
		try {
	        // Step1: Load JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");  //can be omitted for newer version of drivers

	        // Step 2: Define Connection URL
	        String connURL = "jdbc:mysql://localhost/sp_tour?user=root&password=root&serverTimezone=UTC";

	        // Step 3: Establish connection to URL
	        conn = DriverManager.getConnection(connURL); 
		}catch(Exception e) {
			System.out.println("Error in getConnection - getting connection error");
		}
		
		return conn;
	}

}
