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
 
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            margin-right: 2px;
        }

        .product-image {
            width: 100px;
            height: 100px;
            object-fit: contain;
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 2px;
            background-color: #f8f9fa;
        }
    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 p-0 bg-light sidebar">
                <div class="sidebar-header text-center py-4">
                    <h4 class="text-danger">Sports World Admin</h4>
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
 