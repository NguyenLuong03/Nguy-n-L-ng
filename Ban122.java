package model;

import java.sql.Date;
import java.sql.Time;

/**
 * Lớp Ban122 đại diện cho thông tin bàn trong hệ thống.
 */
public class Ban122 {

    private int soBan;         // Số bàn
    private String trangThai;  // Trạng thái bàn (ví dụ: "Trống", "Đã Đặt", "Đang Sử Dụng")
    private Date ngayDat;      // Ngày đặt bàn
    private Time gioDat;       // Giờ đặt bàn
    private Time gioKetThuc;   // Giờ kết thúc đặt bàn

    // Constructor đầy đủ với tham số kiểu Date và Time
    public Ban122(int soBan, String trangThai, Date ngayDat, Time gioDat, Time gioKetThuc) {
        this.soBan = soBan;
        this.trangThai = trangThai;
        this.ngayDat = ngayDat;
        this.gioDat = gioDat;
        this.gioKetThuc = gioKetThuc;
    }

    // Constructor với tham số đầu vào là String, thực hiện chuyển đổi sang Date và Time
    public Ban122(int soBan, String trangThai, String ngayDat, String gioDat, String gioKetThuc) {
        this.soBan = soBan;
        this.trangThai = trangThai;
        this.ngayDat = Date.valueOf(ngayDat);  // Chuyển đổi String sang Date
        this.gioDat = Time.valueOf(gioDat);    // Chuyển đổi String sang Time
        this.gioKetThuc = Time.valueOf(gioKetThuc); // Chuyển đổi String sang Time
    }

    // Getter và Setter cho Số bàn
    public int getSoBan() {
        return soBan;
    }

    public void setSoBan(int soBan) {
        this.soBan = soBan;
    }

    // Getter và Setter cho Trạng thái
    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    // Getter và Setter cho Ngày đặt
    public Date getNgayDat() {
        return ngayDat;
    }

    public void setNgayDat(Date ngayDat) {
        this.ngayDat = ngayDat;
    }

    // Getter và Setter cho Giờ đặt
    public Time getGioDat() {
        return gioDat;
    }

    public void setGioDat(Time gioDat) {
        this.gioDat = gioDat;
    }

    // Getter và Setter cho Giờ kết thúc
    public Time getGioKetThuc() {
        return gioKetThuc;
    }

    public void setGioKetThuc(Time gioKetThuc) {
        this.gioKetThuc = gioKetThuc;
    }

    @Override
    public String toString() {
        return "Ban122{" +
                "soBan=" + soBan +
                ", trangThai='" + trangThai + '\'' +
                ", ngayDat=" + ngayDat +
                ", gioDat=" + gioDat +
                ", gioKetThuc=" + gioKetThuc +
                '}';
    }
}
