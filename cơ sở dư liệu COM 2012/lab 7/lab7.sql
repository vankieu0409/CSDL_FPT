use QLBH1
go

--a. Cập nhật lại thông tin số điện thoại của khách hàng có mã ‘KH002’ có giá trị mới
--là ‘16267788989’
update KhachHang
set DienThoai='16267788989'
where MaKhachHang like 'KH02'

--b. Tăng số lượng mặt hàng có mã ‘3’ lên thêm ‘200’ đơn vị

update SanPham
set SoLuong=SoLuong+200
where MaSanPham like 3

--c. Giảm giá cho tất cả sản phẩm giảm 5%

update SanPham
set DonGia=DonGia*0.95


--d. Tăng số lượng của mặt hàng bán chạy nhất trong tháng 12/2016 lên 100 đơn vị
update SanPham
set SoLuong=SoLuong+100
where SoLuong in (select top 1 SanPham.TenSP,SanPham.SoLuong,sum(HoaDonChiTiet.SoLuong)as tongsobanra
from SanPham inner join HoaDonChiTiet on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
 inner join HoaDon on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon
where YEAR(NgayMuaHang)=2016 and MONTH(NgayMuaHang)=12
 group by SanPham.SoLuong, TenSP
 order by sum(HoaDonChiTiet.SoLuong) asc)
 

--e. Giảm giá 10% cho 2 sản phẩm bán ít nhất trong năm 2016
update SanPham
set DonGia= DonGia*0.9
where SoLuong in (select top 2 SanPham.TenSP,SanPham.SoLuong,sum(HoaDonChiTiet.SoLuong)as tongsobanra

from SanPham inner join HoaDonChiTiet on SanPham.MaSanPham=HoaDonChiTiet.MaSanPham
 inner join HoaDon on HoaDon.MaHoaDon=HoaDonChiTiet.MaHoaDon
where YEAR(NgayMuaHang)=2016

 group by SanPham.SoLuong, TenSP
 order by sum(HoaDonChiTiet.SoLuong) desc)

--f. Cập nhật lại trạng thái “đã thanh toán” cho hoá đơn có mã 120956
update HoaDon
set TrangThai='đã thanh toán' 
where MaHoaDon like '120956'
--g. Xoá mặt hàng có mã sản phẩm là ‘2’ ra khỏi hoá đơn ‘120956’ và trạng thái là
--chưa thanh toán.
delete SanPham
where MaSanPham like '2'
--h. Xoá khách hàng chưa từng mua hàng kể từ ngày “1-1-2016”delete KhachHang where Year(HoaDon.NgayMuaHang)<2016