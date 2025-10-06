USE LuyenThiDB;
GO


CREATE TABLE nguoi_dung (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ten_dang_nhap NVARCHAR(100) UNIQUE NOT NULL,
    email NVARCHAR(255) UNIQUE,
    mat_khau_ma_hoa NVARCHAR(255) NOT NULL,
    avatar_id UNIQUEIDENTIFIER NULL,
    ngay_tao DATETIME2 DEFAULT SYSDATETIME(),
    lan_dang_nhap_cuoi DATETIME2 NULL
);

CREATE TABLE avatar (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ten NVARCHAR(100),
    duong_dan_anh NVARCHAR(255),
    thong_tin_them NVARCHAR(MAX)
);

CREATE TABLE cai_dat_nguoi_dung (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    nguoi_dung_id UNIQUEIDENTIFIER UNIQUE NOT NULL,
    nhac_nen BIT DEFAULT 0,
    am_thanh BIT DEFAULT 0,
    hen_gio_tung_cau BIT DEFAULT 0,
    so_giay_moi_cau INT NULL,
    so_cau_moi_vong INT DEFAULT 5,
    tong_thoi_gian_giay INT NULL,
    ngay_tao DATETIME2 DEFAULT SYSDATETIME(),
    ngay_cap_nhat DATETIME2 DEFAULT SYSDATETIME(),
    CONSTRAINT FK_CaiDatNguoiDung_NguoiDung FOREIGN KEY (nguoi_dung_id)
        REFERENCES nguoi_dung(id) ON DELETE CASCADE
);

CREATE TABLE danh_muc (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ten NVARCHAR(100) UNIQUE NOT NULL,
    mo_ta NVARCHAR(255)
);

CREATE TABLE phuong_tien (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    duong_dan NVARCHAR(255) NOT NULL,
    loai NVARCHAR(20) CHECK(loai IN ('anh','am_thanh','video','khac')),
    thong_tin_them NVARCHAR(MAX)
);

CREATE TABLE cau_hoi (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    nguoi_tao_id UNIQUEIDENTIFIER NULL,
    loai NVARCHAR(20) CHECK(loai IN ('dung_sai','chon_mot')) NOT NULL,
    noi_dung NVARCHAR(MAX) NOT NULL,
    do_kho SMALLINT NULL,
    danh_muc_id UNIQUEIDENTIFIER NULL,
    kich_hoat BIT DEFAULT 1,
    ngay_tao DATETIME2 DEFAULT SYSDATETIME(),
    ngay_cap_nhat DATETIME2 DEFAULT SYSDATETIME(),
    du_lieu_json NVARCHAR(MAX) NULL,
    phuong_tien_id UNIQUEIDENTIFIER NULL,
    CONSTRAINT FK_CauHoi_NguoiDung FOREIGN KEY (nguoi_tao_id) REFERENCES nguoi_dung(id),
    CONSTRAINT FK_CauHoi_DanhMuc FOREIGN KEY (danh_muc_id) REFERENCES danh_muc(id),
    CONSTRAINT FK_CauHoi_PhuongTien FOREIGN KEY (phuong_tien_id) REFERENCES phuong_tien(id)
);

CREATE TABLE lua_chon_cau_hoi (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    cau_hoi_id UNIQUEIDENTIFIER NOT NULL,
    nhan CHAR(1),
    noi_dung NVARCHAR(MAX) NOT NULL,
    la_dap_an_dung BIT DEFAULT 0,
    thu_tu SMALLINT,
    CONSTRAINT FK_LuaChon_CauHoi FOREIGN KEY (cau_hoi_id)
        REFERENCES cau_hoi(id) ON DELETE CASCADE
);

CREATE TABLE nhan (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ten NVARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE nhan_cau_hoi (
    cau_hoi_id UNIQUEIDENTIFIER NOT NULL,
    nhan_id UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (cau_hoi_id, nhan_id),
    FOREIGN KEY (cau_hoi_id) REFERENCES cau_hoi(id) ON DELETE CASCADE,
    FOREIGN KEY (nhan_id) REFERENCES nhan(id) ON DELETE CASCADE
);

CREATE TABLE de_thi (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ten NVARCHAR(100),
    mo_ta NVARCHAR(255),
    nguoi_tao_id UNIQUEIDENTIFIER,
    ngay_tao DATETIME2 DEFAULT SYSDATETIME(),
    FOREIGN KEY (nguoi_tao_id) REFERENCES nguoi_dung(id)
);

CREATE TABLE cau_hoi_de_thi (
    de_thi_id UNIQUEIDENTIFIER NOT NULL,
    cau_hoi_id UNIQUEIDENTIFIER NOT NULL,
    thu_tu SMALLINT,
    PRIMARY KEY (de_thi_id, cau_hoi_id),
    FOREIGN KEY (de_thi_id) REFERENCES de_thi(id) ON DELETE CASCADE,
    FOREIGN KEY (cau_hoi_id) REFERENCES cau_hoi(id) ON DELETE CASCADE
);

CREATE TABLE luot_lam_bai (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    nguoi_dung_id UNIQUEIDENTIFIER NULL,
    de_thi_id UNIQUEIDENTIFIER NULL,
    bat_dau_luc DATETIME2 DEFAULT SYSDATETIME(),
    ket_thuc_luc DATETIME2 NULL,
    diem DECIMAL(5,2) NULL,
    tong_so_cau INT,
    so_cau_dung INT,
    cai_dat_tai_thoi_diem NVARCHAR(MAX) NULL,
    tong_thoi_gian_giay INT NULL,
    FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id),
    FOREIGN KEY (de_thi_id) REFERENCES de_thi(id)
);

CREATE TABLE dap_an_luot_lam (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    luot_lam_id UNIQUEIDENTIFIER NOT NULL,
    cau_hoi_id UNIQUEIDENTIFIER NOT NULL,
    lua_chon_id UNIQUEIDENTIFIER NULL,
    noi_dung_tu_nhap NVARCHAR(MAX) NULL,
    la_dung BIT NULL,
    thoi_gian_tra_loi_giay INT NULL,
    thu_tu SMALLINT,
    FOREIGN KEY (luot_lam_id) REFERENCES luot_lam_bai(id) ON DELETE CASCADE,
    FOREIGN KEY (cau_hoi_id) REFERENCES cau_hoi(id),
    FOREIGN KEY (lua_chon_id) REFERENCES lua_chon_cau_hoi(id)
);



CREATE TABLE nguoi_dung (
	id INT IDENTITY(1,1) PRIMARY KEY,
	ten_dang_nhap NVARCHAR(100) UNIQUE NOT NULL,
	email NVARCHAR(255),
	mat_khau_ma_hoa NVARCHAR(255),
	ngay_tao DATETIME2 DEFAULT SYSDATETIME()
);
GO

INSERT INTO nguoi_dung (ten_dang_nhap, email, mat_khau_ma_hoa)
VALUES
(N'nguyenvana', N'vana@gmail.com', N'123456'),
(N'lethib', N'b@example.com', N'123456'),
(N'tranvanc', N'c@example.com', N'123456');
GO

	
CREATE TABLE danh_muc (
	id INT IDENTITY(1,1) PRIMARY KEY,
	ten NVARCHAR(100),
	mo_ta NVARCHAR(255)
);
GO

INSERT INTO danh_muc (ten, mo_ta)
VALUES
(N'Toán', N'Môn Toán học'),
(N'Anh văn', N'Môn tiếng Anh'),
(N'Lịch sử', N'Môn Lịch sử Việt Nam');
GO

	
CREATE TABLE cau_hoi (
	id INT IDENTITY(1,1) PRIMARY KEY,
	noi_dung NVARCHAR(MAX),
	loai NVARCHAR(20),
	danh_muc_id INT,
	FOREIGN KEY (danh_muc_id) REFERENCES danh_muc(id)
);
GO

INSERT INTO cau_hoi (noi_dung, loai, danh_muc_id)
VALUES
(N'2 + 2 = ?', N'chon_mot', 1),
(N'Thủ đô của Việt Nam là?', N'chon_mot', 3),
(N'Trong tiếng Anh, "cat" nghĩa là gì?', N'chon_mot', 2);
GO


CREATE TABLE lua_chon_cau_hoi (
	id INT IDENTITY(1,1) PRIMARY KEY,
	cau_hoi_id INT,
	noi_dung NVARCHAR(MAX),
	la_dap_an_dung BIT,
	FOREIGN KEY (cau_hoi_id) REFERENCES cau_hoi(id)
);
GO

INSERT INTO lua_chon_cau_hoi (cau_hoi_id, noi_dung, la_dap_an_dung)
VALUES
(1, N'3', 0),
(1, N'4', 1),
(1, N'5', 0),

(2, N'Hà Nội', 1),
(2, N'TP. Hồ Chí Minh', 0),
(2, N'Đà Nẵng', 0),

(3, N'Con chó', 0),
(3, N'Con mèo', 1),
(3, N'Con cá', 0);
GO


CREATE TABLE de_thi (
	id INT IDENTITY(1,1) PRIMARY KEY,
	ten NVARCHAR(100),
	mo_ta NVARCHAR(255),
	nguoi_tao_id INT,
	FOREIGN KEY (nguoi_tao_id) REFERENCES nguoi_dung(id)
);
GO

INSERT INTO de_thi (ten, mo_ta, nguoi_tao_id)
VALUES
(N'Đề kiểm tra Toán cơ bản', N'Kiểm tra cộng trừ nhân chia', 1),
(N'Đề Anh văn số 1', N'Từ vựng cơ bản', 2);
GO


CREATE TABLE cau_hoi_de_thi (
	de_thi_id INT,
	cau_hoi_id INT,
	PRIMARY KEY (de_thi_id, cau_hoi_id),
	FOREIGN KEY (de_thi_id) REFERENCES de_thi(id),
	FOREIGN KEY (cau_hoi_id) REFERENCES cau_hoi(id)
);
GO

INSERT INTO cau_hoi_de_thi (de_thi_id, cau_hoi_id)
VALUES
(1, 1),
(2, 3);
GO


SELECT * FROM nguoi_dung;
SELECT * FROM danh_muc;
SELECT * FROM cau_hoi;
SELECT * FROM lua_chon_cau_hoi;
SELECT * FROM de_thi;
SELECT * FROM cau_hoi_de_thi;
GO

