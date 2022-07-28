/*
 * 	Name: Nabil
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

package dataStructures;

import java.sql.ResultSet;

public class StripeCustomer {
    String stripe_customer_id;
    int user_id;

    public StripeCustomer(ResultSet rs) {
        try {
        	stripe_customer_id = rs.getString(1);
        	user_id = rs.getInt(2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getStripeCustomerId() {
        return stripe_customer_id;
    }

    public int getUserId() {
        return user_id;
    }
}



