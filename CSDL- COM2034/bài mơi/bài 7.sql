-- bài 8:  Function và view

--function là 1 đối tượng trong SQL;

--cấu trúc 
--ccus pháp 1: hàm trả về giá trị vô hướng (int,Float,Nchar)

--create function fn+[tên hàm](@tham sô kiểu dữ liệu,.....)
--returns kiểu DL trả về
--as
--begin
--lẹnh SQL
--Return giá trị trả về
--end

-- ==> Lời Gọi Hàm  dbo.tenham(thamso)
use QLDA
go
-- ví dụ 1: tạo 1 function nhập vào mã nhân viên, hiển thị tuổi
if OBJECT_ID('fnTuoiNV') is not null
	drop function fnTuoiNV
create function fnTuoiNV (@manv Nvarchar(10))
returns Int
as
begin
return (select (YEAR(getdate())-year(NGSINH)) from NHANVIEN where MANV=@manv)
end
go

--gọi hàm
print ' tuổi là: '+ cast(dbo.fnTuoiNV('001') as nvarchar)

select dbo.fnTuoiNV('001') N'tuổi'

--cú pháp 2: hàm trả về 1 bảng đơn giản. trong thân hàm vhir có 1 lệnh Select đơn giả không bao gồm các hàm tính toán ,
-- không chứa phếp toán logic và từ begin....end trong thân hàm 
--create function fn+[tên hàm](@tham sô kiểu dữ liệu,.....)
--returns table
--as
-
--lẹnh SQL
--Return giá trị trả về

--ví dụ 2: tạo 1 fn nhập vào 1 mã phòng ban in ra thông tin phòng ban đó
if OBJECT_ID('fnPB') is not null
	drop function fnPB
go

create function fnPB(@map int)
returns table
as
return (select*from PHONGBAN where MAPHG=@map)

select* from dbo.fnPB(1)

--ví dụ 3: tạo FN nhập vào 1 mã nhân viên. hiển thị ra mã nahan viên , tên nhân viên, lương, tên phòng,
if OBJECT_ID('fnPB1') is not null
	drop function fnPB1
go
create function fnPB1(@man nvarchar(10))
returns table
as
return (select MANV,TENNV,LUONG,TENPHG from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG
where MANV=@man)

select* from dbo.fnPB1('001')
select* from NHANVIEN

--ví dụ 4: tạo FN nhập vào 1 mã Phòng. hiển thị ra mã nahan viên ,
--tên nhân viên, lương, tên phòng của những nhân viên có lương lơn hơn Luong tb
if OBJECT_ID('fnPBLuong') is not null
	drop function fnPBLuong
go
create function fnPBLuong(@map1 int)
returns table
as
return (select MANV,TENNV,LUONG,TENPHG from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG
where MANV=@map1 and LUONG> (select avg(LUONG)from NHANVIEN))
select*from dbo.fnPBLuong(4)

-- cú phấp 3: hàm trả về 1 bảng có câu lệnh phức tạp
--create function fn+[tên hàm](@tham sô kiểu dữ liệu,.....)
--returns @table(
--thuộc tính 1 KDL1,
--..........)
--as
-- begin
--lẹnh SQL
--Return giá trị trả về
--end

--ví dụ 5: Nhập 1 mã Phòng, Đếm sô nhân viên của phòng đó. Hiển thị ra tên phòng, số nhân viên phong đó

if OBJECT_ID('fnPBNV') is not null
	drop function fnPBNV
go
create function fnPBNV(@map2 int)
	returns @btemp table(
						tenphong Nvarchar(50),
						SONV int
						)
	as
		begin
			insert into @btemp
			select TENPHG,count(MANV) from vw_NVPB
			where MAPHG=@map2
			group by TENPHG

			return
		end
select*from dbo.fnPBNV(4)


-- Phần 2: view

---cú pháp
--create view  vwTenView
--as
--begin
--lẹnh SQL
--end

--ví du6: tao 1 view lư trữ toàn bộ thông tin nhân viên và phòng ban
if OBJECT_ID('vw_NVPB')  is not null
	drop view vw_NVPB
	go
create view vw_NVPB as
select * from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG

select * from vw_NVPB