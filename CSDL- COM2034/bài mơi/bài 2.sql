--             Chuyển đổi kiểu dữ kiệu       ----

-- 1. Chuyển đổi ngầm định--- theo độ ưu tiên
-- 2 chuyển đổi tường minh
-- dùng Cast(biểu thức AS KIểu dữ liệu. leght)
select cast (15.45 as int)
select cast (15.45 as nvarchar)
select cast (15.45 as decimal(18,1))-- lấy pần thập phần
-- hàm convert( kiểu dữ liệu
select CONVERT( varchar(10),'2021-1-5')


use QLDA
go
--vd1: tính lương trung bình của cty. LUong hiển thị 2 phần thập phân dùng decimall
select cast(avg(LUONG) as decimal(10,2) from NHANVIEN

-- ví dụ 2: tính trung bính lương của từng Phòng ban

select PHG,CONVERT(varchar, avg(LUONG)) 
from NHANVIEN right outer join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG 
group by PHG

-- ví dụ 3: liệt kê tên đề án, tổng số thời gian làm việc của tất cả các nhân viên trong đè án đó

select TENDEAN,cast(sum(THOIGIAN) as decimal(18,4)) as N'Tổng thòi gian'
from DEAN left outer join CONGVIEC on DEAN.MADA=CONGVIEC.MADA inner join PHANCONG on CONGVIEC.STT=PHANCONG.STT
group by TENDEAN

-- 3. hàm toán học

select CEILING(4.5) as N' lấy cận trên',FLOOR(4.5) N' lấy cạn dưới', ROUND(4.5,1) as N' Hàm Làm tròn'


-- II. Sửa lý chuối
-- hàm thời gian
---  hàm ngày tháng + Ký tự
-- ví duj1: đưa ra tên nhân viên  của all nhân viên trong cty. tên phải viết hoa

select Upper(TENNV), YEAR(getdate())- YEAR(NGSINH) from NHANVIEN

--cách 2:
select Upper(TENNV),datediff(year,NGSINH,getdate()) from NHANVIEN

-- đưa ra đầy đủ họ tên  trong 1 cột và cho biết hojkc sinh vào thứ mấy
select (HONV+' '+TENLOT+' '+  TENNV) as N'Họ Tên',DATENAME(WEEKDAY,NGSINH) as N'thứ',convert(date,NGSINH) as N' Ngày Sinh'  from NHANVIEN

