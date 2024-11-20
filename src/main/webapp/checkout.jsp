<%@page import="dao.UserRegistrationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.CartDAO"%>
<%@ page import="bean.CartItem"%>
<%@ page import="java.util.List"%>
<%
// Retrieve the email of the logged-in user from session
String email = (String) session.getAttribute("userEmail");

// Redirect to login page if email is not available in session
if (email == null) {
    response.sendRedirect("log.jsp");
    return;
}

UserRegistrationDAO dao = new UserRegistrationDAO();

// Assuming a method to get the userRegID based on email
int userRegID = dao.getUserIDByEmail(email);

// Fetch the cart items for the user
CartDAO cartDAO = new CartDAO();
List<CartItem> cartItems = cartDAO.getAllCartItems(userRegID);

// Calculate total amount for the order
double totalPrice = cartDAO.getTotalPrice(userRegID);
double tax = totalPrice * 0.1;
double total = totalPrice + tax;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports World - Checkout</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <a class="navbar-brand text-danger" href="#">Sports World</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link text-danger" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Checkout Section -->
    <div class="container my-5 flex-grow-1">
        <h2 class="text-center text-danger mb-4">Checkout</h2>

        <div class="row">
            <!-- Payment Options -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title text-danger">Total Amount: &#8377;<%= total %></h5>
                        <form action="paymentProcessing.jsp" method="POST">
                            <div class="form-group">
                                <label for="paymentOption">Choose Payment Method</label>
                                <select class="form-control" id="paymentOption" name="paymentOption" required>
                                    <option value="creditCard">Credit Card</option>
                                    <option value="debitCard">Debit Card</option>
                                    <option value="netBanking">Net Banking</option>
                                    <option value="upi">UPI</option>
                                    <option value="cod">Cash on Delivery</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="cardNumber" id="cardLabel" style="display: none;">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="Enter Card Number" style="display: none;" required>
                            </div>

                            <button type="submit" class="btn btn-danger btn-block">Proceed to Payment</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Footer -->
    <footer class="bg-danger text-white text-center py-3 mt-auto">
        <p>&copy; 2024 Sports World. All Rights Reserved.</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Show/hide card number field based on payment method
        document.getElementById("paymentOption").addEventListener("change", function() {
            var paymentOption = this.value;
            if (paymentOption === "creditCard" || paymentOption === "debitCard") {
                document.getElementById("cardLabel").style.display = "block";
                document.getElementById("cardNumber").style.display = "block";
            } else {
                document.getElementById("cardLabel").style.display = "none";
                document.getElementById("cardNumber").style.display = "none";
            }
        });
    </script>
</body>
</html>
