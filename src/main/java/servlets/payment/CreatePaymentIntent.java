package servlets.payment;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;

import dataStructures.CreatePaymentIntentResponseBody;
import dataStructures.GenerateNewClientSecretBody;
import payment.StripePayment;

/**
 * Servlet implementation class CreatePaymentIntent
 */
@WebServlet("/create_payment_intent")
public class CreatePaymentIntent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreatePaymentIntent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Stripe.apiKey = "sk_test_51Kq9aiGruISt8Q6BxYOHpOOthVQShUJl0aMQDATmgyThOhwVwC8fFlATOGEwlYTDS9Ayx663WADGm4aRtBjDpuAH006ZTQvYCI";
		
		GenerateNewClientSecretBody entity = new GenerateNewClientSecretBody(200, "sgd");
		
		Client client = ClientBuilder.newClient();
		
		String restUrl = "http://localhost:8080/CA1-Preparation/checkout/create";
		
		WebTarget target = client.target(restUrl);
		
		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		
		Response resp = invocationBuilder.post(Entity.json(entity));
		
		if(resp.getStatus() == Response.Status.CREATED.getStatusCode()) {
			CreatePaymentIntentResponseBody responseBody = resp.readEntity(CreatePaymentIntentResponseBody.class);
			request.setAttribute("payment_intent_secret", responseBody.client_secret);
			request.getRequestDispatcher("views/payment/checkout.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
