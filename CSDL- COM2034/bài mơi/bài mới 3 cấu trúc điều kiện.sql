-- bài 3 : Cấu trú điều kiện

-- lý thuyết:

-- 1. Block (Khối lệnh)
-- cú pháp : Begin.....end
---> Từ 2 cấu lện trở lên phaari đặt trong khối begin--end


-- 2.. cấu trúc câu điều kiệ IF-ELse
-- cú pháp: IF <Biểu thức điều kiện>
--begin
--lệnh true
--end
---- Else
--begin
----Lẹnh false
--end

--ví dụ 1: Nhập vào 1 điểm thi. in ra trạng thái  trượt hay đỗ
declare @diemthi float= 9.5,@tt nvarchar(10)
if @diemthi>=5
set @tt= N'Đỗ'
else 
set @tt=N'tạch'
select @diemthi,@tt

--ví duj2: Nhập vào điểm trung bình. xếp loại TB>=9 xuất sắc, tb>=8 giỏi
declare @dtb float= 9.5,@xl nvarchar(10)
if @dtb>=9
set @xl=N'xuất sắc'
else if @dtb>=8
begin
set @xl=N'giỏi'
end
else if @dtb>=6
set @xl=N'TB'
else if @dtb>=4
set @xl=N'KÉM'
else
set @xl=N'yếu'
select @dtb,@xl

--ví dụ 3: dùn CSDL qLDA, nếu TBLuong >30000. in NHa viên có thu nhập cao else thu nhập thấp
use QLDA
go
declare @LTB float,@x nvarchar(40);
set @LTB=(select AVG(LUONG) from NHANVIEN)

if @LTB>30000
 set @x= N'Thu Nhập Cao'
 else 
 set @x= N'thu nhập thấp'
 select @LTB,@x


 --3. hàm iif
 --cú pháp iif(biểu thức điều kiện, giá trị true,giá trị fale)
 
 --vid dụ 4:
 --dưa ra ten, luong trijng thái của luong NHVIeen toàn công ty. viết LUong >3000, Luong cao nguoiwjc lại lương thấp

 select TENNV,LUONG, IIF(LUONG>=30000,N'Luong cao',N'Lương thấp')
 from NHANVIEN
 -- ví dụ 5: đưa ra tên, tuổi, chê sộ hưu. biết tuổi>>=60 được về hưu, KHÔNG
 select TENNV, datediff(year,NGSINH,getdate()) as N'Tủi',
 iif(datediff(year,NGSINH,getdate())>=60,N' Được phép nghỉ Hưu',N' Không')
 from NHANVIEN

 -- 4. hàm Case-- cấu trúc đa điều kiện
 ---4.1-- Simpale case SO sanh bằng
 ---- cú pháp: Case< Biến đầu vào> 
 -------------- WHEN + giastri1 + THEN+ Lệnh 1
  -------------- WHEN + giastri2 + THEN+ Lệnh 2
  -----
  -----else lẹnh cuối
  -----END

  --vid dụ 6: diểm 10 hoạc bông loại 1,8 diểm học bổng loại 2
  declare @d float =8;
  select
  case @d
  when 10 then N'HỌc Bổng 1'
  when 8 then N' học bổng 2'
  else N'không'
  end

  --ví dụ 7: hiển thị ten Nhân viên, MaxPHG, du lịch. biest m=5 đi anh, mã =4 đi nhật, còn lại tại nhà =
  select TENNV, PHG,DULIC=
  case PHG
  when 5 then N'ĐI Anh'
  when 4 then N' ĐI Nhật'
  else N' Ở nhà'
  end
  from NHANVIEN
 ---4.2-- Search Case
 --cú pháp: Case 
 -------------- WHEN + Biểu thức 1 + THEN+ Lệnh 1
  -------------- WHEN + biểu thức 2+ THEN+ Lệnh 2
  -----
  -----else lẹnh cuối
  -----END

  -- ví dụ 8: hiên thị Tennv, Luong, Mức Luong.
  --biết Luong >50000 Luong cao, Luong>3000, luong thấp còn lai

  select TENNV,LUONG,Mức=
  case
  when Luong>=50000 then N'Luong cao'
  when Luong>=30000 then N'Luong tb'
  else N' Luong thấp'
  end
  from NHANVIEN

  --ví dụ 9:
  --hiên thị Tennv, Luong, Mức Luong. lương <tb tăng còn lại thì không
    select TENNV,LUONG,tangluong=
  case
  when LUONG<(select avg(LUONG) from NHANVIEN) then N'tĂNG LƯƠNG'
  else N'KHÔNG TăNG'
  end
  from NHANVIEN
