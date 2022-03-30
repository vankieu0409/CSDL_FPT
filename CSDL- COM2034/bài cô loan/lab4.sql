use QLDA
go
--Bài 1: (4 điểm)
--Đưa ra thông nhân viên như sau: MaNV, TenNV, giới tính, ngày sinh, tuổi,
--trạng thái. Trong đó:
--- Giới tính: Dùng iif: Phái Nam thì ghi là Mr, còn lại ghi Mrs.
--- Trạng thái (dùng case) : + Nếu tuổi <18: Trẻ em.
--+ Tuổi từ 18 đến <60: Lao động,
--+ Còn lại: Tuổi già
--1.1
select MANV,
iif(PHAI like N'%Nam%','Mr','Mrs')+ TENLOT, PHAI as N' giới tính', DATEDIFF(year,NGSINH,Getdate()),
(case
when  DATEDIFF(year,NGSINH,Getdate())<18 then N' Trẻ EM'
when 18<= DATEDIFF(year,NGSINH,Getdate()) and  DATEDIFF(year,NGSINH,Getdate())<=60 then N' Lao Động'
else N' Tuổi già'
end) as N'Trạng thái'
from NHANVIEN


/* Bài 2: (3 điểm)
Thực hiện chèn thêm một dòng dữ liệu vào bảng DEAN theo 2 bước
-- Nhận thông báo “ thêm dư lieu thành cong” từ khối Try
-- Thêm thất bại để nhận thông báo lỗi “Thêm dư liệu thất bại” từ khối Catch */
begin try
insert DEAN
values (N'MSB',12,N'BT','cc')
print N'SUCCESS: THêm dữ liệu thành Công'
end try
begin catch
print N' FAILURE: THêm Giữ Liệu thất bại'
end catch


--Bài 3: Sử dụng vòng lặp WHILE: (3 điểm)
--Viết chương trình tính tổng số lẻ từ 1 đến n:
--- Khai báo 2 biến: @a và @n. Với @a = 1 và @n = 10
--- Cấu trúc điều khiển WHILE, IF .. ELSE để tìm và xuất ra màn hình tổng số
--lẻ của 2 biến từ @a đến @n.
