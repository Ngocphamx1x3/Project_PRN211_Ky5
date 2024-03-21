Create database CHBHTH
go
use CHBHTH
go

/*TÀI KHOẢN*/
Create table TaiKhoan
(MaNguoiDung int IDENTITY(1,1) NOT NULL,
	HoTen nvarchar(50) NULL,
	Email varchar(50) NULL,
	Dienthoai varchar(50) NULL,
	Matkhau varchar(50) NULL,
	IDQuyen int NULL,
	Diachi nvarchar(100) NULL,
	primary key(MaNguoiDung));

/*PHÂN QUYỀN*/
Create table PhanQuyen
(IDQuyen int IDENTITY(1,1) NOT NULL,
	TenQuyen nvarchar(20) NULL,
	primary key(IDQuyen));

/*NHÀ CUNG CẤP*/
Create table NhaCungCap
(MaNCC int IDENTITY(1,1) NOT NULL, 
	TenNCC nvarchar(100) NULL, 
	primary key(MaNCC));

/*LOẠI HÀNG*/
Create table LoaiHang
(MaLoai int IDENTITY(1,1) NOT NULL,
	TenLoai nvarchar(100) DEFAULT NULL,
	Primary key(MaLoai));

/*SẢN PHẨM*/
CREATE TABLE SanPham(
	MaSP int IDENTITY(1,1) NOT NULL,
	TenSP nvarchar (100) NULL,
	GiaBan decimal(18,0) NULL,	
	Soluong int NULL,
	MoTa ntext NULL,
	MaLoai int NULL,
	MaNCC int NULL,
	AnhSP nvarchar(100) NULL,
	Primary key(MaSP));


/*ĐƠN HÀNG*/
CREATE TABLE DonHang(
	Madon int IDENTITY(1,1) NOT NULL,	
	NgayDat  datetime NULL,
	TinhTrang  int NULL,
	ThanhToan int NULL,
	DiaChiNhanHang Nvarchar(100) NULL,
	MaNguoiDung int NULL,
	TongTien decimal(18,0),
	Primary key(Madon));

/*CT ĐƠN HÀNG*/
CREATE TABLE ChiTietDonHang(
	CTMaDon int IDENTITY(1,1) NOT NULL,
	MaDon int NOT NULL,
	MaSP int NOT NULL,
	SoLuong int NULL,
	DonGia decimal(18,0) NULL,
	ThanhTien decimal(18,0)  NULL,
	PhuongThucThanhToan int Null,
	Primary key(CTMaDon));

CREATE TABLE TinTuc(
	MaTT int IDENTITY(1,1) NOT NULL,
	TieuDe nvarchar(100),
	NoiDung ntext,
	Primary key(MaTT));


/*Ràng buộc TÀI KHOẢN*/
alter table TaiKhoan
add constraint FK_tk_pq foreign key(IDQuyen) references PhanQuyen(IDQuyen);

/*Ràng buộc SẢN PHẨM*/
alter table SanPham
add constraint FK_sp_ncc foreign key(MaNCC) references NhaCungCap(MaNCC);
alter table SanPham
add constraint FK_sp_loai foreign key(Maloai) references LoaiHang(Maloai);

/*Ràng buộc ĐƠN HÀNG*/
alter table DonHang
add constraint FK_hd_tk foreign key(MaNguoiDung) references taikhoan(MaNguoiDung);

/*Ràng buộc CHI TIẾT ĐƠN HÀNG*/
alter table ChiTietDonHang
add constraint FK_cthd_hd foreign key(MaDon) references DonHang(MaDon);
alter table ChiTietDonHang
add constraint FK_cthd_sp foreign key(MaSP) references SanPham(MaSP);

/*Phân quyền*/
insert into PhanQuyen values ('Adminstrator');
insert into PhanQuyen values ('Member');

/*Tài khoảng*/
insert into TaiKhoan values (N'Duy','Admin@gmail.com','0904596810','123456',1,N'Vĩnh Long');
insert into TaiKhoan values (N'Nguyễn Văn A','nguyenvana@gmail.com','0123456789','123456',2,N'Vũng Liêm');

/*Loại hàng*/
insert into LoaiHang values (N'Hoa Hồng');
insert into LoaiHang values (N'Hoa Sen');
insert into LoaiHang values (N'Hoa Ly');

/*Nhà cung cấp*/
insert into NhaCungCap values (N'CT Dương Thị');
insert into NhaCungCap values (N'CT Kim Thủy');
insert into NhaCungCap values (N'CT Ngọc Huyền');

/*Sản phẩm*/
insert into SanPham values (N'Hoa Hồng',180000,10,N'Bó hoa hồng đỏ tươi, đầy sức sống và quyến rũ.',1,3,N'\Images\HoaHong.jpg');
insert into SanPham values (N'Hoa Sen',500000,10,N'Bó hoa mang đến sự thanh nhã và tĩnh lặng. ',2,2,N'\Images\HoaSen.jpg');
insert into SanPham values (N'Hoa Ly ',220000,10,N'Bó hoa mang đến sự diệu dàng',3,1,N'\Images\HoaLy.jpg');

/*ĐƠN HÀNG*/
insert into DonHang values ('2023-02-07',1,1,N'Đại Học VLUTE',2,27000);
insert into DonHang values ('2023-02-07',NULL,1,N'Vũng Liêm',2,18000);

/*CT_Hóa đơn*/
insert into ChiTietDonHang values (1,2,1,5000,5000,1);
insert into ChiTietDonHang values (1,3,1,22000,22000,1);
insert into ChiTietDonHang values (2,1,1,18000,18000,1);

/*Tin Tức*/
insert into TinTuc values (N'Hoa đẹp cuộc sống thêm đẹp',N'Biến Những Dịp Đặc Biệt Thành Những Khoảng Khắc Đẹp Nhất!');

select * from PhanQuyen;
select * from TaiKhoan; 
select * from LoaiHang where TenLoai <> 'Thùng rác';
select * from NhaCungCap;	
--select * from SanPham order by MaSP DESC where MaLoai='2';

select * from DonHang;
select * 
from DonHang,ChiTietDonHang 
where DonHang.MaDon=ChiTietDonHang.MaDon and DonHang.MaDon = 1 

select * from TinTuc

/*
select * from khachhang where SDT <> '0'

Hàm kiểm tra tồn tại
IF EXISTS (SELECT * FROM ct_phieuxuat Where MaSP = 'EX') 
BEGIN
	Update ct_kho SET Soluong = 
	 ((select 'Soluongnhap'=Sum(SoLuong) from ct_phieunhap where MaSP = 'EX') - 
	 (select 'Soluongxuat' =Sum(SoLuong) from ct_phieuxuat where MaSP = 'EX')) 
	 Where MaSP = 'EX'
END
ELSE 
	 Update ct_kho SET Soluong = (select 'Soluongnhap'=Sum(SoLuong) from ct_phieunhap where MaSP = 'EX') Where MaSP = 'EX'


-- Hàm kiểm tra tồn tại
IF EXISTS (SELECT * FROM ct_phieunhap Where MaPN = 4 AND MaSP = 'VS') 
BEGIN
	PRINT 'DA TON TAI'
END
ELSE INSERT INTO ct_phieunhap(MaPN,MaSP,Soluong,DonGiaNhap) VALUES ('4','VS','20','3000000')


Update ct_kho SET 

Soluong=
(select Sum(SoLuong) as 'Soluongnhap'
from ct_phieunhap
where MaSP = 'EX') 
-
(select Sum(SoLuong) as 'Soluongxuat'
from ct_phieuxuat
where MaSP = 'EX') 
from ct_kho
Where MaSP = 'EX'

Select Soluong From ct_kho Where MaSP = 'EX' 

delete from kho where MaKho = '1'	

select * from ct_hoadon where MaHoaDon = '1'

select SUM(TongTien) as 'TongTien'
from hoadon 
where Ngay between '2021-02-07' and '2021-02-09' 

SELECT 'TongTien'=SUM(TongTien) FROM hoadon WHERE Ngay between '2021-02-07' and '2021-02-07'

select TenSP,DonGia,'SoLuong'=SUM(SoLuong),'TongTien'=(DonGia * SUM(SoLuong))
from ct_hoadon,hoadon,sanpham  
where ct_hoadon.MaHoaDon = hoadon.MaHoaDon and sanpham.MaSP = ct_hoadon.MaSP and hoadon.Ngay between '2021-02-07' and '2021-02-07' 
Group by TenSP,DonGia

select 'SoLuong'=SUM(SoLuong), 'TongTien'=SUM(TongTien)
from ct_hoadon,hoadon
where ct_hoadon.MaHoaDon = hoadon.MaHoaDon and Ngay between '2021-02-07' and '2021-02-07' 

--tính tổng hoá đơn theo ngày
select * , 'tong'= (select 'TONG'=sum(TongTien) from hoadon where  Ngay between '2021-05-29' and '2021-05-30') 
from hoadon
where  Ngay between '2021-02-07' and '2021-05-29'

select MaHoaDon,Ngay,SDT,TongTien,Username,GhiChu
FROM hoadon
where Ngay between '2021-02-07' and '2021-05-29'
 
select 'TONG' = sum(TongTien) from hoadon where  Ngay between '2021-02-07' and '2021-02-09' 
group by MaHoaDon,Ngay,SDT,TongTien,Username,GhiChu

UPDATE ct_phieuxuat SET MaPX = '1',MaSP ='EX',SoLuong = '4',DonGia = '40000' WHERE MaCTPX = '1'

Select 'TongTien'=sum(DonGia) 
From ct_hoadon 
Where MaHoaDon = '12' 

select 'SoLuong'=SUM(SoLuong)
from ct_hoadon
where MaHoaDon = '12'


select 'DonGia'=sum(DonGia)
from ct_hoadon
where MaHoaDon = '12'


UPDATE hoadon 
SET TongTien = 
(select 'TongTien'=sum(SoLuong * DonGia)
from ct_hoadon
where MaHoaDon = '12'
Group by MaHoaDon)
where MaHoaDon = '12'

--Tính tổng chi tiết hoá đơn từng sản phẩm theo ngày
select TenSP, GiaBan, 'SoLuong'=SUM(SoLuong), 'TongTien'=(SUM(SoLuong) * GiaBan) 
from ct_hoadon,hoadon,sanpham  
where ct_hoadon.MaHoaDon = hoadon.MaHoaDon and sanpham.MaSP = ct_hoadon.MaSP and Ngay between '2021-05-29' and '2021-05-30' 
Group by TenSP,GiaBan

select TenSP, GiaBan, 'SoLuong'=SUM(SoLuong), 'TongTien'=(SUM(SoLuong) * GiaBan),
"TongĐG" = (SELECT "TONGGG"= sum(TongTien)
	FROM "dbo"."hoadon" hoadon
	WHERE Ngay between '2021-05-29' and '2021-05-30' ),
"TongCG" = (SELECT "TONGCG"= sum(ThanhTien)
	 FROM ct_hoadon,hoadon
	 WHERE ct_hoadon.MaHoaDon = hoadon.MaHoaDon and Ngay between '2021-05-29' and '2021-05-30'), 
"TongSL" = (SELECT "TONGSL"= sum(SoLuong)
            FROM hoadon,ct_hoadon
            WHERE ct_hoadon.MaHoaDon = hoadon.MaHoaDon and Ngay between '2021-05-29' and '2021-05-30'), 
"TongGG" = (
	(SELECT "TONGCG"= sum(ThanhTien)
	 FROM ct_hoadon,hoadon
	 WHERE ct_hoadon.MaHoaDon = hoadon.MaHoaDon and Ngay between '2021-05-29' and '2021-05-30')
-
	(SELECT "TONGGG"= sum(TongTien)
	FROM "dbo"."hoadon" hoadon
	WHERE Ngay between '2021-05-29' and '2021-05-30' ))
from ct_hoadon,hoadon,sanpham  
where ct_hoadon.MaHoaDon = hoadon.MaHoaDon and sanpham.MaSP = ct_hoadon.MaSP and Ngay between '2021-05-29' and '2021-05-30'  
Group by TenSP,GiaBan

--Lấy tổng tiền báo cáo
select DISTINCT 'SoLuong' = sum(ct_hoadon.ThanhTien),'TongTien'= (select 'TongTien'= sum(TongTien) from hoadon where Ngay between '09/06/2021' and '09/06/2021')
from ct_hoadon,hoadon
where ct_hoadon.MaHoaDon = hoadon.MaHoaDon and Ngay between '09/06/2021' and '09/06/2021'

--Lấy giảm tiền báo cáo
select DISTINCT 'SoLuong' = sum(ct_hoadon.ThanhTien),'TongTien'= sum(ct_hoadon.ThanhTien) - (select 'TongTien'= sum(TongTien) from hoadon where Ngay between '09/06/2021' and '09/06/2021')
from ct_hoadon,hoadon
where ct_hoadon.MaHoaDon = hoadon.MaHoaDon and Ngay between '09/06/2021' and '09/06/2021'
*/

/*Ràng buộc ĐƠN HÀNG*/
alter table Course
add constraint FK_c_u foreign key(LecturerId) references AspNetUsers(Id);
