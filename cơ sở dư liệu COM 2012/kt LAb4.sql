create database KTLAB
go
use KTLAB
go
create table SINHVIEN
(
	MaSV nvarchar(6) not null,
	TenSV nvarchar(100) not null,
	NgaySinh date,
	GioiTinh nvarchar(10) not null,
	MaKN nvarchar(5) not null,
	DiaChi nvarchar(100) not null,
	SDT nvarchar(20) not null,
	Email nvarchar(100) not null,
	constraint PK_SINHVIEN primary key (MaSV)
)
go


create table LOAIDIEM
(
	MaLoaidiem nvarchar(6) not null,
	Tenloaidiem nvarchar (50) not null,
	TrongSo int,
	constraint PK_LOAIDIEM primary key (MaLoaidiem)
)
go
create table DIEM
(
	MaSV nvarchar(6) not null,
	IDLopMon nvarchar(6) not null,
	MaLoaidiem nvarchar(6) not null,
	Diem nvarchar(6) not null,
	constraint PK_DIEM primary key (IDLopMon,MaSV,MaLoaidiem),
	constraint FK_DIEM_SINHVIEN foreign key(MaSV) references SINHVIEN(MaSV),
	constraint FK_DIEM_LOAIDIEM foreign key(MaLoaidiem) references LOAIDIEM(MaLoaidiem),
)
go
 insert into SINHVIEN(MaSV,TenSV,NgaySinh,GioiTinh,MaKN,DiaChi,SDT,Email)
 values ('K01','Nguyen Van Kieu','1-25-1998','Nam','B01',N' hà Nội','0987456123','CA@gmail.com')

 insert LOAIDIEM(MaLoaidiem,Tenloaidiem,TrongSo)
 values ('C01', N'điểm 1 tiết',10)

 insert into DIEM(MaSV,IDLopMon,MaLoaidiem,Diem)
 values ('K01','D01','C01','10')

 select * from SINHVIEN
 select * from LOAIDIEM
 select * from DIEM



