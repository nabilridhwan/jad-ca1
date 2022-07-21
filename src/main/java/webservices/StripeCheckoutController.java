package webservices;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.stripe.*;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;

import dataStructures.GenerateNewClientSecretBody;
import payment.StripePayment;





@Path("/checkout")
public class StripeCheckoutController {
	
	
	
	
	
	
	@POST
	@Path("/create")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response generateNewClientSecret(GenerateNewClientSecretBody body) {
		Stripe.apiKey = "sk_test_51Kq9aiGruISt8Q6BxYOHpOOthVQShUJl0aMQDATmgyThOhwVwC8fFlATOGEwlYTDS9Ayx663WADGm4aRtBjDpuAH006ZTQvYCI";
		
		try {
			PaymentIntent intent = StripePayment.createNewPayment((long)body.amount, body.currency);
			Map<String, String> map = new HashMap<String, String>();
			
			map.put("client_secret", intent.getClientSecret());
			return Response.status(Response.Status.CREATED).entity(map).build();
		}catch(StripeException se) {
			System.out.println(se);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR).build();
		}
	}
}
