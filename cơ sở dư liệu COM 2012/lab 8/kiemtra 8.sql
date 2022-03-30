create database QLNV1
go
use QLNV1
go

create table PHONGBAN
(
	MaPB nvarchar(5) not null,
	TenPB nvarchar(20) not null
	primary key (MaPB)
)
go
create table CHUCVU
 (
	MaCV nvarchar(5) not null,
	TenCV nvarchar(30) not null,
	PhuCap money not null,
	primary key (MaCV)
)
go

create table BANGNV
(
	MaNV nvarchar(5) not null,
	Hodem nvarchar(30) not null,
	Ten nvarchar(10) not null,
	Gioitinh nvarchar(5) not null,
	NgaySinh date not null,
	DiaChi nvarchar(50) not null,
	HesoLuong float not null,
	MaPB nvarchar(5) not null,
	MaCV nvarchar(5) not null,
	primary key (MaNV),
	constraint FK_PB_NV foreign key(MaPB) references PHONGBAN(MaPB),
	constraint FK_NV_CV foreign key(MaCV) references CHUCVU(MaCV)
)
go

insert into PHONGBAN
values ('PB01',N'Kế Toán'),
('PB02', N' Hành Chinh'),
('PB03',N'Phát triển'),
('PB04', N' Kế hoạch'),
('PB05', N'KInh doanh'),
('PB06', N' Công trình')
go

insert into CHUCVU
values ('CV01',N'Giám Đốc',5000000),
('CV02',N'Phó Giám Đốc',4000000),
('CV03',N'Trưởng Phòng',3000000),
('CV04',N'Tổ Trưởng',1500000),
('CV05',N'Nhân Viên',500000)
 go

insert into BANGNV
values('NV01',N'NGuyễn Văn',N'Kiều',N'Nam','1998-2-25',N'Vĩnh Phúc',4.3,'PB01','CV01'),
('NV02',N'NGuyễn Văn',N'Lâm',N'Nam','1998-2-25',N'Vĩnh Phúc',3.21,'PB04','CV03'),
('NV03',N'NGuyễn Lâm',N'THiều',N'Nam','1998-2-25',N'Vĩnh Phúc',2.83,'PB06','CV04'),
('NV04',N'Lê Thị',N'Phương',N'Nữ','1998-2-25',N'Vĩnh Phúc',3.21,'PB02','CV02'),
('NV05',N'NGuyễn Văn',N'Bậu',N'Nam','1998-2-25',N'Vĩnh Phúc',2.34,'PB01','CV05')
go

--truy vấn
--1.	Hiển thị thông tin gồm: MaNV, Hoten, gioiTinh, ngaySinh, tuoi, phucap, tencv 
select MaNV,Hodem+' '+Ten as HOTEN, Gioitinh,NgaySinh,Tuổi=year(getdate())-year(ngaysinh),PhuCap,TenCV
From BANGNV inner join CHUCVU on BANGNV.MaCV=CHUCVU.MaCV

--2.	Hiển thị thông tin Nhân viên có hsl<4.6: MaNV, hoten, hsl, phucap
select MaNV,Hodem+' '+Ten as HOten,HesoLuong,PhuCap
From BANGNV inner join CHUCVU on BANGNV.MaCV=CHUCVU.MaCV
where HesoLuong<4.6

--3.	Cập nhật lại hsl của NV0001 thành 4.6
update BANGNV
set HesoLuong=4.6
where MaNV like 'NV01'
--4.	Xóa những NhanVien sinh trước ngày 1/1/1960
delete BANGNV
where NgaySinh <'1960-1-1'

--5.	Hiển thị thông tin các Nhân viên sinh tháng 11: MaNV, hoten, ngaysinh, tenpb

select MaNV,Hodem+' '+Ten as HOten,NgaySinh,TenPB
from  BANGNV inner join PHONGBAN on BANGNV.MaPB=PHONGBAN.MaPB
where MONTH(NgaySinh)='11'

--6.	Hiển thị thông tin các Nhân viên Nữ họ Đỗ
select BANGNV.*
from BANGNV
where Hodem like N'%Đỗ%' and Gioitinh like N'%Nữ%'

--7.	Hiển thị thông tin các Nhân viên tên bắt đầu là H.
select BANGNV.*
from BANGNV
where Ten like N'h%'
--8.	Hiển thị các chức vụ không có nhân viên nào.
select CHUCVU.*
from CHUCVU left outer join BANGNV on CHUCVU.MaCV=BANGNV.MaCV
where BANGNV.Ten is null

--c2:
	select *
		from CHUCVU
		where macv not in (select mcv
						  from NHANVIEN)
--9.	Xóa thông tin các Nhân viên Nữ
delete BANGNV
where Gioitinh like 'Nữ'
--10.	Hiển thị Top 2 các phòng ban có nhiều nhân viên nhất.
select Top 2 TenPB,COUNT(MaNV) as soluongnv 
from PHONGBAN inner join BANGNV on PHONGBAN.MaPB=BANGNV.MaPB
group by TenPB
order by COUNT(MaNV) desc

--10.	Hiển thị các phòng ban có nhiều nhân viên nhất.
		select top 1 with ties TenPB , COUNT(MaNV) soluongNV
		from PHONGBAN inner join NHANVIEN on PHONGBAN.MaPB=NHANVIEN.MaPB
		group by TenPB
		order by COUNT(MaNV) desc

--11.	Hiển thị thông tin các nhân viên có độ tuổi từ 18 đến 40, sắp giảm dần theo độ tuổi
 select *, YEAR(getdate())-YEAR(NgaySinh) as tuoi
 from BANGNV
 where YEAR(getdate())-YEAR(NgaySinh) between 18 and 40
 order by YEAR(getdate())-YEAR(NgaySinh) desc

--12.	Cập nhật phụ cấp của macv “CV01” thành 6000000
update CHUCVU
set PhuCap=6000000
where MaCV like 'CV01'
--13.	Hiển thị thông tin các sinh viên nam, sinh vào tháng 5 năm 1990
--14.	Viết lệnh giảm 50% phụ cấp của tất cả các chức vụ
--15.	Xóa các chức vụ không có NhanVien nào.
delete from CHUCVU
where MaCV not in (s
--15.	Xóa các chức vụ không có NhanVien nào.
		delete from CHUCVU
		where macv not in (select mcv
						   from NHANVIEN		
						   )

--16.	Hiển thị thông tin Nhân viên Nữ có tuổi >20: MaNV, hoten, tuoi, hsl, phucap
--17.	Chèn thêm 1 bản ghi mới vào bảng NhanVien (Không được phép nhập giá trị null).
--18.	
--19.	Hiển thị Mã nhân viên, họ tên (gộp họ đệm và tên), giới tính, địa chỉ của các nhân viên nam 
--20.	Đưa ra họ tên, địa chỉ, hệ số lương, phụ cấp chức vụ, Lương thực lĩnh của tất cả các nhân viên (biết Lương thực lĩnh=hệ số lương * 900+ phụ cấp chức vụ) 
--21.	Đếm số nhân viên mỗi phòng ban (Thông tin đưa ra: tên phòng ban, số lượng) 
--22.	Đưa ra tên phòng ban có số lượng nhân viên nhiều nhất 
--23.	Thống kê số nhân viên của mỗi phòng ban 
select* 
from PHONGBAN inner join 
--24.	Xóa nhân viên có mã NV0101 
