<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<html>
<head>
    <title>Cập Nhật Thông Tin Món Ăn</title>
    <style>
        .message {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
            color: green;
        }
        .button {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<%
    // Lấy các tham số từ form
    String id = request.getParameter("id");
    String tenMon = request.getParameter("tenMon");
    String giaMonStr = request.getParameter("giaMon");
    String moTa = request.getParameter("moTa");
    String loaiMon = request.getParameter("loaiMon");

    double giaMon = 0.0;
    try {
        giaMon = Double.parseDouble(giaMonStr);
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }

    String url = "jdbc:mysql://localhost:3306/b21dcat122";
    String user = "root";
    String password = "";
    Connection connection = null;
    PreparedStatement psmt = null;
    boolean isUpdated = false;

    try {
        // Kết nối tới cơ sở dữ liệu
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);

        // Cập nhật thông tin món ăn
        String sql = "UPDATE monan122 SET tenMon = ?, giaMon = ?, moTa = ?, loaiMon = ? WHERE id = ?";
        psmt = connection.prepareStatement(sql);
        psmt.setString(1, tenMon);
        psmt.setDouble(2, giaMon);
        psmt.setString(3, moTa);
        psmt.setString(4, loaiMon);
        psmt.setInt(5, Integer.parseInt(id));

        // Thực thi câu lệnh cập nhật
        int result = psmt.executeUpdate();
        if (result > 0) {
            isUpdated = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (psmt != null) psmt.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<% if (isUpdated) { %>
    <!-- Thông báo cập nhật thành công -->
    <div class="message">
        <h2>Cập nhật thông tin món ăn thành công!</h2>
    </div>
    <div class="button">
        <a href="GDQLMonAn122.jsp" style="text-decoration: none; color: white; background-color: green; padding: 10px 20px; border-radius: 5px;">Quay lại danh sách món ăn</a>
    </div>
<% } else { %>
    <!-- Thông báo cập nhật thất bại -->
    <div class="message" style="color: red;">
        <h2>Không thể cập nhật món ăn. Vui lòng thử lại!</h2>
    </div>
    <div class="button">
        <a href="danhSachMonAn.jsp" style="text-decoration: none; color: white; background-color: red; padding: 10px 20px; border-radius: 5px;">Quay lại danh sách món ăn</a>
    </div>
<% } %>

</body>
</html>
