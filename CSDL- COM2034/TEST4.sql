--Câu 1: T?o c? s? d? li?u DATHANG g?m 3 b?ng. (1.5 ?i?m)
--KHACHANG (Makh, Hoten, Ngaysinh, diachi,giotinh)
--SANPHAM (Masp, tensp ,soluong)
--COMMENT (Makh, Masp,noidung, ngaycmt)
create database DATHANG
go
use DATHANG
go
create table KHACHANG(
Makh char(5) not null primary key,
Hoten nvarchar(30),
Ngaysinh date,
diachi nvarchar(30),
gioitinh char(5),
)
go
create table SANPHAM(
Masp int not null primary key,
tensp nvarchar(30),
soluong int,)
go
create table COMMENT(
Makh char(5) not null ,
Masp int ,
noidung nvarchar(40),
ngaycmt date,
primary key(Makh,Masp),

foreign key(Makh) references KHACHANG(Makh),
foreign key(Masp) references SANPHAM(Masp))
go




--Câu 2: Chèn thông tin vào các b?ng (3 ?i?m)
--- T?o Stored Procedure (SP) v?i các tham s? ??u vào phù h?p KHACHHANG, SANPHAM,
--COMMENT
--- Yêu c?u m?i SP ph?i ki?m tra tham s? ??u vào. V?i các c?t không ch?p nh?n thu?c tính Null.
--V?i m?i SP vi?t 3 l?i g?i thành công.

if OBJECT_ID('sp_Y1') IS NOT NULL
DROP PROC sp_Y1
GO
CREATE PROC sp_Y1(
@Makh char(5) ,
@Hoten nvarchar(30),
@Ngaysinh date,
@diachi nvarchar(30),
@gioitinh char(5))
AS
IF(@Makh IS NULL) OR (@Hoten IS NULL) OR (@Ngaysinh IS NULL)
BEGIN 
     PRINT 'NHAP THIEU THONG TIN'
END
ELSE INSERT INTO KHACHANG VALUES (@Makh,@Hoten,@Ngaysinh,@diachi,@gioitinh)
     PRINT 'NHAP THNAH CONG'
	 GO
EXEC sp_Y1 'T1',N'LÊ NAM','1998-09-09',N'HÀ N?I',N'NAM'
EXEC sp_Y1 'T2',N'LÊ NO','1998-09-07',N'HÀ N?I',N'NAM'
EXEC sp_Y1 'T3',N'LÊ NU','1998-09-06',N'HÀ N?I',N'NAM'
--Y2
if OBJECT_ID('sp_Y2') IS NOT NULL
DROP PROC sp_Y2
GO
CREATE PROC sp_Y2(
@Masp int ,
@tensp nvarchar(30),
@soluong int
)
AS
IF(@Masp IS NULL) OR (@tensp IS NULL) OR (@soluong IS NULL)
BEGIN 
     PRINT 'NHAP THIEU THONG TIN'
END
ELSE INSERT INTO SANPHAM VALUES (@Masp,@tensp,@soluong)
     PRINT 'NHAP THNAH CONG'
	 GO

	 exec sp_Y2 '1','a','13'
	 exec sp_Y2 '2','b','14'
	 exec sp_Y2 '3','c','15'
	 
--y3
if OBJECT_ID('sp_Y3') IS NOT NULL
DROP PROC sp_Y3
GO
CREATE PROC sp_Y3(
@Makh char(5)  ,
@Masp int ,
@noidung nvarchar(40),
@ngaycmt date

)
AS
IF(@Makh IS NULL) OR (@Masp IS NULL) OR (@ngaycmt IS NULL) or (@noidung is null)

BEGIN 
     PRINT 'NHAP THIEU THONG TIN'
END
ELSE INSERT INTO COMMENT VALUES (@Makh,@Masp,@noidung,@ngaycmt)
     PRINT 'NHAP THNAH CONG'
	 GO

	 EXEC sp_Y3 'T1','1','ok','2020-09-09'
	 EXEC sp_Y3 'T2','2','ok','2020-09-09'
	 EXEC sp_Y3 'T3','3','ok','2020-09-09'


--Câu 3: Vi?t hàm các tham s? ??u vào t??ng ?ng v?i các c?t c?a b?ng SANPHAM. Hàm này tr?
--v? Masp th?a mãn các giá tr? ???c truy?n tham s?. (2 ?i?m)

if OBJECT_ID('fn_cau3') is not null
drop function fn_cau3
go

create function fn_cau3(
@Masp int ,
@tensp nvarchar(30),
@soluong int)
RETURNS TABLE 
AS  RETURN  (SELECT Masp from SANPHAM WHERE Masp=@Masp and tensp=@tensp and soluong=@soluong)
go
select * from fn_cau3('1' ,'a','13')

--Câu 4: T?o View l?u thông tin c?a TOP 2 có giá tr? s? l??ng ??n hàng l?n nh?t g?m các thông
--tin sau: Masp, tensp, s? l??ng commnet. (1.5 ?i?m)

if OBJECT_ID('b4') is not null
drop view b4
go
create view b4
as
select top 2 SANPHAM.Masp,SANPHAM.tensp,count(COMMENT.noidung) as SL_COMMENT
from SANPHAM JOIN COMMENT
on SANPHAM.Masp=COMMENT.Masp
GROUP BY SANPHAM.Masp,SANPHAM.tensp
ORDER BY COUNT(SANPHAM.soluong) DESC
GO
SELECT * FROM B4
--Câu 5: Viết một SP nhận một tham số đầu vào là SoLuong. SP này thực hiện thao tác xóa thông
--tin commnet và sanpham nếu tổng số lượng comment của sanpham đặt được > giá trị tham sô
--được truyền vào. (2 điểm)

IF OBJECT_ID('B5') IS NOT NULL
DROP PROC B5
GO
CREATE PROC B5(@soluong int)
as
begin try
-- b?ng t?m
BEGIN TRAN
declare @tam table (Masp int)

insert into @tam
select Masp from dbo.COMMENT GROUP BY Masp HAVING COUNT(ngaycmt)>@soluong
	DELETE FROM dbo.COMMENT WHERE Masp=(SELECT Masp FROM @tam)
	DELETE FROM dbo.SANPHAM WHERE Masp=(SELECT Masp FROM @tam)
COMMIT
END TRY
BEGIN CATCH
 ROLLBACK
END CATCH
GO

EXEC dbo.B5 @soluong = 0-- int




