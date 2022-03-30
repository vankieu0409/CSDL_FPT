--Câu 1: Tạo cơ sở dữ liệu DETAITOTNGHIEP  gồm 3 bảng.
--GIAOVIEN (Magv, Hoten, Ngaysinh,  Gioitinh, NamCongTac)
--DUAN (MaDA, Tenda, namthuchien, diadiem, magv)
--SINHVIEN (Masv, hoten, ngaysinh, diem, mada)
CREATE DATABASE DEANTOTNGHIEP
GO
USE DEANTOTNGHIEP
GO

CREATE TABLE GIAOVIEN
(
	MaGV NVARCHAR(5) NOT NULL PRIMARY KEY,
	Hoten NVARCHAR(50) NOT NULL,
	NgaySinh DATE NOT NULL,
	Gioitinh NVARCHAR(5) NOT NULL,
	NamCongtac INT NOT NULL,
)
GO

CREATE TABLE DEAN
(
	MaDA NVARCHAR(5) NOT NULL PRIMARY KEY,
	Tenda NVARCHAR(50) NOT NULL,
	namthuchien NVARCHAR(5) NOT NULL,
	diadiem NVARCHAR(100) NOT NULL,
	MaGV NVARCHAR(5) NOT NULL FOREIGN KEY REFERENCES dbo.GIAOVIEN(MaGV)
)
GO
CREATE TABLE SINHVIEN
(
	Masv NVARCHAR(5) NOT NULL PRIMARY KEY,
	hoten NVARCHAR(50) NOT NULL,
	ngaysinh DATE NOT NULL,
	diem FLOAT NOT NULL,
	MaDA NVARCHAR(5) NOT NULL FOREIGN KEY REFERENCES dbo.DEAN(MaDA)
)
GO



--Câu 2. Tạo 3 Stored Procedure (SP) với các tham số đầu vào phù hợp cho 3 bảng DUAN, GIAOVIEN, SINHVIEN để thêm dữ liệu vào. Và thực hiện 3 lời gọi hàm với mỗi SP

IF OBJECT_ID('SP_GIAOVIEN') IS NOT NULL
DROP PROC SP_GIAOVIEN
GO

CREATE PROC SP_GIAOVIEN
	@MaGV NVARCHAR(5), 
	@Hoten NVARCHAR(50) ,
	@NgaySinh DATE ,
	@Gioitinh NVARCHAR(5),
	@NamCongtac INT
AS
BEGIN
IF(@MaGV IS NULL)
	PRINT N' BẠn chưa nhập Mã GV'
	ELSE IF(@Hoten IS NULL)
	PRINT N' BẠn chưa nhập họ tên GV'
	ELSE IF(@NgaySinh IS NULL)
	PRINT N' BẠn chưa nhập Ngày Sinh GV'
	ELSE IF(@Gioitinh IS NULL)
	PRINT N' BẠn chưa nhập giới tính GV'
	ELSE IF(@NamCongtac IS NULL)
	PRINT N' BẠn chưa nhập số Năm Công tác GV'
	ELSE
BEGIN TRY
	INSERT INTO dbo.GIAOVIEN
(
    MaGV,
    Hoten,
    NgaySinh,
    Gioitinh,
    NamCongtac
)
	VALUES
(   @MaGV , 
	@Hoten  ,
	@NgaySinh  ,
	@Gioitinh ,
	@NamCongtac 
    )
END TRY
BEGIN CATCH 
	PRINT N' Bạn Nhập Sai Dữ Liệu'
END CATCH
END
GO

EXEC dbo.SP_GIAOVIEN @MaGV = N'01',              -- nvarchar(5)
                     @Hoten = N'kieu',             -- nvarchar(50)
                     @NgaySinh = '1998-06-16', -- date
                     @Gioitinh = N'nam',          -- nvarchar(5)
                     @NamCongtac = 2           -- int
EXEC dbo.SP_GIAOVIEN @MaGV = N'02',              -- nvarchar(5)
                     @Hoten = N'kkieu',             -- nvarchar(50)
                     @NgaySinh = '1988-06-16', -- date
                     @Gioitinh = N'nam',          -- nvarchar(5)
                     @NamCongtac = 10           -- int

EXEC dbo.SP_GIAOVIEN @MaGV = N'03',              -- nvarchar(5)
                     @Hoten = N'kkkieu',             -- nvarchar(50)
                     @NgaySinh = '1978-06-16', -- date
                     @Gioitinh = N'nữ',          -- nvarchar(5)
                     @NamCongtac = 17          -- int
EXEC dbo.SP_GIAOVIEN @MaGV = N'',              -- nvarchar(5)
                     @Hoten = N'',             -- nvarchar(50)
                     @NgaySinh = '2021-06-19', -- date
                     @Gioitinh = N'',          -- nvarchar(5)
                     @NamCongtac = 0           -- int
_


--Câu 3. Viết hàm các tham số đầu là giới tính. Hàm này trả về toàn bộ giáo viên tương tứng với giới tính truyền vào
IF OBJECT_ID('FN_GV') IS NOT NULL
DROP FUNCTION FN_GV
GO

CREATE FUNCTION FN_GV ( @gioitinh NVARCHAR(5))
RETURNS TABLE
AS
RETURN(SELECT*FROM dbo.GIAOVIEN WHERE Gioitinh LIKE @gioitinh)
go
SELECT*FROM FN_GV('Nam')
--Câu 4. Tạo View lưu thông tin của TOP 2 có giá trị số lượng dự án mà giáo viên hướng dẫn gồm các thông tin sau: Magv, hoten, Tendt,  số lượng đề tài hướng dẫn
 IF OBJECT_ID ('VW_DA') IS NOT NULL
 DROP VIEW VW_DA
 GO

 CREATE VIEW VW_DA
 AS
 SELECT TOP 2 DEAN.MaGV,Hoten,Tenda,COUNT(MaDA) AS N'SL DỀ tài'
 FROM dbo.GIAOVIEN JOIN dbo.DEAN ON DEAN.MaGV = GIAOVIEN.MaGV
 GROUP BY Tenda,Hoten,DEAN.MaGV
 ORDER BY COUNT(MaDA) DESC
 GO
 SELECT * FROM dbo.VW_DA

