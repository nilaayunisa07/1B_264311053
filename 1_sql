CREATE DATABASE IF NOT EXISTS fraud_detection_db;
USE fraud_detection_db;

-- Hapus tabel lama (urutan: anak terlebih dahulu, baru induk)
DROP TABLE IF EXISTS peringatan_fraud;
DROP TABLE IF EXISTS model_deteksi;
DROP TABLE IF EXISTS pengguna;

-- 1. Tabel Induk 1: pengguna
CREATE TABLE pengguna (
    id_pengguna INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    status_verifikasi ENUM('Terverifikasi', 'Belum Terverifikasi', 'Dibekukan')
        DEFAULT 'Belum Terverifikasi'
);

-- 2. Tabel Induk 2: model_deteksi
CREATE TABLE model_deteksi (
    id_model INT AUTO_INCREMENT PRIMARY KEY,
    nama_algoritma VARCHAR(100) NOT NULL,
    pendekatan ENUM('Supervised', 'Unsupervised', 'Rule-based', 'Hybrid') NOT NULL,
    mode_pemrosesan ENUM('Real-time', 'Batch', 'Hybrid') NOT NULL
);

-- 3. Tabel Transaksi/Anak: peringatan_fraud
CREATE TABLE peringatan_fraud (
    id_peringatan INT AUTO_INCREMENT PRIMARY KEY,
    id_model INT NOT NULL,
    id_pengguna INT NOT NULL,
    waktu_deteksi DATETIME NOT NULL,
    skor_fraud DECIMAL(5,2) NOT NULL,
    status_peringatan ENUM('Baru', 'Sedang Ditinjau', 'Selesai') DEFAULT 'Baru',
    CONSTRAINT fk_peringatan_model FOREIGN KEY (id_model)
        REFERENCES model_deteksi(id_model)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_peringatan_pengguna FOREIGN KEY (id_pengguna)
        REFERENCES pengguna(id_pengguna)
        ON DELETE CASCADE ON UPDATE CASCADE
);
