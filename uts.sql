-- uts.sql

CREATE DATABASE IF NOT EXISTS fraud_detection_db;
USE fraud_detection_db;

-- Hapus tabel lama dulu (tabel anak dulu, baru tabel induk)
DROP TABLE IF EXISTS hasil_evaluasi;
DROP TABLE IF EXISTS peringatan_fraud;
DROP TABLE IF EXISTS model_deteksi;
DROP TABLE IF EXISTS pengguna;

-- =====================================================
-- BAGIAN 1: Salinan database kelompok (script UTS)
-- =====================================================

-- Tabel pengguna
CREATE TABLE pengguna (
    id_pengguna INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    status_verifikasi ENUM('Terverifikasi', 'Belum Terverifikasi', 'Dibekukan')
        DEFAULT 'Belum Terverifikasi'
);

-- Tabel model_deteksi
CREATE TABLE model_deteksi (
    id_model INT AUTO_INCREMENT PRIMARY KEY,
    nama_algoritma VARCHAR(100) NOT NULL,
    pendekatan ENUM('Supervised', 'Unsupervised', 'Rule-based', 'Hybrid') NOT NULL,
    mode_pemrosesan ENUM('Real-time', 'Batch', 'Hybrid') NOT NULL
);

-- Tabel peringatan_fraud
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

-- =====================================================
-- BAGIAN 2: Tabel tambahan
-- =====================================================

-- Tabel hasil_evaluasi (menyimpan nilai penilaian tiap model)
CREATE TABLE hasil_evaluasi (
    id_model INT NOT NULL,
    nama_parameter VARCHAR(50) NOT NULL,
    nilai_parameter DECIMAL(8,4) NOT NULL,
    PRIMARY KEY (id_model, nama_parameter),
    CONSTRAINT chk_nilai_parameter CHECK (nilai_parameter >= 0),
    CONSTRAINT fk_evaluasi_model FOREIGN KEY (id_model)
        REFERENCES model_deteksi(id_model)
        ON DELETE CASCADE ON UPDATE CASCADE
);
