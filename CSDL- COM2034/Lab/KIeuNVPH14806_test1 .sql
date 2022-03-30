--Câu 1: Tạo cơ sở dữ liệu QUANLYNHANSU gồm 3 bảng. (1.5 điểm)
--CHUCVU(MACV,TENCV)
--NHANVIEN(MANV, HOTEN, NGAYSINH, GIOITINH, LUONG, MACV)
--CHAMCONG(MACONG, MANV, NGAYCONG, THANG)


CREATE DATABASE QLNHANSU
GO
USE QLNHANSU
GO
CREATE TABLE CHUCVU
(
	MACV INT NOT NULL PRIMARY KEY,
	TENCV nvarchar(50) NOT NULL
)
GO
CREATE TABLE NHANVIEN
(
	MANV NVARCHAR(5) NOT NULL PRIMARY KEY,
	hoTen NVARCHAR(50) NOT NULL,
	NGSINH DATE,
	GioiTinh NVARCHAR(10),
	Luong MONEY,
	MACV INT FOREIGN KEY REFERENCES dbo.CHUCVU(MACV)

)
CREATE TABLE CHAMCONG
(
	MACC NVARCHAR(5) NOT NULL PRIMARY KEY,
	MANV NVARCHAR(5) NOT NULL FOREIGN KEY REFERENCES dbo.NHANVIEN(MANV),
	NGAYCONG INT NOT NULL,
	THANG INT NOT NULL

)--Câu 2: Chèn thông tin vào các bảng (3 điểm)
--- Tạo Stored Procedure (SP) với các tham số đầu vào phù hợp CHUCVU, NHANVIEN, CHAMCONG
--- Yêu cầu mỗi SP phải kiểm tra tham số đầu vàoVới mỗi SP viết 3 lời gọi thành công.
IF OBJECT_ID('SP_chucvu') IS NOT NULL
 DROP PROC SP_chucvu
 GO
 CREATE PROC SP_chucvu
	@macv INT,@tencv NVARCHAR(50)
AS
begin
	IF (@macv IS NULL)
		PRINT N'Bạn Phải nhập MACV vào'
	ELSE IF (@tencv IS NULL)
		PRINT N'Bạn Phải nhập tên chức vụ vào'
	ELSE
	begin try		
INSERT INTO dbo.CHUCVU
(
    MACV,
    TENCV
)
VALUES
(   @macv,  -- MACV - int
    @tencv -- TENCV - nvarchar(50)
    )
end try
		begin catch
			print N'Nhập sai dữ liệu của bảng cức vụ'
		END CATCH
  END
  go
EXEC dbo.SP_chucvu @macv = 1,   -- int
                   @tencv = N'Nhân viên' -- nvarchar(50)
EXEC dbo.SP_chucvu @macv = 2,   -- int
                   @tencv = N'giám đôc' -- nvarchar(50)

EXEC dbo.SP_chucvu @macv = 3,   -- int
                   @tencv = N'chủ tịch' -- nvarchar(50)

IF OBJECT_ID('SP_chamcong') IS NOT NULL
 DROP PROC SP_chamcong
 GO
 CREATE PROC SP_chamcong
	@macc NVARCHAR(5),@mNV NVARCHAR(50),@ngaycong INT,@thang int
AS
BEGIN
	IF (@macc IS NULL)
		PRINT N'Bạn Phải nhập MACc vào'
	ELSE IF (@mNV IS NULL)
		PRINT N'Bạn Phải nhập mã nhân viên vào'
	ELSE IF (@ngaycong IS NULL)
		PRINT N'Bạn Phải nhập ngày công vào'
	ELSE IF (@thang IS NULL)
		PRINT N'Bạn Phải nhập số tháng vào'
	ELSE
	begin try
			insert into CHAMCONG VALUES (@macc,@mNV,@ngaycong ,@thang )
		end try
		begin catch
			print N'Nhập sai dữ liệu của bảng CHAM CÔNG'
		end catch
END
EXEC dbo.SP_chamcong N'001',N'002',28,12
EXEC dbo.SP_chamcong @macc = N'002',   -- nvarchar(5)
                     @mNV = N'002',    -- nvarchar(50)
                     @ngaycong = 28, -- int
                     @thang = 12   
EXEC dbo.SP_chamcong @macc = N'003',   -- nvarchar(5)
                     @mNV = N'001',    -- nvarchar(50)
                     @ngaycong = 26, -- int
                     @thang = 10  


IF OBJECT_ID('SP_nhanvien') IS NOT NULL
 DROP PROC SP_nhanvien
 GO
 CREATE PROC SP_nhanvien
	@manv NVARCHAR(5),@hoten NVARCHAR(50),@ngaysinh DATE,@gioitinh NVARCHAR(5),@luong MONEY,@macv INT
AS
BEGIN
	IF (@manv IS NULL)
		PRINT N'Bạn Phải nhập mã nhân viên vào'
	ELSE IF (@hoten IS NULL)
		PRINT N'Bạn Phải nhập họ tên vào'
	ELSE IF (@ngaysinh IS NULL)
		PRINT N'Bạn Phải nhập ngày sinh vào'
	ELSE IF (@gioitinh IS NULL)
		PRINT N'Bạn Phải nhập giới tính vào'
	ELSE IF (@luong IS NULL)
		PRINT N'Bạn Phải nhập lương vào'
	ELSE IF (@macv IS NULL)
		PRINT N'Bạn Phải nhập số mã công việc vào'
	ELSE
	begin try
			insert INTO dbo.NHANVIEN VALUES( @macv,@hoten,@ngaysinh,@gioitinh,@luong,@macv)
		end try
		begin catch
			print N'Nhập sai dữ liệu của bảng nhân viên'
		end catch
end
EXEC dbo.SP_nhanvien @manv = N'001',              -- nvarchar(5)
                     @hoten = N'kk',             -- nvarchar(50)
                     @ngaysinh = '1985-06-12', -- date
                     @gioitinh = N'nam',          -- nvarchar(5)
                     @luong = 15000000,            -- money
                     @macv = 1                 -- int
EXEC dbo.SP_nhanvien @manv = N'002',              -- nvarchar(5)
                     @hoten = N'đ',             -- nvarchar(50)
                     @ngaysinh = '1985-07-12', -- date
                     @gioitinh = N'nam',          -- nvarchar(5)
                     @luong = 15000000,            -- money
                     @macv = 2                 -- int
EXEC dbo.SP_nhanvien @manv = N'003',              -- nvarchar(5)
                     @hoten = N'ff',             -- nvarchar(50)
                     @ngaysinh = '1985-08-12', -- date
                     @gioitinh = N'nam',          -- nvarchar(5)
                     @luong = 15000000,            -- money
                     @macv = 3                 -- int

--Câu 3:  Viết hàm các tham số đầu vào mã nhân viên và giới tính. Hàm này trả về toàn bộ thông tin Nhân viên theo tham số đầu vào và có tuổi trên 30. (2 điểm)
IF OBJECT_ID('fn_NHANVIEN') IS NOT NULL
 DROP FUNCTION fn_NHANVIEN
 GO
 CREATE FUNCTION fn_NHANVIEN(
  @ma NVARCHAR(5),@gioitinh NVARCHAR(5))
  RETURNS TABLE
AS
RETURN (SELECT * FROM NHANVIEN WHERE MANV=@ma AND GioiTinh=@gioitinh AND (YEAR(GETDATE())-YEAR(NGSINH))>30 )

--Câu 4: Tạo View lưu thông tin của có giá trị số lượng nhân viên đông nhất theo chưc vụ gồm các thông tin sau: Mã chức vụ, Tên chức vụ, số lượng nhân viên. (1.5 điểm)
IF OBJECT_ID('VW_CV') IS NOT NULL
 DROP view VW_CV

 GO
 CREATE VIEW VW_CV
 AS
 SELECT CHUCVU.MACV,TENCV,COUNT(MANV)AS slNguoi FROM dbo.CHUCVU JOIN dbo.NHANVIEN ON NHANVIEN.MACV = CHUCVU.MACV 
 GROUP BY CHUCVU.MACV,TENCV

--Câu 5:  Viết một SP nhận một tham số đầu vào là số ngày công và tháng mấy SP này thực hiện thao tác xóa thông tin chấm công và nhân viên tương ứng nếu tổng số ngày phép lớn hơn giá trị tham số đầu vào. (2 điểm)
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác xóa thực hiện không thành công.

 IF OBJECT_ID('CAU5') IS NOT NULL
DROP PROC CAU5
GO
CREATE PROC CAU5 @SN INT,@THANG INT 
AS
BEGIN 
   BEGIN TRY
     BEGIN TRAN
	 BEGIN
	    DELETE FROM dbo.CHAMCONG WHERE NGAYCONG=@SN AND THANG=@THANG
	    DELETE FROM dbo.NHANVIEN WHERE MANV IN 
		( SELECT MANV FROM CHAMCONG WHERE NGAYCONG=@SN AND THANG=@THANG)
	END
	 COMMIT TRAN
   END TRY
   BEGIN CATCH
      ROLLBACK TRAN
   END CATCH
END
GO
EXEC dbo.CAU5 @SN = 0,   -- int
              @THANG = 0 -- int

