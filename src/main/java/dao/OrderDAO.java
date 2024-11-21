package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.OrderBean;
import db.DBconnection;

public class OrderDAO {
    public List<OrderBean> getAllOrders() {
        List<OrderBean> orderList = new ArrayList<>();
        String query = "SELECT o.orderId, c.customerName, p.productName, o.quantity, o.price, o.status " +
                       "FROM orders o " +
                       "JOIN customers c ON o.customerId = c.customerId " +
                       "JOIN product p ON o.productId = p.productId";

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                OrderBean order = new OrderBean();
                order.setOrderId(rs.getInt("orderId"));
                order.setCustomerName(rs.getString("customerName"));
                order.setProductName(rs.getString("productName"));
                order.setQuantity(rs.getInt("quantity"));
                order.setPrice(rs.getDouble("price"));
                order.setStatus(rs.getString("status"));
                orderList.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
    }
    
    
    public List<OrderBean> getOrdersByUser(int userId) {
        List<OrderBean> orderList = new ArrayList<>();
        String query = "SELECT o.orderId, p.productName, o.quantity, o.price, o.status " +
                       "FROM orders o " +
                       "JOIN product p ON o.productId = p.productId " +
                       "WHERE o.customerId = ?";

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);  // Bind the userId to the query
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderBean order = new OrderBean();
                    order.setOrderId(rs.getInt("orderId"));
                    order.setProductName(rs.getString("productName"));
                    order.setQuantity(rs.getInt("quantity"));
                    order.setPrice(rs.getDouble("price"));
                    order.setStatus(rs.getString("status"));
                    orderList.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
    }

    
}
