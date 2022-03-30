create database test2
go
use test2
go
create table VANPHONG
(
	MaVP nvarchar(50) not null,
	TenVP nvarchar(50) not null,
	MaTruSo nvarchar(50) not null,
	DienThoai nvarchar(50) not null,
	Email nvarchar(50) not null,
	TruongPhong nvarchar(50) not null,
	constraint PK_VANPHONG primary key (MaVP),
)
go

create table NHANVIEN
(
	MaNV nvarchar(50) not null,
	Hoten nvarchar(50) not null,
	MaVP nvarchar(50) not null,
	NgaySinh date not null,
	GioiTinh nvarchar(50) not null,
	Email nvarchar(50) not null,
	SoDT nvarchar(15) not null,
	CMND nvarchar(15) not null,
	constraint PK_NHANVIEN primary key (MaNV),
	constraint PK_NHANVIEN_VANPHONG foreign key (MaVP) references VANPHONG(MaVP)
)
go

insert into VANPHONG(MaVP,TenVP,MaTruSo,DienThoai,Email,TruongPhong)
values ('K01','FPT','A01',0857326448,'CA@gmail.com',' Nguyễn Văn Kiều')
insert into VANPHONG(MaVP,TenVP,MaTruSo,DienThoai,Email,TruongPhong)
values ('K02','FPC','A02',0857326448,'BA@gmail.com',' Nguyễn Văn')

insert into NHANVIEN(MaNV,Hoten,MaVP,NgaySinh,GioiTinh,Email,SoDT,CMND)
values ('B01','Nguyễn Kha','K01','1-9-1998','nam','CC@gmail.com','0987456321','138593973')
insert into NHANVIEN(MaNV,Hoten,MaVP,NgaySinh,GioiTinh,Email,SoDT,CMND)
values ('B02','Nguyễn Khi','K02','1-5-1998','nữ','CK@gmail.com','0987456321','138593974')

select * from VANPHONG
select * from NHANVIEN