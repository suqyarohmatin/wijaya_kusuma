-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 13, 2024 at 04:41 PM
-- Server version: 10.4.32-MariaDB-log
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wijaya_kusuma`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_karyawan`
--

CREATE TABLE `tbl_karyawan` (
  `Id_karyawan` int(10) NOT NULL,
  `Nm_karyawan` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_karyawan`
--

INSERT INTO `tbl_karyawan` (`Id_karyawan`, `Nm_karyawan`) VALUES
(1, 'Satria yunan mubarok');

-- --------------------------------------------------------

--
-- Stand-in structure for view `tbl_keuntungan`
-- (See below for the actual view)
--
CREATE TABLE `tbl_keuntungan` (
`Tahun` int(4)
,`Bulan` int(2)
,`Jumlah_pendapatan` int(11)
,`Jumlah_pengeluaran` int(11)
,`Jumlah_keuntungan` bigint(12)
);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pemilik`
--

CREATE TABLE `tbl_pemilik` (
  `Id_pemilik` int(11) NOT NULL,
  `Nm_pemilik` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pendapatan`
--

CREATE TABLE `tbl_pendapatan` (
  `Id_pendapatan` int(11) NOT NULL,
  `Jml_pendapatan` int(11) DEFAULT NULL,
  `Id_karyawan` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_pendapatan`
--

INSERT INTO `tbl_pendapatan` (`Id_pendapatan`, `Jml_pendapatan`, `Id_karyawan`, `Tanggal`) VALUES
(1, 5000000, 1, '2024-12-12'),
(2, 4000000, 1, '2024-11-12'),
(3, 6000000, 1, '2024-10-09');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pengeluaran`
--

CREATE TABLE `tbl_pengeluaran` (
  `Id_pengeluaran` int(11) NOT NULL,
  `Jml_pengeluaran` int(11) DEFAULT NULL,
  `Id_karyawan` int(11) DEFAULT NULL,
  `Tanggal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_pengeluaran`
--

INSERT INTO `tbl_pengeluaran` (`Id_pengeluaran`, `Jml_pengeluaran`, `Id_karyawan`, `Tanggal`) VALUES
(1, 3000000, 1, '2024-12-12'),
(2, 2000000, 1, '2024-11-12'),
(3, 4500000, 1, '2024-10-11');

-- --------------------------------------------------------

--
-- Structure for view `tbl_keuntungan`
--
DROP TABLE IF EXISTS `tbl_keuntungan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tbl_keuntungan`  AS SELECT year(`tbl_pendapatan`.`Tanggal`) AS `Tahun`, month(`tbl_pendapatan`.`Tanggal`) AS `Bulan`, `tbl_pendapatan`.`Jml_pendapatan` AS `Jumlah_pendapatan`, `tbl_pengeluaran`.`Jml_pengeluaran` AS `Jumlah_pengeluaran`, `tbl_pendapatan`.`Jml_pendapatan`- `tbl_pengeluaran`.`Jml_pengeluaran` AS `Jumlah_keuntungan` FROM (`tbl_pendapatan` join `tbl_pengeluaran` on(year(`tbl_pendapatan`.`Tanggal`) = year(`tbl_pengeluaran`.`Tanggal`) and month(`tbl_pendapatan`.`Tanggal`) = month(`tbl_pengeluaran`.`Tanggal`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_karyawan`
--
ALTER TABLE `tbl_karyawan`
  ADD PRIMARY KEY (`Id_karyawan`);

--
-- Indexes for table `tbl_pemilik`
--
ALTER TABLE `tbl_pemilik`
  ADD PRIMARY KEY (`Id_pemilik`);

--
-- Indexes for table `tbl_pendapatan`
--
ALTER TABLE `tbl_pendapatan`
  ADD PRIMARY KEY (`Id_pendapatan`),
  ADD KEY `Id_karyawan` (`Id_karyawan`);

--
-- Indexes for table `tbl_pengeluaran`
--
ALTER TABLE `tbl_pengeluaran`
  ADD PRIMARY KEY (`Id_pengeluaran`),
  ADD KEY `Id_karyawan` (`Id_karyawan`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_pendapatan`
--
ALTER TABLE `tbl_pendapatan`
  ADD CONSTRAINT `tbl_pendapatan_ibfk_1` FOREIGN KEY (`Id_karyawan`) REFERENCES `tbl_karyawan` (`Id_karyawan`);

--
-- Constraints for table `tbl_pengeluaran`
--
ALTER TABLE `tbl_pengeluaran`
  ADD CONSTRAINT `tbl_pengeluaran_ibfk_1` FOREIGN KEY (`Id_karyawan`) REFERENCES `tbl_karyawan` (`Id_karyawan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
