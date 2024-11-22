<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<html>
<head>
    <title>Danh Sách Món Ăn</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        .action-button {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .action-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Danh Sách Món Ăn</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên Món</th>
                <th>Giá Món</th>
                <th>Mô Tả</th>
                <th>Loại Món</th> <!-- Cột Loại Món -->
                <th>Hành Động</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Kết nối cơ sở dữ liệu và lấy danh sách món ăn
                String url = "jdbc:mysql://localhost:3306/b21dcat122";
                String user = "root"; // Tên người dùng MySQL
                String password = ""; // Mật khẩu (thường là rỗng đối với XAMPP)
                Connection connection = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Kết nối với MySQL
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, user, password);
                    stmt = connection.createStatement();
                    String sql = "SELECT * FROM monan122"; // Câu lệnh SQL
                    rs = stmt.executeQuery(sql);

                    // Lặp qua kết quả và hiển thị
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String tenMon = rs.getString("tenMon");
                        double giaMon = rs.getDouble("giaMon");
                        String moTa = rs.getString("moTa");
                        String loaiMon = rs.getString("loaiMon"); // Lấy thông tin loại món
            %>
            <tr>
                <td><%= id %></td>
                <td><%= tenMon %></td>
                <td><%= giaMon %></td>
                <td><%= moTa %></td>
                <td><%= loaiMon %></td> <!-- Hiển thị loại món -->
                <td>
                    <!-- Nút Thêm thông tin món ăn -->
                    <a href="GDTTTMonAn122.jsp?id=<%= id %>">
                        <button class="action-button">Thêm thông tin món ăn</button>
                    </a>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Đóng kết nối
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
