use QLBH1
go

--Bài 1 (4 điểm) Tạo chỉ mục trên các bảng có tần suất truy vấn nhiều
--a. Tạo chỉ mục UNIQUE trên cột điện thoại của bảng khách hàng
create unique index index_u_KHACHHANG on KHACHHANG(DienThoai);
--b. Tạo chỉ mục UNIQUE trên cột email của bảng khách hàng
create unique index index_E_KHACHHANG on KHACHHANG(Email);




--b. Sử dụng hệ quản trị csdl My SQL hoặc SQL Server để lưu trữ dữ liệu
-- Thực hiện các thao tác import/export DB ra file .sql
-- Sao lưu dự phòng
--Tạo user trong my sql