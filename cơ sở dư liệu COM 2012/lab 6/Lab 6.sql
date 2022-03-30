--Ngôn ngữ truy vấn select trên nhiều bảng


--cách 1:
--select [distinct/top n] tên cột, tên cột 2..
--from bangr1 inner join/ left order join\ right oder join Barng2 (phép nối)  on barng 1= barng2 cot chung( điều kiện nối)
-- phép nối Bảng 3 on Điều kiện  nối ( VD barng2 cột chung= bảng 3. cột chung)
-- where nơi đặt điều kiện bình thường (vd>5dieerm)
-- group by tên cột cần nhóm,...( khí select có hàm thống kê. group by nhóm 

-- having nơi đặt điều kiện thống kê (VD: sum (điểm) >50)


-- oder by+ tên cột cần sắp xếp +asc|desc+tên cột 2 ccafn nhóm+ asc|desc




--NOTE:
--cột chung phải chỉ rõ tenbang.tencot
--cách 2: dùng trong mệnh đề where
-- phép ưu tiên chỉ có ý nghĩa khi ưu tiên bảng 1


--innerjoin: đưa ra phần dữ liệu chung của 2 bảng.

--full outter join: kết quả gồm tất cả các bản ghi 2 bảng.

-- left outter join :ưu tiên dữ liệu bản gbeen trái
-- đưa ra toàn bộ dữ liệu của bảng bên trái (Hoa dơn chi tiết). nếu dòn gduwx liệu bảng còn lại không có thì hiển thị null.


-- hà


use QLBH1
go
--nối 2 bảng Sanpham, hóa đơn chi tết inner join
select*
from HoaDonChiTiet inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
-- nối 2 bảng Sanpham, hoadownchitet: left outter join
select*
from HoaDonChiTiet left outer join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham


-- nối 2 bảng Sanpham, hoadownchitet: right outter join

select*
from HoaDonChiTiet right outer join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham

-- nối 3 bảng San pham,hoa don, hoa dơn chi tiết
select*
from HoaDonChiTiet left outer join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham inner join HoaDon on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon

-- nối 4 bảng
select*
from HoaDonChiTiet left outer join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham inner join HoaDon on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join KhachHang on KhachHang.MaKhachHang=HoaDon.MaKhachHang


--bài 1:
--a. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột
--sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua
select HoaDon.MaHoaDon,MaKhachHang,TrangThai,MaSanPham,SoLuong,NgayMuaHang
from HoaDon inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon


--b. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột
--sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua với
--điều kiện maKhachHang = ‘KH001’
select HoaDon.MaHoaDon,MaKhachHang,TrangThai,MaSanPham,SoLuong,NgayMuaHang
from HoaDon inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon
where MaKhachHang like 'KH01'

--c. Hiển thị thông tin từ 3 bảng Hoá đơn, Hoá đơn chi tiết và Sản phẩm gồm các cột
--sau: maHoaDon, ngayMua, tenSP, donGia, soLuong mua trong hoá đơn, thành
--tiền. Với thành tiền= donGia* soLuong
select HoaDon.MaHoaDon,NgayMuaHang,TenSP,DonGia*SanPham.SoLuong as thanhtien
from HoaDon inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham


--d. Hiển thị thông tin từ bảng khách hàng, bảng hoá đơn, hoá đơn chi tiết gồm các
--cột: họ và tên khách hàng, email, điện thoại, mã hoá đơn, trạng thái hoá đơn và
--tổng tiền đã mua trong hoá đơn. Chỉ hiển thị thông tin các hoá đơn chưa thanh
--toán.
select HovaTen,Email,DienThoai,TrangThai,HoaDonChiTiet.MaHoaDon,TongTien=Sum(DonGia*HoaDonChiTiet.SoLuong)
from KhachHang inner join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
where TrangThai like N'%Chưa Thanh Toán%'
group by HovaTen,Email,DienThoai,TrangThai,HoaDonChiTiet.MaHoaDon



--e. Hiển thị maHoaDon, ngàyMuahang, tổng số tiền đã mua trong từng hoá đơn. Chỉ
--hiển thị những hóa đơn có tổng số tiền >=500.000 và sắp xếp theo thứ tự giảm dần
--của cột tổng tiền.select HoaDon.MaHoaDon,NgayMuaHang,TongTien= Sum(DonGia*HoaDonChiTiet.SoLuong)from KhachHang inner join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
group by HoaDon.MaHoaDon,NgayMuaHanghaving sum(DonGia*HoaDonChiTiet.SoLuong) <=500000order by TongTien desc--use QLBH1--stop--Bài 2 (4 điểm) Viết các câu truy vấn sau:
--a. Hiển thị danh sách các khách hàng chưa mua hàng lần nào kể từ tháng 1/1/2016
select KhachHang.*
from KhachHang left outer join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang
where NgayMuaHang>'2015' and MaHoaDon is null

--b. Hiển thị mã sản phẩm, tên sản phẩm có lượt mua nhiều nhất trong tháng 12/2016
select top 1 HoaDonChiTiet.SoLuong,TenSP
from HoaDonChiTiet inner join SanPham on HoaDonChiTiet.MaSanPham=SanPham.MaSanPham inner join HoaDon on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon
where month(NgayMuaHang) =12 and YEAR(NgayMuaHang)=2016
order by SoLuong desc
--c. Hiển thị top 5 khách hàng có tổng số tiền mua hàng nhiều nhất trong năm 2016
select top 5 KhachHang.*, TongTien=DonGia*HoaDonChiTiet.SoLuong
from KhachHang inner join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
where YEAR(NgayMuaHang)=2016
order by TongTien desc

--d. Hiển thị thông tin các khách hàng sống ở ‘Đà Nẵng’ có mua sản phẩm có tên
--“Iphone 7 32GB” trong tháng 12/2016
select KhachHang.*
from KhachHang inner join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
where YEAR(NgayMuaHang)=2016 and MONTH(NgayMuaHang)=12 and Diachi like N'Đà Nẵng' and TenSP like N'Iphone 7 32GB'

--e. Hiển thị tên sản phẩm có lượt đặt mua nhỏ hơn lượt mua trung bình các các sản
--phẩm.select TenSP,HoaDonChiTiet.SoLuongfrom HoaDonChiTiet inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPhamgroup by SanPham.MaSanPham,TenSP,DonGia,HoaDonChiTiet.SoLuonghaving  AVG(SanPham.MaSanPham*HoaDonChiTiet.SoLuong) > HoaDonChiTiet.SoLuongselect* from KhachHangselect* from HoaDonselect* from HoaDonChiTietselect* from SanPham--Câu 1:
--Lấy thông tin sau, sắp giảm dần theo MaKhachHang:
--MaKhachHang, Họ tên, MaHoaDon, NgayMuaHang, MaSanPham, TenSP, Số lượng mua, Thành Tiền. Trong đó Thành tiền = số lượng mua * DonGia

select KhachHang.MaKhachHang,HovaTen,HoaDon.MaHoaDon,NgayMuaHang,SanPham.MaSanPham,TenSP,SanPham.SoLuong, ThanhTien= SanPham.SoLuong * DonGia
from KhachHang inner join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
order by  MaKhachHang desc
 --Câu 2:  Hiển thị thông tin các hóa đơn mua hàng trong tháng 9 năm 2019, sắp tăng dần theo makhachhang: MaKhacHang, họ tên, mahoadon, ngày mua hàng.

select KhachHang.MaKhachHang,HovaTen,HoaDon.MaHoaDon,NgayMuaHang,SanPham.MaSanPham
from KhachHang inner join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
Where NgayMuaHang like N'2019/9'
order by  MaKhachHang
--Câu 3: 
--Cho biết thông tin mua hàng của các khách hàng có địa chỉ ở Hà nội (kể cả khách hàng không mua hàng lần nào): 
--MaKhachHang, họ và tên, số lần mua. 
select KhachHang.MaKhachHang,HovaTen, COUNT(HoaDon.MaHoaDon) as SoLANMUA
from KhachHang left outer join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang inner join HoaDonChiTiet on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
where Diachi like N'%Hà Nội%'
group by KhachHang.MaKhachHang,HovaTen

--Câu 4: Cho biết top 1 số sản phầm được mua nhiều lần nhất: masanpham, tenSP, số lần mua.
select top 1 SanPham.MaSanPham,TenSP, COUNT(HoaDonChiTiet.MaHoaDon) as SoLANMUA
from HoaDonChiTiet  inner join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
group by SanPham.MaSanPham, TenSP
order by SoLANMUA desc
--Câu 5: cho biết những sản phẩm chưa được mua lần nào: masanpham, tên sản phẩm, so luong, đơn giá.
select  SanPham.*
from HoaDonChiTiet right outer join SanPham on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
where HoaDonChiTiet.MaHoaDon is null

--Câu 5a: cho biết những Khách hàng chưa mua hàng lần nào: MaKH, họ tên, địa chỉ, điện thoại.
select KhachHang.* 
from KhachHang left outer join HoaDon on KhachHang.MaKhachHang=HoaDon.MaKhachHang
where HoaDon.MaKhachHang is null