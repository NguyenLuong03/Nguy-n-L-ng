package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {

    // Thông tin kết nối
    private static final String URL = "jdbc:mysql://localhost:3306/b21dcat122"; // Thay localhost nếu sử dụng máy chủ khác
    private static final String USER = "root"; // Tên người dùng của MySQL (mặc định trong XAMPP là 'root')
    private static final String PASSWORD = ""; // Mật khẩu (mặc định trong XAMPP là trống)

    // Phương thức lấy kết nối
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Đăng ký MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Tạo kết nối
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Kết nối thành công đến cơ sở dữ liệu b21dcat122!");
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy driver JDBC MySQL.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
            e.printStackTrace();
        }
        return conn;
    }

    // Phương thức đóng kết nối (nên được gọi sau khi sử dụng kết nối)
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Kết nối đã được đóng.");
            } catch (SQLException e) {
                System.err.println("Không thể đóng kết nối.");
                e.printStackTrace();
            }
        }
    }
}
