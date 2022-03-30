create database BANHANG1
go
use BANHANG1
go

create table KHACHHANG
(
	MaKH Nvarchar(5) not null,
	tenkhachhang Nvarchar(20) not null,
	DIACHI Nvarchar(20) not null,
	SDT Nvarchar(20) not null,
	primary key (MaKH)
)
go

create table HANGHOA
(
	MaHH nvarchar(5) not null,
	TENhanghoa Nvarchar(20) not null,
	DONGIA money not null,
	DVT Nvarchar(20) not null,
	SOLUONG int not null
	primary key (MaHH)
)
go

create table PHIEUNHAP
(
	sophieunhap  Nvarchar(5) not null,
	ngaynhap date not null,
	SOLUONG int not null,
	MaKH Nvarchar(5) not null,
	primary key (sophieunhap),
	foreign key(MaKH) references KHACHHANG(MaKH)
)
go

create table CTNHAP
(
	sophieunhap Nvarchar(5) not null,
	MaHH nvarchar(5) not null,
	SOLUONG int not null
	primary key (sophieunhap,MaHH),
	foreign key (sophieunhap) references PHIEUNHAP(sophieunhap),
	foreign key (MaHH) references HANGHOA(MaHH)
)
go

insert into KHACHHANG
values ('K01',N'Nguyen Van Kieu',N'VInh Phuc', '09876543210'),
('K02',N'Nguyen Van bau',N'VInh Phuc', '09876565689'),
('K03',N' Van Kieu',N'VInh Phuc', '0987789410')

insert into HANGHOA
values ('H01',N' Am dien',100000,N'cai',12),
('H02',N'TU lanh',3000000,N'cai',10),
('H03',N'Noi Dien',500000,N'cai',2)

insert into PHIEUNHAP
values ('01','2021-5-28','K01'),
('02','2021-5-29','K01'),
('03','2021-1-28','K02')

insert into CTNHAP
values ('01','H01',5),
('02','H02',5),
('03','H03',5)




--1. Liệt kê hàng hóa có số lượng >10
select*
from HANGHOA
where SOLUONG>10


--2. Liệt kê các phiếu nhập (So_PN, NgayLap, soluong, dongia, thanhtien) có THANHTIEN  từ 1000000 đến 6000000. 
select PHIEUNHAP.sophieunhap,ngaynhap,DONGIA, (DONGIA*CTNHAP.SOLUONG) as thanhtien
from PHIEUNHAP inner join CTNHAP on CTNHAP.sophieunhap=PHIEUNHAP.sophieunhap
	inner join HANGHOA on HANGHOA.MaHH=CTNHAP.MaHH
where (DONGIA*CTNHAP.SOLUONG) between 1000000 and 6000000

--3. Với mỗi KHACHHANG, liệt kê tên khach hàng, Số lần nhập hàng. Kể cả những khách hàng chưa nhập hàng lần nào
select tenkhachhang, count(ngaynhap) as solannhap 
from KHACHHANG left outer join PHIEUNHAP on PHIEUNHAP.MaKH= KHACHHANG.MaKH
where PHIEUNHAP.ngaynhap is null
group by tenkhachhang

--4. Cho biết có bao nhiêu phiếu nhập trong năm 2018. 

select count(sophieunhap)
from PHIEUNHAP
where YEAR(ngaynhap)=2021
--5. Đưa ra thông tin khách hàng chưa bao giờ nhập hàng 

select KHACHHANG.*
from KHACHHANG left outer join PHIEUNHAP on PHIEUNHAP.MaKH= KHACHHANG.MaKH
where ngaynhap is null
--6. Thêm 1 cột email cho khách hàng. Cập nhập mã khách hàng “KH001” có email là mail123@gmail.com
alter table KHACHHANG
add Email nvarchar(40);-- thêm cột
update KHACHHANG
set Email='mail123@gmail.com'
where MaKH like N'%01%'

--chỉnh sửa cột
ALTER TABLE ten_bang
  ALTER COLUMN ten_cot kieu_cot;


  alter table PHIEUNHAP-- chỉnh dữ liệu trong bảng
drop column SOLUONG-- xóa cột