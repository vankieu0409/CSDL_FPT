use QLBH1
go

-- bài 1:
--a Hiển thị tất cả thông tin co trong bảng khách hàng
  select *
  from KhachHang
 -- b hiển thị top 10 khách hàng trong bảng khách hàng bao gồm các mã khach hàng, khách hàng,email,sdt
 select top 10 MaKhachHang,HovaTen,Email,DienThoai
 from KhachHang
 -- hiển thị thông tin từ bảng sản phẩm gồm các cột : mã sản phảm, tên sản phẩm,
 --tổng tiền tồn kho. với tổng tiền tồn kho= đơn giá*số lượng
 select MaSanPham,TenSP,Tien=Dongia * SoLuong
 from SanPham
 -- c2
 select MaSanPham,TenSP,Dongia * SoLuong as Tien
 from SanPham

 --. Hiển thị danh sách khách hàng có tên bắt đầu bởi kí tự ‘H’ gồm các cột:
--maKhachHang, hoVaTen, diaChi. Trong đó cột hoVaTen ghép từ 2 cột
--hoVaTenLot và Ten
 select MaKhachHang,HovaTen,Diachi
 from KhachHang
 where HovaTen like N'L%'


-- Hiển thị tất cả thông tin các cột của khách hàng có địa chỉ chứa chuỗi ‘Đà Nẵng’
select *
from KhachHang
where Diachi like N'Vĩnh Phúc'


-- Hiển thị các sản phẩm có số lượng nằm trong khoảng từ 100 đến 500.
select *
from SanPham
where SoLuong between 4 and 10


-- Hiển thị danh sách các hoá hơn có trạng thái là chưa thanh toán và ngày mua hàng
--trong năm 2016
select *
from HoaDon
where TrangThai like N'Đã Thanh Toán' and  YEAR (NgayMuaHang)= 2021


-- Hiển thị các hoá đơn có mã Khách hàng thuộc 1 trong 3 mã sau: KH001, KH003,KH006
select*
from HoaDon
where MaKhachHang like N'KH0[136]'


--bài 2

--a. Hiển thị số lượng khách hàng có trong bảng khách hàng
select COUNT (MaKhachHang) as SLKH
from KhachHang



--b. Hiển thị đơn giá lớn nhất trong bảng SanPham

select max(DonGia) as Dongialn
from SanPham

--c. Hiển thị số lượng sản phẩm thấp nhất trong bảng sản phẩm
select min(SoLuong) as SLmin
from SanPham

--d. Hiển thị tổng tất cả số lượng sản phẩm có trong bảng sản phẩm

select sum(SoLuong) as tongSanPham
from SanPham

--e. Hiển thị số hoá đơn đã xuất trong tháng 12/2016 mà có trạng thái chưa thanh toán
select count(MaHoaDon) as soHDCTT
from HoaDon
where TrangThai like N' Chưa Thanh Toán' and month (NgayMuaHang)=12 and YEAR(NgayMuaHang)=2016

--f. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn.
select MaHoaDon,count(MaSanPham) as SoloaiSp
from HoaDonChiTiet
group by MaHoaDon


--g. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn. Yêu cầu
--chỉ hiển thị hàng nào có số loại sản phẩm được mua >=5.

select MaHoaDon,count(MaSanPham) as SoloaiSp
from HoaDonChiTiet
group by MaHoaDon
having COUNT(MaSanPham)>=2

--h. Hiển thị thông tin bảng HoaDon gồm các cột maHoaDon, ngayMuaHang
--maKhachHang. Sắp xếp theo thứ tự giảm dần của ngayMuaHang
select MaHoaDon,NgayMuaHang,MaKhachHang
from HoaDon
order by NgayMuaHang desc
