package dataStructures;

public class GenerateNewClientSecretBody {
		public double amount;
		public String currency;
		
		public GenerateNewClientSecretBody(double amt, String curr) {
			amount = amt;
			currency = curr;
		}
		
		public GenerateNewClientSecretBody() {
			this(0, null);
		}
		
		public void setAmount(double amt) {
			amount = amt;
		}
		
		public void setCurrency(String curr) {
			currency = curr;
		}
		
		public double getAmount() {
			return amount;
		}
		
		public String getCurrency() {
			return currency;
		}
}
