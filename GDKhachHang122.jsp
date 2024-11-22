<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giao diện Khách Hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }
        .container {
            width: 60%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Chào mừng bạn đến với nhà hàng của chúng tôi!</h1>
        <p>Vui lòng bấm vào nút dưới đây để đặt bàn tại nhà hàng.</p>
        <!-- Thay đổi action để chuyển đến GDChonBan122.jsp -->
        <form action="GDChonBan122.jsp" method="get">
            <button type="submit" class="btn">Đặt Bàn</button>
        </form>
    </div>
</body>
</html>
