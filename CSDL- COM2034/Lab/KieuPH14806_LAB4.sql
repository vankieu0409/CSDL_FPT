--LAB 4 SU21
--1. Khai báo 3 biến là  3 cạnh của tam giác. Kiểm tra xem 3 cạnh đó có lập thành 3 cạnh của tam giác không? 
--Nếu có thì in ra diện tích tam theo công thức Heron, nếu không thì thông báo.
declare @a int=3,@b int=5, @c int=9,@dientich float, @p int;
set @p=(@a+@b+@c)/2
if (@a+@b)>@c and (@a+@c)>@b and (@c+@b)>@a
begin
set @dientich= SQRT( @p*(@p-@a)*(@p-@b)*(@p-@c))
print N' Đây là tam giác có Diện tích là: '+ cast(@dientich as Varchar)
end
else
Print N' Đây không phải 3 cạnh của tam giác'




--Sử dụng csdl quản lý dự án thực hiện các câu truy vấn sau:
use QLDA
go
--2. Liệt kê danh sách (Tên sinh viên, địa chỉ, tuổi, thưởng)
--Biết nếu tuổi >=50 tuổi thì thưởng 500, ngược lại không thì ghi 0. Sử dụng hàm iif
select TENNV,DCHI, Datediff(year,NGSINH,getdate())as tuổi ,
iif( Datediff(year,NGSINH,getdate())>=50 , 500,0) as N' thưởng'
from NHANVIEN


--3. Liệt kê danh sách (Tên sinh viên, giới tính , lương, chế độ) 
--Biết nếu là giới tính nữ và lương >=30000 thì  ghi là “Chế độ vip”, ngược lại thì ghi 0. Sử dụng hàm iif
select TENNV,PHAI,LUONG ,
iif( PHAI like N'%Nữ%' and LUONG>=30000 , 'VIP','Không') as N' Chế độ'
from NHANVIEN


--4. Hiên thị TenNV, Tên phòng, Lương, Thưởng biết thưởng nếu lương>40000 thưởng 10000, lương>30000 thưởng 5000 còn lại là thưởng 0.

select TENNV,TENPHG, LUONG,
(case
when LUONG>40000 then 10000
when LUONG>30000 then 5000
else 0
end) as THưởng
from PHONGBAN left join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG 


--5. Hiển thị tên nhân viên, Tổng số giờ làm việc, Tăng lương. Biết Tổng số giờ làm việc> >40 thưởng 10000,
--Tổng số giờ làm việc>35 thưởng 5000 còn lại là thưởng 0.
select TENNV, sum(THOIGIAN) as N' Tổng thời gian làm',
(case
 when sum(THOIGIAN)>40 then 10000
 when sum(THOIGIAN)>35 then 5000
 else 0 
 end) 
 as N' Tăng Luong'
from NHANVIEN join PHANCONG on NHANVIEN.MANV=PHANCONG.MA_NVIEN
group by TENNV

--6. Hiển thị tên nhân viên, tên phòng, lương nhân viên, Lương mới. 
--Biết Nếu lương< Trung bình lương thì được tăng 10% luong, ngược lại vẫn là lương cũ
declare @LTB float;
select @LTB= Avg(LUONG) from NHANVIEN

select TENNV,TENPHG, LUONG,
(case
when LUONG<@LTB then LUONG+(LUONG*0.1)
else LUONG
end)
as N' Lương MỚi'
from PHONGBAN left join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG
group by TENNV,TENPHG,LUONG

--7. Hiển thị tên nhân viên, lương, số người thân, thuế phải nộp.
--Nếu số người thân >=3 thì thuế phải nộp 0% lương, nếu số người thân >=2 thì thuế phải nộp là 5% lương,
--nếu số người thân>=1 thì nộp 8% lương còn lại nộp 10% lương.

select TENNV, count(TENTN)as SOThanNhan,
case
when count(TENTN)>=1 then LUONG*0.1
when count(TENTN)>=2 then LUONG*0.05
else 0
end as THUẾ
From NHANVIEN join THANNHAN on NHANVIEN.MANV=THANNHAN.MA_NVIEN
group by TENNV, LUONG


--8. Đưa ra tên phòng ban, tên trưởng phòng, số đề án phòng đó làm, thưởng phòng.
--Nếu số đề án >=3 thưởng 50000, số đề án >=1 thưởng 30000 còn lại thưởng là 0

select MAPHG,TENNV
into #trhg
from PHONGBAN left join NHANVIEN on PHONGBAN.MAPHG=NHANVIEN.PHG
where MANV=TRPHG
--b2: truy vấn cung bảng cục bộ
select TENPHG, #kk.TENNV as N'Tên Trưởng Phòng' ,count(DEAN.MADA) as N' số Lượng Đề án',
case
when count(DEAN.MADA)>=3 then 50000
when count(DEAN.MADA)>=1 then 30000
else 0
end as THưởng
from PHONGBAN  join DEAN on PHONGBAN.MAPHG=DEAN.PHONG join #kk on PHONGBAN.MAPHG=#kk.MAPHG
group by #kk.TENNV,TENPHG
