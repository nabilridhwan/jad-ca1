/*
Name: Xavier Tay Cher Yew
Admin No: P2129512
Class: DIT/FT/2A/01
Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
*/

/*
Name: Nabil Ridhwanshah Bin Rosli
Admin No: P2007421
Class: DIT/FT/2A/01
Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI
 */

package servlets.payment;

import com.stripe.Stripe;
import dataStructures.Cart;
import dataStructures.CreatePaymentIntentResponseBody;
import dataStructures.GenerateNewClientSecretBody;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;

/**
 * Servlet implementation class CreatePaymentIntent
 */
@WebServlet("/create_payment_intent")
public class CreatePaymentIntent extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Stripe.apiKey = "sk_test_51Kq9aiGruISt8Q6BxYOHpOOthVQShUJl0aMQDATmgyThOhwVwC8fFlATOGEwlYTDS9Ayx663WADGm4aRtBjDpuAH006ZTQvYCI";

        Cart cart = Cart.GetExisting(request.getSession());
        if (cart == null || cart.Size() == 0) {
            response.sendRedirect(request.getContextPath() + "/views/user/cart.jsp?error_cartEmpty=");
            return;
        }

        String currency = (String) request.getSession().getAttribute("currency");
        double amt = cart.getTotalPrice(currency);

        if (amt <= -1) {
            response.sendRedirect(request.getContextPath() + "/views/user/cart.jsp?error=cannot process payment");
            return;
        }

        GenerateNewClientSecretBody entity = new GenerateNewClientSecretBody(amt * 1.07, currency);

        Client client = ClientBuilder.newClient();
        String restUrl = "http://localhost:8080/CA1-Preparation/checkout/create";
//        String restUrl = request.getContextPath() + "/checkout/create";
        WebTarget target = client.target(restUrl);

        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);

        Response resp = invocationBuilder.post(Entity.json(entity));

        if (resp.getStatus() == Response.Status.CREATED.getStatusCode()) {
            CreatePaymentIntentResponseBody responseBody = resp.readEntity(CreatePaymentIntentResponseBody.class);
            request.setAttribute("payment_intent_secret", responseBody.client_secret);
            request.getRequestDispatcher("views/payment/checkout.jsp").forward(request, response);
        }
    }
}
