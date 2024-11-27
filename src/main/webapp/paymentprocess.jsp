<%@page import="bean.OrderBean"%>
<%@page import="dao.OrderDAO"%>
<%@page import="dao.PaymentDAO , dao.UserRegistrationDAO"%>
<%@page import="bean.PaymentBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="net.authorize.api.contract.v1.*, net.authorize.api.controller.*, net.authorize.api.controller.base.ApiOperationBase"%>
<%@ page import="java.util.*, java.math.*"%>
<%@ page import="net.authorize.Environment"%>
<%@ page import="java.io.*, org.json.JSONObject"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%
String email = (String) session.getAttribute("userEmail");

if (email == null) {
	response.sendRedirect("log.jsp");
	return; // Exit the page
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment Confirmation</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	background-color: white;
	border-radius: 8px;
	padding: 30px;
	width: 80%;
	max-width: 800px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

h3 {
	color: #4CAF50;
}

p {
	font-size: 16px;
	line-height: 1.6;
}

.error {
	color: red;
}

.success {
	color: green;
}

.transaction-info {
	margin-bottom: 20px;
}

.billing-info {
	background-color: #f9f9f9;
	padding: 15px;
	border-radius: 5px;
	margin-top: 20px;
}

.billing-info p {
	margin: 5px 0;
}

.button {
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.button:hover {
	background-color: #45a049;
}
</style>
</head>
<body>

	<%
	final String apiLoginId = "256fMQSzZn46";
	final String transactionKey = "5kV38Fu89xc5G6jh";

	if (apiLoginId == null || transactionKey == null) {
		out.println(
		"<div class='container'><h3 class='error'>Error: Missing API credentials. Please check your environment variables.</h3></div>");
		return;
	}

	// Capture product and user data from the request
	String productId = request.getParameter("productId");
	String amount = request.getParameter("amount");
	String cardNumber = request.getParameter("cardNumber");
	String expiryDate = request.getParameter("expiryDate");
	String cvv = request.getParameter("cvv");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zip = request.getParameter("zip");
	String country = request.getParameter("country");
	String phone = request.getParameter("phone");

	// Validate the additional fields (optional)
	if (firstName == null || lastName == null || address == null || city == null || state == null || zip == null
			|| country == null) {
		out.println("<div class='container'><h3 class='error'>Please fill in all the required fields.</h3></div>");
		return;
	}

	// Get the email for user identification
	// String email = request.getParameter("email");
	if (email == null || email.isEmpty()) {
		out.println("<div class='container'><h3 class='error'>Email is required.</h3></div>");
		return;
	}

	// Fetch user ID from the database using email
	UserRegistrationDAO userDAO = new UserRegistrationDAO();
	Integer userID = userDAO.getUserIDByEmail(email);

	// Validate user ID
	if (userID == null) {
		out.println("<div class='container'><h3 class='error'>User not found.</h3></div>");
		return;
	}
	
 	String quantityStr = request.getParameter("quantity");
	int quantity = 1; // Default to 1 if not provided

	if (quantityStr != null && !quantityStr.isEmpty()) {
	    try {
	        quantity = Integer.parseInt(quantityStr);
	        if (quantity <= 0) {
	            out.println("<div class='container'><h3 class='error'>Invalid quantity. Please enter a valid number.</h3></div>");
	            return;
	        }
	    } catch (NumberFormatException e) {
	        out.println("<div class='container'><h3 class='error'>Invalid quantity format.</h3></div>");
	        return;
	    }
	}


	// Convert INR to USD
	String targetCurrency = "USD";
	 //int paymentAmount = 0; 
	int paymentAmount = Integer.parseInt(amount) * quantity;
	int amountInUSD = 0; // Initialize the amountInUSD to a default value

	// Step 1: Convert INR to USD
	try {
		paymentAmount = Integer.parseInt(amount);

		if (paymentAmount <= 0) {
			out.println(
			"<div class='container'><h3 class='error'>Invalid amount. Amount should be greater than zero.</h3></div>");
			return;
		}

		// Convert INR to USD using currency API
		String apiUrl = "https://api.exchangerate-api.com/v4/latest/INR"; // Example API URL
		URL url = new URL(apiUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setDoOutput(true);

		// Read the response
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String inputLine;
		StringBuffer apiResponse = new StringBuffer();
		while ((inputLine = in.readLine()) != null) {
			apiResponse.append(inputLine);
		}
		in.close();

		// Parse and validate response
		JSONObject jsonResponse = new JSONObject(apiResponse.toString());

		if (jsonResponse.has("rates") && jsonResponse.getJSONObject("rates").has(targetCurrency)) {
			String exchangeRateStr = jsonResponse.getJSONObject("rates").getString(targetCurrency);

			// Sanitize the exchange rate string to remove any unwanted characters
			exchangeRateStr = exchangeRateStr.replaceAll("[^\\d.]", ""); // Remove anything that is not a digit or a decimal point

			// Ensure the exchange rate format contains only digits
			if (!exchangeRateStr.matches("^[0-9]+(\\.[0-9]+)?$")) {
		out.println("<div class='container'><h3 class='error'>Invalid exchange rate format: " + exchangeRateStr
				+ "</h3></div>");
		return;
			}

			try {
		// Convert the sanitized exchange rate to integer (round it)
		double exchangeRate = Double.parseDouble(exchangeRateStr); // Use double for more accurate conversion
		amountInUSD = (int) (paymentAmount * exchangeRate); // Multiplying with integer values
			} catch (NumberFormatException e) {
		out.println("<div class='container'><h3 class='error'>Error in converting exchange rate: " + exchangeRateStr
				+ "</h3></div>");
		return;
			}
		} else {
			out.println(
			"<div class='container'><h3 class='error'>Failed to retrieve exchange rate. Please try again later.</h3></div>");
			return; // Exit if conversion fails
		}

	} catch (Exception e) {
		out.println("<div class='container'><h3 class='error'>Failed to fetch exchange rate or convert amount.</h3><pre>"
		+ e.getMessage() + "</pre></div>");
		return; // Exit if there's an issue with the API request
	}

	// Step 2: Process the payment
	if (productId != null && amount != null && cardNumber != null && expiryDate != null && cvv != null) {
		try {
			// Set the environment to SANDBOX for testing
			ApiOperationBase.setEnvironment(Environment.SANDBOX);

			// Set API credentials
			MerchantAuthenticationType merchantAuthentication = new MerchantAuthenticationType();
			merchantAuthentication.setName(apiLoginId);
			merchantAuthentication.setTransactionKey(transactionKey);
			ApiOperationBase.setMerchantAuthentication(merchantAuthentication);

			// Payment details
			PaymentType paymentType = new PaymentType();
			CreditCardType creditCard = new CreditCardType();

			creditCard.setCardNumber(cardNumber); // Get card number from the form
			creditCard.setExpirationDate(expiryDate); // Get expiration date from the form
			creditCard.setCardCode(cvv); // Get CVV from the form
			paymentType.setCreditCard(creditCard);

			// Billing address
			CustomerAddressType billTo = new CustomerAddressType();
			billTo.setFirstName(firstName);
			billTo.setLastName(lastName);
			billTo.setAddress(address);
			billTo.setCity(city);
			billTo.setState(state);
			billTo.setZip(zip);
			billTo.setCountry(country);
			billTo.setPhoneNumber(phone);

			// Transaction details
			TransactionRequestType transactionRequest = new TransactionRequestType();
			transactionRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
			transactionRequest.setAmount(new BigDecimal(amountInUSD)); // Using the integer USD amount
			transactionRequest.setPayment(paymentType);
			transactionRequest.setBillTo(billTo); // Add billing info
			transactionRequest.setOrder(new OrderType());
			transactionRequest.getOrder().setInvoiceNumber("INV-1001");
			transactionRequest.getOrder().setDescription("Sports World Order");

			// API request
			CreateTransactionRequest apiRequest = new CreateTransactionRequest();
			apiRequest.setTransactionRequest(transactionRequest);

			// Execute transaction
			CreateTransactionController controller = new CreateTransactionController(apiRequest);
			controller.execute();

			// Get API response
			CreateTransactionResponse res = controller.getApiResponse();

			// Handle the response
			if (res != null && res.getMessages() != null && res.getMessages().getResultCode() == MessageTypeEnum.OK) {
				
		// Create PaymentBean object and set values
		PaymentBean payment = new PaymentBean();
		payment.setTransactionId(res.getTransactionResponse().getTransId());
		payment.setProductId(productId);
		payment.setFirstName(firstName);
		payment.setLastName(lastName);
		payment.setAddress(address);
		payment.setCity(city);
		payment.setState(state);
		payment.setZip(zip);
		payment.setCountry(country);
		payment.setPhone(phone);
		payment.setAmount(paymentAmount);
		payment.setQuantity(quantity);
		payment.setPaymentStatus("Success");
		payment.setUserId(userID); // Use the userID when saving payment details

		// Save payment details to the database
		PaymentDAO paymentDAO = new PaymentDAO();
		boolean isSaved = paymentDAO.savePaymentDetails(payment);
		
		// After saving payment, now insert the order
				OrderDAO orderDAO = new OrderDAO();
				OrderBean order = new OrderBean();
				order.setCustomerId(userID); // Set the user ID from the session
				order.setProductId(Integer.parseInt(productId)); // Set the product ID
				order.setQuantity(1); // You can modify this based on the request (e.g., quantity of products)
				order.setPrice(paymentAmount); // Use the payment amount (converted to USD)
				order.setStatus("Completed"); // You can set the order status to "Completed" or other status
				// Save order to the database
				boolean isOrderSaved = orderDAO.saveOrder(order);

		out.println("<div class='container'>");
		out.println("<h3 class='success'>Payment Successful!</h3>");
		out.println("<div class='transaction-info'>");
		out.println("<p><strong>Transaction ID:</strong> " + res.getTransactionResponse().getTransId() + "</p>");
		out.println("<p><strong>Name:</strong> " + billTo.getFirstName() + " " + billTo.getLastName() + "</p>");
		out.println("<p><strong>Address:</strong> " + billTo.getAddress() + ", " + billTo.getCity() + "</p>");
		out.println("<p><strong>State/Province:</strong> " + billTo.getState() + ", <strong>Zip:</strong> "
				+ billTo.getZip() + "</p>");
		out.println("<p><strong>Country:</strong> " + billTo.getCountry() + ", <strong>Phone:</strong> "
				+ billTo.getPhoneNumber() + "</p>");
		out.println("</div>");
		
		// Display order placement message
		if (isOrderSaved) {
			out.println("<p>Your order has been placed successfully!</p>");
		} else {
			out.println("<p>There was an issue saving your order. Please contact support.</p>");
		}

		// Button to navigate to the Order History Page
		out.println(
				"<button class='button' onclick=\"window.location.href='home.jsp';\">View Order History</button>");
		out.println("</div>");
			} else {
		out.println("<div class='container'><h3 class='error'>Payment Failed</h3>");
		if (res != null && res.getMessages() != null) {
			out.println("<p>" + res.getMessages().getMessage().get(0).getText() + "</p>");
		}
		out.println("</div>");
			}

		} catch (Exception e) {
			out.println(
			"<div class='container'><h3 class='error'>Payment processing failed. Please try again later.</h3><pre>"
					+ e.getMessage() + "</pre></div>");
		}
	} else {
		out.println("<div class='container'><h3 class='error'>Missing payment details.</h3></div>");
	}
	%>

</body>
</html>
