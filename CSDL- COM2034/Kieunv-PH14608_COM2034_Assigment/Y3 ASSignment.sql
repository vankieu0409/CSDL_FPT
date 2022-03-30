USE QLNhaTro
go
--1. Thêm thông tin vào các bảng
---	Tạo ba Stored Procedure (SP) với các tham số đầu vào phù hợp.
--		o SP thứ nhất thực hiện chèn dữ liệu vào bảng NGUOIDUNG
IF OBJECT_ID('SPNguoiDung') IS NOT NULL
	DROP PROC SPNguoiDung
GO

CREATE PROC SPNguoiDung 
	@TenND NVARCHAR(50), @sex NVARCHAR(15), @SODT NVARCHAR(15),
	@DiaChi nVARCHAR(100), @QUANHUYEN NVARCHAR(50), @email NVARCHAR(50)
AS
	IF (@TenND IS NULL)
		PRINT N'Bạn Phải nhập tên vào'
	ELSE IF (@SODT IS NULL)
		PRINT N'Bạn Phải nhập SĐT vào'
	ELSE IF (@DiaChi IS NULL)
		PRINT N'Bạn Phải nhập ĐỊA CHỈ vào'
	ELSE IF (@email IS NULL)
		PRINT N'Bạn Phải nhập Email vào'
	ELSE
INSERT INTO NGUOIDUNG
	VALUES(@TenND,@sex,@SODT,@SODT,@DiaChi,@QUANHUYEN,@email )

EXEC dbo.SPNguoiDung @TenND = N'Kiều',     -- nvarchar(50)
                     @sex = N'Nam',       -- nvarchar(15)
                     @SODT = N'0987654321',      -- nvarchar(15)
                     @DiaChi = N'Tuân Chính',    -- nvarchar(100)
                     @QUANHUYEN = N'VĨnh Tường', -- nvarchar(50)
                     @email = N'cc@gmail.com'      -- nvarchar(50)

EXEC dbo.SPNguoiDung @TenND = N'Bin',     -- nvarchar(50)
                     @sex = N'nam',       -- nvarchar(15)
                     @SODT = N'',      -- nvarchar(15)
                     @DiaChi = N'hn',    -- nvarchar(100)
                     @QUANHUYEN = N'kk', -- nvarchar(50)
                     @email = N''      -- nvarchar(50)


--		o SP thứ hai thực hiện chèn dữ liệu vào bảng NHATRO
IF OBJECT_ID('SP_NhaTro') IS NOT NULL
	DROP PROC SP_NhaTro
GO

CREATE PROC SP_NhaTro 
	@MaNT NVARCHAR(51), @S FLOAT, @gia MONEY,@DiaChiND nVARCHAR(100),
	@QUAN NVARCHAR(50),@MOTA NVARCHAR(100),@NgayDANG DATE,
	 @MALOAINHA NVARCHAR(5)
AS
	IF (@MaNT IS NULL)
		PRINT N'Bạn Phải nhập Mã Nhà trọ vào'
	ELSE IF (@S IS NULL)
		PRINT N'Bạn Phải nhập Diện tích Phòng vào'
	ELSE IF (@gia IS NULL)
		PRINT N'Bạn Phải nhập Giá Phòng vào'
	ELSE IF (@DiaChiND IS NULL)
		PRINT N'Bạn Phải nhập Địa Chỉ vào'
	ELSE IF (@NgayDANG IS NULL)
		PRINT N'Bạn Phải nhập Ngày Đăng vào'
	ELSE
INSERT INTO NHATRO
	VALUES(@MaNT,@S,@gia,@DiaChiND,@QUAN,@MOTA,@NgayDANG,@MALOAINHA )

EXEC dbo.SP_NhaTro @MaNT = N'h11',              -- nvarchar(51)
                   @S = 15.2,                 -- float
                   @gia = 222222000,              -- money
                   @QUAN = N'a',              -- nvarchar(50)
                   @MOTA = N'KHông đẹp',              -- nvarchar(100)
                   @NgayDANG = '2021-06-10' -- date
            
EXEC dbo.SP_NhaTro @MaNT = N'',              -- nvarchar(51)
                   @S = 0.0,                 -- float
                   @gia = NULL,              -- money
                   @DiaChiND = N'',          -- nvarchar(100)
                   @QUAN = N'',              -- nvarchar(50)
                   @MOTA = N'',              -- nvarchar(100)
                   @NgayDANG = '2021-06-10', -- date
                   @MALOAINHA = N''          -- nvarchar(5)


--		o SP thứ ba thực hiện chèn dữ liệu vào bảng DANHGIA
IF OBJECT_ID('SP_DanhGia') IS NOT NULL
	DROP PROC SP_DanhGia
GO

CREATE PROC SP_DanhGia
	@MaDG NVARCHAR(5) ,@ChatLuong nVARCHAR(50),@NĐANHGIA NVARCHAR(100),
	@TrangThai NVARCHAR(50),@MaNT NVARCHAR(10)
AS
	IF (@MaDG IS NULL)
		PRINT N'Bạn Phải nhập Mã Đánh giá vào'
	ELSE IF (@ChatLuong IS NULL)
		PRINT N'Bạn Phải nhập Chất Lượng vào'
	ELSE IF (@TrangThai IS NULL)
		PRINT N'Bạn Phải nhập Like or DisLike vào'
	ELSE IF (@MaNT IS NULL)
		PRINT N'Bạn Phải nhập Mã Nhà Trọ vào'
	
	ELSE
INSERT INTO DANHGIA
	VALUES(@MaDG,@ChatLuong,@NĐANHGIA,@TrangThai,@MaNT)
EXEC dbo.SP_DanhGia @MaDG = N''PH14255'',      -- nvarchar(5)
                    @ChatLuong = N''Motel05'', -- nvarchar(50)
                    @NĐANHGIA = N'',  -- nvarchar(100)
                    @TrangThai = N'', -- nvarchar(50)
                    @MaNT = N''       -- nvarchar(10)
 ,,1,N'Liêu Tấn Minh'
-- báo lỗi
EXEC SPaddDanhGia 'PH14277','Motel07',1,null




--Yêu cầu đối với các SP: Trong mỗi SP phải kiểm tra giá trị các tham số đầu vào. Với 
--các cột không chấp nhận thuộc tính NULL, nếu các tham số đầu vào tương ứng với 
--chúng không được truyền giá trị, thì không thực hiện câu lệnh chèn mà in một thông báo
--yêu cầu người dùng nhập liệu đầy đủ.
---		Với mỗi SP, viết hai lời gọi. Trong đó, một lời gọi thực hiện chèn thành công dữ liệu,
--	và một lời gọi trả về thông báo lỗi cho người dùng.


--2. Truy vấn thông tin
--	a. Viết một SP với các tham số đầu vào phù hợp. SP thực hiện tìm kiếm thông tin các 
--phòng trọ thỏa mãn điều kiện tìm kiếm theo: Quận, phạm vi diện tích, phạm vi ngày đăng
--tin, khoảng giá tiền, loại hình nhà trọ.
--	SP này trả về thông tin các phòng trọ, gồm các cột có định dạng sau:
--		o Cột thứ nhất: có định dạng ‘Cho thuê phòng trọ tại’ + <Địa chỉ phòng trọ>
--+ <Tên quận/Huyện>
--		o Cột thứ hai: Hiển thị diện tích phòng trọ dưới định dạng số theo chuẩn Việt Nam + 
--	-m2. Ví dụ 30,5 m2
--		o Cột thứ ba: Hiển thị thông tin giá phòng dưới định dạng số theo định dạng chuẩn 
--Việt Nam. Ví dụ 1.700.000
--		o Cột thứ tư: Hiển thị thông tin mô tả của phòng trọ
--		o Cột thứ năm: Hiển thị ngày đăng tin dưới định dạng chuẩn Việt Nam.
--Ví dụ: 27-02-2012
--		o Cột thứ sáu: Hiển thị thông tin người liên hệ dưới định dạng sau:
--			▪ Nếu giới tính là Nam. Hiển thị: A. + tên người liên hệ. Ví dụ A. Thắng
--			▪ Nếu giới tính là Nữ. Hiển thị: C. + tên người liên hệ. Ví dụ C. Lan
--		o Cột thứ bảy: Số điện thoại liên hệ
--		o Cột thứ tám: Địa chỉ người liên hệ
--- Viết hai lời gọi cho SP này
if OBJECT_ID('SPTIMKIEM') is not null
	drop proc SPTIMKIEM
go
create proc SPTIMKIEM(
	@QUAN NVARCHAR(30),
	@PHAMVIMIN decimal(8, 2),
	@PHAMVIMAX decimal(8, 2),
	@NGAYDANGMIN DATETIME,
	@NGAYDANGMAX DATETIME,
	@GIATIENMIN MONEY,
	@GIATIENMAX MONEY,
	@LOẠINHA VARCHAR (50)
)
as 
begin
	select N'CHO THUÊ PHÒNG TRỌ TẠI'+NHATRO.DiaChi + ' ' + Quan , FORMAT(DIENTICH,'###,# m2'),FORMAT(GIAPHONG , '#,##,##0'),MOTA,NgayDang,
	case GIOITINH
		when N'Nam' then 'Anh' + TenNguoiDung
		when N'Nữ' then 'Chị' + TenNguoiDung
		end,SoDienThoai,NGUOIDUNG.DIACHI

	from  NHATRO  JOIN DANHGIA on NHATRO.MaNhaTro = DANHGIA.MaNhaTro join NGUOIDUNG on NGUOIDUNG.MaNguoiDung = DANHGIA.MaNguoiDung
	where dbo.NHATRO.Quan = @QUAN and DienTich BETWEEN @PHAMVIMAX and @PHAMVIMAX and GIAPHONG BETWEEN @GIATIENMAX AND @GIATIENMAX
end
go
select * from  NHATRO JOIN DANHGIA on NHATRO.MaNhaTro = DANHGIA.MaNhaTro join NGUOIDUNG on NGUOIDUNG.MaNguoiDung = DANHGIA.MaDanhGia
exec SPTIMKIEM N'Hà Nội',30.5,100,'01/01/2021', '01/05/2021' , 4000000,5000000, N'Nhà riêng'
exec SPTIMKIEM N'HCM',100.6,250.5,'05/01/2021', '11/11/2021' , 7000000,10000000, N'Nhà Nghỉ'

--	b. Viết một hàm có các tham số đầu vào tương ứng với tất cả các cột của bảng 
--NGUOIDUNG. Hàm này trả về mã người dùng (giá trị của cột khóa chính của bảng 
--NGUOIDUNG) thỏa mãn các giá trị được truyền vào tham số
if OBJECT_ID('FN_NGUOIDUNG') is not null
	drop function FN_NGUOIDUNG
go
create function FN_NGUOIDUNG(@maND varchar(10))
returns table 
as
return (select * from NGUOIDUNG where MaNguoiDung = @maND)
go

--	c. Viết một hàm có tham số đầu vào là mã nhà trọ (cột khóa chính của bảng 
--NHATRO). Hàm này trả về tổng số LIKE và DISLIKE của nhà trọ này.
if OBJECT_ID('FN_NHATRO') is not null
	drop function FN_NHATRO
GO

CREATE FUNCTION FN_NHATRO (@maNT NVARCHAR(10))

RETURNS INT
AS
begin
RETURN (SELECT COUNT(TrangThai) FROM dbo.DANHGIA WHERE MaNhaTro=@maNT)
END
GO

SELECT dbo.FN_NHATRO('005')

--	d. Tạo một View lưu thông tin của TOP 10 nhà trọ có số người dùng LIKE nhiều nhất gồm 
--các thông tin sau:
--- Diện tích
--- Giá
--- Mô tả
--- Ngày đăng tin
--- Tên người liên hệ
--- Địa chỉ
--- Điện thoại
--- Email
if OBJECT_ID('VW_top10')  is not null
	drop view VW_top10
	go
create view VW_top10 as
SELECT TOP 10 DienTich,GiaPhong,MoTa,NgayDang,TenNguoiDung,NHATRO.DiaChi,SoDienThoai,Email
FROM NHATRO JOIN dbo.DANHGIA ON DANHGIA.MaNhaTro = NHATRO.MaNhaTro JOIN dbo.NGUOIDUNG ON NGUOIDUNG.MaNguoiDung = DANHGIA.MaNguoiDung
ORDER BY (SELECT COUNT(MaNhaTro) FROM DANHGIA WHERE TrangThai LIKE 'Like') DESC

SELECT * FROM VW_top10

--	e. Viết một Stored Procedure nhận tham số đầu vào là mã nhà trọ (cột khóa chính của
--bảng NHATRO). SP này trả về tập kết quả gồm các thông tin sau:
--- Mã nhà trọ
--- Tên người đánh giá
--- Trạng thái LIKE hay DISLIKE
--- Nội dung đánh giá

if OBJECT_ID('SP_DanhgiaNhaTro') is not null
drop proc SP_DanhgiaNhaTro
go
create proc SP_DanhgiaNhaTro @MANT NVARCHAR(9)
as
begin
	SELECT MaNhaTro,TenNguoiDung,TrangThai,NoiDungDanhGia FROM dbo.DANHGIA JOIN dbo.NGUOIDUNG ON NGUOIDUNG.MaNguoiDung = DANHGIA.MaNguoiDung
	where  MaNhaTro LIKE @MANT 
end
--3. Xóa thông tin
--	1. Viết một SP nhận một tham số đầu vào kiểu int là số lượng DISLIKE. SP này thực hiện
--thao tác xóa thông tin của các nhà trọ và thông tin đánh giá của chúng, nếu tổng số lượng
--DISLIKE tương ứng với nhà trọ này lớn hơn giá trị tham số được truyền vào.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác 
--xóa thực hiện không thành công.
if OBJECT_ID('SP_TRANGthaisQLnhatro')is not null
drop proc SP_TRANGthaisQLnhatro
create proc SP_TRANGthaisQLnhatro (@TT int)
as
begin try
	begin tran-- bắt đầu giao dịch
		delete from NHATRO where (select count(TrangThai) from DANHGIA where TrangThai like N'DisLike')>@TT
		delete from DANHGIA where(select count(TrangThai) from DANHGIA where TrangThai like N'DisLike')>@TT
	commit
end try
begin catch
	rollback
end catch
go
exec SP_TRANGthaisQLnhatro 3

select * from DANHGIA

--	2. Viết một SP nhận hai tham số đầu vào là khoảng thời gian đăng tin. SP này thực hiện
--thao tác xóa thông tin những nhà trọ được đăng trong khoảng thời gian được truyền vào 
--qua các tham số.
if OBJECT_ID('SP_xoaNT')is not null
drop proc SP_xoaNT
create proc SP_xoaNT (@nd date,@ND2 date)
as
begin try
	begin tran-- bắt đầu giao dịch

		delete from NHATRO where NgayDang BETWEEN @nd AND @ND2
		delete from DANHGIA WHERE MaNhaTro= (SELECT MaNhaTro FROM dbo.NHATRO where NgayDang BETWEEN @nd AND @ND2)
	commit
end try
begin catch
	rollback
end catch
go
--Lưu ý: SP cũng phải thực hiện xóa thông tin đánh giá của các nhà trọ này.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác 
--xóa thực hiện không thành công.
--Y4. Yêu cầu quản trị CSDL
--- Tạo hai người dùng CSDL
--o Một người dùng với vai trò nhà quản trị CSDL. Phân quyền cho người dùng
--này chỉ được phép thao tác trên CSDL quản lý nhà trọ cho thuê và có toàn 
--quyền thao tác trên CSDL đó
--o Một người dùng thông thường. Phân cho người dùng này toàn bộ quyền thao
--tác trên các bảng của CSDL và quyền thực thi các SP và các hàm được tạo ra từ
--các yêu cầu trên
--- Kết nối tới Server bằng tài khoản của người dùng thứ nhất. Thực hiện tạo một bản sao
--CSDL