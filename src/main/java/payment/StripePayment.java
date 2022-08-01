package payment;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Address;
import com.stripe.model.Customer;
import com.stripe.model.PaymentIntent;
import com.stripe.param.CustomerCreateParams;
import com.stripe.param.CustomerUpdateParams;
import com.stripe.param.PaymentIntentCreateParams;

public class StripePayment {
	// Create a new payment intent
	public static PaymentIntent createNewPayment(Long amount, String currency) throws StripeException {
		PaymentIntentCreateParams params = PaymentIntentCreateParams.builder().setAmount(amount).setCurrency(currency)
				.setAutomaticPaymentMethods(
						PaymentIntentCreateParams.AutomaticPaymentMethods.builder().setEnabled(true).build())
				.build();

		PaymentIntent paymentIntent = PaymentIntent.create(params);

		return paymentIntent;
	}

	public static Customer createNewCustomer(String name, String email, String phone) throws StripeException {
		Stripe.apiKey = "sk_test_51Kq9aiGruISt8Q6BxYOHpOOthVQShUJl0aMQDATmgyThOhwVwC8fFlATOGEwlYTDS9Ayx663WADGm4aRtBjDpuAH006ZTQvYCI";

		CustomerCreateParams params = CustomerCreateParams.builder().setName(name)
				.setEmail(email).setPhone(phone).build();

		// Get customer details by user id, including address
		Customer customer = Customer.create(params);

		return customer;
	}
	
	public static Customer updateCustomer(String cust_id, String name, String email, String phone) {
		Stripe.apiKey = "sk_test_51Kq9aiGruISt8Q6BxYOHpOOthVQShUJl0aMQDATmgyThOhwVwC8fFlATOGEwlYTDS9Ayx663WADGm4aRtBjDpuAH006ZTQvYCI";
		Customer customer = null;
		try {
			customer = getCustomer(cust_id);
			
			CustomerUpdateParams params = CustomerUpdateParams.builder().setName(name)
					.setEmail(email).setPhone(phone).build();
			
			customer.update(params);
			
			return customer;
		} catch (StripeException e) {
			
			e.printStackTrace();
		}
		
		return customer;
	}
	
	public static Customer getCustomer(String cust_id) {
		Stripe.apiKey = "sk_test_51Kq9aiGruISt8Q6BxYOHpOOthVQShUJl0aMQDATmgyThOhwVwC8fFlATOGEwlYTDS9Ayx663WADGm4aRtBjDpuAH006ZTQvYCI";
		Customer customer = null;
		try {
			customer = Customer.retrieve(cust_id);
			return customer;
		} catch (StripeException e) {
			
			e.printStackTrace();
		}
		
		return customer;
	}
	
	public static PaymentIntent retrievePayment(String payment_intent_client_secret) throws StripeException {
		PaymentIntent intent = PaymentIntent.retrieve(payment_intent_client_secret);
		return intent;
	}

}
