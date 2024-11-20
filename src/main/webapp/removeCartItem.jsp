<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CartDAO,dao.UserRegistrationDAO " %>

<%
    // Get productId from the request
    String productIdStr = request.getParameter("productId");
    int productId = Integer.parseInt(productIdStr);

    // Get userRegID from session (assumes the user is logged in)
    String email = (String) session.getAttribute("userEmail");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Get userRegID (assuming you have a method for this)
    UserRegistrationDAO userDao = new UserRegistrationDAO();
    int userRegID = userDao.getUserIDByEmail(email);

    // Remove the item from the cart
    CartDAO cartDAO = new CartDAO();
    cartDAO.deleteCartItem(userRegID, productId);

    // Redirect back to the cart page
    response.sendRedirect("viewCart.jsp");
%>
