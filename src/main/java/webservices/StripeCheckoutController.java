package webservices;

import java.util.HashMap;
import java.util.Map;

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

import payment.StripePayment;

@Path("/checkout")
public class StripeCheckoutController {
	
	
	
	public class GenerateNewClientSecretBody{
		public String amount;
		public String currency;
	}
	
	
	@POST
	@Path("/create")
	@Produces(MediaType.APPLICATION_JSON)
	public Response generateNewClientSecret(GenerateNewClientSecretBody body) {
		try {
			PaymentIntent intent = StripePayment.createNewPayment(Long.parseLong(body.amount), body.currency);
			Map<String, String> map = new HashMap<String, String>();
			
			map.put("client_secret", intent.getClientSecret());
			return Response.status(Response.Status.CREATED).entity(map).build();
		}catch(StripeException se) {
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR).build();
		}
	}
}
