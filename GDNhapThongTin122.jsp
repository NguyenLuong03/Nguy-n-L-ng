<%@ page import="java.sql.*, java.util.*, java.time.LocalTime, java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập Thông Tin Đặt Bàn</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 30px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-size: 14px;
            margin-bottom: 5px;
            color: #555;
        }
        input {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 100%;
            box-sizing: border-box;
        }
        input[readonly] {
            background-color: #f5f5f5;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .info {
            color: #4CAF50;
            font-size: 14px;
            margin-top: 10px;
        }
        .back-button-container {
            text-align: right;
            margin-top: 20px;
        }
        .back-button {
            background-color: #2196F3;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .back-button:hover {
            background-color: #1976D2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Nhập Thông Tin Đặt Bàn</h1>
        <form method="POST" action="GDNhapThongTin122.jsp">
            <div class="form-group">
                <label for="soBan">Số Bàn:</label>
                <input type="text" id="soBan" name="soBan" value="<%= request.getParameter("chonBan") != null ? request.getParameter("chonBan") : "" %>" readonly>
            </div>

            <div class="form-group">
                <label for="tenKhachHang">Tên Khách Hàng:</label>
                <input type="text" id="tenKhachHang" name="tenKhachHang" required>
            </div>

            <div class="form-group">
                <label for="soDienThoai">Số Điện Thoại:</label>
                <input type="text" id="soDienThoai" name="soDienThoai" pattern="\d{10}" title="Số điện thoại phải có 10 chữ số" required>
                <small>Vui lòng nhập số điện thoại có 10 chữ số.</small>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <button type="submit">Xác nhận đặt bàn</button>
        </form>

        <% 
            String tenKhachHang = request.getParameter("tenKhachHang");
            String soDienThoai = request.getParameter("soDienThoai");
            String email = request.getParameter("email");
            String soBan = request.getParameter("soBan");

            if (tenKhachHang != null && !tenKhachHang.isEmpty() && 
                soDienThoai != null && !soDienThoai.isEmpty() &&
                email != null && !email.isEmpty()) {
                
                // Cập nhật trạng thái bàn
                try {
                    // Kết nối với cơ sở dữ liệu b21dcat122 và bảng ban122
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/b21dcat122", "root", "");
                    String query = "UPDATE ban122 SET trangThai = 'Đã đặt' WHERE soBan = ?";
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, soBan);
                    int rowsUpdated = pst.executeUpdate();
                    con.close();

                    if (rowsUpdated > 0) {
                        // Lưu thông báo thành công vào request attribute
                        request.setAttribute("message", "Đặt bàn thành công cho số bàn " + soBan + "!");
                    } else {
                        request.setAttribute("message", "Không thể cập nhật trạng thái bàn. Vui lòng thử lại.");
                    }

                } catch (Exception e) {
                    request.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
                }
            } else {
                request.setAttribute("message", "Vui lòng điền đầy đủ thông tin để xác nhận đặt bàn.");
            }
        %>

        <!-- Hiển thị thông báo -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div class="info"><%= message %></div>
            <!-- Nút quay lại trang GDKhachHang122 -->
            <div class="back-button-container">
                <a href="GDKhachHang122.jsp" class="back-button">Quay lại</a>
            </div>
        <% 
            }
        %>

    </div>
</body>
</html>
