create database BanHang
go
use BanHang
go

create table KHACHHANG
(
	makhachhang nvarchar(5) not null,
	tenkhachhang nvarchar(30) not null,
	DIACHI nvarchar(50) not null,
	SDT nvarchar(10) not null
	constraint PK_KHACHHANG primary key(makhachhang)
)
go 
create table HANGHOA
(
	Mahanghoa nvarchar(5) not null,
	Tenhanghoa nvarchar(30) not null,
	DonGia money not null,
	DonVitinh nvarchar(5) not null,
	SoLuong int not null
	constraint PK_HANGHOA primary key(Mahanghoa)
)
go


create table PHIEUNHAP
(
	SoPN int not null,
	NgayNhap date not null,
	makhachhang nvarchar(5) not null
	constraint PK_PHIEUNHAP primary key (SoPN)
	constraint FK_PHIEUNHAP_KHACHHANG foreign key(makhachhang) references KHACHHANG(makhachhang)
)
go

create table CTNHAP
(
	SoPN int not null,
	Mahanghoa nvarchar(5) not null,
	SoLUONG int not null
	constraint PK_CTNHAP primary key (SoPN,MaHanghoa),
	constraint FK_CTNHAP_PHIEUNHAP foreign key (SoPN) references PHIEUNHAP(SoPN),
	constraint FK_CTNHAP_HANGHOA foreign key (MaHanghoa) references HANGHOA(MaHanghoa)
)
go

insert into KHACHHANG
values ('KH01',N'Nguyễn Văn Kiều',N'Vĩnh Phúc','0987654321'),
('KH02',N'Lê THị Phương', N'Vĩnh Phúc','0123568794'),
('KH03',N'Thiều Đức Lâm', N' Hà Nội','0976548123')

insert into PHIEUNHAP
values (01,'2019-01-26','KH01'),
(02,'2020-5-13','KH02'),
(03,'2016-7-20','KH03')

insert into HANGHOA
values ('BD01', N'Bình Nước', 250000,N'Cái', 5),
('BD02', N' Củ Cải', 10000,N'Củ',50),
('BD03', N' Gạo', 20000,N'Kg',100)

insert into CTNHAP
values(01,'BD01',3),
(02,'BD02',8),
(03,'BD03',20)



select* from KHACHHANG
select* from PHIEUNHAP
select* from CTNHAP
select* from HANGHOA


--Câu 2: Thực hiện bằng ngôn ngữ SQL các câu truy vấn sau:
--1. Liệt kê hàng hóa có số lượng >10
select HANGHOA.*
from HANGHOA
where SoLuong>10

--2. Liệt kê các phiếu nhập (So_PN, NgayLap, soluong, dongia, thanhtien) có THANHTIEN  từ 1000000 đến 6000000. 
select CTNHAP.SoPN,NgayNhap,CTNHAP.SoLUONG,DonGia, (DonGia*CTNHAP.SoLUONG) as ThanhTien
from PHIEUNHAP inner join CTNHAP on PHIEUNHAP.SoPN=CTNHAP.SoPN inner join HANGHOA on HANGHOA.Mahanghoa=CTNHAP.Mahanghoa
where (DonGia*CTNHAP.SoLUONG) > 100000 and (DonGia*CTNHAP.SoLUONG)<600000



--3. Với mỗi KHACHHANG, liệt kê tên khach hàng, Số lần nhập hàng. Kể cả những khách hàng chưa nhập hàng lần nào
select tenkhachhang, count(PHIEUNHAP.SoPN) as SoLanNhap
from KHACHHANG left outer join PHIEUNHAP on PHIEUNHAP.makhachhang=KHACHHANG.makhachhang
group by tenkhachhang
--4. Cho biết có bao nhiêu phiếu nhập trong năm 2018. 
select count(PHIEUNHAP.SoPN) as TongsoPM2018
from PHIEUNHAP
where YEAR(NgayNhap)=2018
--5. Đưa ra thông tin khách hàng chưa bao giờ nhập hàng 
select KHACHHANG.*
from KHACHHANG left outer join PHIEUNHAP on PHIEUNHAP.makhachhang=KHACHHANG.makhachhang
where PHIEUNHAP.SoPN is null
--6. Thêm 1 cột email cho khách hàng. Cập nhập mã khách hàng “KH001” có email là mail123@gmail.com 
alter table KHACHHANG
add Email nvarchar(40) 
update [KHACHHANG]
set Email ='mail123@gmail.com'
where makhachhang like 'KH01'

