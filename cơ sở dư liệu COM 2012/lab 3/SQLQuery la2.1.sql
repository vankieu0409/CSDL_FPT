create database QLBHL2 --CSDL Lab 2
go
use QLBHL2
go
Create table KhachHang
( 
	MaKhachHang nvarchar(5) not null,
	HovaTen nvarchar(200) not null,
	Diachi nvarchar(200) not null,
	DienThoai nvarchar (200) not null,
	constraint PK_KhachHang primary key(MaKhachHang)
)
go
create table TaiKhoan
(
	SoTK int not null,
	MaKhachHang nvarchar(5) not null,
	NgayMoTK datetime not null,
	SoTien money not null,
	constraint PK_TaiKhoan primary key(SoTK),
	constraint FK_TaiKhoan_KhachHang foreign key(MaKhachHang) references KhachHang(MaKhachHang)
)
go
create table GiaoDich
(
	MaGD int not null,
	SoTK int not null,
	ThoiGianGD datetime not null,
	SoTienGD money not null,
	MoTa nvarchar(150) not null,
	SoDuTaiKhoan money not null,
	constraint PK_GiaoDich primary key(MaGD),
	constraint FK_GiaoDich_TaiKhoan foreign key(SoTK) references TaiKhoan(SoTK)
)
go

INsert into KhachHang(MaKhachHang,HovaTen,Diachi,DienThoai)
Values ('KH01',N'Nguyễn văn Kiều',N'Vĩnh Phúc','0987654321')
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,DienThoai)
Values ('KH02',N'Nguyễn văn Bậu',N'Vĩnh Phúc','0987256432')
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,DienThoai)
Values ('KH03',N'Nguyễn văn Bệu',N'Vĩnh Phúc','0987256433')
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,DienThoai)
Values ('KH04',N'Nguyễn văn Bêu',N'Vĩnh Phúc','0987256434')
INsert into KhachHang(MaKhachHang,HovaTen,Diachi,DienThoai)
Values ('KH05',N'Nguyễn văn Bếu',N'Vĩnh Phúc','0987256435')

insert  into TaiKhoan(SoTK,MaKhachHang,NgayMoTK,SoTien)
Values (0321548974,'KH01','2021-1-15',1000000)
insert  into TaiKhoan(SoTK,MaKhachHang,NgayMoTK,SoTien)
Values (0321548975,'KH02','2021-1-15',1000000)
insert  into TaiKhoan(SoTK,MaKhachHang,NgayMoTK,SoTien)
Values (0321548976,'KH03','2021-1-15',1000000)
insert  into TaiKhoan(SoTK,MaKhachHang,NgayMoTK,SoTien)
Values (0321548977,'KH04','2021-1-15',1000000)
insert  into TaiKhoan(SoTK,MaKhachHang,NgayMoTK,SoTien)
Values (0321548978,'KH05','2021-1-15',1000000)


insert into GiaoDich(MaGD,SoTK,ThoiGianGD,SoTienGD,MoTa,SoDuTaiKhoan)
values (1,0321548974,'2020-1-15',50000,N'Mua Link Kiện',950000)
insert into GiaoDich(MaGD,SoTK,ThoiGianGD,SoTienGD,MoTa,SoDuTaiKhoan)
values (2,0321548975,'2020-1-15',50000,N'Mua Link Kiện',950000)
insert into GiaoDich(MaGD,SoTK,ThoiGianGD,SoTienGD,MoTa,SoDuTaiKhoan)
values (3,0321548976,'2020-1-15',50000,N'Mua Link Kiện',950000)
insert into GiaoDich(MaGD,SoTK,ThoiGianGD,SoTienGD,MoTa,SoDuTaiKhoan)
values (4,0321548977,'2020-1-15',50000,N'Mua Link Kiện',950000)
insert into GiaoDich(MaGD,SoTK,ThoiGianGD,SoTienGD,MoTa,SoDuTaiKhoan)
values (5,0321548978,'2020-1-15',50000,N'Mua Link Kiện',950000)

select * from KhachHang
select * from TaiKhoan
select * from GiaoDich