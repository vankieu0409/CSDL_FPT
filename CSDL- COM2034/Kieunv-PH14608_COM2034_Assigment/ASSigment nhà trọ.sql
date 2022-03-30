create database	QLNhaTro
go
use QLNhaTro
go

create table LOAINHA
(
	MaLoaiNha nvarchar(5) primary key,
	TenLoaiNha nvarchar(20) not null
)
go
create table NGUOIDUNG
(
	MaNguoiDung int identity primary key,
	TenNguoiDung nvarchar(50) not null,
	GioiTinh nvarchar(5),
	SoDienThoai nvarchar(10) not null,
	DiaChi Nvarchar(100) not Null,
	QuanHuyen Nvarchar(50),
	Email nvarchar(50) not Null
)	
go
create table NHATRO
(
	MaNhaTro nvarchar(5) primary key,
	DienTich float not null,
	GiaPhong money not null,
	DiaChi nvarchar(100) not null,
	Quan nvarchar(20),
	MoTa nvarchar(100),
	NgayDang datetime not null,
	MaLoaiNha nvarchar(5) foreign key references LOAINHA(MaLoaiNha),
	MaNguoiDung int identity foreign key references NGUOIDUNG(MaNguoiDung),
	check (DienTich >0),
	Check (GiaPhong >1000)
)
go

create table DANHGIA
(
	MaDanhGia nvarchar(5) not null primary key,
	ChatLuong Nvarchar(30)not null,
	NoiDungDanhGia NVARCHAR(100),
	TrangThai nvarchar(15)not null,
	MaNhaTro nvarchar(5) NOT NULL foreign key references NHATRO(MaNhaTro),
	MaNguoiDung int identity foreign key references NGUOIDUNG(MaNguoiDung)
)
go

alter table DANHGIA
alter column MaNhaTro Nvarchar(5)not NULL 
ALTER table DANHGIA
alter column LikeOrDisLike bit not null

insert into LOAINHA(MaLoaiNha,TenLoaiNha)
values ('HT01', N'Nhà Trọ'),
('HT02', N'Căn Hộ'),
('HT03',N'Chung Cư'),
('PH01',N'PenHouse trên Đà Lạt'),
('BT01',N'Biệt thự Nhà Vườn')

insert into NGUOIDUNG(TenNguoiDung,GioiTinh,SoDienThoai,DiaChi,QuanHuyen,Email)
values (N'Bình',N'nữ','01189',N'Tràng An',N'Ninh Bình','kieu@gmail.com'),
(N'Nam',N'Nam','19008198',N'Tràng An',N'Ninh Bình','nam@gmail.com'),
(N'Phương',N'Nam','19008198',N'Yên Thành',N'Nghệ An','Phuong@gmail.com'),
(N'Lưu',N'Nam','19008199',N'Đô Lương',N'Nghệ An','Luu@gmail.com'),
(N'Hải',N'Nữ','19008589',N'Hoài Đức ',N'Hà Tây','hai@gmail.com')
insert into NGUOIDUNG(TenNguoiDung,SoDienThoai,DiaChi,Email)
values (N'Kiều','01189',N'Tuân Chính','kieu@gmail.com'),
(N'Nghĩa','11189',N'Đại Đồng','nghia@gmail.com'),
(N'Đặng','21189',N'Vĩnh Tường','Dang@gmail.com'),
(N'Vũ','31189',N'Tuân Chính','Vu@gmail.com'),
(N'kk','41189',N'Chính','home@gmail.com')

insert into NHATRO(MaNhaTro,DienTich,GiaPhong,DiaChi,Quan,MoTa,NgayDang,MaLoaiNha)
values ('H1',15.3,1000000,N'Xuân Phương',N'Từ Liêm',N' Sâu trong ngõ, Yên tĩnh, ở 1 người','2021-1-2','HT01'),
 ('H2',60,2000000,N'Xuân Phương',N'Từ Liêm',N' Sâu trong ngõ, Yên tĩnh, ở 3 người','2021-2-18','HT02'),
 ('H3',20,150000,N'Xuân Lai',N'Từ Liêm',N' Sâu trong ngõ, Yên tĩnh, ở 1 người','2021-1-19','HT03'),
 ('H4',150.6,8000000,N'Phương Canh',N'Từ Liêm',N' mặt Dường, Yên tĩnh','2021-1-2','PH01'),
 ('H5',600,16000000,N'Xuân Phương',N'Từ Liêm',N' Sâu trong ngõ, Yên tĩnh, ở 1 người','2021-1-2','BT01')
insert into NHATRO(MaNhaTro,DienTich,GiaPhong,DiaChi,NgayDang,MaLoaiNha)
values ('H6',30.7,1000000,N'Xuân Phương','2021-1-2','HT01'),
('H7',500,2000000,N'ĐộiCấn','2021-2-1','BT01'),
('H8',30.7,2500000,N'Thanh Xuân','2021-1-2','HT02'),
('H9',60,5500000,N'Phương Canh','2021-1-2','HT03'),
('H10',200,1000000,N'Xuân Phương','2021-1-2','PH01')

insert into DANHGIA(MaDanhGia,ChatLuong,TrangThai,MaNhaTro)
values ('DG01',N'Tốt','Like','H1'),
('DG02',N'Trung Bình','DisLike','H3'),
('DG03',N'Kém','Like','H4'),
('DG04',N'Tốt','DisLike','H6'),
('DG05',N'Kém','DisLike','H1')

INSERT INTO DANHGIA
VALUES('DG06',N'Khá',N' Phòng không được như hình, ổn','Like','H8'),
('DG07',N'Trung Bình',N' Phòng ở quá sâu trong ngõ','Like','H2'),
('DG08',N'Tốt',N' giá rẻ, chất lượng tốt','Like','H6'),
('DG09',N'Yếu',N' Phòng nhỏ, xuống cấp','DisLike','H3'),
('DG010',N'Kém',N' Phòng xuống cấp trraafm trọng','DisLike','H1')

select*from LOAINHA
select*from NGUOIDUNG
select*from NHATRO
select*from DANHGIA

