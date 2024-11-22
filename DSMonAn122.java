package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.MonAn122;

public class DSMonAn122 {
    private Connection connection;

    // Kết nối với cơ sở dữ liệu
    public DSMonAn122() {
        try {
            // Thay đổi thông tin kết nối nếu cần
            String url = "jdbc:mysql://localhost:3306/b21dcat122";
            String user = "root"; // Tên người dùng MySQL
            String password = ""; // Mật khẩu (thường là rỗng đối với XAMPP)
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách món ăn từ cơ sở dữ liệu
    public List<MonAn122> getDanhSachMonAn() {
        List<MonAn122> monAnList = new ArrayList<>();
        String sql = "SELECT * FROM monan122";  // Tên bảng trong cơ sở dữ liệu của bạn

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                int id = rs.getInt("id");
                String tenMon = rs.getString("tenMon");
                double giaMon = rs.getDouble("giaMon");
                String moTa = rs.getString("moTa");
                String loaiMon = rs.getString("loaiMon");  // Lấy dữ liệu loại món ăn

                // Khởi tạo đối tượng monan122 với thông tin đầy đủ
                MonAn122 monAn = new MonAn122(id, tenMon, giaMon, moTa, loaiMon);
                monAnList.add(monAn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monAnList;
    }
}
