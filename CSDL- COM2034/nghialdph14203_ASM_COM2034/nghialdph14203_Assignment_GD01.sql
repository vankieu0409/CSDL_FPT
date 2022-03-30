Create database QLNT
go
use QLNT
go

IF OBJECT_ID('LOAINHA') IS NOT NULL DROP TABLE LOAINHA
go
Create table LOAINHA
(
MALN varchar(15) not null,
TENLN nvarchar(50) null,
CONSTRAINT PK_LOAINHA PRIMARY KEY(MALN)
)
go

IF OBJECT_ID('QUANHUYEN') IS NOT NULL DROP TABLE QUANHUYEN
go
Create table QUANHUYEN
(
MAQH varchar(15) not null,
TENQH nvarchar(50) null,
CONSTRAINT PK_QUANHUYEN PRIMARY KEY(MAQH)
)
go

IF OBJECT_ID('NGUOIDUNG') IS NOT NULL DROP TABLE NGUOIDUNG
go
Create table NGUOIDUNG
(
MAND varchar(15) not null,
HOTENND nvarchar(50) null,
GIOITINH nvarchar(5) null,
SDT nvarchar(15) null,
DIACHI nvarchar(50) null,
QUAN nvarchar(30) null,
EMAIL nvarchar(50) null,
CONSTRAINT PK_NGUOIDUNG PRIMARY KEY(MAND)
)
go

IF OBJECT_ID('NHATRO') IS NOT NULL DROP TABLE NHATRO
go
Create table NHATRO
(
MANT varchar(15) not null,
DIENTICH decimal(8,2) null,
GIAPHONG money null,
DIACHI nvarchar(50) null,
MOTA nvarchar(100) null,
NGAYDANGTIN datetime null,
MALN varchar(15) not null,
MAQH varchar(15) not null,
CONSTRAINT PK_NHATRO PRIMARY KEY(MANT),
CONSTRAINT FK_LOAINHA_LOAINHA FOREIGN KEY (MALN) REFERENCES LOAINHA,
CONSTRAINT FK_LOAINHA_QUANHUYEN FOREIGN KEY (MAQH) REFERENCES QUANHUYEN,
)
go

IF OBJECT_ID('DANHGIA') IS NOT NULL DROP TABLE DANHGIA
go
Create table DANHGIA
(
MAND varchar(15) not null,
MANT varchar(15) not null,
[LIKE/DISLIKE] nvarchar(50) null, 
DANHGIAND nvarchar(100) null,
CONSTRAINT PK_DANHGIA PRIMARY KEY(MANT,MAND),
CONSTRAINT FK_DANHGIA_NGUOIDUNG FOREIGN KEY (MAND) REFERENCES NGUOIDUNG,
CONSTRAINT FK_DANHGIA_NHATRO FOREIGN KEY (MANT) REFERENCES NHATRO
)
go

Select * from LOAINHA
Select * from QUANHUYEN
Select * from NGUOIDUNG
Select * from NHATRO
Select * from DANHGIA

Select * from LOAINHA
Delete from LOAINHA
Insert into LOAINHA values 							
							('Home01',N'Chung cư'),
						   ('Home02',N'Nhà trọ'),
						   ('Home03',N'Nhà nghỉ'),
						   ('Home04',N'Kí túc xá'),
						   ('Home05',N'Nhà riêng'),

						   ('Home06',N'Nhà riêng'),
						   ('Home07',N'Nhà riêng'),
						   ('Home08',N'Nhà riêng'),
						   ('Home09',N'Nhà riêng'),
						   ('Home10',N'Nhà riêng')

go

Select * from QUANHUYEN
Delete from QUANHUYEN
Insert into QUANHUYEN values ('District01',N'Bắc Giang'),
						   ('District02',N'Nam Từ Liêm'),
						   ('District03',N'Vân Ninh'),
						   ('District04',N'Mỹ Đình'),
						   ('District05',N'Quảng Ninh'),

						   ('District06',N'Quảng Bình'),
						   ('District07',N'Quảng Ngãi'),
						   ('District08',N'Hưng Yên'),
						   ('District09',N'Bắc Ninh'),
						   ('District10',N'Vĩnh Phúc')
go

Select * from NGUOIDUNG
Delete from NGUOIDUNG
Insert into NGUOIDUNG values ('PH14205',N'Đỗ Văn Trường' ,'Nam' ,'0383542588',N'thôn 3 xã Đài Xuyên huyện Vân Đồn tỉnh Quảng Ninh' ,N'huyện Vân Đồn','truongdvph14196.fpt.edu.vn'),
						     ('PH14102',N'Nghuyễn Văn Nam' ,'Nam' ,'015897369537',N'Thôn 10 Vạn yên Đài Xuyên Quảng Ninh' ,N'huyện Vân Đồn','namnv14157.fpt.edu.vn'),
							 ('PH14196',N'Vũ Đình Thi' ,'Nam' ,'0483452588',N'Khu 8 Thị Trấn Cái Rồng Vân Đồn Quảng Ninh' ,N'huyện Vân Đồn','vudtph14203.fpt.edu.vn'),
							 ('PH14199',N'Vũ Phạm Công Hưng' ,'Nữ' ,'0983795369',N'thôn 3 xã Đài Xuyên huyện Vân Đồn tỉnh Quảng Ninh' ,N'huyện Vân Đồn','hungpcph14204.fpt.edu.vn'),
							 ('PH14203',N'Lê Văn Luyện' ,'Nam' ,'0383542580',N'thôn 2 xã Đài Xuyên huyện Vân Đồn tỉnh Quảng Ninh' ,N'huyện Vân Đồn','luyenlvph14205.fpt.edu.vn')


Insert into NGUOIDUNG values ('PH14255',N'Lê Văn Sơn' ,'Nam' ,'023354280',N'338 Phố Xã Đàn  Đống Đa, TP. Hà Nội' ,N'Vân Đồn','sonlvph14255.fpt.edu.vn'),
							 ('PH14266',N'Lê Thị Đào' ,'Nữ' ,'05334580',N'P. Mộ Lao, , TP. Hà Nội' ,N'Hà Nội','Daoltph14266.fpt.edu.vn'),
							 ('PH14277',N'Phạm Hồng Ngấm' ,'Nam' ,'033325480',N'146 Minh Phụng, Q.6, TP.HCM' ,N'HCM','Ngamphph14277.fpt.edu.vn'),
							 ('PH14288',N'Phúc Văn Thiên' ,'Nữ' ,'032254280',N' TX. Dĩ An, Tỉnh Bình Dương.' ,N'Bình Dương','Thienpvph14288.fpt.edu.vn'),
							 ('PH14299',N'Đào Hồng Tuyển' ,'Nữ' ,'032135280',N' , P. Tân Tiến, TP. Biên Hòa, Tỉnh Đồng Nai' ,N'Đông Nai','Tuyendhph14299.fpt.edu.vn')

go

Select * from NHATRO		
Delete from NHATRO
Insert into NHATRO values ('Motel01' , 30.2 , 4500000 ,N'199 Hồ Tùng Mậu cầu Diễn Nam Từ Liêm Hà Nội' ,N'nhà trọ rộng rãi thoáng mát đầy đủ tiện nghi giá phòng hơi đắt' , '05/18/2021', 'Home01' ,'District01'),
						  ('Motel02' , 100.3 , 4500000 ,N'thôn 9 xã Hạ Long huyện Vân Đồn tỉnh Quảng Ninh' ,N'đồ gia dụng mình sẽ phải tự mua nơi ở tự do không bị gò bó' , '05/18/2021', 'Home02' ,'District02'),
						  ('Motel03' , 40.2 , 4500000 ,N'nhà nghỉ Hạ Đoan Đông Xá Đông Thịnh' ,N'có điều hòa có wifi phòng không lắp camera giá phòng vừa rẻ' , '05/18/2021', 'Home03' ,'District03'),
						  ('Motel04' , 234.3 , 4500000 ,N'ký túc xá Mỹ Đình 2' ,N'kí túc xá rộng cao tiện nghi bạn cùng phòng vui vẻ hòa đồng' , '05/18/2021', 'Home04' ,'District04'),
						  ('Motel05' , 97.2 , 4500000 ,N'thôn 8 xã Hạ Long huyện Vân Đồn tỉnh Quảng Ninh' ,N'tự do ăn ngủ nghỉ chi tiêu tự do mình quyết định và chủ sở hữu là mình' , '05/18/2021', 'Home05' ,'District05'),

						  ('Motel06' , 99.2 , 4500000 ,N' Tx. Đồng Xoài, Tỉnh Bình Phước' ,N'Ăn chơi hết mình chỉ lo hết tiền' , '05/24/2021', 'Home06' ,'District06'),
						  ('Motel07' , 155.4 , 4500000 ,N'  TP.Phan Thiết, T.Bình Thuận.' ,N'Vạn sự tùy duyên' , '08/01/2021', 'Home07' ,'District07'),
						  ('Motel08' , 255.9 , 4500000 ,N' TP. Pleiku, Tỉnh Gia Lai' ,N'NGủ nghỉ tùy ý ' , '07/10/2021', 'Home08' ,'District08'),
						  ('Motel09' , 668.1 , 4500000 ,N' Q. Đống Đa, TP. Hà Nội' ,N'Thoáng mát sạch sẽ là những gì không có ở đây' , '10/05/2021', 'Home09' ,'District09'),
						  ('Motel10' , 222.9 , 4500000 ,N' Q. Ninh Kiều, TP. Cần Thơ' ,N'Chán ở nơi dầy đủ tiện nghi thì đừng đến đây' , '12/07/2021', 'Home10' ,'District10')

go
 
Select * from DANHGIA
Delete from DANHGIA
Insert into DANHGIA values ('PH14205','Motel01',N'Dislike',N'Liêu Long Vũ'),
						   ('PH14102','Motel02',N'Like',N'Liêu Tấn Minh'),
						   ('PH14196','Motel03',N'Dislike',N'Nguyễn Hồng Ngọc'),
						   ('PH14199','Motel04',N'Like',N'Nguyễn Hồng Khanh'),
						   ('PH14203','Motel05',N'Dislike',N'Nguyễn Hồng Mai'),

						   ('PH14255','Motel06',N'Dislike',N'Nguyễn Hồng Mai'),
						   ('PH14266','Motel07',N'Like',N'Nguyễn Hồng Mai'),
						   ('PH14277','Motel08',N'Like',N'Nguyễn Hồng Mai'),
						   ('PH14288','Motel09',N'Dislike',N'Nguyễn Hồng Mai'),
						   ('PH14299','Motel10',N'Dislike',N'Nguyễn Hồng Mai')


							
						     




