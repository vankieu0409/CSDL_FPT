
use QLDA
go
-- bài 5: 
--1 tạp thủ tục
create proc têntt @Thamso Kieu DuL[outPut]
as
begin
-- lệnh làm việc
end

-- VD1: Xây dựng thủ tục tính tổng 2 số: có 2 tham số đầu vào, không có đầu ra
if OBJECT_ID('SP_TinhToong2So') is not null-- kiểm tra nếu thủ tục tồn tại =>xóa
drop proc SP_TinhToong2So
go

create proc SP_TinhToong2So @so1 int, @so2 int
as
begin
declare @tong int;
set @tong=@so1+@so2
print N'Tổng là: '+cast(@tong As nvarchar)
end
go

--goi thủ tục
exec SP_TinhToong2So 12,3 -- truyền theo vị trí
exec SP_TinhToong2So @so1=7,@so2=8 --truyền theo tham số


if OBJECT_ID('SP_TinhToong2So2') is not null-- kiểm tra nếu thủ tục tồn tại =>xóa
drop proc SP_TinhToong2So2
go

create proc SP_TinhToong2So2 @so1 int, @so2 int,@tong int output
as
begin

set @tong=@so1+@so2
print N'Tổng là: '+cast(@tong As nvarchar)
end
go

--gọi thut tục
declare @kq int
exec SP_TinhToong2So2 12,3,@kq out
select @kq-- truyền theo vị trí
exec SP_TinhToong2So2 @so1=7,@so2=8, @tong=@kq out
select @kq


-- tham số mẶc Định
if OBJECT_ID('SP_TinhToong2So3') is not null-- kiểm tra nếu thủ tục tồn tại =>xóa
drop proc SP_TinhToong2So2
go
create proc SP_TinhToong2So3 @so1 int=3, @so2 int=6
as
begin
declare @tong3 int;
set @tong3=@so1+@so2
print N'Tổng là: '+cast(@tong3 As nvarchar)
end
go

--gọi tt 
exec SP_TinhToong2So3
exec SP_TinhToong2So3 12,3 -- truyền theo vị trí
exec SP_TinhToong2So3 @so1=7,@so2=8 --truyền theo tham số


--thủ tục dùng return để trả về giá trị
--( chỉ return số nguyên)
-- VD2: Xây dựng thủ tục tính tổng 2 số: có 2 tham số đầu vào, dùng return để trả về giá trị
if OBJECT_ID('SP_TinhToong2So3') is not null
drop proc SP_TinhToong2So3
go
create proc SP_TinhToong2So3 @so1 int=3, @so2 int=6
as
begin
declare @tong4 int;
set @tong4=@so1+@so2
return @tong4
end
go

--gọi tt 
declare @kq int
exec @kq= SP_TinhToong2So3
select @kq

exec @kq= SP_TinhToong2So3 12,3 -- truyền theo vị trí
select @kq
exec @kq= SP_TinhToong2So3 @so1=7,@so2=8 --truyền theo tham số
select @kq


-- VD5: Tạo thủ tục: Truy xuất thông tin nhân viên theo Mã nhân viên 
if OBJECT_ID('SP_TTNV') is not null
drop proc SP_TTNV
go
create proc SP_TTNV @MANV nvarchar(9)
as
begin
	select*from NHANVIEN
	where @MANV like MANV
end

exec SP_TTNV '001'

-- VD6:Tạo thủ tục có đầu vào là MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó 
--C1: Dùng output:
--C2: Dùng Return

if OBJECT_ID('SP_DEAN') is not null
drop proc SP_DEAN
go
create proc SP_DEAN @MDEA int,@SLNV int output
as
begin
	select @SLNV=Count(*)
	from PHANCONG join  NHANVIEN on PHANCONG.MA_NVIEN =NHANVIEN.MANV
	where @MDEA = MADA
end
declare @LS int
exec SP_DEAN 1 ,@LS out
select @LS
select*from DEAN join  NHANVIEN on DEAN.PHONG =NHANVIEN.PHG


--2.2
if OBJECT_ID ('DEAN2') IS NOT NULL
DROP PROC DEAN2
GO
CREATE PROC DEAN2 @MADA NVARCHAR(20)
AS 
BEGIN 
DECLARE @SODEAN INT
SELECT  @SODEAN=(
SELECT COUNT(*)
 FROM PHANCONG 
 WHERE MADA=@MADA)
 RETURN @SODEAN
END
GO
declare @KQ int
exec @KQ=DEAN2 3
select @KQ as SODEAN








--- bài cô loan
-- Nhập  @mada và @ DDiem-DA, cho biết SLNV tham gia vào đè án đó
if OBJECT_ID ('SPbai2_3') IS NOT NULL
DROP PROC SPbai2_3
create proc SPbai2_3 @maDA int,@Diem nvarchar(100)
as
select count(MA_NVIEN) 
from PHANCONG join DEAN on PHANCONG.MADA=DEAN.MADA
where DEAN.MADA=@maDA and DDIEM_DA =@Diem
exec SPbai2_3  N'Vũng Tàu'

/* Nhập vào @Trphg (mã trưởng phòng), xuất tt các NV 
có trưởng phòng là @Trphg và các NV này KO có thân nhân.*/
---C1: KO SỬ DỤNG PROC
SELECT * 
FROM NHANVIEN JOIN PHONGBAN ON NHANVIEN.PHG =PHONGBAN.MAPHG
WHERE TRPHG = 5 AND MANV  NOT IN (SELECT MA_NVIEN
								FROM THANNHAN)
---C2: SỬ DỤNG PROC
------<BÀI KTRA> 



IF OBJECT_ID('SPBAI3_3') IS NOT NULL
	DROP PROC SPBAI3_3
GO
CREATE PROC SPBAI3_3
	@HONV NVARCHAR(15), @TENLOT NVARCHAR(15), @TENNV NVARCHAR(15),
	@MANV VARCHAR(10), @NGSINH DATETIME, @DCHI NVARCHAR(50),
	@PHAI NVARCHAR(5), @LUONG MONEY, @MA_NQL VARCHAR(5), @PHG INT
AS
DECLARE @TUOI INT = DATEDIFF(YEAR, @NGSINH, GETDATE())
	IF(@PHG != (SELECT MAPHG FROM PHONGBAN WHERE TENPHG = 'IT'))
		PRINT N'NHẬP SAI, NHẬP LẠI VÌ NHÂN VIÊN KHÔNG THUỘC PHÒNG IT'
	ELSE IF @PHAI = 'NAM' AND (@TUOI < 18 OR @TUOI > 65)
		PRINT N'NHÂN VIÊN NAM PHẢI TUỔI TỪ 18 ĐẾN 65'
	ELSE IF @PHAI = N'NỮ' AND (@TUOI < 18 OR @TUOI > 60)
		PRINT N'NHÂN VIÊN NỮ PHẢI TUỔI TỪ 18 ĐẾN 60'
	ELSE
INSERT INTO NHANVIEN 
		VALUES(@HONV, @TENLOT,@TENNV,@MANV,@NGSINH,@DCHI,@PHAI,@LUONG,
				IIF(@LUONG < 25000,'009','005'),@PHG)
-----GỌI
EXEC SPBAI3_3 'A','B','C','00000','1977-10-10','HN','NAM',30000,NULL,6
select * from NHANVIEN