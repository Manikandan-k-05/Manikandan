package dao;

import bean.PaymentBean;
import db.DBconnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PaymentDAO {
    
  //  private static final String INSERT_PAYMENT_QUERY = "INSERT INTO payments (transaction_id, product_id, first_name, last_name, address, city, state, zip, country, phone, amount, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String INSERT_PAYMENT_QUERY = 
		    "INSERT INTO payments (userId, transaction_id, product_id, first_name, last_name, address, city, state, zip, country, phone, amount, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            pstmt.setString(13, payment.getPaymentStatus());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
