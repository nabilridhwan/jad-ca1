/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
 * */

package dataStructures;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

public class CurrencyExchangeRates {
	public CurrencyExchangeRates() {
	}

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

	public Date getDate() {
		try {
			return new SimpleDateFormat("dd/MM/yyyy").parse(date);
		} catch (ParseException e) {
			return null;
		}
	}

	public void setDate(String date) {
		this.date = date;
	}

	public HashMap<String, Double> getRates() {
		if (rates == null) rates = new HashMap<>();
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

	public double tryGet(String currency) {
		HashMap<String, Double> map = getRates();
		return map.getOrDefault(currency, -1d);
	}

	private static CurrencyExchangeRates currencyExchangeRateInstance;
	public static CurrencyExchangeRates GetCurrentRates() {
//		Calendar cal = Calendar.getInstance();
//		cal.add(Calendar.HOUR, 5);
//		Date date = cal.getTime();

		//TODO implement discarding of old rates after a certain time
		if (currencyExchangeRateInstance != null)
			return currencyExchangeRateInstance;

		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8080/CA2-Webservices/currency";
		WebTarget target = client.target(restUrl).path("/");

		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invocationBuilder.get();

		if (resp.getStatus() != Response.Status.OK.getStatusCode()) return null;
		try {
			CurrencyExchangeRates exchange = resp.readEntity(CurrencyExchangeRates.class);
			if (exchange == null) {
				System.out.println("Currency exchange rates null");
				return null;
			}
			if (!exchange.isSuccess()) {
				System.out.println("Currency exchange rates unsuccessful");
				System.out.println(exchange.getBase() + " " + exchange.getDate() + " " + exchange.getTimestamp());
				System.out.println(exchange.getRates());
				return exchange;
			}
			currencyExchangeRateInstance = exchange;
			exchange.getRates().put(exchange.getBase(), 1.0);
			return exchange;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}


		//Call API directly
//		Client client = ClientBuilder.newClient();
//
//		String restUrl = "https://api.apilayer.com/exchangerates_data/latest?symbols=USD%2CEUR&base=SGD";
//
//		WebTarget target = client.target(restUrl);
//
//		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
//
//		HashMap<String, String> h = new HashMap<String, String>();
//
//		h.put("apikey", "m4nEJVld876oMcySYvrKV5MMLfZUNhW8");
//
//		Response resp = invocationBuilder.header("apikey", "m4nEJVld876oMcySYvrKV5MMLfZUNhW8").get();
//
//		if (resp.getStatus() != Response.Status.OK.getStatusCode()) return null;
//		try {
//			CurrencyExchangeRates exchange = resp.readEntity(CurrencyExchangeRates.class);
//			if (exchange == null) {
//				System.out.println("Currency exchange rates null");
//				return null;
//			}
//			if (!exchange.isSuccess()) {
//				System.out.println("Currency exchange rates unsuccessful");
//				System.out.println(exchange.getBase() + " " + exchange.getDate() + " " + exchange.getTimestamp());
//				System.out.println(exchange.getRates());
//				return exchange;
//			}
//			exchange.getRates().put(exchange.getBase(), 1.0);
//			return exchange;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return null;
//		}
	}
}
