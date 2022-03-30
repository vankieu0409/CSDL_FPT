--Y3. CÁC YÊU CẦU VỀ CHỨC NĂNG
use QLNT
go
--1. Thêm thông tin vào các bảng
--- Tạo ba Stored Procedure (SP) với các tham số đầu vào phù hợp.
--o SP thứ nhất thực hiện chèn dữ liệu vào bảng NGUOIDUNG
IF OBJECT_ID('SPaddNguoiDung') IS NOT NULL
DROP PROC SPaddNguoiDung
GO
CREATE PROC SPaddNguoiDung
	@MAND varchar(10) = null,
	@HOTENND nvarchar(50)= null,
	@GIOITINH nvarchar(5) = null,
	@SDT nvarchar(15)= null,
	@DIACHI	nvarchar(50)= null,
	@QUAN	nvarchar(30)= null,	
	@EMAIL	nvarchar(50)= null

AS
	BEGIN 
	IF (@MAND IS NULL OR @HOTENND IS NULL OR @GIOITINH IS NULL OR @SDT IS NULL OR @DIACHI IS NULL OR @QUAN IS NULL OR @EMAIL IS NULL)
		PRINT N' KHÔNG ĐƯỢC ĐỂ GIÁ TRỊ NULL'
	ELSE
	  BEGIN
	     INSERT INTO NGUOIDUNG
		 VALUES (@MAND,@HOTENND,@GIOITINH,@SDT,@DIACHI,@QUAN,@EMAIL)
	  END 
	END
GO
-- thành công
EXEC SPaddNguoiDung 'PH14209',N'Đỗ Văn Long' ,'Nam' ,'0383542588',N'thôn 3 xã Đài Xuyên huyện Vân Đồn tỉnh Quảng Ninh' ,N'huyện Vân Đồn','Longdvph14209.fpt.edu.vn'
-- báo lỗi
EXEC SPaddNguoiDung 'PH14245','Nam' ,'0383542588',N'thôn 3 xã Đài Xuyên huyện Vân Đồn tỉnh Quảng Ninh' ,N'huyện Vân Đồn','Truongph14245.fpt.edu.vn'
Select * from NGUOIDUNG
--o SP thứ hai thực hiện chèn dữ liệu vào bảng NHATRO
IF OBJECT_ID('SPaddNhaTro') IS NOT NULL
DROP PROC SPaddNhaTro
GO
CREATE PROC SPaddNhaTro
	@MANT	varchar(10) = null	,
	@DIENTICH	decimal(8, 2)= null,
	@GIAPHONG	money= null,
	@DIACHI	nvarchar(50)= null,
	@MOTA nvarchar(100)= null,
	@NGAYDANGTIN	datetime= null,
	@MALN varchar(10)= null,
	@MAQH varchar(10)= null
		

AS
	BEGIN 
	IF (@MANT IS NULL OR @DIENTICH IS NULL OR @GIAPHONG IS NULL OR @DIACHI IS NULL OR @MOTA IS NULL OR @NGAYDANGTIN IS NULL OR @MALN IS NULL OR @MAQH IS NULL)
		PRINT N' KHÔNG ĐƯỢC ĐỂ GIÁ TRỊ NULL'
	ELSE
	  BEGIN
	     INSERT INTO NHATRO
		 VALUES (@MANT,@DIENTICH,@GIAPHONG,@DIACHI,@MOTA,@NGAYDANGTIN,@MALN,@MAQH)
	  END 
	END
GO
-- thành công
EXEC SPaddNhaTro 'Motel1' , 99.2 , 4500000 ,N' Tx. Đồng Xoài, Tỉnh Bình Phước' ,N'Ăn chơi hết mình chỉ lo hết tiền' , '05/24/2021', 'Home06' ,'District06'
-- báo lỗi
EXEC SPaddNhaTro 'Motel12' , 99.2 , 4500000 ,N' Tx. Đồng Xoài, Tỉnh Bình Phước' ,N'Ăn chơi hết mình chỉ lo hết tiền',null , 'Home06' ,'District06'
Select * from NHATRO
--o SP thứ ba thực hiện chèn dữ liệu vào bảng DANHGIA
IF OBJECT_ID('SPaddDanhGia') IS NOT NULL
	DROP PROC SPaddDanhGia
GO
CREATE PROC SPaddDanhGia
	@MAND	varchar(10)= null,
	@MANT	varchar(10)	= null,
	@LIKEDISLIKE	bit	= null,
	@NGUOIDUNG	nvarchar(100)= null	
		

AS
	BEGIN 
	IF (@MAND IS NULL OR @MANT IS NULL OR @LIKEDISLIKE IS NULL OR @NGUOIDUNG IS NULL)
		PRINT N' KHÔNG ĐƯỢC ĐỂ GIÁ TRỊ NULL'
	ELSE
	  BEGIN
	     INSERT INTO DANHGIA
		 VALUES (@MAND,@MANT,@LIKEDISLIKE,@NGUOIDUNG)
	  END 
	END
GO
-- thành công
EXEC SPaddDanhGia 'PH14255','Motel05',1,N'Liêu Tấn Minh'
-- báo lỗi
EXEC SPaddDanhGia 'PH14277','Motel07',1,null
Select * from DANHGIA
--Yêu cầu đối với các SP: Trong mỗi SP phải kiểm tra giá trị các tham số đầu vào. Với 
--các cột không chấp nhận thuộc tính NULL, nếu các tham số đầu vào tương ứng với 
--chúng không được truyền giá trị, thì không thực hiện câu lệnh chèn mà in một thông báo
--yêu cầu người dùng nhập liệu đầy đủ.
--- Với mỗi SP, viết hai lời gọi. Trong đó, một lời gọi thực hiện chèn thành công dữ liệu,
--và một lời gọi trả về thông báo lỗi cho người dùng.

--2. Truy vấn thông tin

--a. Viết một SP với các tham số đầu vào phù hợp. SP thực hiện tìm kiếm thông tin các 
--phòng trọ thỏa mãn điều kiện tìm kiếm theo: Quận, phạm vi diện tích, phạm vi ngày đăng
--tin, khoảng giá tiền, loại hình nhà trọ.
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
	select N'CHO THUÊ PHÒNG TRỌ TẠI'+NHATRO.DIACHI + ' ' + TENQH , FORMAT(DIENTICH,'###,# m2'),FORMAT(GIAPHONG , '#,##,##0'),MOTA,NGAYDANGTIN,
	case GIOITINH
		when N'Nam' then 'Anh' + HOTENND
		when N'Nữ' then 'Chị' + HOTENND
		end,SDT,NGUOIDUNG.DIACHI

	from QUANHUYEN JOIN NHATRO ON QUANHUYEN.MAQH = NHATRO.MAQH JOIN DANHGIA on NHATRO.MANT = DANHGIA.MANT join NGUOIDUNG on NGUOIDUNG.MAND = DANHGIA.MAND
	where TENQH = @QUAN and DIENTICH BETWEEN @PHAMVIMAX and @PHAMVIMAX and GIAPHONG BETWEEN @GIATIENMAX AND @GIATIENMAX
end
go
select * from QUANHUYEN JOIN NHATRO ON QUANHUYEN.MAQH = NHATRO.MAQH JOIN DANHGIA on NHATRO.MANT = DANHGIA.MANT join NGUOIDUNG on NGUOIDUNG.MAND = DANHGIA.MAND
	
exec SPTIMKIEM N'Hà Nội',30.5,100,'01/01/2021', '01/05/2021' , 4000000,5000000, N'Nhà riêng'
exec SPTIMKIEM N'HCM',100.6,250.5,'05/01/2021', '11/11/2021' , 7000000,10000000, N'Nhà Nghỉ'
--select * from QUANHUYEN JOIN NHATRO ON QUANHUYEN.MAQH = NHATRO.MAQH JOIN LOAINHA ON NHATRO.MALN = LOAINHA.MALN

--SP này trả về thông tin các phòng trọ, gồm các cột có định dạng sau:
--o Cột thứ nhất: có định dạng ‘Cho thuê phòng trọ tại’ + <Địa chỉ phòng trọ>
--+ <Tên quận/Huyện>
--o Cột thứ hai: Hiển thị diện tích phòng trọ dưới định dạng số theo chuẩn Việt Nam + 
--m2. Ví dụ 30,5 m2
--o Cột thứ ba: Hiển thị thông tin giá phòng dưới định dạng số theo định dạng chuẩn 
--Việt Nam. Ví dụ 1.700.000
--o Cột thứ tư: Hiển thị thông tin mô tả của phòng trọ
--o Cột thứ năm: Hiển thị ngày đăng tin dưới định dạng chuẩn Việt Nam.
--Ví dụ: 27-02-2012
--o Cột thứ sáu: Hiển thị thông tin người liên hệ dưới định dạng sau:
--▪ Nếu giới tính là Nam. Hiển thị: A. + tên người liên hệ. Ví dụ A. Thắng
--▪ Nếu giới tính là Nữ. Hiển thị: C. + tên người liên hệ. Ví dụ C. Lan
--o Cột thứ bảy: Số điện thoại liên hệ
--o Cột thứ tám: Địa chỉ người liên hệ
--- Viết hai lời gọi cho SP này


--b. Viết một hàm có các tham số đầu vào tương ứng với tất cả các cột của bảng 
--NGUOIDUNG. Hàm này trả về mã người dùng (giá trị của cột khóa chính của bảng 
--NGUOIDUNG) thỏa mãn các giá trị được truyền vào tham số.
if OBJECT_ID('fnNguoiDung') is not null
	drop function fnNguoiDung
go
create function fnNguoiDung(@maND varchar(10))
returns table 
as
return (select * from NGUOIDUNG where MAND = @maND)
go
-- gọi hàm
select * from dbo.fnNguoiDung('PH14255')


--c. Viết một hàm có tham số đầu vào là mã nhà trọ (cột khóa chính của bảng 
--NHATRO). Hàm này trả về tổng số LIKE và DISLIKE của nhà trọ này.
if OBJECT_ID('fnCountLike') is not null
	drop function fnCountLike
	go
create function fnCountLike(@maNT varchar(10))
returns @bangtam table(
	solike bit
	)as
	begin
		insert into @bangtam 
		select COUNT([LIKE/DISLIKE])
		from DANHGIA left outer join NHATRO on DANHGIA.MANT = NHATRO.MANT 
		where NHATRO.MANT = @maNT 
		return
	end
go
select * from dbo.fnCountLike('Motel02')



--d. Tạo một View lưu thông tin của TOP 10 nhà trọ có số người dùng LIKE nhiều nhất gồm 
--các thông tin sau:
--- Diện tích
--- Giá
--- Mô tả
--- Ngày đăng tin
--- Tên người liên hệ
--- Địa chỉ
--- Điện thoại
--- Email
if OBJECT_ID('vwTTTop10') is not null
	drop view vwTTTop10
go
create view vwTTTop10 as
	select top 10  COUNT([LIKE/DISLIKE])as N'Số Lượng like', DIENTICH,GIAPHONG,MOTA,NGAYDANGTIN,HOTENND,NGUOIDUNG.DIACHI,SDT,EMAIL
	from NHATRO JOIN DANHGIA on NHATRO.MANT = DANHGIA.MANT join NGUOIDUNG on NGUOIDUNG.MAND = DANHGIA.MAND
	where [LIKE/DISLIKE] = N'Like'
	group by DIENTICH,GIAPHONG,MOTA,NGAYDANGTIN,HOTENND,NGUOIDUNG.DIACHI,SDT,EMAIL
	order by COUNT([LIKE/DISLIKE])  desc
go
select * from vwTTTop10
--e. Viết một Stored Procedure nhận tham số đầu vào là mã nhà trọ (cột khóa chính của
--bảng NHATRO). SP này trả về tập kết quả gồm các thông tin sau:
--- Mã nhà trọ
--- Tên người đánh giá
--- Trạng thái LIKE hay DISLIKE
--- Nội dung đánh giá
if OBJECT_ID ('spNhaTro') is not null
	drop proc spNhaTro
go
create proc spNhaTro(
	@MaNT varchar(15)
) as begin
	select NHATRO.MANT,HOTENND,[LIKE/DISLIKE],DANHGIA.DANHGIAND
	from NHATRO join DANHGIA on NHATRO.MANT = DANHGIA.MANT join NGUOIDUNG on DANHGIA.MAND= NGUOIDUNG.MAND
	where NHATRO.MANT = @MaNT
end

-- gọi
exec spNhaTro 'Motel03'




--3. Xóa thông tin
--1. Viết một SP nhận một tham số đầu vào kiểu int là số lượng DISLIKE. SP này thực hiện
--thao tác xóa thông tin của các nhà trọ và thông tin đánh giá của chúng, nếu tổng số lượng
--DISLIKE tương ứng với nhà trọ này lớn hơn giá trị tham số được truyền vào.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác 
--xóa thực hiện không thành công.

if OBJECT_ID('SP_TRANGthaisQLnhatro')is not null
	drop proc SP_TRANGthaisQLnhatro
go
create proc SP_TRANGthaisQLnhatro (@TT int)
as
begin try
	begin tran-- bắt đầu giao dịch
		delete from NHATRO where (select count([LIKE/DISLIKE]) from DANHGIA where [LIKE/DISLIKE] like N'Dislike')>@TT
		delete from DANHGIA where(select count([LIKE/DISLIKE]) from DANHGIA where [LIKE/DISLIKE] like N'Dislike')>@TT
	commit
end try
begin catch
	rollback
end catch
go
-- gọi 
exec SP_TRANGthaisQLnhatro 1


--2. Viết một SP nhận hai tham số đầu vào là khoảng thời gian đăng tin. SP này thực hiện
--thao tác xóa thông tin những nhà trọ được đăng trong khoảng thời gian được truyền vào 
--qua các tham số.
--Lưu ý: SP cũng phải thực hiện xóa thông tin đánh giá của các nhà trọ này.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác 
--xóa thực hiện không thành công.
if OBJECT_ID('spNgayDang') is not null
	drop proc spNgayDang
go
create proc spNgayDang(
	@ngayDangMin datetime,
	@ngayDangMax datetime
)as  begin try
	begin tran-- bắt đầu giao dịch
		delete from NHATRO where NGAYDANGTIN between @ngayDangMin and @ngayDangMin
	commit
end try
begin catch
	rollback
end catch
go

-- gọi 
select * from	NHATRO
exec spNgayDang '01/01/2020','12/30/2022'


--Y4. Yêu cầu quản trị CSDL
--- Tạo hai người dùng CSDL.
--o Một người dùng với vai trò nhà quản trị CSDL. Phân quyền cho người dùng
--này chỉ được phép thao tác trên CSDL quản lý nhà trọ cho thuê và có toàn 
--quyền thao tác trên CSDL đó
--o Một người dùng thông thường. Phân cho người dùng này toàn bộ quyền thao
--tác trên các bảng của CSDL và quyền thực thi các SP và các hàm được tạo ra từ
--các yêu cầu trên
--- Kết nối tới Server bằng tài khoản của người dùng thứ nhất. Thực hiện tạo một bản sao
--CSDL