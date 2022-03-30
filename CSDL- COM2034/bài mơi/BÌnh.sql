--Bài 1: (3 điểm)
--Viết stored-procedure:
--➢ In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của 
--bạn. Gợi ý:
--o sử dụng UniKey để gõ Tiếng Việt ♦
--o chuỗi unicode phải bắt đầu bởi N (vd: N’Tiếng Việt’) ♦
--o dùng hàm cast (<biểuThức> as <kiểu>) để đổi thành kiểu <kiểu> của<biểuThức>.
if OBJECT_ID('SP_Xinchao') is not null
	drop proc SP_Xinchao
create proc SP_Xinchao(@ten nvarchar(30))
as
print N' Xin chào '+@ten
exec SP_Xinchao N'BÌnh'

--➢ Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.
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
--➢ Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
if OBJECT_ID('SP_tongN') is not null-- kiểm tra nếu thủ tục tồn tại =>xóa
drop proc SP_tongN
create proc SP_tongN( @n int)
as
declare @c int=2,@d int=0;
while @d<=@n
set @c=@c+@d;
set @d=@d+2;
print N'tổng các số chẵn từ 1 đến @n' +cast(@c as varchar)

exec  SP_tongN 10

--➢ Nhập vào 2 số. In ra ước chung lớn nhất của chúng theo gợi ý dưới đây:
--o b1. Không mất tính tổng quát giả sử a <= A 
--o b2. Nếu A chia hết cho a thì : (a,A) = a ngược lại : (a,A) = (A%a,a) hoặc (a,A) = 
--(a,A-a) 
--o b3. Lặp lại b1,b2 cho đến khi điều kiện trong b2 được thỏaQuản trị cơ sở dữ liệu với SQL Server 2
-- 1.1




--Bài 2: (3 điểm)
--Sử dụng cơ sở dữ liệu QLDA, Viết các Proc:
--➢ Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
use QLDA
go

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


--➢ Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó

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

--➢ Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham 
--gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA
if OBJECT_ID ('SPbai2_3') IS NOT NULL
DROP PROC SPbai2_3
create proc SPbai2_3 @maDA int,@Diem nvarchar(100)
as
select count(MA_NVIEN) 
from PHANCONG join DEAN on PHANCONG.MADA=DEAN.MADA
where DEAN.MADA=@maDA and DDIEM_DA =@Diem
exec SPbai2_3  N'Vũng Tàu'



--➢ Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là 
--@Trphg và các nhân viên này không có thân nhân.
if OBJECT_ID('SP_TRGPHG') is not null
drop proc SP_TRGPHG
go
create proc SP_TRGPHG @Trgphg nvarchar(5)
as
begin
	select NHANVIEN.*
	from PHONGBAN join  NHANVIEN on PHONGBAN.MAPHG =NHANVIEN.PHG join THANNHAN on NHANVIEN.MANV=THANNHAN.MA_NVIEN
	where @Trgphg = TRPHG and TENTN is null
end

exec SP_TRGPHG '1'


select * from PHONGBAN
--➢ Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có 
--mã @Mapb hay không
if OBJECT_ID('SP_KTNV') is not null
drop proc SP_KTNV
go
create proc SP_KTNV @Trgphg nvarchar(5)
as

--Bài 3: (3 điểm)
--Sử dụng cơ sở dữ liệu QLDA, Viết các Proc
--➢ Thêm phòng ban có tên CNTT vào csdl QLDA, các giá trị được thêm vào dưới dạng 
--tham số đầu vào, kiếm tra nếu trùng Maphg thì thông báo thêm thất bại.
IF OBJECT_ID('SPBAI3_1') IS NOT NULL
	DROP PROC SPBAI3_1
GO
CREATE PROC SPBAI3_1
@Tenphg nvarchar(50), @maPHG int,@TRphg Nvarchar(8),@NGay date
as
if @maPHG=(SELECT MAPHG FROM PHONGBAN)
print N' THêm Thất bại'
else
INSERT INTO PHONGBAN
values(@Tenphg,@maPHG,@TRphg,@NGay)

exec SPBAI3_1  'CNTT',1,'00',2021-01-12
select*from PHONGBAN
--➢ Cập nhật phòng ban có tên CNTT thành phòng IT.
IF OBJECT_ID('SPBAI3_2') IS NOT NULL
	DROP PROC SPBAI3_2
GO
CREATE PROC SPBAI3_2
as
Update PHONGBAN
 set TENPHG= 'IT' where TENPHG like 'CNTT'

 exec SPBAI3_2


--➢ Thêm một nhân viên vào bảng NhanVien, tất cả giá trị đều truyền dưới dạng tham số đầu 
--vào với điều kiện:
--o nhân viên này trực thuộc phòng IT
--o Nhận @luong làm tham số đầu vào cho cột Luong, nếu @luong<25000 thì nhân 
--viên này do nhân viên có mã 009 quản lý, ngươc lại do nhân viên có mã 005 quản 
--lý
--o Nếu là nhân viên nam thi nhân viên phải nằm trong độ tuổi 18-65, nếu là nhân 
--viên nữ thì độ tuổi phải từ 18-60
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