

-- Buat tabel jenis_donasi
CREATE TABLE jenis_donasi (
    id_jenis INT PRIMARY KEY AUTO_INCREMENT,
    nama_jenis VARCHAR(50) NOT NULL UNIQUE
);

-- Insert data jenis donasi
INSERT INTO jenis_donasi (nama_jenis) VALUES 
('sedekah'),
('sedekah palestina'),
('sedekah al quran'),
('sedekah anak yatim'),
('infaq'),
('zakat mal'),
('zakat fitrah'),
('zakat penghasilan');

-- Buat tabel donasi
CREATE TABLE donasi (
    no INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(255),
    no_hp VARCHAR(20),
    nominal DECIMAL(15, 2) NOT NULL,
    id_jenis INT NOT NULL,
    FOREIGN KEY (id_jenis) REFERENCES jenis_donasi(id_jenis)
);

-- Buat tabel relawan
CREATE TABLE relawan (
    id_relawan INT PRIMARY KEY AUTO_INCREMENT,
    no_id VARCHAR(20) UNIQUE,
    nama_relawan VARCHAR(100) NOT NULL,
    no_hp_relawan VARCHAR(20),
    alamat_relawan VARCHAR(255),
    keterangan TEXT
);

-- Insert data dummy ke tabel donasi
INSERT INTO donasi (nama, alamat, no_hp, nominal, id_jenis) VALUES
('Ahmad Fauzi', 'Jakarta Selatan', '081234567890', 500000.00, 1),
('Siti Nurhaliza', 'Bandung', '082345678901', 1000000.00, 2),
('Budi Santoso', 'Surabaya', '083456789012', 750000.00, 3),
('Dewi Lestari', 'Yogyakarta', '084567890123', 300000.00, 4),
('Eko Prasetyo', 'Medan', '085678901234', 2000000.00, 5),
('Fatimah Azizah', 'Palembang', '086789012345', 1500000.00, 6),
('Gunawan Wijaya', 'Makassar', '087890123456', 250000.00, 7),
('Hana Putri', 'Semarang', '088901234567', 400000.00, 8),
('Irfan Hakim', 'Denpasar', '089012345678', 600000.00, 1),
('Julia Perez', 'Malang', '081112223333', 800000.00, 2),
('Kurniawan Dwi', 'Padang', '082223334444', 350000.00, 3),
('Lestari Sari', 'Pontianak', '083334445555', 1200000.00, 4),
('Muhammad Rizki', 'Balikpapan', '084445556666', 900000.00, 5),
('Nur Aisyah', 'Manado', '085556667777', 1800000.00, 6),
('Oscar Wijaya', 'Ambon', '086667778888', 450000.00, 7),
('Putri Maharani', 'Kupang', '087778889999', 550000.00, 8);

-- Insert data dummy ke tabel relawan
INSERT INTO relawan (no_id, nama_relawan, no_hp_relawan, alamat_relawan, keterangan) VALUES
('RL001', 'Andi Pratama', '081111111111', 'Jakarta Pusat', 'Koordinator Lapangan'),
('RL002', 'Rina Susanti', '082222222222', 'Bandung', 'Tim Logistik'),
('RL003', 'Budi Cahyono', '083333333333', 'Surabaya', 'Tim Medis'),
('RL004', 'Dewi Sartika', '084444444444', 'Yogyakarta', 'Tim Pendidikan'),
('RL005', 'Eko Sutrisno', '085555555555', 'Medan', 'Tim Distribusi'),
('RL006', 'Fatmawati', '086666666666', 'Palembang', 'Tim Keuangan'),
('RL007', 'Gunawan', '087777777777', 'Makassar', 'Tim Humas'),
('RL008', 'Hendra Wijaya', '088888888888', 'Semarang', 'Tim IT'),
('RL009', 'Ika Permata', '089999999999', 'Denpasar', 'Tim Fundraising'),
('RL010', 'Joko Widodo', '081000000000', 'Malang', 'Koordinator Wilayah');

-- Contoh Query 1: Menampilkan semua donasi dengan jenis donasi
SELECT 
    d.no AS 'No Donasi',
    d.nama AS 'Nama Donatur',
    d.alamat AS 'Alamat',
    d.no_hp AS 'No HP',
    d.nominal AS 'Nominal (Rp)',
    j.nama_jenis AS 'Jenis Donasi'
FROM donasi d
JOIN jenis_donasi j ON d.id_jenis = j.id_jenis
ORDER BY d.no;

-- Contoh Query 2: Menampilkan data relawan
SELECT 
    id_relawan AS 'ID Relawan',
    no_id AS 'No ID',
    nama_relawan AS 'Nama Relawan',
    no_hp_relawan AS 'No HP',
    alamat_relawan AS 'Alamat',
    keterangan AS 'Keterangan'
FROM relawan
ORDER BY id_relawan;

-- Contoh Query 3: Menampilkan total donasi per jenis
SELECT 
    j.nama_jenis AS 'Jenis Donasi',
    COUNT(d.no) AS 'Jumlah Donasi',
    FORMAT(SUM(d.nominal), 2) AS 'Total Nominal (Rp)',
    FORMAT(AVG(d.nominal), 2) AS 'Rata-rata (Rp)'
FROM donasi d
JOIN jenis_donasi j ON d.id_jenis = j.id_jenis
GROUP BY j.nama_jenis
ORDER BY SUM(d.nominal) DESC;

-- Contoh Query 4: Menampilkan 5 donatur dengan nominal terbesar
SELECT 
    d.nama AS 'Nama Donatur',
    d.no_hp AS 'No HP',
    j.nama_jenis AS 'Jenis Donasi',
    FORMAT(d.nominal, 2) AS 'Nominal (Rp)'
FROM donasi d
JOIN jenis_donasi j ON d.id_jenis = j.id_jenis
ORDER BY d.nominal DESC
LIMIT 5;

-- Contoh Query 5: Menampilkan relawan berdasarkan kategori tim
SELECT 
    keterangan AS 'Tim',
    COUNT(id_relawan) AS 'Jumlah Relawan',
    GROUP_CONCAT(nama_relawan SEPARATOR ', ') AS 'Daftar Relawan'
FROM relawan
GROUP BY keterangan
ORDER BY COUNT(id_relawan) DESC;

-- Contoh Query 6: Mencari donasi berdasarkan nama donatur
SELECT 
    d.no AS 'No Donasi',
    d.nama AS 'Nama Donatur',
    d.alamat AS 'Alamat',
    j.nama_jenis AS 'Jenis Donasi',
    FORMAT(d.nominal, 2) AS 'Nominal (Rp)'
FROM donasi d
JOIN jenis_donasi j ON d.id_jenis = j.id_jenis
WHERE d.nama LIKE '%Ahmad%' OR d.nama LIKE '%Siti%';

select * FROM relawan