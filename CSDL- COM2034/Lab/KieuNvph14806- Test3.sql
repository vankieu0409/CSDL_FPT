--Câu 1: Tạo cơ sở dữ liệu QLSPPOLY1 gồm 3 bảng. (1.5 điểm)
--SANPHAM (MaSP, TenSP, GiaBan, SoLuong)		
--PHIEUNHAP (SoPN, NgayNhap, TrangThai)
--CTPNHAP(SoPN, MaSP, SLNhap, GiaNhap)
CREATE DATABASE QLSPPOLY1
GO
USE QLSPPOLY1
GO

CREATE TABLE SANPHAM
(
	MaSP NVARCHAR(5) NOT NULL PRIMARY KEY,
	TenSP NVARCHAR(50) NOT NULL,
	GiaBan MONEY,
	SoLuong INT
)
GO
CREATE TABLE PHIEUNHAP 
(
	SoPN NVARCHAR(5) NOT NULL PRIMARY KEY,
	NgayNhap DATE NOT NULL,
	TrangThai NVARCHAR(20)
)
GO
CREATE TABLE CTPNHAP
(
	SoPN NVARCHAR(5) NOT NULL,
	 MaSP NVARCHAR(5) NOT NULL,
	 SLNhap INT,
	 GiaNhap MONEY,

	PRIMARY KEY (SoPN,MaSP),
	FOREIGN KEY (SoPN) REFERENCES dbo.PHIEUNHAP(SoPN),
	FOREIGN KEY(MaSP) REFERENCES dbo.SANPHAM(MaSP)

)
GO

	
--Câu 2: Chèn thông tin vào các bảng (3 điểm)
--- Tạo Stored Procedure (SP) với các tham số đầu vào phù hợp vào bảng  SANPHAM, PHIEUNHAP, CTPNHAP
IF OBJECT_ID('SP_SANPHAM') IS NOT NULL
DROP PROC SP_SANPHAM
GO

CREATE PROC SP_SANPHAM 
@masp NVARCHAR(5),@TenSP NVARCHAR(50),
	@GiaBan MONEY,
	@SoLuong INT
AS
BEGIN
IF @masp IS NULL
 PRINT N'MÃ Sản Phẩm Không được để trông'
ELSE IF @TenSP IS NULL
	PRINT N' Tên Sản Phẩm Không được để trống'
ELSE
BEGIN TRY
INSERT INTO dbo.SANPHAM
(
    MaSP,
    TenSP,
    GiaBan,
    SoLuong
)
VALUES
(   @masp ,@TenSP ,
	@GiaBan ,
	@SoLuong
    )
END TRY
BEGIN CATCH
	PRINT N' Bạn Đã Nhập Sai Kiểu Dữ Liệu'
END CATCH
END
GO

EXEC dbo.SP_SANPHAM @masp = N'1',    -- nvarchar(5)
                    @TenSP = N'quạt',   -- nvarchar(50)
                    @GiaBan = 100000, -- money
                    @SoLuong = 30    -- int
EXEC dbo.SP_SANPHAM @masp = N'2',    -- nvarchar(5)
                    @TenSP = N'nồi',   -- nvarchar(50)
                    @GiaBan = 1200000, -- money
                    @SoLuong = 34    -- int
EXEC dbo.SP_SANPHAM @masp = N'3',    -- nvarchar(5)
                    @TenSP = N'bếp củi',   -- nvarchar(50)
                    @GiaBan = 800000, -- money
                    @SoLuong = 300    -- int

-- bảng PHIEU NHAP
IF OBJECT_ID('SP_PHIEUNHAP') IS NOT NULL
DROP PROC SP_PHIEUNHAP
GO

CREATE PROC SP_PHIEUNHAP 
@SoPN NVARCHAR(5),
	 @MaSP NVARCHAR(5) ,
	 @SLNhap INT,
	 @GiaNhap MONEY
AS
BEGIN
IF @SoPN IS NULL
 PRINT N'Số Phiếu nhập Sản Phẩm Không được để trông'
ELSE IF @NgayNhap IS NULL
	PRINT N' ngày Nhập Sản Phẩm Không được để trống'
	ELSE
BEGIN TRY
INSERT INTO dbo.PHIEUNHAP
(
    SoPN,
    NgayNhap,
    TrangThai
)
VALUES
(  @SoPN  ,
	@NgayNhap  ,
	@TrangThai         -- TrangThai - nvarchar(20)
    )
END TRY
BEGIN CATCH
	PRINT N'Bạn Nhập Sai Kiểu Dữ Liệu'
END CATCH
END
GO

EXEC dbo.SP_PHIEUNHAP @SoPN = N'001',              -- nvarchar(5)
                      @NgayNhap = '2018-06-17', -- date
                      @TrangThai = N'CÒn Hàng'          -- nvarchar(20)

EXEC dbo.SP_PHIEUNHAP @SoPN = N'002',              -- nvarchar(5)
                      @NgayNhap = '2019-06-17', -- date
                      @TrangThai = N'CÒn Hàng'          -- nvarchar(20)
EXEC dbo.SP_PHIEUNHAP @SoPN = N'003',              -- nvarchar(5)
                      @NgayNhap = '2017-06-17', -- date
                      @TrangThai = N'hết Hàng'          -- nvarchar(20)

-- CTNHAP
IF OBJECT_ID('SP_CTPNHAP') IS NOT NULL
DROP PROC SP_CTPNHAP
GO

CREATE PROC SP_CTPNHAP
@SoPN NVARCHAR(5) ,
	@MaSP NVARCHAR(5),
	 @SLNhap INT,
	 @GiaNhap MONEY

AS
BEGIN
IF @SoPN IS NULL
 PRINT N'Số Phiếu nhập Sản Phẩm Không được để trông'
ELSE IF @MaSP IS NULL
	PRINT N' ngày Nhập Sản Phẩm Không được để trống'
	ELSE
BEGIN TRY
INSERT INTO dbo.CTPNHAP
(
    SoPN,
    MaSP,
    SLNhap,
    GiaNhap
)
VALUES
(  @SoPN  ,
	@MaSP ,
	 @SLNhap ,
	 @GiaNhap
    )
END TRY
BEGIN CATCH
	PRINT N' bạn chưa nhập đúnh Kiểu DỮ Liệu'
	END CATCH
	END
	GO
EXEC dbo.SP_CTPNHAP @SoPN = N'001',    -- nvarchar(5)
                    @MaSP = N'2',    -- nvarchar(5)
                    @SLNhap = 30,    -- int
                    @GiaNhap = 100000 -- money
EXEC dbo.SP_CTPNHAP @SoPN = N'002',    -- nvarchar(5)
                    @MaSP = N'1',    -- nvarchar(5)
                    @SLNhap = 400,    -- int
                    @GiaNhap = 300000 -- money
EXEC dbo.SP_CTPNHAP @SoPN = N'003',    -- nvarchar(5)
                    @MaSP = N'3',    -- nvarchar(5)
                    @SLNhap = 100,    -- int
                    @GiaNhap = 400000 -- money


--- Yêu cầu mỗi SP phải kiểm tra tham số đầu vào. Với các cột không chấp nhận thuộc tính Null.
--- Với mỗi SP viết 3 lời gọi thành công.
--Câu 3: Viết hàm các tham số đầu vào tương ứng với các cột của bảng SANPHAM. Hàm này trả về MaSP thỏa mãn các giá trị được truyền tham số. (2 điểm)
IF OBJECT_ID('FN_CAU3') IS NOT NULL
DROP FUNCTION FN_CAU3
GO

CREATE FUNCTION FN_CAU3 (@TenSP NVARCHAR(50),
	@GiaBan MONEY,
	@SoLuong INT
)
RETURNS TABLE
AS
RETURN (SELECT MaSP FROM SANPHAM)
go

--Câu 4: Tạo View lưu thông tin của TOP 2 phiếu Nhập có giá trị lớn nhất, gồm các thông tin sau: MaSP, TenSP, NgayNhập,
--SLNHập, DonGia, giá trị nhập (biết giá trị nhập = sl nhập * giá nhập).  (1.5 điểm)

IF OBJECT_ID('V_CAU4') IS NOT NULL
DROP VIEW V_CAU4
GO

CREATE VIEW V_CAU4
AS
SELECT TOP 2 CTPNHAP.MaSP, TenSP,SLNhap,GiaNhap AS N'Đơn Giá', (SoLuong*GiaNhap) AS N'Giá trị Nhập' 
FROM dbo.SANPHAM JOIN dbo.CTPNHAP ON CTPNHAP.MaSP = SANPHAM.MaSP JOIN dbo.PHIEUNHAP ON PHIEUNHAP.SoPN = CTPNHAP.SoPN
GROUP BY CTPNHAP.MaSP,TenSP,SLNhap
ORDER BY SoLuong*GiaNhap DESC

--Câu 5: Viết một SP nhận một tham số đầu vào là SLNhập. SP này thực hiện thao tác xóa thông tin sản phẩm và phiếu nhập tương ứng. (2 điểm)
IF OBJECT_ID('SP_Cau5') IS NOT NULL
DROP proc SP_Cau5
GO
CREATE PROC SP_Cau5(@SLnhap INT)
as
begin try
	begin tran-- bắt đầu giao dịch
		delete from dbo.CTPNHAP where SLNhap LIKE @SLnhap
		delete from dbo.PHIEUNHAP WHERE SoPN=(SELECT SoPN FROM dbo.CTPNHAP where SLNhap LIKE @SLnhap)
		delete from dbo.SANPHAM WHERE MaSP=(SELECT MaSP FROM dbo.CTPNHAP where SLNhap LIKE @SLnhap)
	commit
end try
begin catch
	rollback
end catch
go
EXEC dbo.SP_Cau5 @SLnhap = 30 -- int


