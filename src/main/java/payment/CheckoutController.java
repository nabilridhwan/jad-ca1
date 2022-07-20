package payment;

import java.util.ArrayList;
import java.util.List;

import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;



public class CheckoutController {
	public static String clientId = "AaJnLYKox1QXoDTQRL4yztuJHrUKanKzDpO9j37hv-DpSRXApHwmVybQ73JciV3mBUr3WCP7Z8hLxKXa";
	public static String clientSecret = "ECnk9FAXbZgw09NeMf7Zc4pAZUjx6tfmcb6q9GQBskYYgh2YOpHfILSWO4itfl3tBZWbnLnPGM-PJo7r";
	public static String sandboxAccount = "sb-iyefw19265710@business.example.com";
	
	List<Transaction> transactions = new ArrayList<Transaction>();
	Payer payer = new Payer();
	Payment payment = new Payment();
	
	
	public CheckoutController addTransaction(String currency, String value) {
		Amount amount = new Amount();
		amount.setCurrency(currency);
		amount.setTotal(value);
		Transaction transaction = new Transaction();
		transaction.setAmount(amount);
		
		transactions.add(transaction);
		return this;
	}
	
	public CheckoutController setPayer() {
		payer.setPaymentMethod("paypal");
		return this;
	}
	
	public Payment build() {
		payment.setIntent("sale");
		payment.setPayer(payer);
		payment.setTransactions(transactions);
		
		// Set redirect URLs
		RedirectUrls redirectUrls = new RedirectUrls();
		redirectUrls.setCancelUrl("https://example.com/cancel");
		redirectUrls.setReturnUrl("https://example.com/return");
		payment.setRedirectUrls(redirectUrls);
		
		return payment;
	}


}
