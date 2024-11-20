<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="net.authorize.api.contract.v1.*, net.authorize.api.controller.*, net.authorize.api.controller.base.ApiOperationBase"%>
<%@ page import="java.util.*, java.math.*"%>
<%@ page import="net.authorize.Environment"%>
<%@ page import="java.io.*, org.json.JSONObject"%>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>

<%
    // Retrieve productId and amount from the URL query string
    String productId = request.getParameter("productId");
    String amount = request.getParameter("amount");

    if (productId == null || amount == null) {
        out.println("<h3>Product or amount is missing. Please try again.</h3>");
        return;
    }

    // Remove decimal points from the amount (if any)
    try {
        // Convert the amount to an integer to remove decimals
        int intAmount = (int) Double.parseDouble(amount); // This will truncate the decimal part
        amount = String.valueOf(intAmount); // Update the amount with the integer value
    } catch (NumberFormatException e) {
        out.println("<h3>Error in processing the amount. Please ensure it's a valid number.</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-header, .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control {
            margin-bottom: 1rem;
        }

        .container {
            max-width: 600px;
        }

        h3 {
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="container mt-5">
        <div class="card shadow-lg">
            <div class="card-header text-center text-white">
                <h3>Payment Details</h3>
            </div>
            <div class="card-body">

                <form action="paymentprocess.jsp" method="POST">
                    <!-- Hidden Fields -->
                    <input type="hidden" name="productId" value="<%= productId %>">
                    <input type="hidden" name="amount" value="<%= amount %>">

                    <!-- Billing Information -->
                    <div class="form-group">
                        <label for="firstName">First Name:</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name:</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone:</label>
                        <input type="tel" class="form-control" id="phone" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>
                    <div class="form-group">
                        <label for="city">City:</label>
                        <input type="text" class="form-control" id="city" name="city" required>
                    </div>
                    <div class="form-group">
                        <label for="state">State/Province:</label>
                        <input type="text" class="form-control" id="state" name="state" required>
                    </div>
                    <div class="form-group">
                        <label for="zip">Zip/Postal Code:</label>
                        <input type="text" class="form-control" id="zip" name="zip" required>
                    </div>
                    <div class="form-group">
                        <label for="country">Country:</label>
                        <input type="text" class="form-control" id="country" name="country" required>
                    </div>

                    <!-- Card Details -->
                    <div class="form-group">
                        <label for="cardNumber">Card Number:</label>
                        <input type="text" class="form-control" id="cardNumber" name="cardNumber" maxlength="16" required>
                    </div>
                    <div class="form-group">
                        <label for="expiryDate">Expiry Date (MM-YYYY):</label>
                        <input type="text" class="form-control" id="expiryDate" name="expiryDate" required>
                    </div>
                    <div class="form-group">
                        <label for="cvv">CVV:</label>
                        <input type="text" class="form-control" id="cvv" name="cvv" maxlength="3" required>
                    </div>

                    <!-- Submit Button -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-danger w-100 mt-4">Payment</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
