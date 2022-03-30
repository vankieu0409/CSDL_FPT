create database QLBH1 --CSDL Lab 2
go
use QLBH1
go
Create table KhachHang
( 
	MaKhachHang nvarchar(5) not null,
	HovaTen nvarchar(200) not null,
	Diachi nvarchar(200) not null,
	Email nvarchar(200) not null,
	DienThoai nvarchar (200) not null,
	constraint PK_KhachHang primary key(MaKhachHang)
)
go
create table SanPham
(
	MaSanPham int not null identity,-- tự động tăng
	MoTa nvarchar (255) not null,
	SoLuong int Not null,
	DonGia money not null,
	TenSP nvarchar(200) not null,
	constraint PK_SanPham primary key(MaSanPham),
	Constraint Check_SoLuong Check(SoLuong>0),
	constraint Check_DonGia Check(DonGia>0),
)
go
Create table HoaDon
(
	MaHoaDon  int not null,
	NgayMuaHang datetime not null,
	MaKhachHang Nvarchar (5) not null,
	TrangThai Nvarchar (200) Not null,
	constraint PK_HoaDon Primary key(MaHoaDon),
	constraint FK_HoaDon_KhachHang foreign key(MaKhachHang) references KhachHang(MaKhachHang)
)
go
create table HoaDonChiTiet
(
	MaHoaDon int not null,
	MaSanPham int not null,
	SoLuong int not null,
	MaHoaDonChiTiet int not null identity,
	constraint PK_HoaDonChiTiet primary key(MaHoaDonChiTiet),--Tu Dong tang
	constraint PK_HoaDonChiTiet_HoaDon foreign key(MaHoaDon) references HoaDon(MaHoaDon),
	constraint PK_HoaDonChiTiet_SanPham foreign key(MaSanPham) references SanPham(MaSanPham),
)
go
-- nhập liệu bảng khách hàng
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,Email,DienThoai)
Values ('KH01',N'Nguyễn văn Kiều',N'Vĩnh Phúc','ca@gmail.com','0987654321')
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,Email,DienThoai)
Values ('KH02',N'Nguyễn văn Bậu',N'Vĩnh Phúc','ba@gmail.com','0987256431')
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,Email,DienThoai)
Values ('KH03',N'Lê Thị Phương',N'Vĩnh Phúc','da@gmail.com','0987256431')
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,Email,DienThoai)
Values ('KH04',N'Lê Phương',N'Vĩnh Phúc','fa@gmail.com','0987256431')
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,Email,DienThoai)
Values ('KH05',N'Phương Lê',N'Vĩnh Phúc','ea@gmail.com','0987256431')

--Nhập Liệu bảng Sanpham
insert into SanPham(MoTa,SoLuong,DonGia,TenSP)
values (N'Chơi Game',5,10000,N'Điện thoại Iphone7 32GB')
insert into SanPham(MoTa,SoLuong,DonGia,TenSP)
values (N'Chơi Game',2,10000,N'ĐT')
insert into SanPham(MoTa,SoLuong,DonGia,TenSP)
values (N'Chơi Game',3,10000,N'Router')
insert into SanPham(MoTa,SoLuong,DonGia,TenSP)
values (N'Chơi Game',7,10000,N'PC')
insert into SanPham(MoTa,SoLuong,DonGia,TenSP)
values (N'Chơi Game',8,10000,N'laptop')



-- Nhập liệu bảng hóa đơn
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)
values (1,'1-15-2016','KH01',N' Chưa Thanh Toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)
values (2,'1-15-2021','KH02',N' Đã Thanh Toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)
values (3,'1-15-2021','KH03',N' Đã Thanh Toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)
values (4,'12-15-2021','KH04',N' Đã Thanh Toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)
values (5,'1-15-2021','KH05',N' Đã Thanh Toán')


insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong)
values (1,1,4)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong)
values (2,2,6)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong)
values (3,3,8)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong)
values (4,4,11)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong)
values (5,5,10)


select * from KhachHang
select * from SanPham
select * from HoaDon
select * from HoaDonChiTiet