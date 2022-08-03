/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
 * */

package dataStructures;

import java.util.HashMap;

public class CurrencyExchangeRates {

	String base;
	String date;
	HashMap<String, Double> rates;
	boolean success;
	int timestamp;

	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public HashMap<String, Double> getRates() {
		return rates;
	}

	public void setRates(HashMap<String, Double> rates) {
		this.rates = rates;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public int getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(int timestamp) {
		this.timestamp = timestamp;
	}


	public static CurrencyExchangeRates GetCurrentRates(){
		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8080/CA2-Webservices/currency";
		WebTarget target = client.target(restUrl).path("/");

		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invocationBuilder.get();

		if (resp.getStatus() != Response.Status.OK.getStatusCode()) return null;
		try {
			CurrencyExchangeRates exchange = resp.readEntity(new GenericType<CurrencyExchangeRates>() {
			});
			return exchange;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
