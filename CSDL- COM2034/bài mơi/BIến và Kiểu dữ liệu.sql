use QLDA
go

--1. Khai báo biến trong TSQL
-- có 3 laoji biến : Biến vô hướng và biến Bảng
-- 1.1 Biến Vô Hướng
--cú PháP:
-- DEclare@Tenbien KieuDL[=giá trị Khỏi tạo],
--  

-->Khỏi tạo giá trị cho biến 
-- Set@tenBien = Giá trị

-- ví dụ: 
declare @hoten nvarchar(50), @DIEM FLOAT;
SET @hoten=N'Kiều';
set @DIEM=9;
print N'Bạn'+@hoten+N' đạt '+cast(@DIEM as varchar);


--ví dụ về phép toán của T-SQL. tinh chu vi và s HCN
declare @cannha float=10,@canhb float=4.5, @chuvi float,@dt float;

set @chuvi=(@cannha+@canhb)*2;
set @dt=@canhb*@cannha

select @cannha N'Cạnh a', @canhb cạnhB ,@chuvi N'CHu VI' ,@dt N'diện tích'

-- ví dụ 3: Khai báo 1 biến Lương với giá trị 30000.
-- tìm thông tin tất cả nhân viên có lương lớn hơn biến Lương sắp sếp theo chiều giảm dần
select* from NHANVIEN


declare @luong int=30000;
select* from NHANVIEN
where LUONG>@luong
order by LUONG desc

-- ví dụ 4: Đếm xem phòng có mã là 5 có bao nhiêu Nhân viên . Lư sô Nhân viên so vào biến

declare @soNVp5 int;
set @soNVp5=(select count(MANV) from NHANVIEN where PHG=5)
select @soNVp5 N'SỐ nhân viên Phòng 5'

-- ví dụ 5: đặt tên biến vảo trong câu lệnh select
-- tim tên nhân viên và lương cao nhất trong công ty và lưu tên, lương vào 2 biến

declare @tenmx nvarchar(15),@Luong1 int;
select @tenmx= TENNV,@Luong1=LUONG from NHANVIEN
where luong=(select max(LUONG) from NHANVIEN)
select @tenmx tên,@Luong1 Lương

--  Phần 1.2: Biến Bảng
-- cú pháp:
-- declare @tên Biến bảng table( 
-- tên cột1 Kiểu duex liệu,
-- tên coojt2 Kiểu dữ liệu,
-- ...
-- )

--ví dụ 1: 

declare @NHanVienp4 table(
mvn varchar(10),         --mỗi lần dùng đều phải chạy cả biến bảng
ten Nvarchar(15),
gioiTInh Nvarchar(15),
Luong float
)

-- chèn dữ liệu vào câu truy vấn
insert into @NHanVienp4	
select MANV,TENNV,PHAI,LUONG from NHANVIEN
where PHG=4
--chèn dữ liệu thông thường
select*from @NHanVienp4

-- bảng tạm temp thây- bồ

--bảng tạm cục bộ ==> tên có 1 dấu # đằng trước
select MANV,TENNV,PHAI,LUONG
into #NHVIENPHONG5

from NHANVIEN
where PHG=5

select* from #NHVIENPHONG5


--Bảng tạm toàn CỤc

select MANV,TENNV,PHAI,LUONG
into ##NHVIENPHONG3
from NHANVIEN
where PHG=5

select* from ##NHVIENPHONG3


