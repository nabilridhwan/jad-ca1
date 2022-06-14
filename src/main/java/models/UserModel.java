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

    public static IDatabaseUpdate updateUser(User user) {
        return databaseConnection -> {
            if (user.IsFromDatabase()) return 0;
            boolean firstVariable = false;
            StringBuilder sql = new StringBuilder("Update user SET ");
            if (user.getFullName() != null) {
                sql.append("full_name = ?");
//                if (firstVariable) sql.append(", "); //first one is always false
                firstVariable = true;
            }
            if (user.getEmail() != null) {
                sql.append("email = ?");
                if (firstVariable) sql.append(", ");
                firstVariable = true;
            }
            if (user.getPfpUrl() != null) {
                sql.append("profile_pic_url = ?");
                if (firstVariable) sql.append(", ");
                firstVariable = true;
            }
            if (user.getRole() != null) {
                sql.append("role = ?");
                if (firstVariable) sql.append(", ");
                firstVariable = true;
            }
            if (user.getPassword() != null) {
                sql.append("role = ?");
                if (firstVariable) sql.append(", ");
                firstVariable = true;
            }
            sql.append("WHERE user_id = ?");

            //todo might want to return -1 instead
            if (!firstVariable) return 0; //no variables were set therefore no change;

            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement(sql.toString());

                int variableCount = 1;
                if (user.getFullName() != null) {
                    prepStatement.setString(variableCount, user.getFullName());
                    variableCount++;
                }
                if (user.getEmail() != null) {
                    prepStatement.setString(variableCount, user.getEmail());
                    variableCount++;
                }
                if (user.getPfpUrl() != null) {
                    prepStatement.setString(variableCount, user.getPfpUrl());
                    variableCount++;
                }
                if (user.getRole() != null) {
                    prepStatement.setString(variableCount, user.getRole());
                    variableCount++;
                }
                if (user.getPassword() != null) {
                    prepStatement.setString(variableCount, user.getPassword());
//                    variableCount++;
                }
                return prepStatement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }
}
