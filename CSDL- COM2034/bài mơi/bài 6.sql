--bài 6:
--- xử lý trong transaction
commit: -- xác nhận trong các thay đổi.
rollback:-- Khôi phục các giao dịc trước đó
--savepoint

use QLDA
go

--vd1: tạo 1 proc cới tham số đầu vào là nhân viên . SP đó thực hiệ xóa tất cả thân nhân của nhân viên đó
if OBJECT_ID('SP_DELETETHANNHAN')is not null
drop proc SP_DELETETHANNHAN

create proc SP_DELETETHANNHAN(@maNV nvarchar(50))
as
begin try
	begin tran-- bắt đầu giao dịch
		delete from THANNHAN where MA_NVIEN=@maNV
	commit
end try
begin catch
	rollback
end catch
go

exec SP_DELETETHANNHAN '002'
select*from THANNHAN

--vd2: tạo 1 proc cới tham số đầu vào là mã đề án . SP đó thực hiện xóa tất cả đề án đó
if OBJECT_ID('SP_DELETEDEAN')is not null
drop proc SP_DELETEDEAN
create proc SP_DELETEDEAN @maDA int
as
begin try
	begin tran-- bắt đầu giao dịch
		delete from PHANCONG where MADA=@maDA
		delete from CONGVIEC where MADA=@maDA
		delete from DEAN where MADA=@maDA
	commit
end try
begin catch
	rollback
end catch
go
exec SP_DELETEDEAN 12

select*from DEAN

--vd3( khó vcl): xóa đề án có tông thời gian làm từ  x   đến y
select MADA, sum(THOIGIAN) from PHANCONG group by MADA having SUm(THOIGIAN) between 10 and 30
insert into #kk

if OBJECT_ID('SP_DELETEDEANTIME')is not null
drop proc SP_DELETEDEANTIME
create proc SP_DELETEDEANTIME (@timemin float,@timeMAX float)
as
begin try
	begin tran-- bắt đầu giao dịch
	declare @temptable table(
	maduan int,
	gio float)
	insert into @temptable
	select MADA, sum(THOIGIAN) from PHANCONG group by MADA having SUm(THOIGIAN) between @timemin and @timeMAX
		delete from PHANCONG where MADA in(select maduan from @temptable)
		delete from CONGVIEC where MADA in(select  maduan from @temptable)
		delete from DEAN where MADA in(select maduan from @temptable)
	commit
end try
begin catch
	rollback
end catch
go

exec SP_DELETEDEANTIME 10,30

---asssss
use QLNhaTro
go

--câu 1 
if OBJECT_ID('SP_TRANGthaisQLnhatro')is not null
drop proc SP_TRANGthaisQLnhatro
create proc SP_TRANGthaisQLnhatro (@diss int)
as
begin try
	begin tran-- bắt đầu giao dịch
		delete from NHATRO where (select count(LikeOrDisLike) from DANHGIA where LikeOrDisLike like 0)<@diss
		delete from DANHGIA where(select count(LikeOrDisLike) from DANHGIA where LikeOrDisLike like 0)<@diss
	commit
end try
begin catch
	rollback
end catch
go
exec SP_TRANGthaisQLnhatro 3

select * from DANHGIA

