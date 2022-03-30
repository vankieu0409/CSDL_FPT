CREATE DATABASE test
GO 
USE test
GO

CREATE TABLE GIAOVIEN(
	MaGV INT NOT NULL PRIMARY KEY,
	Hoten NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	gioiTInh NVARCHAR(5)
)
GO
 CREATE TABLE DETAI(
	Madt INT NOT NULL PRIMARY KEY,
	tenDT NVARCHAR(50) NOT NULL,
	NamTHhien INT,
	MaGV INT NOT NULL FOREIGN KEY REFERENCES dbo.GIAOVIEN(MaGV)
)
GO
CREATE TABLE SINHVIEN(
	MaSV NVARCHAR(5) NOT NULL PRIMARY KEY,
	HoTenSV NVARCHAR(50) NOT NULL,
	ngSinh DATE,
	diem FLOAT,
	Madt INT NOT NULL FOREIGN KEY REFERENCES dbo.DETAI(Madt)
)
go


---2
IF OBJECT_ID('SP_GiaoVien')IS NOT NULL
DROP PROC SP_GiaoVien
GO

CREATE PROC SP_GiaoVien 
@MaGV INT,
	@Hoten NVARCHAR(50),
	@NgaySinh DATE,
	@gioiTInh NVARCHAR(5)
AS
BEGIN

BEGIN TRY
IF (@MaGV IS NULL OR @Hoten IS NULL)
PRINT N'Không được để trống'
INSERT INTO dbo.GIAOVIEN
(
    MaGV,
    Hoten,
    NgaySinh,
    gioiTInh
)
VALUES
( @MaGV,@Hoten,@NgaySinh,@gioiTInh)
END TRY
BEGIN CATCH
	PRINT N'Bạn Nhập sai Dữ liệu Hãy Nhập lại'
END CATCH
END
GO
EXEC dbo.SP_GiaoVien @MaGV = 1,                -- int
                     @Hoten = N'Kiều',             -- nvarchar(50)
                     @NgaySinh = '1998-06-23', -- date
                     @gioiTInh = N'Nam'           -- nvarchar(5)
EXEC dbo.SP_GiaoVien @MaGV = 2,                -- int
                     @Hoten = N'nam',             -- nvarchar(50)
                     @NgaySinh = '1986-06-23', -- date
                     @gioiTInh = N'Nam'    
EXEC dbo.SP_GiaoVien @MaGV = 3,                -- int
                     @Hoten = N'LÚ',             -- nvarchar(50)
                     @NgaySinh = '1978-06-23', -- date
                     @gioiTInh = N'Nữ'    
--////////////////////////////////////////////////
IF OBJECT_ID('SP_DeTai')IS NOT NULL
DROP PROC SP_DeTai
GO

CREATE PROC SP_DeTai 
@Madt INT ,
	@tenDT NVARCHAR(50),
	@NamTHhien INT,
	@MaGV INT
AS
BEGIN
 IF @Madt=NULL 
	PRINT N'Không được để trống'
ELSE IF @tenDT=NULL 
	PRINT N'Không được để trống'
	ELSE IF @MaGV=NULL 
	PRINT N'Không được để trống'
BEGIN TRY
INSERT INTO dbo.DETAI
(
    Madt,
    tenDT,
    NamTHhien,
    MaGV
)
VALUES
( @Madt,@tenDT,@NamTHhien,@MaGV
    )
END TRY
BEGIN CATCH
	PRINT N'Bạn Nhập sai Dữ liệu Hãy Nhập lại'
END CATCH
END
GO

EXEC dbo.SP_DeTai @Madt = 1,      -- int
                  @tenDT = N'xây nhà',   -- nvarchar(50)
                  @NamTHhien =2004, -- int
                  @MaGV = 1      -- int
EXEC dbo.SP_DeTai @Madt = 2,      -- int
                  @tenDT = N'sửa nhà',   -- nvarchar(50)
                  @NamTHhien =2005, -- int
                  @MaGV = 1      -- int

EXEC dbo.SP_DeTai @Madt = 3,      -- int
                  @tenDT = N'mua nồi điện',   -- nvarchar(50)
                  @NamTHhien =2019, -- int
                  @MaGV = 2      -- int
--///////////////////////////////////////////////////////////////////
IF OBJECT_ID('SP_SInhvien')IS NOT NULL
DROP PROC SP_SInhvien
GO

CREATE PROC SP_SInhvien
@MaSV NVARCHAR(5) ,
	@HoTenSV NVARCHAR(50) ,
	@ngSinh DATE,
	@diem FLOAT,
	@Madt INT
AS
BEGIN
 IF @Madt=NULL 
	PRINT N'Không được để trống'
ELSE IF @MaSV=NULL 
	PRINT N'Không được để trống'
	ELSE IF @HoTenSV=NULL 
	PRINT N'Không được để trống'
BEGIN TRY
INSERT INTO dbo.SINHVIEN
(
    MaSV,
    HoTenSV,
    ngSinh,
    diem,
    Madt
)
VALUES
(@MaSV,@HoTenSV,@ngSinh,@diem,@Madt)
END TRY
BEGIN CATCH
	PRINT N'Bạn Nhập sai Dữ liệu Hãy Nhập lại'
END CATCH
END
GO

EXEC dbo.SP_SInhvien @MaSV = N'kh1',            -- nvarchar(5)
                     @HoTenSV = N'Kiên',         -- nvarchar(50)
                     @ngSinh = '2001-06-23', -- date
                     @diem = 10,            -- float
                     @Madt = 1               -- int
EXEC dbo.SP_SInhvien @MaSV = N'kh2',            -- nvarchar(5)
                     @HoTenSV = N'bậu',         -- nvarchar(50)
                     @ngSinh = '2001-06-23', -- date
                     @diem = 6.9,            -- float
                     @Madt = 1  
EXEC dbo.SP_SInhvien @MaSV = N'kh3',            -- nvarchar(5)
                     @HoTenSV = N'Bệu',         -- nvarchar(50)
                     @ngSinh = '2001-06-23', -- date
                     @diem = 3.3,            -- float
                     @Madt = 2 

--3
IF OBJECT_ID('FN_giaovien') IS NOT NULL
DROP FUNCTION FN_giaovien
GO

CREATE FUNCTION FN_giaovien (@Hoten NVARCHAR(50),
	@NgaySinh DATE,
	@gioiTInh NVARCHAR(5))
RETURNS INT
AS
begin
RETURN (SELECT MaGV  FROM GIAOVIEN WHERE Hoten LIKE @Hoten AND NgaySinh=@NgaySinh AND gioiTInh LIKE @gioiTInh)
END
GO

SELECT dbo.FN_giaovien(N'Kiều','1998-6-23',N'Nam')AS N'Mã GV'
--/////////////////////////////
--4
IF OBJECT_ID('VW_detai') IS NOT NULL
DROP VIEW VW_detai
GO

CREATE VIEW VW_detai AS
SELECT TOP 2 GIAOVIEN.MaGV,Hoten,tenDT, COUNT(Madt) AS SOLUONGDETAI
FROM dbo.GIAOVIEN JOIN dbo.DETAI ON DETAI.MaGV = GIAOVIEN.MaGV
GROUP BY GIAOVIEN.MaGV,Hoten,tenDT
ORDER BY COUNT(Madt) DESC
go

SELECT * FROM VW_detai

--5
IF OBJECT_ID('DL_cau5') IS NOT NULL
DROP PROC DL_cau5
GO

CREATE PROC DL_cau5 @diemthap INT,@diemcao INT
AS
BEGIN
BEGIN TRY
BEGIN TRAN
BEGIN
DECLARE @a INT
SELECT @a=dbo.DETAI.Madt FROM dbo.DETAI JOIN dbo.SINHVIEN ON SINHVIEN.Madt = DETAI.Madt
WHERE diem BETWEEN @diemthap AND @diemcao
DELETE dbo.DETAI WHERE Madt= @a
DELETE dbo.SINHVIEN WHERE Madt= @a
END
COMMIT TRAN
END TRY
BEGIN CATCH
 ROLLBACK
 END CATCH
 END
 go



