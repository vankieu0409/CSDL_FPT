create database QLTV
go
use QLTV
go
create table KHOANGANH
(
	MaKN nvarchar(50) not null,
	TenKN nvarchar(50) not null,
	constraint PK_KHOANGANH primary key(MaKN)
)
go
create table SINHVIEN
(
	MaSV nvarchar(50) not null,
	Hoten nvarchar(200) not null,
	MaKN nvarchar(50) not null,
	CMND int not null,
	DienThoai int not null,
	Email nvarchar(50) not null,
	ThoiHanThe date not null,
	constraint PK_SINHVIEN primary key(MaSV),
	constraint FK_SINHVIEN_KHOANGANH foreign key(MaKN) references KHOANGANH(MaKN),
)
go
create table PHIEUMUON
(
	SoPM int not null identity,
	MaSV nvarchar(50) not null,
	MaLop nvarchar(50) not null,
	NgayMuon date not null,
	NgayTra date not null,
	GiaHan int not null,
	TongSM int not null ,
	TrangThai nvarchar(50) not null,
	constraint PK_PHIEUMUON primary key(SoPM),
	constraint FK_PHIEUMUON_SINHVIEN foreign key(MaSV) references SINHVIEN(MaSV),
	constraint Check_TongSM check (TongSM<=3),
	constraint Check_NgayTra check (NgayTra>=NgayMuon)
)
go
create table CTMUON
(
	MaSach nvarchar(50) not null,
	SoPM int not null identity,
	GhiChu nvarchar(50) not null,
	constraint FK_CTMUON_PHIEUMUON foreign key(SoPM) references PHIEUMUON(SoPM),
	constraint FK_CTMUON_SACH foreign key(MaSach) references SACH(MaSach),
)
go

create table THELOAI
(
	MaTL nvarchar(50) not null,
	TenTL nvarchar(50) not null,
	constraint PK_THELOAI primary key(MaTL)
)
go


create table SACH
(
	MaSach nvarchar(50) not null,
	TenSach nvarchar(50) not null,
	NXB nvarchar(50) not null,
	SoTrang int not null,
	SoLuong int not null,
	GiaTien money not null,
	NgayNhap date not null,
	ViTriKe nvarchar(50) not null,
	MaTL nvarchar(50) not null,
	constraint PK_SACH primary key(MaSach),
	constraint FK_SACH_THELOAI foreign key(MaTL) references THELOAI(MaTL),
	constraint Check_SoTrang check(SoTrang>=5),
	constraint Check_SoLuong check(SoLuong>1),
	constraint Check_GiaTien check(GiaTien>0)
)
go
create table SACHTG
(
	MaSach nvarchar(50) not null,
	MaTG nvarchar(50) not null,
	constraint FK_SACHTG_TACGIA foreign key(MaTG) references TACGIA(MaTG),
	constraint FK_SACHTG_SACH foreign key(MaSach) references SACH(MaSach)
)
go
create table TACGIA
(
	MaTG nvarchar(50) not null,
	TenTG nvarchar(50) not null,
	constraint PK_TACGIA primary key(MaTG)
)
go



insert into KHOANGANH(MaKN,TenKN)
values ('UDPM',N'ứng dụng phần mềm')
insert into KHOANGANH(MaKN,TenKN)
values ('TCDN',N'Tài chính doanh nghiệp')
insert into KHOANGANH(MaKN,TenKN)
values ('TCNH',N'Tài chính Ngân hàng')
insert into KHOANGANH(MaKN,TenKN)
values ('TCKD',N'Tài chính kinh doanh')
insert into KHOANGANH(MaKN,TenKN)
values ('CNTT',N'Công nghệ thông tin')

insert into SINHVIEN(MaSV,Hoten,MaKN,CMND,DienThoai,Email,ThoiHanThe)
values ('PH14801',N'Nguyễn Bậu','UDPM',138593971,0857326448,'CA@gmail.com','4-18-2023')
insert into SINHVIEN(MaSV,Hoten,MaKN,CMND,DienThoai,Email,ThoiHanThe)
values ('PH14802',N'Phương Lê','TCDN',138593972,0857326441,'CA@gmail.com','4-18-2023')
insert into SINHVIEN(MaSV,Hoten,MaKN,CMND,DienThoai,Email,ThoiHanThe)
values ('PH14803',N'Lê Phương ','TCKD',138593973,0857326442,'CA@gmail.com','4-18-2023')
insert into SINHVIEN(MaSV,Hoten,MaKN,CMND,DienThoai,Email,ThoiHanThe)
values ('PH14804',N'Phương thị Lê','TCNH',138593974,0857326443,'CA@gmail.com','4-18-2023')
insert into SINHVIEN(MaSV,Hoten,MaKN,CMND,DienThoai,Email,ThoiHanThe)
values ('PH14805',N'Lê Thị Phương ','CNTT',138593975,0857326444,'CA@gmail.com','4-18-2023')


insert into PHIEUMUON(MaSV,MaLop,NgayMuon,NgayTra,GiaHan,TongSM,TrangThai)
values ('PH14801','PT16301','1-16-2021','1-20-2021',12,1,N'Chưa trả')
insert into PHIEUMUON(MaSV,MaLop,NgayMuon,NgayTra,GiaHan,TongSM,TrangThai)
values ('PH14802','PT16321','6-9-2016','7-4-2016',14,2,N'Đã trả')
insert into PHIEUMUON(MaSV,MaLop,NgayMuon,NgayTra,GiaHan,TongSM,TrangThai)
values ('PH14803','PT16308','4-6-2018','4-11-2018',7,2,N'Chưa trả')
insert into PHIEUMUON(MaSV,MaLop,NgayMuon,NgayTra,GiaHan,TongSM,TrangThai)
values ('PH14804','PT16306','1-16-2020','1-22-2020',9,3,N'Đã trả')
insert into PHIEUMUON(MaSV,MaLop,NgayMuon,NgayTra,GiaHan,TongSM,TrangThai)
values ('PH14805','PT16304','4-9-2019','4-16-2019',10,3,N'Đã trả')



insert into THELOAI(MaTL,TenTL)
values ('H01','Khoa Hoc')
insert into THELOAI(MaTL,TenTL)
values ('H02','Kinh Te')
insert into THELOAI(MaTL,TenTL)
values ('H02','Kinh Te')
insert into THELOAI(MaTL,TenTL)
values ('H03','Xa hoi')
insert into THELOAI(MaTL,TenTL)
values ('H01','Khoa Hoc')


insert into SACH(MaSach,TenSach,NXB,SoTrang,SoLuong,GiaTien,NgayNhap,ViTriKe,MaTL)
values ('K01',N'Luật hấp dẫn','Kim đông',100,5,125000,'6-9-2016',N'kệ ngoài cùng','H01')
insert into SACH(MaSach,TenSach,NXB,SoTrang,SoLuong,GiaTien,NgayNhap,ViTriKe,MaTL)
values ('K02',N'Dạy con làm giàu','Kim đông',285,24,140000,'6-10-2014',N'kệ ngoài cùng','H02')
insert into SACH(MaSach,TenSach,NXB,SoTrang,SoLuong,GiaTien,NgayNhap,ViTriKe,MaTL)
values ('K03',N'Bí quyết thành công','Kim đông',168,9,150000,'6-22-2015',N'kệ ngoài cùng','H02')
insert into SACH(MaSach,TenSach,NXB,SoTrang,SoLuong,GiaTien,NgayNhap,ViTriKe,MaTL)
values ('K04',N'Đắc Nhân Tâm','Kim đông',200,12,200000,'7-19-2013',N'kệ ngoài cùng','H03')
insert into SACH(MaSach,TenSach,NXB,SoTrang,SoLuong,GiaTien,NgayNhap,ViTriKe,MaTL)
values ('K05','Tôi đi code dạo','Kim đông',201,15,22000,'1-31-2015',N'kệ ngoài cùng','H01')


insert into TACGIA(MaTG,TenTG)
values ('A01',N'Nguyễn Kiều')
insert into TACGIA(MaTG,TenTG)
values ('A02',N'Nguyễn Văn Kiều')
insert into TACGIA(MaTG,TenTG)
values ('A03',N'Nguyễn Khắc Kiều')
insert into TACGIA(MaTG,TenTG)
values ('A04',N'Nguyễn Quang Kiều')
insert into TACGIA(MaTG,TenTG)
values ('A05',N'Nguyễn Thúy Kiều')

insert into SACHTG(MaSach,MaTG)
values ('K01','A01')
insert into SACHTG(MaSach,MaTG)
values ('K02','A02')
insert into SACHTG(MaSach,MaTG)
values ('K03','A04')
insert into SACHTG(MaSach,MaTG)
values ('K04','A05')
insert into SACHTG(MaSach,MaTG)
values ('K05','A03')


insert into CTMUON(MaSach,GhiChu)
values ('K01','không')
insert into CTMUON(MaSach,GhiChu)
values ('K02','không')
insert into CTMUON(MaSach,GhiChu)
values ('K03','không')
insert into CTMUON(MaSach,GhiChu)
values ('K04','không')
insert into CTMUON(MaSach,GhiChu)
values ('K05','không')



select*from SACH
select*from SACHTG
select*from SINHVIEN
select*from TACGIA
select*from THELOAI
select*from CTMUON
select*from PHIEUMUON
select*from KHOANGANH


drop table SACHTG