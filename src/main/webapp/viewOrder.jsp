<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.OrderDAO, java.util.List, bean.OrderBean"%>

<%
    String email = (String) session.getAttribute("userEmail");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    OrderDAO orderDAO = new OrderDAO();
    List<OrderBean> orderList = orderDAO.getAllOrders();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Orders - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.navbar, .card-header.bg-danger {
	background-color: #dc3545 !important;
}

.text-danger {
	color: #dc3545 !important;
}

.sidebar {
	background-color: #f8f9fa;
}

.sidebar-header h4 {
	color: #dc3545;
}

.sidebar .nav-link.active {
	background-color: #dc3545;
	color: white;
}

.sidebar .nav-link {
	color: #333;
}

.sidebar .nav-link:hover {
	background-color: #dc3545;
	color: white;
}

.btn-spacing {
	margin-right: 2px; /* Add space between buttons */
}

.product-image {
	width: 100px; /* Adjust to fit your design */
	height: 100px; /* Adjust to fit your design */
	object-fit: contain;
	border-radius: 5px; /* Optional for rounded corners */
	border: 1px solid #ddd; /* Optional border for styling */
	padding: 2px; /* Optional padding for styling */
	background-color: #f8f9fa;
}
</style>
</head>
<body>
<div class="container-fluid">
		<div class="row">
<div class="col-md-3 col-lg-2 p-0 bg-light sidebar">
				<div class="sidebar-header text-center py-4">
					<h4 class="text-danger">Sports World Admin</h4>
				</div>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link" href="admin.jsp">Dashboard</a></li>
					<li class="nav-item"><a class="nav-link"
						href="categoryManage.jsp">Category</a></li>
					<li class="nav-item"><a class="nav-link"
						href="productManage.jsp">Products</a></li>

					<li class="nav-item"><a class="nav-link" href="customer.jsp">Customers</a></li>

					<li class="nav-item"><a class="nav-link" href="viewOrder.jsp">View Orders</a></li>

					<li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
				</ul>
			</div>
    <div class="container mt-5">
        <h2 class="text-center text-danger mb-4">Orders</h2>
        <div class="card">
            <div class="card-header bg-danger text-white">
                <h5>All Orders</h5>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer Name</th>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (OrderBean order : orderList) { %>
                            <tr>
                                <td><%= order.getOrderId() %></td>
                                <td><%= order.getCustomerName() %></td>
                                <td><%= order.getProductName() %></td>
                                <td><%= order.getQuantity() %></td>
                                <td>&#8377; <%= order.getPrice() %></td>
                                <td><%= order.getStatus() %></td>
                                <td>
                                    <a href="editOrder.jsp?orderId=<%= order.getOrderId() %>" class="btn btn-primary btn-sm">Edit</a>
                                    <a href="deleteOrder.jsp?orderId=<%= order.getOrderId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this order?')">Delete</a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 --%>
<%--   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.OrderBean" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="bean.PaymentBean" %>
<%@ page import="dao.PaymentDAO" %>

<%
    // Check if the admin is logged in
    String email = (String) session.getAttribute("userEmail");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Fetch all orders using the DAO
    OrderDAO orderDAO = new OrderDAO();
    List<OrderBean> orderList = null;
    try {
        orderList = orderDAO.getAllOrders();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // Fetch all payments using PaymentDAO
    PaymentDAO paymentDAO = new PaymentDAO();
    List<PaymentBean> paymentList = null;
    try {
        paymentList = paymentDAO.getPaymentsWithPagination(offset, limit);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar, .card-header.bg-danger {
            background-color: #dc3545 !important;
        }

        .sidebar {
            background-color: #f8f9fa;
        }

        .sidebar .nav-link.active {
            background-color: #dc3545;
            color: white;
        }

        .sidebar .nav-link {
            color: #333;
        }

        .sidebar .nav-link:hover {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 p-0 sidebar">
                <div class="sidebar-header text-center py-4">
                    <h4 class="text-danger">Admin Dashboard</h4>
                </div>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link" href="admin.jsp">Dashboard</a></li>
					<li class="nav-item"><a class="nav-link"
						href="categoryManage.jsp">Category</a></li>
					<li class="nav-item"><a class="nav-link"
						href="productManage.jsp">Products</a></li>

					<li class="nav-item"><a class="nav-link" href="customer.jsp">Customers</a></li>

					<li class="nav-item"><a class="nav-link" href="viewOrder.jsp">View Orders</a></li>

					<li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
				</ul>
			</div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 p-4">
                <h2 class="text-center text-danger mb-4">Orders</h2>

                <div class="card">
                    <div class="card-header bg-danger text-white">
                        <h5>All Orders</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered table-striped">
                            <thead>
                                 <tr>
                                    <th>User ID</th>
                                    <th>Transaction ID</th>
                                    <th>Product ID</th>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>Address</th>
                                    <th>City</th>
                                    <th>State</th>
                                    <th>ZIP</th>
                                    <th>Country</th>
                                    <th>Phone</th>
                                    <th>Amount</th>
                                    <th>Quantity</th>
                                    <th>Payment Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if (paymentList != null && !paymentList.isEmpty()) {
                                    for (PaymentBean payment : paymentList) {

                                %>
                                    <tr>
                                         <td><%= payment.getUserId() %></td>
                                        <td><%= payment.getTransactionId() %></td>
                                        <td><%= payment.getProductId() %></td>
                                        <td><%= payment.getFirstName() %></td>
                                        <td><%= payment.getLastName() %></td>
                                        <td><%= payment.getAddress() %></td>
                                        <td><%= payment.getCity() %></td>
                                        <td><%= payment.getState() %></td>
                                        <td><%= payment.getZip() %></td>
                                        <td><%= payment.getCountry() %></td>
                                        <td><%= payment.getPhone() %></td>
                                        <td>&#8377; <%= payment.getAmount() %></td>
                                        <td><%= payment.getQuantity() %></td>
                                        <td><%= payment.getPaymentStatus() %></td>
                                        <td>
                                            <a href="editOrder.jsp?orderId=<%= order.getOrderId() %>" class="btn btn-primary btn-sm">Edit</a>
                                            <a href="deleteOrder.jsp?orderId=<%= order.getOrderId() %>" 
                                               class="btn btn-danger btn-sm" 
                                               onclick="return confirm('Are you sure you want to delete this order?')">Delete</a> 
                                        </td>
                                    </tr>
                                <% 
                                        }
                                    } else { 
                                %>
                                    <tr>
                                        <td colspan="14" class="text-center">No orders found.</td>
                                    </tr>
                                <% 
                                    } 
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>  --%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.OrderBean" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="bean.PaymentBean" %>
<%@ page import="dao.PaymentDAO" %>

<%
    // Check if the admin is logged in
    String email = (String) session.getAttribute("userEmail");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Set offset and limit for pagination, typically passed as request parameters or defaults
    int offset = 0;
    int limit = 100; // You can set any default value here, or get it from request parameters

    // Fetch all orders using the DAO (if needed)
    OrderDAO orderDAO = new OrderDAO();
    List<OrderBean> orderList = null;
    try {
        orderList = orderDAO.getAllOrders();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Fetch payments with pagination using PaymentDAO
    PaymentDAO paymentDAO = new PaymentDAO();
    List<PaymentBean> paymentList = null;
    try {
        paymentList = paymentDAO.getPaymentsWithPagination(offset, limit);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar, .card-header.bg-danger {
            background-color: #dc3545 !important;
        }

        .sidebar {
            background-color: #f8f9fa;
        }

        .sidebar .nav-link.active {
            background-color: #dc3545;
            color: white;
        }

        .sidebar .nav-link {
            color: #333;
        }

        .sidebar .nav-link:hover {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 p-0 sidebar">
                <div class="sidebar-header text-center py-4">
                    <h4 class="text-danger">Admin Dashboard</h4>
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="admin.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="categoryManage.jsp">Category</a></li>
                    <li class="nav-item"><a class="nav-link" href="productManage.jsp">Products</a></li>
                    <li class="nav-item"><a class="nav-link" href="customer.jsp">Customers</a></li>
                    <li class="nav-item"><a class="nav-link" href="viewOrder.jsp">View Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 p-4">
                <h2 class="text-center text-danger mb-4">Orders</h2>

                <div class="card">
                    <div class="card-header bg-danger text-white">
                        <h5>All Orders</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered table-striped">
                            <thead>
                              
                                 <tr>
                                    <th>Username</th>
                                    <th>Transaction ID</th>
                                    <th>Product ID</th>
                                    <th>Full Name</th>
                                    <th>Address</th>
                                    <th>Phone</th>
                                    <th>Amount</th>
                                    <th>Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if (paymentList != null && !paymentList.isEmpty()) {
                                    for (PaymentBean payment : paymentList) {
                                %>
                                    
                                     <tr>
                                         <td><%= payment.getUserId() %></td>
                                        <td><%= payment.getTransactionId() %></td>
                                        <td><%= payment.getProductId() %></td>
                                        <td><%= payment.getFirstName() + " " + payment.getLastName() %></td>
                                        <td><%= payment.getAddress() + ", " + payment.getCity() + ", " + payment.getState() + ", " + payment.getZip() + ", " + payment.getCountry() %></td>
                                        <td><%= payment.getPhone() %></td>
                                        <td>&#8377; <%= payment.getAmount() %></td>
                                        <td><%= payment.getQuantity() %></td>
                                    </tr>
                                <% 
                                    }
                                } else { 
                                %>
                                    <tr>
                                        <td colspan="8" class="text-center">No orders found.</td>
                                    </tr>
                                <% 
                                    } 
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 

 
<%--  
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.OrderDAO" %>

<%
    // Check if the admin is logged in
    String email = (String) session.getAttribute("userEmail");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Fetch customer and product IDs using the DAO
    OrderDAO orderDAO = new OrderDAO();
    List<Integer> customerIds = null;
    List<Integer> productIds = null;
    try {
        customerIds = orderDAO.getUniqueCustomerIds();
        productIds = orderDAO.getUniqueProductIds();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Customers and Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2 class="text-center text-danger my-4">Customers and Products</h2>

        <div class="card mb-4">
            <div class="card-header bg-danger text-white">
                <h5>Customer IDs</h5>
            </div>
            <div class="card-body">
                <ul class="list-group">
                    <% 
                        if (customerIds != null && !customerIds.isEmpty()) {
                            for (Integer customerId : customerIds) {
                    %>
                        <li class="list-group-item">Customer ID: <%= customerId %></li>
                    <% 
                            }
                        } else { 
                    %>
                        <li class="list-group-item text-center">No customer IDs found.</li>
                    <% 
                        } 
                    %>
                </ul>
            </div>
        </div>

        <div class="card">
            <div class="card-header bg-danger text-white">
                <h5>Product IDs</h5>
            </div>
            <div class="card-body">
                <ul class="list-group">
                    <% 
                        if (productIds != null && !productIds.isEmpty()) {
                            for (Integer productId : productIds) {
                    %>
                        <li class="list-group-item">Product ID: <%= productId %></li>
                    <% 
                            }
                        } else { 
                    %>
                        <li class="list-group-item text-center">No product IDs found.</li>
                    <% 
                        } 
                    %>
                </ul>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
  --%>