<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.OrderBean" %>
<%@ page import="dao.OrderDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <link rel="stylesheet" href="styles.css">  <!-- Include your stylesheet -->
</head>
<body>
    <div class="container">
        <h2>Order History</h2>

        <% 
            // Example: Retrieve userId from session or hardcoded for testing
            int userId = 1;  // You should get this from session or user login context

            // Fetch orders for the user
            OrderDAO orderDAO = new OrderDAO();
            List<OrderBean> orders = orderDAO.getOrdersByUser(userId);

            // Set the orders as a request attribute so JSTL can access it
            request.setAttribute("orders", orders);
        %>
        
        <!-- Check if there are any orders to display -->
        <c:if test="${not empty orders}">
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Iterate through orders and display each one -->
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.productName}</td>
                            <td>${order.quantity}</td>
                            <td>${order.price}</td>
                            <td>${order.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty orders}">
            <p>You have no previous orders.</p>
        </c:if>
    </div>
</body>
</html>
