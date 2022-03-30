create database demo
go
use demo
go
create table lop(
	malop nchar(10) not null primary key,
	tenlop nvarchar(100) not null,
	siso int check(siso>0),
)
create table sinhvien(
	masv nchar(10) not null primary key,
	tensv nvarchar(100) not null,
	ngaysinh date,
	malop nchar(10) foreign key references lop(malop),
)
create table ngoaingu(
	mann nchar(10) not null primary key,
	tennn nvarchar(100),
)
create table sv_nn(
	mann nchar(10) not null foreign key references ngoaingu(mann),
	masv nchar(10) not null foreign key references sinhvien(masv) ,
	primary key(mann,masv),
)

