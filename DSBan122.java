
package dao;

import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import model.Ban122;

public class DSBan122 {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/b21dcat122";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public Connection connect() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public List<Ban> getDanhSachBanTrong(String ngayDat, LocalTime gioDatInput, LocalTime gioKetThucInput) {
        List<Ban> danhSachBan = new ArrayList<>();
        String query = "SELECT * FROM ban122 WHERE trangThai = 'Trống' AND ngayDat = ?";

        try (Connection conn = connect();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, ngayDat);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LocalTime gioDatDB = rs.getTime("gioDat").toLocalTime();
                    LocalTime gioKetThucDB = rs.getTime("gioKetThuc").toLocalTime();

                    if (gioDatInput.isBefore(gioKetThucDB) && gioKetThucInput.isAfter(gioDatDB)) {
                        Ban ban = new Ban(
                                rs.getInt("soBan"),
                                rs.getString("trangThai"),
                                rs.getDate("ngayDat"),
                                rs.getTime("gioDat"),
                                rs.getTime("gioKetThuc")
                        );
                        danhSachBan.add(ban);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return danhSachBan;
    }

    private static class Ban {

        public Ban() {
        }

        private Ban(int aInt, String string, Date date, Time time, Time time0) {
            throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
        }
    }
}
