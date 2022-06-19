package dataStructures;

import java.sql.ResultSet;


public class User {

    private int userID;
    private String fullName;
    private String pfpUrl;
    private String email;
    private String role;
    private String password;


    public User(ResultSet rs) {
        try {
            userID = rs.getInt("user_id");
            fullName = rs.getString("full_name");
            pfpUrl = rs.getString("profile_pic_url");
            email = rs.getString("email");
            role = rs.getString("role");
            password = rs.getString("password");
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
}
