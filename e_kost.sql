CREATE TABLE `pemilik_kos`(
    `id_pemilik` VARCHAR(25) NOT NULL PRIMARY KEY,
    `email_pemilik` VARCHAR(60) NOT NULL,
    `pass_pemilik` VARCHAR(60) NOT NULL,
    `nama_pemilik` TEXT(50) NOT NULL,
    `notelp_pemilik` INT(15) NOT NULL
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `penyewa_kos`(
    `id_penyewa` VARCHAR(25) NOT NULL PRIMARY KEY,
    `email_penyewa` VARCHAR(60) NOT NULL,
    `pass_penyewa` VARCHAR(60) NOT NULL,
    `nama_penyewa` TEXT(50) NOT NULL,
    `notelp_penyewa` INT(15) NOT NULL,
    `daerah_asal` TEXT(50) NOT NULL,
    `tanggal_masuk` DATE NOT NULL,
    `harga_kos` INT(15) NOT NULL
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `kos`(
    `id_kos` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `nama_kos` VARCHAR(60) NOT NULL,
    `alamat_kos` VARCHAR(60) NOT NULL,
    `id_pemilik` VARCHAR(25) NOT NULL,
    `id_penyewa` VARCHAR(25)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `forum_kos`(
    `id_forum` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `id_kos` INT NOT NULL,
    `postingan` VARCHAR(280) NOT NULL,
    `komentar` VARCHAR(280)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `mitra`(
    `id_mitra` VARCHAR(25) NOT NULL PRIMARY KEY,
    `email_mitra` VARCHAR(60) NOT NULL,
    `pass_mitra` VARCHAR(60) NOT NULL,
    `nama_mitra` TEXT(50) NOT NULL,
    `notelp_mitra` INT(15) NOT NULL,
    `produl_jasa` VARCHAR(50) NOT NULL,
    `id_undang` VARCHAR(25) NOT NULL
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `pemesanan`(
    `id_pemesanan` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `id_penyewa` VARCHAR(25) NOT NULL,
    `id_mitra` VARCHAR(25) NOT NULL,
    `pemesanan` VARCHAR(50) NOT NULL,
    `catatan` VARCHAR(200)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE data_pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    id_penyewa VARCHAR(25) NOT NULL,
    id_pemilik VARCHAR(25) NOT NULL,
    tanggal_bayar DATE NOT NULL,
    lunas_cicil VARCHAR(5) NOT NULL,
    nominal INT NOT NULL,
    bukti_transaksi LONGBLOB NOT NULL
) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `pembukuan`(
    `id_pembukuan` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `id_pemilik` VARCHAR(25) NOT NULL,
    `id_pembayaran` INT NOT NULL,
    `tanggal_bayar` DATE NOT NULL,
    `lunas_cicil` VARCHAR(5) NOT NULL,
    `nominal` INT(15) NOT NULL,
    `keterangan` VARCHAR(50)
    ) ENGINE = INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE kos
ADD CONSTRAINT kos_1
FOREIGN KEY (id_pemilik)
REFERENCES pemilik_kos(id_pemilik), 
ADD CONSTRAINT kos_2
FOREIGN KEY (id_penyewa)
REFERENCES penyewa_kos(id_penyewa);

ALTER TABLE forum_kos
ADD CONSTRAINT forum_kos_1
FOREIGN KEY (id_kos)
REFERENCES kos(id_kos);

ALTER TABLE data_pembayaran
ADD CONSTRAINT data_pembayaran_1
FOREIGN KEY (id_pemilik)
REFERENCES pemilik_kos(id_pemilik),
ADD CONSTRAINT data_pembayaran_2
FOREIGN KEY (id_penyewa)
REFERENCES penyewa_kos(id_penyewa);

ALTER TABLE pembukuan
ADD CONSTRAINT pembukuan_1
FOREIGN KEY (id_pemilik)
REFERENCES pemilik_kos(id_pemilik),
ADD CONSTRAINT pembukuan_2
FOREIGN KEY (id_pembayaran)
REFERENCES data_pembayaran(id_pembayaran);

ALTER TABLE pemesanan
ADD CONSTRAINT pemesanan_1
FOREIGN KEY (id_penyewa)
REFERENCES penyewa_kos(id_penyewa),
ADD CONSTRAINT pemesanan_2
FOREIGN KEY (id_mitra)
REFERENCES mitra(id_mitra);