<%@ page import="dao.CartDAO, dao.UserRegistrationDAO" %>
<%@ page import="java.io.IOException" %>
<%
    // Retrieve parameters
    String productIdStr = request.getParameter("productId");
    String quantityStr = request.getParameter("quantity");
    
    // Validate input
    if (productIdStr != null && quantityStr != null) {
        int productId = Integer.parseInt(productIdStr);
        int quantity = Integer.parseInt(quantityStr);

        // Get userRegID from session
        String email = (String) session.getAttribute("userEmail");
        if (email == null) {
            response.sendRedirect("log.jsp");
            return;
        }

        UserRegistrationDAO userDao = new UserRegistrationDAO();
        int userRegID = userDao.getUserIDByEmail(email);

        // Update the quantity in the cart
        CartDAO cartDAO = new CartDAO();
        cartDAO.updateCartItemQuantity(userRegID, productId, quantity);
    }

    // Redirect back to the cart page
    response.sendRedirect("viewCart.jsp");
%>
