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

import dataStructures.Category;
import dataStructures.StripeCustomer;
import dataStructures.Tour;
import payment.StripePayment;
import utils.IDatabaseQuery;
import utils.IDatabaseUpdate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.stripe.exception.StripeException;
import com.stripe.model.Customer;

public class StripeCustomerModel {

	public static IDatabaseQuery<StripeCustomer> getCustomerByStripeCustomerId(String cust_id) {
		return databaseConnection -> {
			Connection conn = databaseConnection.get();
			try {
				PreparedStatement pstmt = conn.prepareStatement(
						"SELECT u.user_id, u.full_name, u.profile_pic_url, u.email, u.role, u.phone, sc.stripe_customer_id FROM stripe_customer sc\n"
								+ "LEFT JOIN `user` u ON u.user_id = sc.user_id\n" + "WHERE sc.stripe_customer_id = \""
								+ cust_id + "\"\n" + "LIMIT 1;");
				ResultSet rs = pstmt.executeQuery();

				ArrayList<StripeCustomer> list = new ArrayList<>();

				if (rs != null)
					while (rs.next())
						list.add(new StripeCustomer(rs));

				return list.toArray(new StripeCustomer[0]);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		};
	}
	
	public static IDatabaseQuery<StripeCustomer> getCustomerByUserId(String user_id) {
		return databaseConnection -> {
			Connection conn = databaseConnection.get();
			try {
				PreparedStatement pstmt = conn.prepareStatement(
						"SELECT u.user_id, u.full_name, u.profile_pic_url, u.email, u.role, u.phone, sc.stripe_customer_id FROM stripe_customer sc\n"
								+ "LEFT JOIN `user` u ON u.user_id = sc.user_id\n" + "WHERE sc.stripe_customer_id = \""
								+ user_id + "\"\n" + "LIMIT 1;");
				ResultSet rs = pstmt.executeQuery();

				ArrayList<StripeCustomer> list = new ArrayList<>();

				if (rs != null)
					while (rs.next())
						list.add(new StripeCustomer(rs));

				return list.toArray(new StripeCustomer[0]);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		};
	}

	public static IDatabaseUpdate insertNewStripeCustomer(int user_id, String name, String email, String phone) {
		return databaseConnection -> {

			if (name == null || email == null || phone == null)
				return 0;

			Connection conn = databaseConnection.get();
			try {

//	            Create new stripe customer
				Customer newCustomer = StripePayment.createNewCustomer(name, email, phone);

				String stripeCustomerId = newCustomer.getId();

				PreparedStatement pstmt = conn
						.prepareStatement("INSERT INTO stripe_customer(stripe_customer_id, user_id) VALUES(?,?);");
				pstmt.setString(1, stripeCustomerId);
				pstmt.setInt(2, user_id);

				System.out.println("Inserting new stripe customer");
				System.out.println(pstmt.toString());

				int affectedRows = pstmt.executeUpdate();

				return affectedRows;
			} catch (StripeException se) {
				System.out.println("There was an error creating new customer");
				System.out.println(se);
			} catch (Exception e) {
				e.printStackTrace();
				return -1;
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return -1;

		};
	}


}
