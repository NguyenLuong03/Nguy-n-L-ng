package dao;

public class DSBan122 {
    private int soBan;         // Số bàn
    private String trangThai;  // Trạng thái bàn (Trống / Đã đặt)
    private String ngayDat;    // Ngày đặt
    private String gioDat;     // Giờ đặt
    private String gioKetThuc; // Giờ kết thúc

    // Constructor
    public DSBan122(int soBan, String trangThai, String ngayDat, String gioDat, String gioKetThuc) {
        this.soBan = soBan;
        this.trangThai = trangThai;
        this.ngayDat = ngayDat;
        this.gioDat = gioDat;
        this.gioKetThuc = gioKetThuc;
    }

    // Getters và Setters
    public int getSoBan() {
        return soBan;
    }

    public void setSoBan(int soBan) {
        this.soBan = soBan;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getNgayDat() {
        return ngayDat;
    }

    public void setNgayDat(String ngayDat) {
        this.ngayDat = ngayDat;
    }

    public String getGioDat() {
        return gioDat;
    }

    public void setGioDat(String gioDat) {
        this.gioDat = gioDat;
    }

    public String getGioKetThuc() {
        return gioKetThuc;
    }

    public void setGioKetThuc(String gioKetThuc) {
        this.gioKetThuc = gioKetThuc;
    }
}