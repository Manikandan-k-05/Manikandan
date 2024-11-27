/*
 * package dao;
 * 
 * import java.sql.Connection; import java.sql.PreparedStatement; import
 * java.sql.ResultSet; import java.util.ArrayList; import java.util.List;
 * 
 * import bean.OrderBean; import db.DBconnection;
 * 
 * public class OrderDAO { public List<OrderBean> getAllOrders() {
 * List<OrderBean> orderList = new ArrayList<>(); String query =
 * "SELECT o.orderId, c.customerName, p.productName, o.quantity, o.price, o.status "
 * + "FROM orders o " + "JOIN customers c ON o.customerId = c.customerId " +
 * "JOIN product p ON o.productId = p.productId";
 * 
 * try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt =
 * conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
 * 
 * while (rs.next()) { OrderBean order = new OrderBean();
 * order.setOrderId(rs.getInt("orderId"));
 * order.setCustomerName(rs.getString("customerName"));
 * order.setProductName(rs.getString("productName"));
 * order.setQuantity(rs.getInt("quantity"));
 * order.setPrice(rs.getDouble("price"));
 * order.setStatus(rs.getString("status")); orderList.add(order); } } catch
 * (Exception e) { e.printStackTrace(); } return orderList; }
 * 
 * 
 * public List<OrderBean> getOrdersByUser(int userId) { List<OrderBean>
 * orderList = new ArrayList<>(); String query =
 * "SELECT o.orderId, p.productName, o.quantity, o.price, o.status " +
 * "FROM orders o " + "JOIN product p ON o.productId = p.productId " +
 * "WHERE o.customerId = ?";
 * 
 * try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt =
 * conn.prepareStatement(query)) { stmt.setInt(1, userId); // Bind the userId to
 * the query
 * 
 * try (ResultSet rs = stmt.executeQuery()) { while (rs.next()) { OrderBean
 * order = new OrderBean(); order.setOrderId(rs.getInt("orderId"));
 * order.setProductNam(rs.getString("productName"));
 * order.setQuantity(rs.getInt("quantity"));
 * order.setPrice(rs.getDouble("price"));
 * order.setStatus(rs.getString("status")); orderList.add(order); } } } catch
 * (Exception e) { e.printStackTrace(); } return orderList; }
 * 
 * 
 * }
 */

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.OrderBean;
import db.DBconnection;

public class OrderDAO {
    
    // Method to get all orders with customer and product details
    public List<OrderBean> getAllOrders() {
        List<OrderBean> orderList = new ArrayList<>();
        String query = "SELECT o.orderId, o.customerId, o.productId, o.quantity, o.price, o.status " +
                       "FROM orders o " +
                       "JOIN userregistration c ON o.customerId = c.userRegID" +
                       "JOIN product p ON o.productId = p.productId";

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                OrderBean order = new OrderBean();
                order.setOrderId(rs.getInt("orderId"));
                order.setCustomerId(rs.getInt("customerId"));  // Set customerId
                order.setProductId(rs.getInt("productId"));    // Set productId
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
    
    public List<Integer> getUniqueCustomerIds() throws SQLException {
        List<Integer> customerIds = new ArrayList<>();
        String query = "SELECT DISTINCT customerId FROM orders";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                customerIds.add(resultSet.getInt("customerId"));
            }
        }
        return customerIds;
    }
    
    public List<Integer> getUniqueProductIds() throws SQLException {
        List<Integer> productIds = new ArrayList<>();
        String query = "SELECT DISTINCT productId FROM orders";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                productIds.add(resultSet.getInt("productId"));
            }
        }
        return productIds;
    }



    // Method to get orders by a specific user (customer)
    public List<OrderBean> getOrdersByUser(int userId) {
        List<OrderBean> orderList = new ArrayList<>();
        String query = "SELECT o.orderId, o.productId, o.quantity, o.price, o.status " +
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
                    order.setProductId(rs.getInt("productId"));  // Set productId
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
    
    public boolean saveOrder(OrderBean order) {
        String query = "INSERT INTO orders (customerId, productId, quantity, price, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, order.getCustomerId());
            stmt.setInt(2, order.getProductId());
            stmt.setInt(3, order.getQuantity());
            stmt.setDouble(4, order.getPrice());
            stmt.setString(5, order.getStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
