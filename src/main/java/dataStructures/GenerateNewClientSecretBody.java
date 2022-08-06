package dataStructures;
/*
 * 	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */


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
