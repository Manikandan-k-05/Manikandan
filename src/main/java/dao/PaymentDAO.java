package dao;

import bean.PaymentBean;
import db.DBconnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

	private static final String INSERT_PAYMENT_QUERY = "INSERT INTO payments (userId, transaction_id, product_id, first_name, last_name, address, city, state, zip, country, phone, amount, quantity, payment_status) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	public boolean savePaymentDetails(PaymentBean payment) {
		try (Connection conn = DBconnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(INSERT_PAYMENT_QUERY)) {

			pstmt.setInt(1, payment.getUserId());
			pstmt.setString(2, payment.getTransactionId());
			pstmt.setString(3, payment.getProductId());
			pstmt.setString(4, payment.getFirstName());
			pstmt.setString(5, payment.getLastName());
			pstmt.setString(6, payment.getAddress());
			pstmt.setString(7, payment.getCity());
			pstmt.setString(8, payment.getState());
			pstmt.setString(9, payment.getZip());
			pstmt.setString(10, payment.getCountry());
			pstmt.setString(11, payment.getPhone());
			pstmt.setDouble(12, payment.getAmount());
			pstmt.setInt(13, payment.getQuantity()); // Set quantity
			pstmt.setString(14, payment.getPaymentStatus());

			int rowsAffected = pstmt.executeUpdate();
			return rowsAffected > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}


    
    public List<PaymentBean> getPaymentsWithPagination(int offset, int limit) {
        List<PaymentBean> paymentList = new ArrayList<>();
        String query = "SELECT userId, transaction_id, product_id, first_name, last_name, address, city, state, zip, country, phone, amount, quantity, payment_status " +
                       "FROM payments LIMIT ? OFFSET ?";

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    PaymentBean payment = new PaymentBean();
                    payment.setUserId(rs.getInt("userId"));
                    payment.setTransactionId(rs.getString("transaction_id"));
                    payment.setProductId(rs.getString("product_id"));
                    payment.setFirstName(rs.getString("first_name"));
                    payment.setLastName(rs.getString("last_name"));
                    payment.setAddress(rs.getString("address"));
                    payment.setCity(rs.getString("city"));
                    payment.setState(rs.getString("state"));
                    payment.setZip(rs.getString("zip"));
                    payment.setCountry(rs.getString("country"));
                    payment.setPhone(rs.getString("phone"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setQuantity(rs.getInt("quantity"));
                    payment.setPaymentStatus(rs.getString("payment_status"));

                    paymentList.add(payment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentList;
    }
    
    public List<PaymentBean> getAllPayments() {
        List<PaymentBean> paymentList = new ArrayList<>();
        String query = "SELECT * FROM payments"; // Modify the query as per your database schema
        
        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query); 
             ResultSet rs = stmt.executeQuery()) {
                
            while (rs.next()) {
                PaymentBean payment = new PaymentBean();
                payment.setUserId(rs.getInt("userId"));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setProductId(rs.getString("product_id"));
                payment.setFirstName(rs.getString("first_name"));
                payment.setLastName(rs.getString("last_name"));
                payment.setAddress(rs.getString("address"));
                payment.setCity(rs.getString("city"));
                payment.setState(rs.getString("state"));
                payment.setZip(rs.getString("zip"));
                payment.setCountry(rs.getString("country"));
                payment.setPhone(rs.getString("phone"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setQuantity(rs.getInt("quantity"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                paymentList.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentList;
    }

}
