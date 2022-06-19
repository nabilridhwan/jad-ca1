package models;

import dataStructures.User;
import utils.DatabaseConnection;
import utils.IDatabaseQuery;
import utils.IDatabaseUpdate;

import java.sql.*;
import java.util.ArrayList;

public class UserModel {

    public static IDatabaseQuery<User> getUserByEmailAndPassword(String email, String password) {

        return databaseConnection -> {
            try {
                Connection conn = databaseConnection.get();
                PreparedStatement prepStatement = conn.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");
                prepStatement.setString(1, email);
                prepStatement.setString(2, password);
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<User> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new User(rs));

                return list.toArray(new User[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }

    public static IDatabaseQuery<User> getUserByUserID(int userID) {
        return databaseConnection -> {
            try {
                Connection conn = databaseConnection.get();
                PreparedStatement prepStatement = conn.prepareStatement("SELECT * FROM user WHERE user_id = ?;");
                prepStatement.setInt(1, userID);
                ResultSet rs = prepStatement.executeQuery();

                ArrayList<User> list = new ArrayList<>();

                if (rs != null) while (rs.next()) list.add(new User(rs));

                return list.toArray(new User[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        };
    }


    public static IDatabaseUpdate insertNewUser(String name, String email, String password) {
        //		Default profile picture image
        return insertNewUser(name, email, password, "https://via.placeholder.com/400");
    }

    public static IDatabaseUpdate insertNewUser(String name, String email, String password, String pfpImg) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("INSERT INTO user(full_name, email, password, profile_pic_url) VALUES(?, ?, ?, ?)");

                prepStatement.setString(1, name);
                prepStatement.setString(2, email);
                prepStatement.setString(3, password);
                prepStatement.setString(4, pfpImg);
                return prepStatement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate updateUser(int userId, String fullName, String email, String password) {
        return databaseConnection -> {
<<<<<<< HEAD
=======

>>>>>>> 8ecdcd52db6a0de2c3162954bae12d3c49c249ab
//            SQL Reference "UPDATE user SET full_name = ?, email = ?, password = ?, profile_pic_url = ? WHERE user_id = ?";

            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("UPDATE user " +
                        "SET " +
                        "full_name = ?," +
                        "email = ?," +
                        "password =? " +
                        "WHERE user_id = ?");


                prepStatement.setString(1, fullName);
                prepStatement.setString(2, email);
                prepStatement.setString(3, password);
                prepStatement.setInt(4, userId);

                return prepStatement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate updateUser(int userId, String fullName, String email) {
        return databaseConnection -> {
//            SQL Reference "UPDATE user SET full_name = ?, email = ?, password = ?, profile_pic_url = ? WHERE user_id = ?";

            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("UPDATE user " +
                        "SET " +
                        "full_name = ?," +
                        "email = ?," +
                        "WHERE user_id = ?");


                prepStatement.setString(1, fullName);
                prepStatement.setString(2, email);
                prepStatement.setInt(3, userId);
                return prepStatement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }
}
