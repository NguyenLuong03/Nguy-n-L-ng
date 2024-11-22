<%@ page import="java.sql.*, java.util.*, java.time.LocalTime, java.time.format.DateTimeFormatter, java.time.Duration" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giao Diện Chọn Bàn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: inline-block;
            width: 150px;
        }
        input {
            width: 200px;
            padding: 5px;
        }
        button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .error {
            color: red;
            font-size: 14px;
        }
    </style>
    <script>
        // Hàm kiểm tra xem có bàn nào được chọn hay không
        function validateForm() {
            var selectedBan = document.querySelector('input[name="chonBan"]:checked');
            if (!selectedBan) {
                alert('Vui lòng chọn một bàn trước khi xác nhận!');
                return false; // Ngừng gửi form nếu không có bàn nào được chọn
            }
            return true; // Tiếp tục gửi form nếu đã chọn bàn
        }
    </script>
</head>
<body>
    <h1>Giao Diện Chọn Bàn</h1>
    <form method="GET" action="GDChonBan122.jsp">
        <div class="form-group">
            <label for="ngayDat">Ngày đặt:</label>
            <input type="date" id="ngayDat" name="ngayDat" value="<%= request.getParameter("ngayDat") != null ? request.getParameter("ngayDat") : "" %>" required>
        </div>
        <div class="form-group">
            <label for="gioDat">Giờ đặt:</label>
            <input type="time" id="gioDat" name="gioDat" value="<%= request.getParameter("gioDat") != null ? request.getParameter("gioDat") : "" %>" required>
        </div>
        <div class="form-group">
            <label for="gioKetThuc">Giờ kết thúc:</label>
            <input type="time" id="gioKetThuc" name="gioKetThuc" value="<%= request.getParameter("gioKetThuc") != null ? request.getParameter("gioKetThuc") : "" %>" required>
        </div>
        <button type="submit">Tìm Bàn Trống</button>
    </form>

    <% 
        // Lấy thông tin từ form
        String ngayDat = request.getParameter("ngayDat");
        String gioDat = request.getParameter("gioDat");
        String gioKetThuc = request.getParameter("gioKetThuc");
        String errorMsg = ""; // Biến chứa thông báo lỗi

        if (ngayDat != null && gioDat != null && gioKetThuc != null) {
            // Kiểm tra giờ đặt và giờ kết thúc hợp lệ
            try {
                // Chuyển giờ từ dạng String sang LocalTime để so sánh chi tiết (bao gồm giờ và phút)
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
                LocalTime gioDatInput = LocalTime.parse(gioDat, formatter);
                LocalTime gioKetThucInput = LocalTime.parse(gioKetThuc, formatter);

                // Kiểm tra giờ đặt phải >= 8h và giờ kết thúc phải <= 22h
                if (gioDatInput.isBefore(LocalTime.of(8, 0))) {
                    errorMsg = "Giờ đặt phải từ 8:00 sáng.";
                } else if (gioKetThucInput.isAfter(LocalTime.of(22, 0))) {
                    errorMsg = "Giờ kết thúc phải trước 22:00.";
                } else if (gioDatInput.isAfter(gioKetThucInput)) {
                    errorMsg = "Giờ đặt phải nhỏ hơn giờ kết thúc.";
                } else {
                    // Kiểm tra sự chênh lệch giữa giờ kết thúc và giờ đặt phải ít nhất 15 phút
                    Duration duration = Duration.between(gioDatInput, gioKetThucInput);
                    if (duration.toMinutes() < 15) {
                        errorMsg = "Giờ kết thúc phải cách giờ đặt ít nhất 15 phút.";
                    }
                }

                if (!errorMsg.isEmpty()) {
                    out.println("<p class='error'>" + errorMsg + "</p>");
                    return;
                }

                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    // Kết nối cơ sở dữ liệu
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/b21dcat122", "root", "");

                    // Câu truy vấn tìm bàn trống với ngày trùng khớp
                    String query = "SELECT * FROM ban122 WHERE trangThai = 'Trống' AND ngayDat = ?";
                    ps = conn.prepareStatement(query);
                    ps.setString(1, ngayDat); // Truyền ngày nhập vào vào câu truy vấn
                    rs = ps.executeQuery();

                    // Hiển thị danh sách bàn trống
    %>
                    <form method="POST" action="GDNhapThongTin122.jsp" onsubmit="return validateForm();">
                        <table>
                            <thead>
                                <tr>
                                    <th>Chọn</th>
                                    <th>Số Bàn</th>
                                    <th>Trạng Thái</th>
                                    <th>Ngày Đặt</th>
                                    <th>Giờ Đặt</th>
                                    <th>Giờ Kết Thúc</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% while (rs.next()) { 
                                    // Lấy giờ đặt và giờ kết thúc từ cơ sở dữ liệu
                                    LocalTime gioDatDB = rs.getTime("gioDat").toLocalTime();
                                    LocalTime gioKetThucDB = rs.getTime("gioKetThuc").toLocalTime();

                                    // Kiểm tra giờ nhập vào với giờ trong cơ sở dữ liệu
                                    boolean isValid = true;
                                    if (gioDatInput.isBefore(gioDatDB)) {
                                        isValid = false; // Giờ đặt nhập vào phải >= giờ đặt trong danh sách
                                    } else if (gioKetThucInput.isAfter(gioKetThucDB)) {
                                        isValid = false; // Giờ kết thúc nhập vào phải <= giờ kết thúc trong danh sách
                                    } else if (gioDatInput.isAfter(gioKetThucInput)) {
                                        isValid = false; // Giờ đặt phải nhỏ hơn giờ kết thúc
                                    }

                                    if (!isValid) {
                                        continue; // Bỏ qua bàn này nếu giờ không hợp lệ
                                    }
                                %>
                                    <tr>
                                        <td><input type="radio" name="chonBan" value="<%= rs.getInt("soBan") %>"></td>
                                        <td><%= rs.getInt("soBan") %></td>
                                        <td><%= rs.getString("trangThai") %></td>
                                        <td><%= rs.getDate("ngayDat") != null ? rs.getDate("ngayDat") : "Chưa Đặt" %></td>
                                        <td><%= rs.getTime("gioDat") != null ? rs.getTime("gioDat") : "Chưa Đặt" %></td>
                                        <td><%= rs.getTime("gioKetThuc") != null ? rs.getTime("gioKetThuc") : "Chưa Đặt" %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <button type="submit">Xác Nhận Chọn Bàn</button>
                    </form>
    <%
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Lỗi: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } catch (Exception e) {
                out.println("<p class='error'>Lỗi: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
