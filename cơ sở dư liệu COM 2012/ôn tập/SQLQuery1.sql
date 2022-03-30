create database QLKHANG
go
use QLKHANG
go

create table KHACHHANG
(
	makhachhang nvarchar(5) not null,
	Tenkhachhang nvarchar(50) not null,
	DIACHI nvarchar(20) not null,
	SDT nvarchar(20) not null,
	primary key (makhachhang)
)
go
create table HANGHOA
(
	mahanghoa nvarchar(5)not null,
	TENhanghoa nvarchar(20)not null,
	DONGIA money not null,
	DVT nvarchar(10) not null,
	SOLUONG int not null
	primary key (mahanghoa)
)
go
create table PHIEUNHAP
(
	soPhieunhap nvarchar(5) not null,
	Ngaynhap date not null,
	makhachhang nvarchar(5) not null
	primary key(soPhieunhap)
	foreign key(makhachhang) references KHACHHANG(makhachhang)
)
go
create table CT_NHAP
(	
	soPhieunhap nvarchar(5) not null,
	mahanghoa nvarchar(5)not null,
	SOLUONG int
	primary key(soPhieunhap,mahanghoa)
	foreign key(soPhieunhap) references PHIEUNHAP(soPhieunhap),
	foreign key(mahanghoa) references HANGHOA(mahanghoa)
)
go

insert into KHACHHANG
values('k01',N'Nguyễn Kiều',N' Vĩnh phúc','0123456789'),
('k02',N'Nguyễn Phương',N' Vĩnh phúc','0123456789'),
('k03',N' Lê Phương',N' Vĩnh phúc','0123456789')


insert into HANGHOA
values('h01',N'ấm điện',100000,N'Cái',10),
('h02',N'nồi điện',2000000,N'Cái',8),
('h03',N'bếp điện',300000,N'Cái',20)

insert into PHIEUNHAP
values ('01','2021-5-18','k01'),
('02','2021-6-18','k03'),
('03','2021-5-30','k02')

insert into CT_NHAP
values( '01','h01',4),
( '02','h01',5),
( '03','h02',14)

select* from KHACHHANG
select* from HANGHOA
select* from PHIEUNHAP
select* from CT_NHAP

--1. Liệt kê hàng hóa có số lượng >10
select *
from HANGHOA
where SOLUONG>10

--2. Liệt kê các phiếu nhập (So_PN, NgayLap, soluong, dongia, thanhtien) có THANHTIEN  từ 1000000 đến 6000000. 
select PHIEUNHAP.soPhieunhap,Ngaynhap,CT_NHAP.SOLUONG,DONGIA,(DONGIA * CT_NHAP.SOLUONG) as thanhtien
from PHIEUNHAP inner join CT_NHAP on PHIEUNHAP.soPhieunhap=CT_NHAP.soPhieunhap 
inner join HANGHOA on HANGHOA.mahanghoa=CT_NHAP.mahanghoa
--3. Với mỗi KHACHHANG, liệt kê tên khach hàng, Số lần nhập hàng. Kể cả những khách hàng chưa nhập hàng lần nào
--4. Cho biết có bao nhiêu phiếu nhập trong năm 2018. 
--5. Đưa ra thông tin khách hàng chưa bao giờ nhập hàng 
--6. Thêm 1 cột email cho khách hàng. Cập nhập mã khách hàng “KH001” có email là mail123@gmail.com
