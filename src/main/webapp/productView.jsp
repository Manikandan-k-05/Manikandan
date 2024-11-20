<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dao.*,bean.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
// Declare productDAO and query once in this file
ProductDAO productDAO = new ProductDAO();
List<ProductBean> productList = new ArrayList<>();
String query = request.getParameter("query");

try {
	if (query != null && !query.isEmpty()) {
		// Search logic
		productList = productDAO.searchProductsByName(query);
	} else {
		// Default product fetching
		productList = productDAO.getAllProducts();
	}
} catch (SQLException e) {
	e.printStackTrace();
	request.setAttribute("errorMessage", "An error occurred while fetching products.");
}

// Pass data to the include file
request.setAttribute("products", productList);
request.setAttribute("searchQuery", query);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product View</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.product-card {
	margin: 20px;
	border: none;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s, box-shadow 0.2s;
	height: 400px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
}

.product-card img {
	height: 250px;
	width: 100%;
	object-fit: contain;
	margin: auto;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.product-card .card-body {
	text-align: center;
	padding: 15px;
}

.product-card .card-title {
	font-size: 1.2rem;
	font-weight: bold;
	margin-bottom: 10px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="container my-5">
		<h2 class="text-center text-danger mb-4">
			<%
			if (query != null && !query.isEmpty()) {
			%>
			Search Results for: "<%=query%>"
			<%
			} else {
			%>
			Popular Products
			<%
			}
			%>
		</h2>

		<div class="row">
			<c:choose>
				<c:when test="${empty products}">
					<div class="alert alert-warning text-center" role="alert">No
						products found. Try searching for something else!</div>
				</c:when>

				<c:otherwise>
					<c:forEach var="product" items="${products}">
						<div class="col-md-4 mb-4">
							<a href="productDetail.jsp?productId=${product.productId}"
								class="text-decoration-none">
								<div class="card product-card">
									<img src="uploads/${product.productImage}" class="card-img-top"
										alt="${product.productName}">
									<div class="card-body">
										<h5 class="card-title">${product.productName}</h5>

										<a
											href="paymentsupport.jsp?productId=${product.productId}&amount=${product.price}"
											class="btn btn-danger"> Buy Now </a>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
