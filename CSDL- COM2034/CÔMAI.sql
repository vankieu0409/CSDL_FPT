
create database QUANLYNHANSU1
go
use QUANLYNHANSU1
go


create table CHUCVU 
(
MACV nvarchar(10) not null primary key, 
TENCV nvarchar(20) not null
)
create table NHANVIEN 
(
MANV nvarchar(10) not null primary key,
HOTEN nvarchar(20) not null, 
NGAYSINH datetime not null, 
GIOITINH nvarchar(5) not null, 
LUONG int not null,
MACV nvarchar(10) not null,
foreign key (MACV) references CHUCVU(MACV)
)

create table CHAMCONG 
(
MACONG nvarchar(10) not null primary key,
MANV nvarchar(10) not null, 
SONGAYCONG int not null,
THANG int not null,
foreign key (MANV) references NHANVIEN(MANV)
)

--Câu 2: Chèn thông tin vào các bảng (3 điểm)
--- Tạo lưu trữ Thủ tục (SP) with the first parameter into CHUCVU, NHANVIEN, CHAMCONG
--- Yêu cầu mỗi SP phải kiểm tra tham số đầu vàoVới mỗi SP viết 3 lời gọi thành công.
IF OBJECT_ID('SP_CV') IS NOT NULL
	DROP PROC SP_CV
GO
CREATE PROC SP_CV
	 @MACV nvarchar(10), 
	 @TENCV nvarchar(20)
AS
BEGIN
BEGIN TRY 
    IF(@MACV IS NULL OR @TENCV IS NULL)
		PRINT N'KHÔNG ĐƯỢC ĐỂ NULL'
	ELSE
		BEGIN 
			INSERT INTO CHUCVU
			VALUES (@MACV,@TENCV)
			PRINT N'THÊM THÀNH CÔNG'
		END
END TRY
BEGIN CATCH 
 PRINT N' LỖI'
END CATCH
END
GO
EXEC SP_CV 'CV01',N'NHÂN VIÊN'
EXEC SP_CV 'CV02',N'TRƯỞNG PHÒNG'
EXEC SP_CV 'CV03',N'GIÁM ĐỐC'


---NHANVIEN
IF OBJECT_ID('SP_NV') IS NOT NULL
DROP PROC SP_NV
GO
CREATE PROC SP_NV @MANV nvarchar(10)=NULL,
@HOTEN nvarchar(20)=NULL , 
@NGAYSINH datetime=NULL , 
@GIOITINH nvarchar(5)=NULL, 
@LUONG int =NULL,
@MACV nvarchar(10) =NULL
AS
BEGIN
    BEGIN TRY 
    IF(@MANV IS NULL OR @HOTEN IS NULL OR @NGAYSINH IS NULL OR @GIOITINH IS NULL OR @LUONG IS NULL OR @MACV IS NULL )
	PRINT N'KHÔNG ĐƯỢC ĐỂ NULL'
	ELSE
	BEGIN 
    INSERT INTO NHANVIEN
	VALUES (@MANV,@HOTEN,@NGAYSINH,@GIOITINH,@LUONG,@MACV)
	PRINT N'THÊM THÀNH CÔNG'
	END
END TRY
BEGIN CATCH 
 PRINT N' LỖI'
END CATCH
END
GO
EXEC SP_NV 'NV01',N'KIỀU THỊ BÌNH','2002-03-08',N'NỮ',2000,'CV03'
EXEC SP_NV 'NV05',N'NGUYỄN KHẮC KIÊN','2000-08-08',N'NAM',1000,'CV02'
EXEC SP_NV 'NV03',N'TRẦN NAM TRƯỜNG','2001-01-01',N'NAM',1500,'CV01'
EXEC SP_NV 'NV04',N'BÙI THỊ DỊU','2002-01-01',N'NAM',1500,'CV01'
EXEC SP_NV 'NV02',N'NGUYỄN KHẮC B','2000-08-08',N'NAM',1000,'CV02'
--CHẤM CÔNG
IF OBJECT_ID('SP_CC') IS NOT NULL
DROP PROC SP_CC
GO
CREATE PROC SP_CC @MACONG nvarchar(10)=NULL ,
@MANV nvarchar(10) =NULL, 
@SONGAYCONG int =NULL,
@THANG int=NULL
AS
BEGIN
   BEGIN TRY 
    IF(@MACONG IS NULL OR @MANV IS NULL OR @SONGAYCONG IS NULL OR @THANG IS NULL)
	PRINT N'KHÔNG ĐƯỢC ĐỂ NULL'
	ELSE
	BEGIN 
     INSERT INTO CHAMCONG
	VALUES (@MACONG,@MANV,@SONGAYCONG,@THANG)
	PRINT N'THÊM THÀNH CÔNG'
	END
END TRY
BEGIN CATCH 
 PRINT N' LỖI'
END CATCH
END
GO
EXEC SP_CC 'MC0','NV01',30,3
EXEC SP_CC 'MC1','NV02',25,3
EXEC SP_CC 'MC2','NV03',21,3
SELECT * FROM CHUCVU
SELECT * FROM NHANVIEN
SELECT * FROM CHAMCONG
--Câu 3: Viết hàm tham số đầu vào nhân viên mã hóa và giới tính. This function return to all information. Nhân viên theo tham số đầu vào và có tuổi trên 30. (2 point)
IF OBJECT_ID('CAU3') IS NOT NULL
	DROP FUNCTION CAU3
GO
CREATE FUNCTION CAU3(
	@MANV NVARCHAR(10),@GT NVARCHAR(10))
RETURNS TABLE
AS
	RETURN(SELECT *
	FROM NHANVIEN
	WHERE MANV=@MANV AND GIOITINH=@GT
	AND YEAR(GETDATE())-YEAR(NGAYSINH) >18
)
GO
SELECT * FROM DBO.CAU3('NV01',N'NỮ')

--Câu 4: Tạo Xem lưu trữ thông tin có giá trị số 
--lượng nhân viên đông nhất theo các tập tin bao gồm 
--các thông tin sau: Mã chức năng, Tên chức năng, số lượng nhân viên. (1.5 điểm)
IF OBJECT_ID('CAU4') IS NOT NULL
DROP VIEW CAU4
GO
CREATE VIEW CAU4
AS
select TOP 1 WITH TIES NHANVIEN.MACV,TENCV,COUNT(MANV) AS SL
FROM CHUCVU JOIN NHANVIEN ON CHUCVU.MACV=NHANVIEN.MACV
GROUP BY NHANVIEN.MACV,TENCV
ORDER BY COUNT(MANV) DESC 
GO 
SELECT * FROM CAU4
--Câu 5: Viết một SP nhận một tham số đầu vào là số ngày và tháng này SP thực thi tác dụng xóa chấm thông tin 
--và nhân viên tương ứng nếu tổng số ngày được phép lớn hơn tham số giá trị đầu vào. (2 điểm)
--Yêu cầu: Sử dụng giao dịch trong SP thân, để bảo đảm toàn bộ dữ liệu khi một thao tác xóa thực hiện không thành công.
IF OBJECT_ID('CAU5') IS NOT NULL
DROP PROC CAU5
GO
CREATE PROC CAU5 @ngayphep INT
AS
BEGIN 
   BEGIN TRY
     BEGIN TRAN
	 BEGIN
	    declare @bangtam table
		(
		manv nvarchar(10),
		songaycong INT )
		insert into @bangtam
		select MANV,SUM(SONGAYCONG)
		FROM CHAMCONG 
		WHERE SONGAYCONG<@ngayphep
		GROUP BY MANV 
		HAVING SUM(SONGAYCONG)>@ngayphep
	    DELETE FROM CHAMCONG WHERE MANV IN (SELECT MANV FROM @bangtam)
	    DELETE FROM NHANVIEN WHERE MANV IN (SELECT MANV FROM @bangtam)
	END
	 COMMIT TRAN
   END TRY
   BEGIN CATCH
      ROLLBACK TRAN
   END CATCH
END
GO 
EXEC CAU5 6
SELECT * FROM CHAMCONG
SELECT * FROM NHANVIEN
