package payment;

import java.util.ArrayList;
import java.util.List;

import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import com.stripe.model.Customer;

public class TestPayment {

	public static CheckoutController checkoutController = new CheckoutController();

	public static void main(String[] args) {
		try {
			Customer customer = StripePayment.getCustomer("cus_M61EbJnYU99YBU");
			
			
			System.out.println(customer.getId());
			System.out.println(customer.getName());
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
