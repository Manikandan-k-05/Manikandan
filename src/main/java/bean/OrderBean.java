/*
 * package bean;
 * 
 * public class OrderBean { private int orderId; private String customerName;
 * private String productName; private int quantity; private double price;
 * private String status;
 * 
 * // Getters and Setters public int getOrderId() { return orderId; } public
 * void setOrderId(int orderId) { this.orderId = orderId; } public String
 * getCustomerName() { return customerName; } public void setCustomerName(String
 * customerName) { this.customerName = customerName; } public String
 * getProductName() { return productName; } public void setProductName(String
 * productName) { this.productName = productName; } public int getQuantity() {
 * return quantity; } public void setQuantity(int quantity) { this.quantity =
 * quantity; } public double getPrice() { return price; } public void
 * setPrice(double price) { this.price = price; } public String getStatus() {
 * return status; } public void setStatus(String status) { this.status = status;
 * } }
 */

package bean;

public class OrderBean {
    private int orderId;
    private int customerId;      // Represents the customerId (foreign key)
    private int productId;       // Represents the productId (foreign key)
    private int quantity;        // Quantity of the product ordered
    private double price;        // Price of the product
    private String status;       // Status of the order (e.g., "Pending", "Shipped")

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
