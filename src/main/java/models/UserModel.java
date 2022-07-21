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
    
    public static IDatabaseQuery<User> getUserByEmail(String email){
    	return databaseConnection -> {
            try {
                Connection conn = databaseConnection.get();
                PreparedStatement prepStatement = conn.prepareStatement("SELECT * FROM user WHERE email = ? LIMIT 1;");
                prepStatement.setString(1, email);
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


    public static IDatabaseUpdate insertNewUser(String name, String email, String password, String address_1, String address_2, String apt_suite, String postal_code, String phone) {
        //		Default profile picture image
        return insertNewUser(name, email, password, "https://via.placeholder.com/400", address_1, address_2, apt_suite, postal_code, phone);
    }

    public static IDatabaseUpdate insertNewUser(String name, String email, String password, String pfpImg, String address_1, String address_2, String apt_suite, String postal_code, String phone) {
        return databaseConnection -> {
            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("INSERT INTO user(full_name, email, password, profile_pic_url, address_1, address_2, apt_suite, postal_code, phone) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");

                prepStatement.setString(1, name);
                prepStatement.setString(2, email);
                prepStatement.setString(3, password);
                prepStatement.setString(4, pfpImg);
                prepStatement.setString(5, address_1);
                prepStatement.setString(6, address_2);
                prepStatement.setString(7, apt_suite);
                prepStatement.setString(8, postal_code);
                prepStatement.setString(9, phone);
                return prepStatement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate updateUser(int userId, String profile_pic_url, String fullName, String email, String password, String address_1, String address_2, String apt_suite, String postal_code, String phone) {
        return databaseConnection -> {

//            SQL Reference "UPDATE user SET full_name = ?, email = ?, password = ?, profile_pic_url = ? WHERE user_id = ?";

            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("UPDATE user " +
                        "SET " +
                		"profile_pic_url = ?," +
                        "full_name = ?," +
                        "email = ?," +
                        "password =?, " +
                        "address_1 = ?," +
                        "address_2 = ?," +
                        "apt_suite = ?," +
                        "postal_code = ?," +
                        "phone = ?" +
                        "WHERE user_id = ?");

                prepStatement.setString(1, profile_pic_url);
                prepStatement.setString(2, fullName);
                prepStatement.setString(3, email);
                prepStatement.setString(4, password);
                
                prepStatement.setString(5, address_1);
                prepStatement.setString(6, address_2);
                prepStatement.setString(7, apt_suite);
                prepStatement.setString(8, postal_code);
                
                prepStatement.setString(9, phone);
                prepStatement.setInt(10, userId);
                
                System.out.println(prepStatement.toString());

                return prepStatement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }

    public static IDatabaseUpdate updateUser(int userId, String profile_pic_url, String fullName, String email, String address_1, String address_2, String apt_suite, String postal_code, String phone) {
        return databaseConnection -> {
//            SQL Reference "UPDATE user SET full_name = ?, email = ?, password = ?, profile_pic_url = ? WHERE user_id = ?";

            Connection conn = databaseConnection.get();
            try {
                PreparedStatement prepStatement = conn.prepareStatement("UPDATE user " +
                        "SET " +
                        "profile_pic_url = ?" +
                        "full_name = ?," +
                        "email = ?," +
                        "address_1 = ?," +
                        "address_2 = ?," +
                        "apt_suite = ?," +
                        "postal_code = ?," +
                        "phone = ?" +
                        "WHERE user_id = ?");

                prepStatement.setString(1, profile_pic_url);
                prepStatement.setString(2, fullName);
                prepStatement.setString(3, email);
                
                prepStatement.setString(4, address_1);
                prepStatement.setString(5, address_2);
                prepStatement.setString(6, apt_suite);
                prepStatement.setString(7, postal_code);
                
                prepStatement.setString(8, phone);
                
                prepStatement.setInt(9, userId);
                return prepStatement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
        };
    }
}
