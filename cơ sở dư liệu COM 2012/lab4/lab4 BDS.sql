create database BDS
go
use BDS
go

create table DIADIEMVP
(
	MaVP nvarchar(5) not null,
	DiaDiem nvarchar(20) Not null,
	constraint PK_DIADIEM primary key (MaVP,DiaDiem),
	constraint FK_DIADIEM_VANPHONG foreign key (MaVP) references VANPHONG(MaVP)
)
go

create table VANPHONG
(
	MaVP nvarchar(5) not null,
	TenVP nvarchar(20) not null,
	SDT nvarchar(20) not null,
	Email nvarchar(50) not null,
	TruongPhong nvarchar(50) not null,
	constraint PK_VANPHONG primary key (MaVP)
)
go

create table NHANVIEN
(
	MaNV nvarchar(5) not null,
	Ten nvarchar(50) not null,
	MaVP nvarchar(5) not null,
	NgayS date,
	Gioitinh nvarchar(5),
	Email nvarchar(50) not Null,
	SoDT nvarchar(20) not null,
	CMND nvarchar(10),
	constraint PK_NHANVIEN primary key (MaNV),
	constraint FK_NHANVIEN_VANPHONG foreign key(MaVP) references VANPHONG(MaVP)
)
go

create table THANNHAN
(
	MaTN nvarchar(5) not null,
	MaNV NVARCHAR(5) not null,
	HoTen nvarchar(50) not null,
	Ngaysinh date,
	QH nvarchar(20) not null,
	constraint PK_THANNHAN primary key (MaTN),
	constraint FK_THANNHAN_NHANVIEN foreign key(MaNV) references NHANVIEN(MaNV)
)
go
create table CHUSOHUU
(
	MaCSH nvarchar(5) not null,
	TenCSH nvarchar(50) not null,
	DiaChi nvarchar(50) not null,
	SoDT nvarchar(20) not null,
	Email nvarchar(50) not Null,
	CMND nvarchar(20) not null,
	constraint PK_CHUSOHUU primary key (MaCSH),
)
go
create table BDS
(
	MaBDS nvarchar(5) not null,
	TenBDS nvarchar(50) not null,
	DiaChi nvarchar(50) not null,
	MaVP nvarchar(5) not null,
	MaCSH nvarchar(5) not null,
	constraint PK_BDS primary key (MaBDS),
	constraint FK_BDS_CHUSOHUU foreign key (MaCSH) references CHUSOHUU(MaCSH),
	constraint PK_BDS_VANPHONG foreign key (MaVP) references VANPHONG(MaVP),
)
go

insert into  DIADIEMVP(MaVP,DiaDiem)
values ('K01', N' Hà Nội')
insert into  DIADIEMVP(MaVP,DiaDiem)
values ('K02', N' Thanh Trì')

insert into VANPHONG(MaVP,TenVP,SDT,Email,TruongPhong)
values ('K01',N' BDS hà nội','02113987586','CA@gmail.com',N'NGuyễn Bậu')
insert into VANPHONG(MaVP,TenVP,SDT,Email,TruongPhong)
values ('K02',N' BDS Thanh Trì','02113987583','CB@gmail.com',N'NGuyễn Văn Bậu')

insert into NHANVIEN(MaNV,Ten,MaVP,NgayS,Gioitinh,Email,SoDT,CMND)
values ('A01',N'Nguyễn Văn Kiều','K01','9-4-1998',N'Nam','BEU@gmail.com','0987652336','183597852')
insert into NHANVIEN(MaNV,Ten,MaVP,NgayS,Gioitinh,Email,SoDT,CMND)
values ('A02',N'Nguyễn Kiều','K02','9-4-1998',N'Nam','BaU@gmail.com','0987652335','183597851')

insert into THANNHAN(MaTN,MaNV,HoTen,Ngaysinh,QH)
values ('B01','A01',N'Lê Thị Phương','6-9-1998',N' Vợ')
insert into THANNHAN(MaTN,MaNV,HoTen,Ngaysinh,QH)
values ('B02','A02',N'Lê Phương','6-9-1998',N' Vợ')

insert into CHUSOHUU(MaCSH,TenCSH,DiaChi,SoDT,Email,CMND)
values ('R01', N'Nguyễn Bệu',N' Nam Từ Liêm','0987456812','DA@gmail.com','02355897131546')
insert into CHUSOHUU(MaCSH,TenCSH,DiaChi,SoDT,Email,CMND)
values ('R02', N'Nguyễn Văn Bệu',N' Nam Từ Liêm','0987456811','DB@gmail.com','02355897131545')

insert into BDS(MaBDS,TenBDS,DiaChi,MaVP,MaCSH)
values ('C01', N'Đất Thổ Cư',N'Bắc Từ Liêm','K01','R01')
insert into BDS(MaBDS,TenBDS,DiaChi,MaVP,MaCSH)
values ('C02', N'Đất DỰ Án',N'Bắc Từ Liêm','K02','R02')

select*from DIADIEMVP
select*from VANPHONG
select*from NHANVIEN
select*from THANNHAN
select*from CHUSOHUU
select*from BDS