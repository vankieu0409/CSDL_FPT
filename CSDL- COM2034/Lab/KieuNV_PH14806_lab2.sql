--LAB 2 SU21 
--Bài 1. Khai báo 3 cạnh của tam giác. Tính diện tích tam giác theo công thức heron. 
--Biết hàm SQRT(x): Căn bậc hai của x, SQUARE(x): bình phương của x, POWER(y,x):  y mũ x 
declare @x float,@y float,@z float,@nuaCHUVI float,@S float
set @x=5; set @y=10; set @z=12;
set @nuaCHUVI=(@x+@y+@z)/2;
set @S= SQRT( @nuaCHUVI*(@nuaCHUVI-@x)*(@nuaCHUVI-@y)*(@nuaCHUVI-@z));
print N' diên tích tam giác có các canh là 5,10,12 là: '+ cast(@S as varchar);

--Bài 2. Khai báo 2 biến x, y. Tìm ước chung lớn nhất của 2 số đó 
declare @k float,@h float, @ucln float;
set @k=25; set @h=20;
if @k>@h
set @ucln=@k-@h
ElsE
set @ucln= @h-@k

print N' UCLN của 2 số 20 và 25 là :'+cast(@ucln as varchar);



--Bài 3. Dựa trên csdl QLDA thực hiện truy vấn 
use QLDA
go
--1. Thực hiện truy vấn tìm ra thông tin những phòng có địa điểm tại Hà Nội. Địa điểm  truyền vào là 1 biến 

DECLARE @diadiem nvarchar(20) 
SET @diadiem=N'Hà Nội'
SELECT TENPHG,DIADIEM FROM dbo.PHONGBAN INNER JOIN dbo.DIADIEM_PHG
ON DIADIEM_PHG.MAPHG = PHONGBAN.MAPHG
WHERE DIADIEM=@diadiem

--2. Đưa ra thông tin những nhân viên nam có tuổi >=55 (Giá trị truyền vào khai báo  biến) 

declare @NHanVienp4 table
(
mvn varchar(10),         --mỗi lần dùng đều phải chạy cả biến bảng
ten Nvarchar(15),
gioiTInh Nvarchar(15),
Luong float
)
insert into @NHanVienp4	
select MANV,TENNV,PHAI,LUONG from NHANVIEN
where year(getdate())-YEAR(NGSINH)>=55 and PHAI like N'%Nam%'
select* from @NHanVienp4

--3. Cho biêt thông nhân viên (mã nhân viên, tên nhân viên, lương, tên phòng ban) có  lương cao nhất.(Giá trị lương cao nhất truyền vào lưu vào 1 biến)
declare @tenmx nvarchar(15),@Luong1 int, @MaNV nvarchar(10),@TENP nvarchar(50);
select @MaNV=MANV,@tenmx= TENNV,@Luong1=LUONG,@MaNV=MANV,@TENP= TENPHG from NHANVIEN inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
where luong=(select max(LUONG) from NHANVIEN)
select @MaNV mãNhânViên, @tenmx tên,@Luong1 Lương,@TENP PHÒng


--4. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) 
--có mức lương trên mức  lương trung bình của phòng "Nghiên cứu” (giá trị trả về lưu vào 1 biến bảng)



declare @dsa table
(HO varchar(10),         --mỗi lần dùng đều phải chạy cả biến bảng
tenDem Nvarchar(15),
ten Nvarchar(15)
)
insert into @dsa
select HONV,TENLOT,TENNV from NHANVIEN 

where LUONG>( select AVG(LUONG) from NHANVIEN 
inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
where TENPHG like N'Nghiên cứu' )


 select HO,tenDem,ten
 into #K
 from @dsa
 select*from #K
 

--5. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó  chủ trì. (giá trị trả về lưu vào 1 biến bảng) 
declare @slda table
(phong Nvarchar(15),
slDEASN int
)
insert into @slda
 select TENPHG,count(TENDEAN)as SluongDEAN
 from PHONGBAN right outer join DEAN on PHONGBAN.MAPHG=DEAN.PHONG
 group by TENPHG
 select *from @slda

 select phong,slDEASN
 into ##SLUONDEAN
 from @slda
----6. Liệt kê các thông tin phòng ban không làm đề án nào? (giá trị trả về lưu vào 1 bảng tạm cục bộ)

select *
into #PHongKhongCoDA
from PHONGBAN
where MAPHG not in(select PHONG from DEAN)
select *from #PHongKhongCoDA

----7. Tìm ra những nhân viên làm được phân công làm nhiều việc nhất. (Biến trị trả về lưu vào biến) 

-- Cách 1: tim qua biến trung gian @max --- dùng Biến băng
declare @tebNv table
(
ten nvarchar(20),
SLCV int
)
declare @max int;
select top 1  @max =count(PHANCONG.MA_NVIEN) 

from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN=NHANVIEN.MANV
group by PHANCONG.MA_NVIEN
order by count(PHANCONG.MA_NVIEN) desc
select @max

insert into @tebNv
select TENNV,count(PHANCONG.MA_NVIEN) 
from NHANVIEN left outer join PHANCONG on PHANCONG.MA_NVIEN=NHANVIEN.MANV
group by TENNV,PHANCONG.MA_NVIEN
having count(PHANCONG.STT)= @max

select* from @tebNv

--cách 2: làm trực tiếp nháp dùng biến bảng
declare @tebNv2 table
(
ten nvarchar(20),
SLCV int
)
insert into @tebNv2
select top 1 with ties TENNV ,count(PHANCONG.THOIGIAN) 
from NHANVIEN left join PHANCONG on PHANCONG.MA_NVIEN=NHANVIEN.MANV
group by TENNV
order by count(PHANCONG.THOIGIAN) desc

select* from @tebNv2


--Dùng biến Vô Hướng tự làm
declare @NVnhieuviec nvarchar(30); 
set @NVnhieuviec = (select PHANCONG.MA_NVIEN
from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN=NHANVIEN.MANV 
group by PHANCONG.MA_NVIEN
having count(PHANCONG.MA_NVIEN)=(select top 1 count(PHANCONG.MA_NVIEN) 
								from NHANVIEN left outer join PHANCONG 
								on PHANCONG.MA_NVIEN=NHANVIEN.MANV
								group by PHANCONG.MA_NVIEN 
								order by count(PHANCONG.MA_NVIEN) desc))
select*from NHANVIEN where MANV=@NVnhieuviec


--vẫn là biến vô hướng nhưng đi chép để ngâm cứu
declare @NHANVIENPC nvarchar(10)=(select MA_NVIEN
from NHANVIEN inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
group by MA_NVIEN
having count(MADA) >=all (select count(MADA) from PHANCONG group by MA_NVIEN))
select * from NHANVIEN where MANV = @NHANVIENPC


----8. Tìm ra những nhân viên không có thân nhân nào cả. ? (giá trị trả về lưu vào 1 bảng tạm toàn cục)

-- Lưu gián tiếp qua biến bảng
declare @notThanNhan table
(
Ten nvarchar(40)
)
insert into @notThanNhan
select NHANVIEN.* from NHANVIEN left outer join THANNHAN on NHANVIEN.MANV=THANNHAN.MA_NVIEN
where MANV not in (select MA_NVIEN from THANNHAN)

select Ten
into ##DSnvKoTHANNHAN1
from @notThanNhan

select*from ##DSnvKoTHANNHAN1



-- Lưu trực tiếp vào biến toàn cục
select NHANVIEN.*
into ##DS_null_THANNHAn
from NHANVIEN left outer join THANNHAN on NHANVIEN.MANV=THANNHAN.MA_NVIEN
where MANV not in (select MA_NVIEN from THANNHAN)
select*from ##DS_null_THANNHAn

