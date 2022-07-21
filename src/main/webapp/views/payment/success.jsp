<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://js.stripe.com/v3/"></script>
</head>
<body>

	<section>
		<p>
			<p id="message"></p>
			
		</p>
	</section>

	<script>
//Initialize Stripe.js using your publishable key
  const stripe = Stripe('pk_test_51Kq9aiGruISt8Q6Bay3PRs8qYLr9NvzEgDzK8F4cI98ZI1vau3047zqKu0ODXHuJpS5MYJ9gmQc6nAltyZU2WBsh00U0mNnNWf');

  // Retrieve the "payment_intent_client_secret" query parameter appended to
  // your return_url by Stripe.js
  const clientSecret = new URLSearchParams(window.location.search).get(
    'payment_intent_client_secret'
  );

  // Retrieve the PaymentIntent
  stripe.retrievePaymentIntent(clientSecret).then(({paymentIntent}) => {
    const message = document.querySelector('#message')

    // Inspect the PaymentIntent `status` to indicate the status of the payment
    // to your customer.
    //
    // Some payment methods will [immediately succeed or fail][0] upon
    // confirmation, while others will first enter a `processing` state.
    //
    // [0]: https://stripe.com/docs/payments/payment-methods#payment-notification
    console.log(paymentIntent)
    switch (paymentIntent.status) {
      case 'succeeded':
        message.innerText = 'Success! Payment received.';
        break;

      case 'processing':
        message.innerText = "Payment processing. We'll update you when payment is received.";
        break;

      case 'requires_payment_method':
        message.innerText = 'Payment failed. Please try another payment method.';
        // Redirect your user back to your payment page to attempt collecting
        // payment again
        break;

      default:
        message.innerText = 'Something went wrong.';
        break;
    }
  });
  </script>
</body>
</html>