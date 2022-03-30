--Bài 1: (4 điểm)
--Viết các hàm:
--
use QLDA
go
--➢ Nhập vào Manv cho biết số lượng đề án nhân viên này đã tham gia
if OBJECT_ID('fnsoda') is not null
	drop function fnsoda
create function fnsoda (@manv Nvarchar(10))
returns Int
as
begin
return (select count(MADA) from NHANVIEN join PHANCONG on NHANVIEN.MANV=PHANCONG.MA_NVIEN
where MANV=@manv)
end
go
--➢ Truyền tham số vào phái nam hoặc nữ, xuất số lượng nhân viên theo phái
if OBJECT_ID('fnSLPHAI') is not null
	drop function fnSLPHAI
create function fnSLPHAI (@manv Nvarchar(10))
returns Int
as
begin
return (select count(MANV) from NHANVIEN 
where PHAI=@manv)
end
go
-- Truyền tham số đầu vào là tên phòng, tính mức lương trung bình của phòng đó, Cho biết 
if OBJECT_ID('fnAVGLUONG') is not null
	drop function fnAVGLUONG
	go
create function fnAVGLUONG (@tenphg Nvarchar(50))
returns  @btemp table(
						tenphong Nvarchar(50),
						AVGLUONG int
						)
as
begin
insert into @btemp
select TENPHG, AVG(LUONG) from NHANVIEN join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
where PHAI=@tenphg
group by TENPHG
return
end
go

--➢ Tryền tham số đầu vào là Mã Phòng, cho biết tên phòng ban, họ tên người trưởng phòng 
--và số lượng đề án mà phòng ban đó chủ trì.
--Bài 2: (4 điểm)
--Tạo các view:
--➢ Hiển thị thông tin HoNV,TenNV,TenPHG, DiaDiemPhg.
--➢ Hiển thị thông tin TenNv, Lương, Tuổi.
--➢ Hiển thị tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất