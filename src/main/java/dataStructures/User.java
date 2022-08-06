/*
 * 	Name: Nabil Ridhwanshah Bin Rosli , Xavier Tay Cher Yew
	Admin No: P2007421, P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */

package dataStructures;

import java.sql.ResultSet;


public class User {

    private int userID;
    private String fullName;
    private String pfpUrl;
    private String email;
    private String role;
    private String password;
    
    private String phone;
    
    private String address_1;
    private String address_2;
    private String apt_suite;
    private String postal_code;


    public User(ResultSet rs) {
        try {
            userID = rs.getInt("user_id");
            fullName = rs.getString("full_name");
            pfpUrl = rs.getString("profile_pic_url");
            email = rs.getString("email");
            role = rs.getString("role");
            password = rs.getString("password");
            
            phone = rs.getString("phone");
            
            address_1 = rs.getString("address_1");
            address_2 = rs.getString("address_2");
            apt_suite = rs.getString("apt_suite");
            postal_code = rs.getString("postal_code");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public String getPassword() {
        return password;
    }
    
    public int getUserID() {
        return userID;
    }

    public String getFullName() {
        return fullName;
    }

    public String getPfpUrl() {
        return pfpUrl;
    }

    public String getEmail() {
        return email;
    }

    public String getRole() {
        return role;
    }
    
    public String getPhone() {
    	return phone;
    }
    
    public String getAddress1() {
    	return address_1;
    }
    
    public String getAddress2() {
    	return address_2;
    }
    
    public String getAptSuite() {
    	return apt_suite;
    }
    
    public String getPostalCode() {
    	return postal_code;
    }
}
