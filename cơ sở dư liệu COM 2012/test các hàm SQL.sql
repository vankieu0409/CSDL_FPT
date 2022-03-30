use QLTV
go

--Tìm Max(column) - Tìm giá trị lớn nhất trong cột column
--Min(column) - Tìm giá trị nhỏ nhất trong cột column
----Avg(column) - Tìm giá trị trung bình của cột column
--Count – Hàm đếm số bộ

select*
from SINHVIEN
where Hoten like N'Nguyễn%' and MaKN like'UDPM'

-- II các hàm thống Kê
--1 cho biết số trang lớn nhất trong bảng sách
select max(SoTrang) as SoTrangLN
from SACH

--2 cho biết số trang trung bình của NXB Kim đồng

select AVG(SoTrang) as soTrangTB
from SACH
where NXB like N'Kim đông'

--vd3 cho biết tổng số đầu sách nhập trong năm 2021
select COUNT(MaSach) as TongsoDS
from SACH
where YEAR (NgayNhap)= 2021

--cach 2:
select COUNT(MaSach) as TongsoDS
from SACH
where NgayNhap <'1-1-2022'

-- thống kê sô SV đã mượn sách của các lớp: MaLop, số SV mượn)
select MaLop,COUNT(MaSV) as sosachmuon
from PHIEUMUON
group by MaLop
-- thống kê Số SV đã mượn sách của các lớp malop, Số SV mượn
select MaLop,COUNT(MaSV) as sosachmuon
from PHIEUMUON
group by MaLop
having COUNT(MaSV)>5