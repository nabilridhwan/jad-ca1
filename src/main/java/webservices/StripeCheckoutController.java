/*
 * 	Name: Nabil Ridhwanshah Bin Rosli
	Admin No: P2007421
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI 
 * */

package webservices;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import dataStructures.GenerateNewClientSecretBody;
import payment.StripePayment;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.Map;

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
