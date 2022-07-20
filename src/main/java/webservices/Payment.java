package webservices;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.stripe.Stripe;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;

@Path("/payment")
public class Payment {

	@POST
	@Path("/create")
	@Produces(MediaType.APPLICATION_JSON)
	public Response createPaymentIntent(){
		Stripe.apiKey = "sk_test_51Kq9aiGruISt8Q6BxYOHpOOthVQShUJl0aMQDATmgyThOhwVwC8fFlATOGEwlYTDS9Ayx663WADGm4aRtBjDpuAH006ZTQvYCI";
		try {
			PaymentIntentCreateParams params = PaymentIntentCreateParams.builder().setAmount(1999L).setCurrency("usd").build();
			PaymentIntent paymentIntent = PaymentIntent.create(params);
			return Response.status(200).entity(paymentIntent.toJson()).build();
		}catch(Exception e) {
			System.out.println(e);
			return Response.status(500).entity(e).build();
		}
		
	}
}
