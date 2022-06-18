package utils;

import java.sql.*;

public class DatabaseConnection extends _DatabaseConnectionConfig implements AutoCloseable {

    private final Connection connection;

    public DatabaseConnection() {
        connection = getConnection();
    }

    public Connection get() {
        return connection;
    }

    @Override
    public void close() {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static final String connURL = "jdbc:mysql://localhost/" + databaseName + "?user=" + user + "&password=" + password + "&serverTimezone=UTC";

    private static Connection getConnection() {
        Connection conn = null;
        try {
            TryLoadDriver();
//            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(connURL);

        } catch (SQLException e) {
            System.out.println("Error in getConnection - getting connection error");
            System.out.println("====Stack Trace====");
            e.printStackTrace();
            System.out.println("===================");
        }

        return conn;
    }


    // Prevents driver from loading multiple times
    private static boolean isDriverLoaded = false;

    private static void TryLoadDriver() {
        if (isDriverLoaded) return;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            isDriverLoaded = true;
        } catch (ClassNotFoundException e) {
            isDriverLoaded = false;
            System.out.println("Class not found error");
            System.out.println("====Stack Trace====");
            e.printStackTrace();
            System.out.println("===================");

        }
    }
}
