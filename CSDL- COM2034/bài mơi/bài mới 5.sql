use QLDA
go
--1. CẤU TRÚC LẶP
--Cú pháp:
--while BTđiềukiện
--begin
--	 Lệnh trong thân vòng lặp
--End
--Lưu ý:
---	Lệnh thực hiện TRONG KHI biểu thức điều kiện là true
---	Trong thân vòng lặp phải có 1 biến điều khiển để cho BTDK trả về gtrij FALSE
---	Có thể break: Thoát khỏi luôn vòng lặp
---	Continue: Tiếp tục vòng lặp
--2. QUẢN LÝ LỖI
--Cú pháp
--	Begin try
--		Lệnh
--	End try
--	Begin catch
--		Thông báo lỗi
--	End catch
--3. Stored procedure (thủ tục)
--Cú pháp:
--Create proc TenThuTuc(
--	@thamso1 <kieudulieu> [=giatri][out],
--@thamso2 <kieudulieu> [=giatri][out]
--…
--)
--As
--Begin
--	…
--end
--ví dụ 1 Xây dựng SP , Nhập tên Bạn Và In ra màn Hình
if OBJECT_ID('SPnhapten') is Not Null
	drop proc SPnhapten
go

create proc SPnhapten(@ten Nvarchar(30))
as 
print N'Chào bạn '+@ten
go

exec SPnhapten N' KIeu'


-- ví dụ 2: Viết SP tính tông 2 số avaf b
if OBJECT_ID(' spTongAB') is not null
	drop proc spTongAB
	go

	create proc spTongAB(@a float, @b float)
	as
	declare @tong float=0;
	set @tong=@a+@b
	print N'Tổng @ số là:'+ cast(@tong as nvarchar)

	exec spTongAB 4,5

	-- vd 3: viết 1 SP Tính tổng 2 Số 2 và b. Tổng trả về giá trị đầu ra
	if OBJECT_ID(' spTongAB2') is not null
	drop proc spTongAB
	go

	create proc spTongAB2(@a float, @b float,@tong float out)
	as
	
	set @tong=@a+@b
	print N'Tổng @ số là:'+ cast(@tong as nvarchar)

	declare @tongra float
	exec spTongAB2 4,5, @tongra out

	print @tongra

	-- Viết lại 1SP thêm dữ liệu vào phồng ban

	if OBJECT_ID('spInsertPhongBan') is not null
	drop proc spInsertPhongBan
go
create proc spInsertPhongBan(
	@TenP nvarchar (15),
	@MaP int,
	@TruongP nvarchar (20),
	@NgayNC date
)
as
	insert into PHONGBAN values(@TenP,@MaP,@TruongP,@NgayNC)
go
exec spInsertPhongBan N'Hành chính',3,'002','2-3-1999'
select * from PHONGBAN


--



if OBJECT_ID('spInsertDeAn') is not null
	drop proc spInsertDeAn
go
create proc spInsertDeAn(
	@TenDa nvarchar(20),
	@MaDa int,
	@DiaDiemDa nvarchar(40),
	@Phong int
)
as
begin
	if @MaDa in (select MADA from DeAn)
		print N'Mã đề án này đã có'
	else 
		begin try
			insert into DeAn values (@TenDa,@MaDa,@DiaDiemDa,@Phong)
		end try
		begin catch
			print N'Nhập sai dữ liệu của bảng đề án'
		end catch
end
go
select * from DeAn
exec spInsertDeAn N'Demo đấy',6,N'Quảng Ninh',1



-- vd7: viết ! SP, vơi stham số đầu vào là mã nhân viên.IN ra toàn t=bộ thông tin về nó
if OBJECT_ID('SPtimnhavientheoma') is not null
	drop proc SPtimnhavientheoma
create proc SPtimnhavientheoma(
@ma nvarchar(10)
)
as 
select* from NHANVIEN where MANV=@ma
go
exec SPtimnhavientheoma '001'


--ví dụ 8: Viết 1 SP với tham số đầu vào là mã nhân viên . in ra Tên Nhân viên, tổng số giờ làm việc của nahan viên đó

if OBJECT_ID('SPSreachGioNV') is not null
	drop proc SPSreachGioNV

create proc SPSreachGioNV(
@Manv nvarchar(10))
as
select TENNV, sum(THOIGIAN)' Tổng số tim làm'
from NHANVIEN join PHANCONG on NHANVIEN.MANV=PHANCONG.MA_NVIEN
where MANV=@Manv
group by TENNV 
exec SPSreachGioNV '003'