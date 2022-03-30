create database QLDEAN
go 
use QLDEAN
go

creATe table PHONGBAn
(	
	TenPHG Nvarchar(15) Not null,
	MaPHG int not null Primary key,
	TrPHG  nvarchar(9) not null,
	Ngay_NhamChuc date not null,
)
go

alter table PHONGBAn
add foreign key (TrPHG) references NHANVIEN(MANV)-- cái này chạy cuối cùng

creATe table NHANVIEN

(	
	HoNV Nvarchar(15) Not null,
	TenLot Nvarchar(15) Not null,
	TenNV Nvarchar(15) Not null,
	MANV Nvarchar(9) Not null ,
	NgaySInh date not null,
	DiaChi Nvarchar(30) Not null,
	Phai Nvarchar(3) Not null,
	Luong money not null,
	Ma_NQL nvarchar(9) not null,
	PHG int not null,
	primary Key (MANV),
	foreign key(PHG) references PHONGBAn(MaPHG),
	foreign key(MANV) references NHANVIEN(MANV),

)
go



alter table NHANVIEN
alter Column DiaChi nvarchar(200) not null
alter table NHANVIEN
alter Column Phai nvarchar(10) not null

create table DIADIEM_PHG
(	
	MaPHG int not null foreign key references PHONGBAn(MaPHG),
	DiaDiem Nvarchar(15) Not null,
	primary key (MaPHG,DiaDiem)	
)
	go

create table DEAN
(	
	TenDA Nvarchar(15) Not null,
	MaDA int not null ,
	DD_DA Nvarchar(15) Not null,
	Phong int not null foreign key references PHONGBAn(MaPHG),
	Primary key(MaDA)
)
go
alter table DEAN
alter Column TenDA Nvarchar(30) Not null

Create table CONGVIEC
(	MaDA int not null  foreign key references DEAN(MaDA),
	STT int not null ,
	TenCV Nvarchar(15) Not null,
	Primary key(STT,MaDA)
)
go
alter table CONGVIEC
alter Column TenCV nvarchar(200) not null

create table PHANCONG
(
	MA_NV Nvarchar(9) Not null  foreign key references NHANVIEN(MaNV),
	MaDA int not null,
	STT int not null,  
	ThoiGIan int not null,
	Primary key (MA_NV,MaDA,STT),
	foreign key (STT,MaDA) references CONGVIEC(STT,MaDA),
)
go

create Table THANNHAN
(
	MA_NV Nvarchar(9) Not null  foreign key references NHANVIEN(MANV),
	TenTN  Nvarchar(9) Not null ,
	Phai  Nvarchar(3) Not null,
	NgaySinh date not null,
	QuanHe Nvarchar(9) Not null,
	primary key (TenTN,MA_NV)
)
go

insert into PHONGBAn
values (N'NHiên Cứu',5,005,'1978-5-22'),
(N'Điều Hành',4,008,'1985-1-1'),
(N'Quản Lý',1,006,'1971-6-19')

insert into NHANVIEN
values(N'Đinh',N'Bá',N'Tiên',009,'1960-2-11',N'119 Cống Quỳnh, Tp HCM',N'Nam',30000,005,5),
(N'NGuyễn',N'Thành',N'Tùng',005,'1962-8-20',N'222 NGuyễn Văn Cừ, Tp HCM',N'Nam',40000,006,5),
(N'Bùi',N'Ngọc',N'Hằng',007,'1954-3-11',N'332 NGuyễn Thái Học, Tp HCM',N'Nữ',25000,001,4),
(N'Lê',N'Quỳnh ',N'Như',001,'1967-2-1',N'291 Hồ Văn Huệ, Tp HCM',N'Nữ',43000,006,4),
(N'NGuyễn',N'Mạnh',N'HÙng',004,'1967-3-4',N'95 Bà Rịa, Vũng Tàu',N'Nam',38000,005,5),
(N'Trần',N'Thanh ',N'Tâm',003,'1957-5-4',N'34 Mai Thị Lự, Tp HCM',N'Nam',25000,005,5),
(N'Trần',N'Hồng',N'Quang',008,'1967-8-1',N'80 Lê Hồng Phong, Tp HCM',N'Nam',25000,001,4),
(N'Phạm ',N'Văn',N'Vinh',006,'1965-1-1',N'45 Trưng Vương, Hà Nội',N'Nam',55000,'',1)

insert into THANNHAN
values(005,N'Trinh',N'Nữ','1976-4-5',N'Con Gái'),
(005,N'Khanh',N'Nam','1973-10-25',N'Con Trai'),
(005,N'Phương',N'Nữ','1948-5-3',N'Vợ'),
(001,N'Minh',N'Nam','1932-2-29',N'Chồng'),
(009,N'Tiến',N'Nam','1978-1-1',N'Con Trai'),
(009,N'Châu',N'Nữ','1978-12-30',N'Con Gái'),
(009,N'Phương',N'Nữ','1957-5-5',N'Vợ')

insert into DEAN
values (N'Sản Phẩm X',1,N'Vũng Tầu',5),
(N'Sản Phẩm Y',2,N'Nha Trang',5),
(N'Sản Phẩm Z',3,N'Tp HCM',5),
(N'Tin Học Hóa',10,N'Hà Nội',4),
(N'Cáp Quang',20,N'Tp HCM',1),
(N'Đào tạo',30,N'Hà Nội',4)

Insert Into DIADIEM_PHG
values (1,' TP HCM'),
(4,N'Hà Nội'),
(5,N' Vũng Tàu'),
(5,N'Nha Trang'),
(5,N'TP HCM')

insert into CONGVIEC
vaLues (1,1,N'Thiết Kế Sản Phẩm X'),
(1,2,N'thử nghiệm Sản Phẩm X'),
(2,1,N'Sản xuất Sản Phẩm Y'),
(2,2,N'Quảng cáo Sản Phẩm Y'),
(3,1,N'Khuyến mãi Sản Phẩm Z'),
(10,1,N'Tin học hóa Phòng nhân Sự'),
(10,2,N'Tin học hóa Phòng Kinh Doang'),
(20,1,N'Lắp Đặt Cáp Quang'),
(30,1,N'Đào Tạo Nhân Viên marketing'),
(30,2,N'Đào Tạo Chuyên Viên thiết kế')

insert into PHANCONG
values ( 009,1,1,32),
( 009,2,2,8),
( 004,3,1,40),
( 003,1,2,20),
( 003,2,1,20),
( 008,10,1,35),
( 008,30,2,5),
( 001,30,1,20),
( 001,20,1,15),
( 006,20,1,30),
( 005,3,1,10),
( 005,10,2,10),
( 005,20,1,10),
( 007,30,2,30),
( 007,10,2,10)

--select

-- 1 Nhân Viên có lương cao nhất
 select top 1 HoNV+''+TenLot+''+TenNV as Ho_Ten,MANV,DiaChi,Ma_NQL,Phai,PHG,Luong
 from NHANVIEN
 order by Luong desc


 -- 2 NHÂN viên có mức lương trên trung bình của Phòng Nghiên cứu
 select HoNV+' '+TenLot+' '+TenNV as Ho_Ten
 from NHANVIEN inner join PHONGBAn on PHONGBAn.MAPHG=NHANVIEN.PHG
 group by HoNV,TenLot,TenNV,NHANVIEN.PHG,NHANVIEN.Luong
 having NHANVIEN.Luong> (count(NHANVIEN.Luong)/7) and (NHANVIEN.PHG like '5')

 -- 3 LIệt kê các Phong ban Có Mức Lương TB Lớn Hơn 30.000 và số Luong nhân Viên của từng Phòng.
 
 Select TenPHG, count(NHANVIEN.MANV)as SLNHANVIEN
 from NHANVIEN inner join PHONGBAn on PHONGBAn.MAPHG=NHANVIEN.PHG
 group by PHONGBAn.TenPHG
 having (sum(NHANVIEN.Luong)/count(NHANVIEN.MANV))>30000

 -- 4 SỐ lượng đề án của từng Phòng ban
 select TenPHG,count(TenDA)as SluongDEAN
 from PHONGBAn right outer join DEAN on PHONGBAn.MaPHG=DEAN.MaDA
 group by TenPHG

 select*from PHONGBAn
 select*from NHANVIEN
 select*from DEAN
 select*from CONGVIEC
 select*from PHANCONG
 select*from THANNHAN
 select*from DIADIEM_PHG


