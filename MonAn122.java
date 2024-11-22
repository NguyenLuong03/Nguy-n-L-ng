package model;

/**
 *
 * @author joy
 */
public class MonAn122 {
    private int id;
    private String tenMon;
    private double giaMon;
    private String moTa;
    private String loaiMon;  // Thêm thuộc tính loại món ăn

    // Constructor
    public MonAn122(int id, String tenMon, double giaMon, String moTa, String loaiMon) {
        this.id = id;
        this.tenMon = tenMon;
        this.giaMon = giaMon;
        this.moTa = moTa;
        this.loaiMon = loaiMon;  // Khởi tạo loại món ăn
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenMon() {
        return tenMon;
    }

    public void setTenMon(String tenMon) {
        this.tenMon = tenMon;
    }

    public double getGiaMon() {
        return giaMon;
    }

    public void setGiaMon(double giaMon) {
        this.giaMon = giaMon;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public String getLoaiMon() {
        return loaiMon;  // Getter cho loại món ăn
    }

    public void setLoaiMon(String loaiMon) {
        this.loaiMon = loaiMon;  // Setter cho loại món ăn
    }
}
