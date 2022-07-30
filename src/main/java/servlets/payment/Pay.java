package servlets.payment;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;

import dataStructures.Cart;
import models.TourModel;
import payment.StripePayment;
import utils.DatabaseConnection;

/**
 * Servlet implementation class Pay
 */
@WebServlet("/pay")
public class Pay extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Pay() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Stripe.apiKey = "sk_test_51Kq9aiGruISt8Q6BxYOHpOOthVQShUJl0aMQDATmgyThOhwVwC8fFlATOGEwlYTDS9Ayx663WADGm4aRtBjDpuAH006ZTQvYCI";
        // Get the API response

        String paymentIntentId = request.getParameter("payment_intent");
        PrintWriter out = response.getWriter();

        Cart cart = Cart.GetExisting(request.getSession());
        if (cart == null || cart.Size() == 0) {
            response.sendRedirect(request.getContextPath() + "/views/user/cart.jsp?error_cartEmpty=");
            return;
        }

        try {
            PaymentIntent intent = StripePayment.retrievePayment(paymentIntentId);
            String paymentId = intent.getId();
            Long paymentAmount = intent.getAmount();
            Long paymentDate = intent.getCreated();
            String paymentStatus = intent.getStatus();

            out.println(paymentId);
            out.println(paymentAmount);
            out.println(paymentDate);
            out.println(paymentStatus);

            DatabaseConnection connection = new DatabaseConnection();
            TourModel.purchaseCart(cart, paymentId).update(connection);
            connection.close();


            response.sendRedirect(request.getContextPath() + "/views/user/cart.jsp?success_purchase=");

            // Save cart to database with the id along with it
        } catch (StripeException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
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
