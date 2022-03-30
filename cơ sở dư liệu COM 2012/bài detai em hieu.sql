create database QUANLI_DETAI
go
use QUANLI_DETAI
go
--Bảng 1:
create table GIAOVIEN(
magv char(20),
primary key(magv),
HoTen nvarchar(30),
NgaySinh date
)
go

--Bảng 2:
create table DETAI(
MaDT char(20) primary key,
TenDT nvarchar(30),
NamThucHien date,
magv char(20)
)
go

--Bảng 3:
create table SINHVIEN(
MaSV char(20) primary key,
HoTen nvarchar(20),
NgaySinh date,
QueQuan nvarchar(30),
MaDT char(20),
DiemSO float
)
go

-- Liên kết:
alter table DETAI add
foreign key(magv) references GIAOVIEN(magv)
alter table SINHVIEN add
foreign key (MaDT) references DETAI(MaDT)
go

--Bảng 1:
insert into GIAOVIEN(magv, HoTen, NgaySinh)
values ('PH1',N'A1','2002/02/25'),
       ('PH2',N'A2','2002/02/25'),
	   ('PH3',N'A3','2002/02/25'),
	   ('PH4',N'A4','2002/02/25'),
	   ('PH5',N'A5','2002/02/25'),
	   ('PH6',N'A6','2002/02/25'),
	   ('PH7',N'A7','2002/02/25'),
	   ('PH8',N'A8','2002/02/25'),
	   ('PH9',N'A9','2002/02/25'),
	   ('PH10',N'A10','2002/02/25')

go

--Bảng 2:
insert into DETAI(MaDT, Magv, TenDT, NamThucHien)
values('P1','PH1',N'Nghiên cứu','2021/01/01'),
      ('P2','PH1',N'Nghiên cứu','2021/01/01'),
      ('P3','PH3',N'Giao Diện','2021/01/01'),
	  ('P4','PH3',N'Giao Diện','2021/01/01'),
	  ('P5','PH5',N'Lập Trình','2021/01/01'),
	  ('P6','PH6',N'Lập Trình','2021/01/01'),
	  ('P7','PH7',N'Phân Tích','2021/01/01'),
	  ('P8','PH8',N'Phân Tích','2021/01/01'),
	  ('P9','PH9',N'Phân Tích','2021/01/01')
go
--Bảng 3:
insert into SINHVIEN(MaSV, HoTen, MaDT, NgaySinh, QueQuan, DiemSo)
values ('PH123',N'D1','P1','2002/02/25',N'Bắc Giang',9),
       ('PH124',N'D2','P2','2002/02/25',N'Bắc Giang',8),
	   ('PH125',N'D3','P3','2002/02/25',N'Bắc Giang',7),
	   ('PH126',N'D4','P1','2002/02/25',N'Bắc Giang',6),
	   ('PH127',N'D5','P5','2002/02/25',N'Bắc Giang',9),
	   ('PH128',N'D6','P2','2002/02/25',N'Bắc Giang',8),
	   ('PH129',N'D7','P7','2002/02/25',N'Bắc Giang',7),
	   ('PH130',N'D8','P1','2002/02/25',N'Bắc Giang',6),
	   ('PH131',N'D9','P3','2002/02/25',N'Bắc Giang',5)
	   go
	   
-- Chạy dữ liệu:
--CÂU 1
SELECT SINHVIEN.MaSV,SINHVIEN.HoTen,DETAI.TenDT
FROM SINHVIEN JOIN DETAI
ON SINHVIEN.MaDT=DETAI.MaDT
JOIN GIAOVIEN
ON GIAOVIEN.Magv=DETAI.Magv
WHERE GIAOVIEN.HOTEN like N'%a1%'
--CÂU 2
SELECT GIAOVIEN.*
FROM GIAOVIEN inner JOIN DETAI ON GIAOVIEN.MAGV=DETAI.MAGV
WHERE MaDT in('P2','P1')

--CÂU 3
SELECT DETAI.MaDT,DETAI.TenDT,AVG(DIEMSO) AS DIEMTRUNGBINH
FROM DETAI JOIN SINHVIEN
ON DETAI.MADT=SINHVIEN.MaDT
WHERE NAMTHUCHIEN='2020'
GROUP BY DETAI.MaDT,DETAI.TenDT
GO
--CÂU 4
SELECT DETAI.NamThucHien,COUNT(MADT) AS SODETAI
FROM DETAI 
GROUP BY DETAI.NamThucHien


--Câu 5:
SELECT a.HoTen,b.Magv,COUNT(MaSV) [số luong sv] FROM Giaovien a INNER JOIN dbo.DETAI b ON a.Magv=b.Magv 
              INNER JOIN dbo.SINHVIEN ON SINHVIEN.MaDT = b.MaDT
			  WHERE NamThucHien = 2019
			  GROUP BY b.Magv ,a.HoTen
			  HAVING COUNT(MaSV)=(SELECT TOP 1 COUNT(MaSV) FROM  dbo.SINHVIEN INNER JOIN dbo.DETAI 
			  ON DETAI.MaDT = SINHVIEN.MaDT INNER JOIN  
			  Giaovien ON Giaovien.Magv=dbo.DETAI.Magv  GROUP BY  Giaovien.Magv 
			  ORDER BY COUNT(MaSV) DESC  )


--Câu 6:
select GIAOVIEN.Magv, GIAOVIEN.HoTen, COUNT(DETAI.MaDT) as SODETAIHD
from GIAOVIEN join DETAI
on GIAOVIEN.Magv=DETAI.Magv
group by GIAOVIEN.Magv, GIAOVIEN.HoTen
having count(DETAI.MaDT) > 2
-- câu 7:


select* from DETAI
select* from SINHVIEN
select* from GIAOVIEN
