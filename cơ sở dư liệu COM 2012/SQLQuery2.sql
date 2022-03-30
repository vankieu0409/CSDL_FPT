CREATE DATABASE QLBH3
go
use QLBH3
go
CREATE TABLE KHACHHANG
(
	MaKH nvarchar(5)not null,--not null: bắt buộc nhập
	tenKH nvarchar(50) not null,
	Diachi nvarchar(50),
	SoDienThoai nvarchar(50),
	primary key(MaKH)--tạo khóa chính
)
go
create table TAIKHOAN
(
	SoTK nvarchar(15)not null,
	MaKH nvarchar(5) not null,
	NgayMoTK nvarchar(50) ,
	SoTien nvarchar(50),
	primary key(SoTK)
	foreign key(MaKH) references KhachHang(MaKH), -- Tạo Khóa ngoại
	check (sotien>=0), -- tạo ràng buộc
)
go
create table GIAO_DICH
(
	MaGD nvarchar(50) not null,
	SoTK nvarchar(15) not null,
	ThoiGianGD nvarchar(50) not null,
	SotienGD nvarchar(50),
	MotaDG nvarchar(50),
	SoDuTaiKhoan nvarchar(50),
	primary key (MaGD)
)
go
select * from TAIKHOAN --Nhập liệu bảng Khách Hàng
Insert into KHACHHANG(MaKH,tenKH,Diachi,SoDienThoai)
values ('KH01',N'Nguyễn Văn Kiều',N'văn cao','563456456');
go
