 --bài mới trigger
 use QLDA
 go
-- Bảng ảo trigger
--Hành động	Bảng ảo inserted	Bảng ảo deleted
--Insert	Lưu trữ dữ liệu của bản ghi vừa được insert	Không có
--Update	Lưu trữ dữ liệu mới của bản ghi vừa được update	Lưu trữ dữ liệu cũ trước đó của bản ghi vừa update
--delete	Không có	Lưu trữ dữ liệu vừa bị xóa

--Cú pháp tạo trigger
--create trigger TenTrigger on TEN_BẢNG
--For [insert],[update],[delete]
--As
--Begin
-- 	Lệnh thực thi trên bảng ảo
--End
--	Sau khi tạo và thực thi trigger. Hok dùng lệnh exec . Nó sẽ tự động được gọi thi mà các bạn gọi các hành động insert, update hay delete dữ liệu



-- ví dụ 1: tạo 1 tri gơ khi thêm nhân viên thì phải nhập lương lớn hơn 30000

create trigger 

--ví dụ 2: ạo 1 tri gơ khi thêm nhân viên thì phải có tuổi nữ từ 18=> 40, nam Ttuwf 18=> 45
if OBJECT_ID('trgNHANVIEN') is not null
drop trigger trgNHANVIEN
create trigger trgNHANVIEN on NHANVIEN
for insert
as 
begin
IF (SELECT phai=N'nữ', YEAR(GETDATE()-YEAR(NGSINH)) AS N'TUỔI' FROM inserted) between 18 and 40

	begin
		PRINT N'PHẢI NHẬP NỮ CÓ ĐỘ TUỔI TỪ 18-40'
		ROLLBACK
	end 

END

--viết 1 trigeer hiển thị tông số nhân viên nam, NHV nữ mỗi khi thêm hoặc sửa nhân viên

if OBJECT_ID('trgNHANVIENupdate') is not null
drop trigger trgNHANVIENupdate
go

create trigger trgNHANVIENupdate on NHANVIEN
for insert, update 
as
begin
	select Phai,count(Manv) as N'giới tính' from NHANVIEN 
	group by Phai
end
insert into NHANVIEN 
values ('hoang','minh','thao',301,'1/1/1995',N'HAFNOIJ',N'Nữ', 75000,'001',4)
update NHANVIEN set TENNV= 'cc' where MANV=301


--delete. trigger xóa taasxt cả dữ liệu có liên quan tới mã dự án vừa nới được xóa

if OBJECT_ID('trgNHANVIENxoa') is not null
drop trigger trgNHANVIENxoa
go
create trigger trgNHANVIENxoa on dean
instead of delete
as
begin
	delete from PhanCong where MADA in (select MADA from deleted)
	delete from Congviec where MADA in (select MADA from deleted)
	delete from dean where MADA in (select MADA from deleted)
end
delete from DEAN where MADA=10
select * from DEAN

--vd5.  Tạo 1 trigger khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM
if OBJECT_ID('trgNHANa') is not null
drop trigger trgNHANa
go
create trigger trgNHANa on NHANVIEN
for insert,update
as
begin
	SELECT TENNV FROM inserted where DCHI like N'% Hồ Chí Minh%'
	begin
	print 'Không cập nhận những nv ở TP HCM'
	rollback
	end

end

--vd6. Tạo 1 trigger instead of Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA là 1
if object_id('trgphancongda') is not null
	drop trigger trgphancongda
go
create trigger trgphancongda 
on nhanvien instead of insert 
as
	begin
		declare @manv nvarchar(10)
		select @manv = manv from inserted
		insert into phancong values (@manv, 1, 1, 1)
	end