use QLTV
go
--6.1 Liệt kê tất cả thông tin của các đầu sách gồm tên sách, mã sách, giá tiền , tác giả
--thuộc loại sách có mã “IT”.(mã thể loại sách)
select TenSach,SACH.MaSach,GiaTien,TenTG
from SACH inner join SACHTG on SACH.MaSach=SACHTG.MaSach inner join TACGIA on SACHTG.MaTG=TACGIA.MaTG
where MaTL like 'H01'


--6.2 Liệt kê các phiếu mượn gồm các thông tin mã phiếu mượn, mã sách , ngày mượn, mã
--sinh viên có ngày mượn trong tháng 01/2017.
select CTMUON.SoPM,NgayMuon,MaSach,MaSV
from PHIEUMUON inner join CTMUON on PHIEUMUON.SoPM=CTMUON.SoPM
where MONTH(NgayMuon)=1 and YEAR(NgayMuon)=2021


--6.3 Liệt kê các phiếu mượn chưa trả sách cho thư viên theo thứ tự tăng dần của ngày
--mượn sách.
select *
from PHIEUMUON 
where TrangThai like N'%Chưa trả%'


----6.4 Liệt kê tổng số đầu sách của mỗi loại sách ( gồm mã loại sách, tên loại sách, tổng số
----lượng sách mỗi loại).
select SACH.MaSach,TenTL,COUNT(PHIEUMUON.TongSM) as TongSLM
from SACH right outer join THELOAI on SACH.MaTL=THELOAI.MaTL inner join CTMUON on SACH.MaSach=CTMUON.MaSach inner join PHIEUMUON on CTMUON.SoPM=PHIEUMUON.SoPM
group by SACH.MaSach,TenTL
-- 6.5 Đếm xem có bao nhiêu lượt sinh viên đã mượn sách.
select distinct count(MaSV) as soLSVMS
from PHIEUMUON
--6.6 Hiển thị tất cả các quyển sách có tiêu đề chứa từ khoá “SQL”.
select*
from SACH
where TenSach like N'SQL%'


--6.7 Hiển thị thông tin mượn sách gồm các thông tin: mã sinh viên, tên sinh viên, mã
--phiếu mượn, tiêu đề sách, ngày mượn, ngày trả. Sắp xếp thứ tự theo ngày mượn sách.
select PHIEUMUON.MaSV,Hoten,PHIEUMUON.SoPM,TenSach,NgayMuon,NgayTra
from SINHVIEN inner join PHIEUMUON on SINHVIEN.MaSV=PHIEUMUON.MaSV inner join CTMUON on CTMUON.SoPM=PHIEUMUON.SoPM inner join SACH on CTMUON.MaSach=SACH.MaSach
order by NgayMuon 

--6.8 Liệt kê các đầu sách có lượt mượn lớn hơn 20 lần.

select Sach.Tensach,Sach.MaSach, count(CTMUON.MaSach) as SoLanMuon
from Sach inner join CTMUON on Sach.MaSach=CTMUON.MaSach
group by SACH.TenSach, SACH.MaSach
having count(CTMUON.MaSach)>20

--6.9 Viết câu lệnh cập nhật lại giá tiền của các quyển sách có ngày nhập kho trước năm
--2014 giảm 30%.
update SACH
set GiaTien=GiaTien-(GiaTien*0.3)
where YEAR(NgayNhap)<2014

--6.10 Viết câu lệnh cập nhật lại trạng thái đã trả sách cho phiếu mượn của sinh viên có mã
--sinh viên PD12301 (ví dụ).
update PHIEUMUON
set TrangThai=N'Đã trả', NgayTra= getdate()
where MaSV=N'PD12301'


--6.11 Lập danh sách các phiếu mượn quá hạn chưa trả gồm các thông tin: mã phiếu mượn,
--tên sinh viên, email, danh sách các sách đã mượn, ngày mượn.
select PHIEUMUON.SoPM,Hoten,Email,NgayMuon,TenSach
from PHIEUMUON inner join SINHVIEN on PHIEUMUON.MaSV=SINHVIEN.MaSV 
	inner join CTMUON on CTMUON.SoPM=PHIEUMUON.SoPM 
	inner join SACH on CTMUON.MaSach=SACH.MaSach
where TrangThai like N'%Chưa trả%' and NgayTra is null -- DATEDIFF(Day,PhieuMuon.NgayTra, getdate())>=7 
 


--6.12 Viết câu lệnh cập nhật lại số lượng bản sao tăng lên 5 đơn vị đối với các đầu sách có
--lượt mượn lớn hơn 10

update SACH set SoLuong= SoLuong+5
where MaSach in (
	select Sach.MaSach
	from Sach inner join CTMUON on Sach.MaSach=CTMUON.MaSach
	group by SACH.MaSach
	having count(CTMUON.MaSach)>10)


--6.13 Viết câu lệnh xoá các phiếu mượn có ngày mượn và ngày trả trước „1/1/2010‟
select SoPM
from PHIEUMUON
where NgayMuon<'2010-1-1' and NgayTra<'2010-1-1'

--bước1:
delete from CTMUON
where SoPM in (
select SoPM
from PHIEUMUON
where NgayMuon<'2010-1-1' and NgayTra<'2010-1-1'
)
delete from [PHIEUMUON]
where NgayMuon<'2010-1-1' and NgayTra<'2010-1-1'

