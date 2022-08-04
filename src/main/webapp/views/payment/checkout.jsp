<%@page import="dataStructures.Cart"%>
<%@page import="utils.DatabaseConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Alex+Brush"
	rel="stylesheet" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/open-iconic-bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/animate.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/owl.carousel.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/owl.theme.default.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/magnific-popup.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/aos.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/ionicons.min.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap-datepicker.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery.timepicker.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/flaticon.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/icomoon.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />

<script src="https://js.stripe.com/v3/"></script>

</head>
<body>

	<div class="container">
		<%
		String paymentIntent = (String) request.getAttribute("payment_intent_secret");

		if (paymentIntent == null) {
		%>
		<h1>Something went wrong while trying to pay</h1>
		<%
		return;
		}

		DatabaseConnection connection = new DatabaseConnection();
		Cart cart = Cart.getOrCreateCart(session, connection);
		String currency = "SGD";
		%>

		<div class="card my-5 p-4">

			<h4>You are paying</h4>
			<h2 class="font-weight-bold">
				$<%=String.format("%.2f", cart.getTotalPrice(currency) / 100)%></h2>
			<p class="text-muted">
				Inclusive of $<%=String.format("%.2f", (cart.getTotalPrice(currency) / 100) * 0.07)%>
				(7% GST)
			</p>

			<small class="text-muted"> Transaction: <%=request.getAttribute("payment_intent_secret")%>
			</small>
		</div>

		<div class="text-right">
			<form id="payment-form">
				<div id="payment-element">
					<!-- Elements will create form elements here -->
				</div>
				<button id="submit" class="btn btn-primary my-5 w-100">Pay</button>
				<div id="error-message">
					<!-- Display error message to your customers here -->
				</div>
			</form>
		</div>
	</div>



	<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.stellar.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/aos.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.animateNumber.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/bootstrap-datepicker.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.timepicker.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/scrollax.min.js"></script>

	<script src="${pageContext.request.contextPath}/js/main.js"></script>

	<script>
		const getUrl = window.location;
		const redirectUrl = getUrl .protocol + "//" + getUrl.host + '${pageContext.request.contextPath}/pay'
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
				      return_url: redirectUrl,
				    },
				  });

				  if (error) {
				    // This point will only be reached if there is an immediate error when
				    // confirming the payment. Show error to your customer (for example, payment
				    // details incomplete)
				    const messageContainer = document.querySelector('#error-message');
				    messageContainer.textContent = error.message + "return url: redirectUrl";
				  } else {
				    // Your customer will be redirected to your `return_url`. For some payment
				    // methods like iDEAL, your customer will be redirected to an intermediate
				    // site first to authorize the payment, then redirected to the `return_url`.
				  }
				});
	</script>

</body>
</html>