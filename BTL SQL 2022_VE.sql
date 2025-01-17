﻿create table Ve(
	mave char(10) primary key,
	makh char(10) references khachhang(makh),
	manv char(10) references nhanvien(manv),
	maLv char(5) references loaive(malv),
	maphim char(10) references phim(maphim),
	maphong char(10) references phongchieu(maphong),
	masc char(5) references suatchieu(masc),
	maghe char(5),
	trangthai varchar(25),
	ngaychieu date
)
drop table Ve
--View in ra danh sách KH hủy vé
create view DS_HuyVe
as
select KHACHHANG.makh, tenkh, mave, malv, masc, trangthai
from KHACHHANG, Ve
where KHACHHANG.makh = Ve.makh and trangthai = 'Huy'

--Thủ tục hủy vé
alter proc sp_huyVe @mave char(10)
as
begin
	if((select trangthai from Ve where mave = @mave) = N'Bình thường')
		begin
			update Ve set trangthai = N'Đã hủy' where mave = @mave
			
			declare @maphong char(5), @column char(5), @mahang char(5), @masc char(5), @ngaychieu date
			set @maphong = (select left(@mave, 2))
			set @column = (select substring(@mave, 3, 1))
			set @mahang = (select substring(@mave, 4, 1))
			set @masc = (select masc from Ve where mave = @mave)
			set @ngaychieu = (select ngaychieu from ve where mave = @mave)

			if(@column = 'A')
				update V_SOGHETRONGNGAY set columnA = 0 where mahang = @mahang and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
			else if(@column = 'B')
				update V_SOGHETRONGNGAY set columnB = 0 where mahang = @mahang and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
			else if(@column = 'C')
				update V_SOGHETRONGNGAY set columnC = 0 where mahang = @mahang and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
			else if(@column = 'D')
				update V_SOGHETRONGNGAY set columnD = 0 where mahang = @mahang and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
			else if(@column = 'E')
				update V_SOGHETRONGNGAY set columnE = 0 where mahang = @mahang and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
			else if(@column = 'F')
				update V_SOGHETRONGNGAY set columnF = 0 where mahang = @mahang and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
			else if(@column = 'G')
				update V_SOGHETRONGNGAY set columnG = 0 where mahang = @mahang and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu

			print N'Mã vé [' + @mave + N'] được hủy thành công !'
		end	
	else
		print N'Mã vé [' + @mave + N'] đã bị hủy trước đó rồi !'
end


select * from V_SOGHETRONGNGAY

--THỦ TỤC THÊM VÉ 
alter proc sp_themVe (@mave char(10), @makh char(10), @manv char(10), @maLv char(5), @maphim char(10), @maphong char(10), @masc char(5), @maghe char(5), @trangthai char(10), @ngaychieu date) 
as
begin 
	if(exists (select mave from Ve where mave = @mave))
		begin
			print N'Mã vé này đã tồn tại trong bảng'
		end
	else 
	
	    if(exists (select maLv from loaive where maLv = @maLv))
	        if(exists (select maphong from phongchieu where maphong = @maphong))
	            if(exists (select maphim from PHIM where maphim = @maphim))
			        if(exists (select masc from SuatChieu where masc = @masc))
						if(dbo.func_checkSeat(@maphong, @maghe, @masc, @ngaychieu) = 0)	
							if((select substring(@maghe, 3, 1)) = 'A')
								begin
								update V_SOGHETRONGNGAY set columnA = 1 where mahang = (select substring(@maghe, 4, 1)) and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
								insert into Ve values (@mave, @makh, @manv, @maLv, @maphim, @maphong, @masc, @maghe, @trangthai, @ngaychieu)
								end
							else if ((select substring(@maghe, 3, 1)) = 'B')
								begin
								update V_SOGHETRONGNGAY set columnB = 1 where mahang = (select substring(@maghe, 4, 1)) and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
								insert into Ve values (@mave, @makh, @manv, @maLv, @maphim, @maphong, @masc, @maghe, @trangthai, @ngaychieu)
								end
							else if ((select substring(@maghe, 3, 1)) = 'C')
								begin
								update V_SOGHETRONGNGAY set columnC = 1 where mahang = (select substring(@maghe, 4, 1)) and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
								insert into Ve values (@mave, @makh, @manv, @maLv, @maphim, @maphong, @masc, @maghe, @trangthai, @ngaychieu)
								end
							else if ((select substring(@maghe, 3, 1)) = 'D')
								begin
								update V_SOGHETRONGNGAY set columnD = 1 where mahang = (select substring(@maghe, 4, 1)) and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
								insert into Ve values (@mave, @makh, @manv, @maLv, @maphim, @maphong, @masc, @maghe, @trangthai, @ngaychieu)
								end
							else if ((select substring(@maghe, 3, 1)) = 'E')
								begin
								update V_SOGHETRONGNGAY set columnE = 1 where mahang = (select substring(@maghe, 4, 1)) and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
								insert into Ve values (@mave, @makh, @manv, @maLv, @maphim, @maphong, @masc, @maghe, @trangthai, @ngaychieu)
								end
							else if ((select substring(@maghe, 3, 1)) = 'F')
								begin
								update V_SOGHETRONGNGAY set columnF = 1 where mahang = (select substring(@maghe, 4, 1)) and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
								insert into Ve values (@mave, @makh, @manv, @maLv, @maphim, @maphong, @masc, @maghe, @trangthai, @ngaychieu)
								end
							else if ((select substring(@maghe, 3, 1)) = 'G')
								begin
								update V_SOGHETRONGNGAY set columnG = 1 where mahang = (select substring(@maghe, 4, 1)) and maphong = @maphong and masc = @masc and NGAYCHIEU = @ngaychieu
								insert into Ve values (@mave, @makh, @manv, @maLv, @maphim, @maphong, @masc, @maghe, @trangthai, @ngaychieu)
								end
						else
							begin
								print N'Ma ghe khong hop le !!!'
							end
					else 
						begin
							print N'Ghe nay da co nguoi dat !!!' 
						end
				else 
					begin
						print N'Khong ton tai suat chieu !!!'
					end
			else 
				begin
					print N'Khong ton tai ma phim tren !!!'
				end
		else 
			begin
				print N'Khong ton tai phong chieu !!!'
			end
	else
		begin
			print N'Khong ton tai loai ve !!!'
		end
end

select * from ve

SELECT * FROM NHANVIEN
SELECT * FROM KHACHHANG
SELECT * FROM PHIM

SELECT * FROM VE



