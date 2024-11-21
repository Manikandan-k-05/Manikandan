<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.UserRegistrationDAO" %>
<%@ page import="bean.RegisterBean" %>

<%
String email = (String) session.getAttribute("userEmail");

if (email == null) {
    response.sendRedirect("log.jsp");
    return; // Exit the page if no user is logged in
}

UserRegistrationDAO userDAO = new UserRegistrationDAO();
List<RegisterBean> users = null;

try {
    users = userDAO.getAllUsers(); // Fetch all users from the database
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Management - Admin</title>
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
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm mb-4">
                <a class="navbar-brand text-danger" href="#">Customer Management</a>
            </nav>

            <h2 class="text-center text-danger mb-4">Customer Details</h2>

            <!-- Customer Table -->
            <div class="table-responsive">
                <table id="customerTable" class="table table-bordered table-striped">
                    <thead class="bg-danger text-white">
                        <tr>
                            <th>SL No</th> <!-- SL No Column -->
                            <th>Email</th>
                            <th>Phone</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        if (users != null) {
                            for (RegisterBean user : users) { 
                        %>
                        <tr>
                            <td></td> <!-- SL No will be dynamically populated -->
                            <td><%= user.getRegisterEmail() %></td>
                            <td><%= user.getRegisterPhone() %></td>
                        </tr>
                        <% 
                            }
                        } else { 
                        %>
                        <tr>
                            <td colspan="4" class="text-center">No users found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add SL No dynamically
    document.addEventListener("DOMContentLoaded", function () {
        const table = document.getElementById("customerTable");
        const rows = table.querySelectorAll("tbody tr");

        rows.forEach((row, index) => {
            const slNoCell = row.children[0]; // First cell in each row
            slNoCell.textContent = index + 1; // Assign serial number starting from 1
        });
    });
</script>
</body>
</html>
