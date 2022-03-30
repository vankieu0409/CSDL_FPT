--Sử dụng csdl quản lý dự án để tạo Stored Procedure (SP), mỗi SP biết 2 lời gọi. 
use QLDA
go

--1. Tạo SP với tham số đầu vào thích hợp để chèn dữ liệu bảng ĐỊA ĐIỂM PHÒNG. Phải kiểm tra giá trị các tham số đầu vào và check trùng mã.
if OBJECT_ID('sp_diadiem') is not null
drop proc sp_diadiem
go
create proc sp_diadiem(
@MaPH int,
@DiaDiem nvarchar(15)
)
as 
if(select COUNT(MAPHG) from DIADIEM_PHG where MAPHG=@MaPH and DIADIEM_PHG=@DiaDiem)=1
print N' Địa điểm này đã có'
else
begin try
insert into DiaDiem_PHG values (@MaPH,@DiaDiem) 
end try
begin catch
print N' nhập sai'
end catch
go
exec sp_diadiem 1,N'KON tum'

select * from DiaDiem_PHG
--2. Tạo SP với tham số đầu vào thích hợp để chèn dữ liệu bảng NHÂN VIÊN. Với một số điều kiện sau
--- Nếu lương mà >=30000 thì cho nhân viên có mã người quản lý là 009. Ngược lại mã người quản lý là 005
-- - Nếu là nhân viên nam thì tuổi nằm trong khoảng từ 18-45. Nếu là nữ thì tuổi nằm trong khoảng là 18-40.
IF OBJECT_ID('SP BAI2') IS NOT NULL
	DROP PROC SPBAI2
GO
CREATE PROC SPBAI2
	@HONV NVARCHAR(15), @TENLOT NVARCHAR(15), @TENNV NVARCHAR(15),
	@MANV VARCHAR(10), @NGSINH DATETIME, @DCHI NVARCHAR(50),
	@PHAI NVARCHAR(5), @LUONG MONEY, @MA_NQL VARCHAR(5), @PHG INT
AS
DECLARE @TUOI INT = DATEDIFF(YEAR, @NGSINH, GETDATE())

	 IF @PHAI = 'NAM' AND (@TUOI < 18 OR @TUOI > 45)
		PRINT N'NHÂN VIÊN NAM PHẢI TUỔI TỪ 18 ĐẾN 45'
	ELSE IF @PHAI = N'NỮ' AND (@TUOI < 18 OR @TUOI > 40)
		PRINT N'NHÂN VIÊN NỮ PHẢI TUỔI TỪ 18 ĐẾN 40'
	ELSE
INSERT INTO NHANVIEN 
		VALUES(@HONV, @TENLOT,@TENNV,@MANV,@NGSINH,@DCHI,@PHAI,@LUONG,
				IIF(@LUONG < 25000,'009','005'),@PHG)
-----GỌI
EXEC SPBAI3_3 'A','B','C','00000','1977-10-10','HN','NAM',30000,NULL,6
select * from NHANVIEN
--3. Viết 1 SP với tham số đầu vào là mã phòng. Hiển thị ra các thông tin sau:
--- Cột 1: Mã nhân viên
--- Cột 2: Họ + tên đệm + tên nhân viên
--- Cột 3: Tên phòng ban
if OBJECT_ID('SP_31') is not null
	drop proc SP_31
creATE proc SP_31 @maphg int
as
begin
select MANV,HONV+' '+TENLOT+' '+TENNV, TENPHG 
from NHANVIEN join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
where MAPHG = @maphg
end
go

exec SP_31 1
		
--4. Viết 1 SP với tham số đầu vào là mã đề án, cho biết số lượng nhân viên tham gia đề án đó
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

--5. Viết 1 SP có tham số đầu vào là mã nhân viên và mã phòng. Kiểm tra nhân viên có nhân viên đó có thuộc phòng ban đó hay không?
if OBJECT_ID('SP_ktnv') is not null
drop proc SP_ktnv
go
create proc SP_ktnv @mp int,@mnv nvarchar(10)
as
begin
select
iif ( MANV=@mnv and PHG=@mp, N'NV này thuộc Phòng', N' Nhân viên này Không thộc phòng')
from NHANVIEN
go
exec SP_ktnv 2,'kieu'
--6. Viết một SP với các tham số đầu vào phù hợp. SP thực hiện tìm kiếm thông tin  nhân viên thỏa mãn điều kiện tìm kiếm theo: thuộc phòng ban nào (nhập mã phòng), mức lương trong khoảng bao nhiêu. SP này trả về thông tin nhân viên, gồm các cột có định dạng sau:
--- Cột 1: Mã nhân viên
--- Cột 2: Hiển thị tên nhân viên với kiểu sau
-- ▪ Nếu Phái là Nam. Hiển thị: A. + tên nhân viên. Ví dụ A. Thắng 
-- ▪ Nếu Phái là Nữ. Hiển thị: C. + tên nhân viên. Ví dụ C. Lan
--- Cột 3: Lương định dạng theo chuẩn Việt Nam. Ví dụ: 30.000
--7. Viết 1 SP với tham số đầu vào là mã nhân viên. Liệt kê toàn bộ thông tin của thân nhân của nhân viên đó, nếu nhân viên không có thân thân thông báo cho người dùng biết
if OBJECT_ID('SP_ThanNhan') is not null
	drop proc SP_thanthan
create proc SP_thannhan @ma nvarchar(10)
as
if (select count(THANNHAN.TENTN)from THANNHAN where MA_NVIEN=@ma)<=0
print N' Nhân viên trên không có thân nhân nào'
else
select* from THANNHAN where MA_NVIEN=@ma
go
exec SP_thannhan '001'