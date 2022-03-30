--Dựa vào csdl QLDA để thực hiên các câu truy vấn sau:
use QLDA
go
--1. Đưa ra top 5 Mã nhân viên, tên nhân viên (bao gồm đầy  đủ họ tên), lương trong công ty.
-- Biết lương có định dạnh sau đấu thập phân 3 số
select top 5 MANV,HONV+' '+TENLOT+' '+TENNV as N'HỌ tên',CAST(Luong as decimal(10,3))
from NHANVIEN

--2. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân 
--viên tham dự đề án đó. Xuất định dạng “tổng số giờ làm việc” kiểu varchar
select TENDEAN,cast(sum(THOIGIAN) as varchar) as N'Tổng thòi gian'
from DEAN left outer join CONGVIEC on DEAN.MADA=CONGVIEC.MADA inner join PHANCONG on CONGVIEC.STT=PHANCONG.STT
group by TENDEAN

--3. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên 
--làm việc cho phòng ban đó. Xuất định dạng “luong trung bình” kiểu decimal với 
--2 số thập phân
select TENPHG,CONVERT(decimal(10,2), avg(LUONG)) 
from NHANVIEN right outer join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG 
group by TENPHG


--4. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các
--nhân viên tham dự đề án đó. Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
select TENDEAN,ceiling(sum(THOIGIAN)) as N'Tổng thòi gian'
from DEAN left outer join CONGVIEC on DEAN.MADA=CONGVIEC.MADA inner join PHANCONG on CONGVIEC.STT=PHANCONG.STT
group by TENDEAN



--5. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV), Lương có mức lương trên mức lương 
-- trung bình (làm tròn đến 2 số thập phân) của phòng "Nghiên cứu"
select HONV+' '+TENLOT+' '+TENNV as N'HỌ tên', cast(LUONG as decimal(10,2))
from PHONGBAN inner join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG
group by HONV,TENLOT,TENNV, LUONG,TENPHG
having LUONG> (select avg(LUONG)
from PHONGBAN inner join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG) and TENPHG like N'%Nghiên Cứu%'
select*from PHONGBAN inner join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG

--6. Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) có trên 2 thân nhân,
--thỏa các yêu cầu Dữ liệu cột HONV được viết in hoa toàn bộ

select Upper(HONV)+' '+ TENLOT+' '+ TENNV as N'Họ Tên NV', DCHI
from NHANVIEN inner join THANNHAN on NHANVIEN.MANV=THANNHAN.MA_NVIEN
group by HONV,TENLOT,TENNV,DCHI
having (select COUNT(TENTN) 
from NHANVIEN inner join THANNHAN on NHANVIEN.MANV=THANNHAN.MA_NVIEN) >2
select*from THANNHAN
--7. Cho biết tên nhân viên, phòng ban, tuổi, sinh vào thứ mấy  các nhân viên
-- có năm sinh trong khoảng 1960 đến 1965.
select TENNV, TENPHG, YEAR(GETDATE())-Year(NGSINH)as N'Tuổi', DATENAME(WEEKDAY,NGSINH) as N'thứ'
from NHANVIEN inner join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG
where year(NGSINH) between 1960 and 1965
--8. Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức trưởng phòng.
--Kết quả lưu vào 1 biến bảng
--b1: add vào bảng cục bộ
select MAPHG,TENNV
into #kk
from PHONGBAN left join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG
where MANV=TRPHG
--b2: truy vấn cung bảng cục bộ
select #kk.TENNV as N'Tên Trưởng Phòng' ,PHONGBAN.NG_NHANCHUC as N'Ngày nhậm chức',count(MANV) as N' số Lượng Nhan Viên Dưới quyền'
from PHONGBAN left join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG join #kk on PHONGBAN.MAPHG=#kk.MAPHG
group by #kk.TENNV,NG_NHANCHUC


--9.  Liệt kê ra (tên nhân viên, tổng thời gian làm việc) của các nhân viên có thời gian
-- làm việc ít nhất. Kết quả lưu vào 1 biến bảng
declare @b table
(

	TENNhaVien nvarchar(50),
	THoigian int
	)
	insert into @b
select top 1 with ties TENNV, sum(THOIGIAN)
from NHANVIEN inner join PHANCONG on NHANVIEN.MANV=PHANCONG.MA_NVIEN
group by TENNV
order by sum(THOIGIAN) 
select*from @b
--10. Đưa ra tên trưởng phòng, tên phòng ban và số địa điểm các các phòng ban đó đặt

select TENNV,TENPHG, count(DIADIEM_PHG.DIADIEM) as N'Số Địa Điểm'
from PHONGBAN left outer join DIADIEM_PHG on PHONGBAN.MAPHG=DIADIEM_PHG.MAPHG inner join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG
WHERE TRPHG=MANV
group by TENPHG,TENNV


