--bài 7 NHôn ngữ thao tác
use QLBH1
go

--SELECT côt 1, cột 2…
--INTO bảng_mới
--FROM bảng_nguồn [WHERE <điều
--kiện> ]
--[GROUP BY group_list]
--[HAVING <điều kiện>]
--[ORDER BY order_by_list]


--vd: Viết câu lệnh tạo 1 bảng mới có tên KhachHang1, sao chép toàn bộ dữ liệu từ
--bảng KhachHang qua bảng mới

Select* 
into KhachHang1
From KhachHang

-- tao bảng mới từ bảng sản phẩm
select* into  SanPham1
from SanPham

---- Nhập liệu

--INSERT INTO tên_bảng (danh_sách_cột)
--VALUES (danh_sách_giá_trị)--cách 2:----INSERT INTO PHONG_BAN
----VALUES ('PB007', 'Truyen Thong', null)

--Thêm nhiều hàng mới vào bảng

--INSERT INTO PHONG_BAN
--VALUES ('PB007', 'Truyen Thong', null),
-- ('PB008', ’Hanh Chinh', null),
-- ('PB009', ’Cong Nghe', null);
-- Thêm 2 dòng dữ liệu vào bảo sản phấm
insert into SanPham(MoTa,SoLuong,DonGia,TenSP)
values (N'ấm Nước',2,100000,N' ấm đun Nước')

insert into SanPham
values (N'ấm Nước',2,100000,N' ấm đun Nước')
--cách 3:
insert into SanPham
values (N'Đồ điện tử',3,20000,N' Tivi'),
(N'Đồ điện tử',3,20000,N' Tivi')

--thêm dữ liệu vào vảng từ 1 cấu truy vấn
insert into KhachHang1
select *
from KhachHang
where MaKhachHang like (N'%KH0[12]%')

--Cập nhật

--UPDATE tên_bảng
--SET cột1= ‘biểu thức 1’ [, cột2= ‘biểu thức 2’] . . .
--[WHERE <điều kiện>]

update KhachHang1
set DienThoai='0987365421'
where MaKhachHang like 'KH02'
-- VD2: Tăng số lượng sản phẩm của mặt hàng có mã là 3 lên thêm 200 đơn vị

UPdate SanPham1
set SoLuong = SoLuong + 200
where MaSanPham = 3

-- VD3: Giảm giá 5% cho tất cả các sản phẩm
update SanPham1
set DonGia = DonGia *0.95

select*
from HoaDonChiTiet

--Xóa dl trong bảng
--DELETE FROM tên_bảng
--[WHERE <điều kiện>]
---- VD1: xóa thông tin của hoadonchitiet có mã là 2
delete HoaDonChiTiet
where MaSanPham=2


