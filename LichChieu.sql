INSERT INTO PHIM VALUES('MP09', 'ML01', N'Morbius');
INSERT INTO PHIM VALUES('MP10', 'ML05', N'Thầy Đạt và những người bạn');
INSERT INTO PHIM VALUES('MP11', 'ML05', N'Thành phố mất tích');
INSERT INTO PHIM VALUES('MP12', 'ML04', N'Bóng đè');
INSERT INTO PHIM VALUES('MP13', 'ML04', N'Vết nứt-Ám hồn trong tranh');
INSERT INTO PHIM VALUES('MP14', 'ML01', N'Batman');
INSERT INTO PHIM VALUES('MP15', 'ML02', N'Những kẻ xấu xa');
INSERT INTO PHIM VALUES('MP16', 'ML01', N'Xe cấp cứu');

CREATE TABLE LICHCHIEU( 
	MaPhim char(10) references PHIM(MaPhim), 
	maPhong char(10) references phongchieu(maPhong), 
	MaSC char(5) references SuatChieu(MaSC), 
	NgayChieu date)

--------------------------------------------------------
-- Nhập dữ liệu
INSERT INTO LICHCHIEU VALUES('MP02','R2','SC001','2-5-2022')
INSERT INTO LICHCHIEU VALUES('MP03','R2','SC002','5-5-2022')
INSERT INTO LICHCHIEU VALUES('MP01','R1','SC002','5-6-2022')
INSERT INTO LICHCHIEU VALUES('MP04','R2','SC002','3-5-2022')
INSERT INTO LICHCHIEU VALUES('MP05','R1','SC003','10-5-2022')
INSERT INTO LICHCHIEU VALUES('MP06','R2','SC001','12-4-2022')
	select * from PHIM
	select * from phongchieu
	select * from Seats

--------------------------------------------------------
-- Thủ tục xem thông tin những phim chiếu trong ngày chỉ định 
CREATE PROC sp_PhimTrongNgay @NgayChieu date 
AS 
BEGIN 
	IF(NOT EXISTS(SELECT NgayChieu FROM LICHCHIEU WHERE NgayChieu= @NgayChieu))
		PRINT N'Không có phim nào chiếu trong ngày đấy!'
	ELSE 
		SELECT * FROM LICHCHIEU WHERE NgayChieu=@NgayChieu
END
-- Thủ tục thêm LICHCHIEU
CREATE PROC sp_ThemLichChieu @maphim char(10), @maphong char(10), @masc char(10), @ngaychieu date
AS
BEGIN
	IF(NOT EXISTS(SELECT MaPhim FROM PHIM WHERE MaPhim=@maphim))
		PRINT N'Mã phim này không tồn tại, vui lòng nhập lại!'
	ELSE IF(NOT EXISTS(SELECT maPhong FROM phongchieu WHERE maPhong=@maphong))
		PRINT N'Mã phòng này không tồn tại, vui lòng nhập lại!'
	ELSE IF(NOT EXISTS(SELECT MaSC FROM SuatChieu WHERE MaSC=@masc))
		PRINT N'Mã suất chiếu này không tồn tại, vui lòng nhập lại!'
	ELSE IF(EXISTS(SELECT maPhong,MaSC,NgayChieu FROM LICHCHIEU
			WHERE maPhong=@maphong AND MaSC = @masc AND NgayChieu=@ngaychieu))
		PRINT N'Đã có phim khác chiếu vào thời điểm này, vui lòng nhập lại!'
	ELSE 
		INSERT INTO LICHCHIEU VALUES(@maphim,@maphong,@masc,@ngaychieu)
END
------------------------------------------------------------------------
----------------------NHẬP DỮ LIỆU--------------------------------------
------------------------------------------------------------------------
SELECT * FROM SuatChieu
SELECT * FROM PHIM
SELECT * FROM LICHCHIEU
delete from LICHCHIEU
EXEC sp_ThemLichChieu 'MP01', 'R1', 'SC001','1-4-2022'
EXEC sp_ThemLichChieu 'MP01', 'R1', 'SC002','5-6-2022'
EXEC sp_ThemLichChieu 'MP01', 'R1', 'SC005','1-4-2022'
EXEC sp_ThemLichChieu 'MP10', 'R3', 'SC006','1-4-2022'
EXEC sp_ThemLichChieu 'MP09', 'R1', 'SC005','12-4-2022'
EXEC sp_ThemLichChieu 'MP15', 'R1', 'SC005','12-4-2022'
EXEC sp_ThemLichChieu 'MP16', 'R2', 'SC002','13-4-2022'
EXEC sp_ThemLichChieu 'MP02', 'R2', 'SC004','15-4-2022'
EXEC sp_ThemLichChieu 'MP07', 'R3', 'SC003','16-4-2022'
EXEC sp_ThemLichChieu 'MP08', 'R3', 'SC001','15-4-2022'


select * from Seats