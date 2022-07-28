<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<script src="https://js.stripe.com/v3/"></script>

</head>
<body>


<%
	String paymentIntent = (String) request.getAttribute("payment_intent_secret");

	if(paymentIntent == null){%>
		<h1>Something went wrong while trying to pay</h1>
		<%return;
	}%>
	
	
<h1><%=request.getAttribute("payment_intent_secret") %></h1>

	<form id="payment-form">
		<div id="payment-element">
			<!-- Elements will create form elements here -->
		</div>
		<button id="submit">Submit</button>
		<div id="error-message">
			<!-- Display error message to your customers here -->
		</div>
	</form>

	<script>
		const stripe = Stripe('pk_test_51Kq9aiGruISt8Q6Bay3PRs8qYLr9NvzEgDzK8F4cI98ZI1vau3047zqKu0ODXHuJpS5MYJ9gmQc6nAltyZU2WBsh00U0mNnNWf');
		
		const options = {
				  clientSecret: '<%=paymentIntent%>',
				  // Fully customizable with appearance API.
				  appearance: {/*...*/},
				};

				// Set up Stripe.js and Elements to use in checkout form, passing the client secret obtained in step 2
				const elements = stripe.elements(options);

				// Create and mount the Payment Element
				const paymentElement = elements.create('payment');
				paymentElement.mount('#payment-element');
				
				const form = document.getElementById('payment-form');

				form.addEventListener('submit', async (event) => {
				  event.preventDefault();

				  const {error} = await stripe.confirmPayment({
				    //`Elements` instance that was used to create the Payment Element
				    elements,
				    confirmParams: {
				      return_url: 'http://localhost:8080/CA1-Preparation/pay',
				    },
				  });

				  if (error) {
				    // This point will only be reached if there is an immediate error when
				    // confirming the payment. Show error to your customer (for example, payment
				    // details incomplete)
				    const messageContainer = document.querySelector('#error-message');
				    messageContainer.textContent = error.message;
				  } else {
				    // Your customer will be redirected to your `return_url`. For some payment
				    // methods like iDEAL, your customer will be redirected to an intermediate
				    // site first to authorize the payment, then redirected to the `return_url`.
				  }
				});
	</script>

</body>
</html>