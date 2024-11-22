<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<html>
<head>
    <title>Chỉnh Sửa Thông Tin Món Ăn</title>
    <style>
        .form-container {
            width: 50%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        label {
            font-size: 16px;
            margin-bottom: 10px;
            display: block;
        }
        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 8px;
            margin: 5px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .submit-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%
    String id = request.getParameter("id"); // Lấy ID từ tham số URL
    String url = "jdbc:mysql://localhost:3306/b21dcat122";
    String user = "root";
    String password = "";
    Connection connection = null;
    Statement stmt = null;
    ResultSet rs = null;

    String tenMon = "";
    double giaMon = 0.0;
    String moTa = "";
    String loaiMon = "";  // Thêm trường loaiMon

    if (id != null) {
        try {
            // Kết nối tới cơ sở dữ liệu
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            stmt = connection.createStatement();

            // Lấy thông tin món ăn từ cơ sở dữ liệu dựa trên ID
            String sql = "SELECT * FROM monan122 WHERE id = " + id;
            rs = stmt.executeQuery(sql);

            // Lấy kết quả từ câu truy vấn
            if (rs.next()) {
                tenMon = rs.getString("tenMon");
                giaMon = rs.getDouble("giaMon");
                moTa = rs.getString("moTa");
                loaiMon = rs.getString("loaiMon");  // Lấy loại món ăn
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
    }
%>

<h2>Chỉnh Sửa Thông Tin Món Ăn</h2>

<div class="form-container">
    <form action="capnhatmonan.jsp" method="POST">
        <input type="hidden" name="id" value="<%= id %>"/>

        <label for="tenMon">Tên Món Ăn:</label>
        <input type="text" id="tenMon" name="tenMon" value="<%= tenMon %>" required />

        <label for="giaMon">Giá Món Ăn:</label>
        <input type="number" id="giaMon" name="giaMon" value="<%= giaMon %>" required />

        <label for="moTa">Mô Tả:</label>
        <textarea id="moTa" name="moTa" rows="4" required><%= moTa %></textarea>

        <label for="loaiMon">Loại Món Ăn:</label>
        <select id="loaiMon" name="loaiMon" required>
            <option value="Món Khai vị" <%= loaiMon.equals("Món Khai Vị") ? "selected" : "" %>>Món Khai Vị</option>
            <option value="Món Chính" <%= loaiMon.equals("Món Chính") ? "selected" : "" %>>Món Chính</option>
            <option value="Món Tráng Miệng" <%= loaiMon.equals("Món Tráng Miệng") ? "selected" : "" %>>Món Tráng Miệng</option>
            <option value="Đồ uống" <%= loaiMon.equals("Đồ uống") ? "selected" : "" %>>Đồ Uống</option>
        </select>

        <button type="submit" class="submit-button">Cập Nhật Thông Tin</button>
    </form>
</div>

</body>
</html>
