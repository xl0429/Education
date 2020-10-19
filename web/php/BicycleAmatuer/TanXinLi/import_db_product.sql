-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 30, 2018 at 04:27 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `product`
--
DROP DATABASE IF EXISTS `product`;
CREATE DATABASE IF NOT EXISTS `product` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `product`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`username`, `hash`, `name`, `email`) VALUES
('admin1', '$2y$10$G7ubd3/TW8m6KZJQBfwHaOBEwQE1kKUSUs6hu5byD2LJVqUvR5G1O', 'Admin One', 'admin1@example.com'),
('admin2', '$2y$10$G7ubd3/TW8m6KZJQBfwHaOBEwQE1kKUSUs6hu5byD2LJVqUvR5G1O', 'Admin Two', 'admin2@example.com');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `photo` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`username`, `hash`, `name`, `email`, `phone`, `photo`) VALUES
('member1', '$2y$10$GwBL2fvaFaZSWy.IrW3yCOrt7KLv4/NM7YA5AVbRhJQ6o6iX.IZ5G', 'Member One', 'member1@example.com', '010-00000001', '5b86a73f95dde.jpg'),
('member2', '$2y$10$G7ubd3/TW8m6KZJQBfwHaOBEwQE1kKUSUs6hu5byD2LJVqUvR5G1O', 'Member Two', 'member2@example.com', '010-00000002', 'member2.jpg'),
('123123', '$2y$10$BQYy7jVFFMB9XjRoJWWtKeNspPrMrEiccSDDcGdSJaLHTY55Crqhq', '123123', 'tanxl-wm17@student.tarc.edu.my', '012-1231231', '5b8696ad7ccf4.jpg'),
('1231231', '$2y$10$g2z0tCjP4/y3PpyE9hfV7u3a0jk4Fsz9x1hN4pEPfejtOox.8yrd2', '123', 'tanxl-wm17@student.tarc.edu.my', '012-1231231', '5b86b7050de67.jpg'),
('12312312', '$2y$10$VoTyz1ldRnXaaAaQVUvQieExW9rPmp9w9/MAAU4EB2lZGeJgCgvuW', '123', 'tanxl-wm17@student.tarc.edu.my', '012-1231231', '5b86b710a1f6f.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `payment` decimal(8,2) NOT NULL,
  `card` char(16) COLLATE utf8_unicode_ci NOT NULL,
  `code` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `recipient` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `username`, `date`, `payment`, `card`, `code`, `recipient`, `address`) VALUES
(10001, 'member1', '2018-08-21', '1659.00', '1111111111111111', '111', '11111', '111111111'),
(10002, 'member1', '2018-08-29', '3318.00', '1111111111111111', '111', '1', '1'),
(10003, 'member1', '2018-08-29', '7116.00', '1111111111111111', '111', '111', '1111'),
(10004, '123123', '2018-08-29', '40611.00', '1111111111111111', '111', '11111111111111', '11111111'),
(10005, 'member1', '2018-08-30', '3798.00', '1222222221111111', '111', 'john', '12, jalan harmoni, taman damai');

-- --------------------------------------------------------

--
-- Table structure for table `orderline`
--

CREATE TABLE `orderline` (
  `order_id` int(11) NOT NULL,
  `prod_id` char(4) COLLATE utf8_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orderline`
--

INSERT INTO `orderline` (`order_id`, `prod_id`, `quantity`, `price`) VALUES
(10001, 'F103', 1, '1659.00'),
(10002, 'F103', 2, '1659.00'),
(10003, 'F102', 2, '1899.00'),
(10003, 'F103', 2, '1659.00'),
(10004, 'F101', 5, '6699.00'),
(10004, 'F102', 2, '1899.00'),
(10004, 'F103', 2, '1659.00'),
(10005, 'F102', 2, '1899.00');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `prod_id` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `prod_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `prod_type` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `imgs` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `weight` decimal(6,2) NOT NULL,
  `tires` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `brakes` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `rims` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `supplier_id` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`prod_id`, `prod_name`, `prod_type`, `price`, `description`, `imgs`, `weight`, `tires`, `brakes`, `rims`, `supplier_id`) VALUES
('F101', 'BIRDY FOLDING BIKES STANDARD 9 SPEED1', 'F', '5000.00', 'BIRDY Sora brings you all the flexibility, comfort and style that BIRDY bikes have became famous for. Thanks to its reliable Shimano 9-speed derailleur gearing it is very light and has a superb price-performance ratio. Quality Avid V brakes bring you to a stop when the time comes.\r\n\r\nHighlights:\r\n\r\nNew Birdy Monocoque Disc Brake Version\r\nNew Birdy spring suspension Disc Brake Version\r\nAvid BB-5R Disc Brake\r\nShimano Sora 9 speed\r\nFolded: 60cm(H) x 39cm(W) x 72cm(L)\r\nMaxxis BIRDY 18 x 1.5&quot;\r\n10.9kg\r\nMade in Taiwan', 'F101.jpg', '10.90', 'Maxxis BIRDY 18x1.5&quot; 90psi kevlar inside w/reflective sidewall', 'Avid BB-5R Disc Brake', 'Alex DA16 black anodized', 1),
('F102', 'Dahon BoardWalk D7', 'F', '1899.00', 'Model  : Dahon Boardwalk D7\r\nFrame: SuperLite 4130 Chromoly\r\nFork: Integrated, Patented Fusion Technology, Steel\r\nHandle Post: Radius, Adjustable with New QR Lever\r\nDrive Train: 7-speed Shimano Tourney\r\nWheels: 20? Aluminum Rims\r\nHub: Mini Aluminum Bearing Hub\r\nBrake: Alloy Powerful V-Brakes\r\nWeight: 12.3kg\r\nFolded size: 78ï¿½65ï¿½34cm', 'F102.jpg', '12.30', 'Promax V, aluminum', 'Kenda, Kwest 20&quot;ï¿½1.50, E/V / Black &amp; Ivory sidewall', 'Aluminum', 2),
('F103', 'Tern Link B7', 'F', '1659.00', 'Entry-level price with advanced Tern technology, Super-stiff Physisï¿½ 3D handlepost\r\nFolds in 10 secondsï¿½put it under your desk or take it on the subway\r\n20ï¿½ wheels make it easy to stop-and-go on busy streets\r\nWide Shimano 7-speed gearing for climbing hills and racing through the city\r\nInclude front / rear fenders\r\nFolded size: 39.5 x 80 x 73 cm\r\napprox. 12.8kg', 'F103.jpg', '12.80', 'Impac StreetPac, 47-406 / Kenda Kwest, 20 x 1.75&quot;', 'V, aluminum, linear spring', 'Aluminum', 1),
('F104', 'DAHON ROUTE AKIBO (JAPAN VERSION)', 'F', '1599.00', 'Model : Dahon Route Akibo (Japan version)\r\nFrame : Dalloy Sonus Aluminum\r\nFork : Integrated, patented Fusion technology, steel\r\nHandle post : Radius, adjustable, Inside folding, H:340-440mm, 8deg. / Silver\r\nDrive train : 7 Speed Shimano Tourney\r\nWheels : 20\" Aluminum Rims\r\nHub : Aluminum Bearing Hub\r\nBrake : Alloy Powerful V-Brakes\r\nWeight : 12.1kg\r\nFolded size : 89 x 64 x 34cm', 'F104.jpg', '12.10', 'Kenda, Kwest 20\" x 1.50, E/V', 'Promax V, aluminum', 'Aluminum', 2),
('F105', 'DAHON MU D10', 'F', '2499.00', 'DAHON\'s iconic Mu frame sits on 20\" wheels, driven by a perfectly balanced 10-speed Tiagra derailleur and wider tires. What more could you want? This clean combo can really go the distance, and feel more stable on any adventure.\r\n\r\nProduct highlights:\r\n\r\nDahon Aluminum (Dalloy) Sonus Tubeset\r\nForged Alloy Radius Telescope w/ Fusion Technology\r\nShimano Tiagra 10 Speed\r\nFolded Size: 66 x 32 x 82cm\r\nWeight: 12.1 kg (max.rider weight 105kg)', 'F105.jpg', '12.10', '20\"Aluminum Rims, Compact Front Hub and Standard Rear Hub. 28 Hole.', 'V-Brake WB-991Dalloy', 'Dalloy Sonus Tubeset with Lattice Forged Hinge and V-Clamp Technology', 2),
('F106', 'TERN ECLIPSE P18', 'F', '4999.00', 'Product Highlights:\r\n\r\nFrame: Aluminum, patented OCL Joint and DoubleTruss technology\r\nSRAM X7 18-speed drivetrain for maximum speed and versatility\r\nAdjustable VRO handlebar stem to fine tune your ride position\r\nHigh performance Kojak road tires\r\nWheel size: 24 inch\r\nFolds speed: 10s\r\nApprox. 12.8kg\r\nFolded size: 42 x 89 x 76 cm', 'F106.jpg', '12.80', 'Schwalbe Kojak, 40-507, 85 psi, RaceGuard puncture protection', 'Kinetix SpeedStop V-brakes, Ashima Direct noodle, stainless hardware', 'Eclipse, hydroformed 7005-Al, patented OCL Joint and DoubleTruss technology, Igus bearings', 3),
('F107', 'DAHON VYBE D7', 'F', '1799.00', 'Dahon Vybe D7 gets you moving, with a handy twist shifter and seven speeds of gear range. This crowd-pleasing folding bike promises convenience and true riding comfort, with all the compact folding features that today\'s busy people have come to expect. A better ride.\r\n\r\nProduct Highlights:\r\n\r\nAluminum Folding Frame\r\nAlloy Parts & Components\r\nShimano 7 Speed Gear System\r\nSmall, Lightweight & Compact Folding Size\r\n12.3kg approx.\r\nFolded Size: 67 X 34 x 72cm (26.4\" X 13.4\" x 28.4\")\r\nMY17', 'F107.jpg', '12.30', '20\" Aluminum Rims with 28 Hole Front and Rear Hubs', 'Winzip Smooth and Powerful 110mm V-Brakes', 'VYBE Dalloy Aluminum, Lattice Forged Hinge, w/ ViseGrip Technology', 2),
('F108', 'DAHON MU P9 (JAPAN VERSION)', 'F', '2799.00', 'Product Highlights:\r\n\r\nFrame : Dalloy Sonus Aluminum\r\nFork : Dalloy aluminum\r\nShimano Altus 9 Speed (1 x 9)\r\nWheel Size : 20\"\r\nFolding Size : W79 x H66 x D34cm\r\nRider height : 142-193cm\r\nWeight rider (max) : 105kg\r\nBike weight: 11.8kg', 'F108.jpg', '11.80', 'Kenda, Kwest 20\" x 1.50, F/ V', 'Dahon SpeedStop V brakes', 'Dahon SCHP406 / Hi-Polish Silver', 2),
('F109', 'DAHON VIGOR P9 (SILVER EDITION)', 'F', '3399.00', 'Product Highlights:\r\n\r\nHydroformed Dalloy Frame\r\nDalloy Aluminum, w/ Integrated Crown\r\n9 Speed SRAM\r\n20\" Aluminum Rims\r\nSealed Bearing Hub with QR\r\n11.7kg approx.\r\nFolded Size: 66 x 34 x 81cm\r\nMAX Rider Weight : 105kg\r\nColor : Silver Black\r\nMY17', 'F109.jpg', '11.70', '20\" Aluminum Rims with 20 Hole Front and 28 Hole', 'Winzip Smooth and Powerful 110mm V-Brakes', 'Hydroformed Dalloy with Lattice Forged Hinge and V-Clamp Technology', 2),
('F110', 'DAHON QIX D8', 'F', '2999.00', 'Qix D8 is a 20\" version with a larger seating position and riding range. Vertical folding technology allows the Qix D8 to roll directly into a folded position with the minimum of effort and time. A rear carrier with in-built guide wheel lets it roll easily along when folded.', 'F110.jpg', '11.80', 'Lightweight and Responsive Dalloy , w/ Integrated Crow', 'Smooth & Powerful V-Brakes', 'Flush Vertical Hinge Qix Arc using Dalloy Tubing, Forged BB Struts', 2),
('M111', 'CUBE ACID (SHIMANO XT/SLX 22S)', 'M', '4199.00', 'Product Highlights:\r\n\r\nAluminium Lite, AMF, Internal Cable Routing\r\nRock Shox Recon Silver TK AIR, Pop Loc, 100mm\r\nShimano SLX / XT 2 x 11 Speed\r\nShimano BR-M315, Hydr. Disc Brake (180/160)\r\n13.3kg approx.', 'M111.jpg', '13.30', 'Schwalbe Smart Sam, Active, 2.25', 'Shimano BR-M315, Hydr. Disc Brake (180/160)', 'Aluminium Lite, AMF, Internal Cable Routing, Easy Mount Kickstand Ready', 4),
('M112', '27.5 MTB CUBE RACE', 'M', '2199.00', 'Aluminum Superlite Frame (27.5 MTB)\r\nSr Suntour XCT Suspension Fork\r\nShimano Altus 27 Speed\r\nTektro Hydraulic Disc Brake System\r\nAlloy Double Wall Rims\r\n13.8kg approx.', 'M112.jpg', '13.80', 'Shimano Altus', 'Tektro Hydr. Disc Brake (160/160)', 'Cube Alex 24', 4),
('M113', 'XDS EYE 30', 'M', '1179.00', '-XDS 27.5 Tapered Aluminum frame x6\r\n-Tektro Hydraulic Disc Brake\r\n-Shimano Altus 27 speed\r\n-95% Aluminum/Alloy Parts & Components\r\n-Approx. 13.9kg (complete bike)\r\n-5-Year Warranty on Frame', 'M113.jpg', '13.90', 'Kenda 27.5×1.95', 'Tektro Hydraulic Disc-Brake', 'Alloy Double Wall rims', 5),
('M114', 'GIANT XTC JR 1 24', 'M', '1499.00', '-ALUXX-Grade Aluminum\r\n-HL Alloy, 50mm Travel, Alloy monocoque -Lower\r\n-Giant Kids 24″, 6061 Aluminum\r\n-Shimano Altus Tourney RS35 3*7 (21 speed)\r\n-Alloy Linear Pull\r\n-Junior MTB geometry\r\n-Age : 9 to 12 year old', 'M114.jpg', '11.20', 'Shimano Altus', 'Alloy V-Brakes', 'Giant Kids 24\", 6061 Aluminum, with CNC Braking Surface', 6),
('M115', 'GIANT ENCHANT 2 24', 'M', '1299.00', 'ALUXX Grade Aluminum\r\nHL Steel, 50mm Travel\r\nGiant Kids 24\", 6061 Aluminum\r\nShimano Tourney RS35 7s\r\nAlloy Linear Pull\r\nJunior MTB geometry\r\nAge:9 TO 12 year old', 'M115.jpg', '10.80', 'ALUXX-grade aluminium', 'Alloy V-Brakes', 'Giant Kids, Alloy, 24', 6),
('M116', 'KONA PRECEPT 27.5', 'M', '4529.00', '-Dual Suspn. Aluminum Frame\r\n-Shimano drivetrain w/ Deore Shadow RD\r\n-RockShox XC 30 120mm air sprung fork\r\n-Tektro HDC-290 hydraulic brakeset\r\n-WTB SX23 27.5 inch rims\r\n-U.S Brand | Made in Taiwan\r\n-Size: S (15.5 inch)', 'M116.jpg', '12.20', 'Maxxis Ardent 27.5x2.25\"', 'Tektro HDC-M290', 'WTB SX23', 7),
('M117', 'CUBE ANALOG 27.5', 'M', '3099.00', 'Product highlights:\r\n\r\n-Cube Superlight Aluminum Frame (smooth welding)\r\n-SR-Suntour XCR Lock out fork (Air Shock)\r\n-Shimano Deore / XT 30s\r\n-Shimano Hydraulic Brake System\r\n-Double Wall Alloy Wheelset 27.5\r\n-Frame size: 16 inch', 'M117.jpg', '13.20', 'Schwalbe MTB Tires 27.5x2.0', 'Shimano Hydraulic Discs', 'Alex Rims with double wall layer & eyelets', 4),
('M118', '27.5 MTB CUBE RACE', 'M', '2199.00', 'Aluminum Superlite Frame (27.5 MTB)\r\nSr Suntour XCT Suspension Fork\r\nShimano Altus 27 Speed\r\nTektro Hydraulic Disc Brake System\r\nAlloy Double Wall Rims\r\n13.8kg approx.', 'M118.jpg', '13.80', 'Kenda, 27.5x2.1', 'Tektro Hydraulic Brake', 'Cube Alex 24', 4),
('M119', '27.5 MTB CUBE AIM', 'M', '2399.00', 'Aluminum Superlite Frame\r\nSr Suntour XCM Lock Suspension Fork\r\nNEW Shimano Alivio 27 Speed\r\nShimano Hydraulic Disc Brake System\r\nAlloy Double Wall Rims\r\n13.8kg approx.', 'M119.jpg', '13.80', 'Kenda, 50-Fifty 27.5x2.1', 'Shimano Hydraulic Brake', 'Cube Alex 24', 4),
('M120', '29 KONA KAHUNA', 'M', '3999.00', 'Kona Race Light 7005/6061 Aluminum Butted frame\r\nShimano Deore Hydraulic Disc Brakes\r\nRockShox XC 32 TK 100mm Fork\r\nShimano Deore 30-speed drivetrain\r\nSmooth Weld Frame\r\nU.S Brand | Made in Taiwan\r\n13.5kg approx.\r\nFrame size: 17 inch', 'M120.jpg', '13.50', 'Maxxis Ikon 29x2.2\"', 'Shimano Deore', 'WTB SX19', 7),
('R121', 'CUBE AXIAL WLS DISC RACE', 'R', '4899.00', 'Aluminium 6061 T6 Superlight, Double Butted, Smooth Welded, Road Comfort Geometry\r\nCUBE CSL Race Disc, One Piece 3D-Forged Steerer/Crown, Carbon Blades\r\nInternal Cable Routing\r\nShimano Tiagra 10s (2 x 10 ) Components\r\nCUBE RA 0.8 Aero Disc, 12x100mm / 12x142mm, 6-Bolt\r\n10.3kg approx.', 'R121.jpg', '10.30', 'Conti Ultra Sport 2', 'Shimano ST-RS405', 'Aluminium', 4),
('R122', 'KONA SUTRA TOURING BIKE', 'R', '4439.00', 'Kona Cromoly Butted Frame\r\nProject two disc fork\r\nShimano Deore / Alivio 9 speed\r\nClement Xplor’r MSO 700x40c\r\nBrooks England B17 Leather Seat\r\nMade in Taiwan', 'R122.jpg', '12.30', 'Clement Xplor\'r MSO 700x40c', 'Hayes CX Expert', 'WTB SX19', 7),
('R123', 'KONA CX JAKE THE SNAKE', 'R', '4999.00', '-Superlite Aluminum Frame\r\n-Full Carbon Race Fork\r\n-Shimano 105 11-speed drivetrain\r\n-Hayes CX Expert disc brakes with L-Series rotors\r\n-Alex CXD6 wheelset\r\n-Challenge Grifo comp tires\r\n-Well smooth Frame Finishing\r\n-U.S Brand | Made in Taiwan\r\n-Size (seat tube): 49cm (equivalent 52cm top tube)', 'R123.jpg', '13.00', 'Shimano 105 11-28t 11spd', 'Alex CXD6 Wheelset', 'Hayes CX Expert', 7),
('R124', 'TRINX TEMPO 1.0', 'R', '939.00', 'NEW! Trinx Aluminum Frame\r\nShimano Tourney 2*7 speed\r\nAlloy Caliper Brakes\r\nDouble Wall Alloy Rims\r\n11kg approx.\r\nFrame size: 480mm (seat tube)', 'R124.jpg', '11.00', 'CST 700x25c', 'Winzip Alloy Brake Caliper', 'Double Wall Alloy Rims 36h', 8),
('R125', 'KONA CYCLOCROSS – JAKE', 'R', '3699.00', '-Kona 6061 Aluminum Butted\r\n-Kona Project 2 Aluminum Fork\r\n-Crank: FSA Omega Complex\r\n-Shimano Tiagra 10s\r\n-Hayes CX Comp Disc Brakes\r\n-Made in Taiwan', 'R125.jpg', '12.00', 'Shimano Tiagra', 'Shimano Tiagra', 'Shimano Tiagra 11-34t 10spd', 7);

-- --------------------------------------------------------

--
-- Stand-in structure for view `prod_supplier`
-- (See below for the actual view)
--
CREATE TABLE `prod_supplier` (
`prod_id` varchar(4)
,`prod_name` varchar(50)
,`prod_type` char(1)
,`price` decimal(7,2)
,`description` text
,`imgs` varchar(255)
,`weight` decimal(6,2)
,`tires` varchar(100)
,`brakes` varchar(100)
,`rims` varchar(100)
,`supplier_id` int(5)
,`supplier_name` varchar(100)
,`supplier_desc` text
,`origin` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `prod_type`
--

CREATE TABLE `prod_type` (
  `prod_code` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `type_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `prod_type`
--

INSERT INTO `prod_type` (`prod_code`, `type_name`) VALUES
('F', 'Folding Bike'),
('M', 'Mountain Bike'),
('R', 'Road Bike');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplier_id` int(5) NOT NULL,
  `supplier_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `supplier_desc` text COLLATE utf8_unicode_ci NOT NULL,
  `origin` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplier_id`, `supplier_name`, `supplier_desc`, `origin`) VALUES
(1, 'Birdy Folding Bikes Malaysia', 'Birdy is a lifestyle. An attitude. An ideal adventure companion for leisure &amp; day to day working. Small enough to fit almost anywhere you go, but it certainly will fit in any car boot and any form of public transport.\r\n\r\nWhen opened out, it deliver a rider experience just like any full size bikes. The full suspension surpasses even its riding safety and comfort. Regular bikes had better watch out. It is still the foldable to beat in terms of looks, comfort and performance.\r\n\r\nBirdy designed by Riese und Mï¿½ller (Germany) / Manufactured by Pacific Cycles (Taiwan Bicycle Manufacturer)', 'Taiwan'),
(2, 'Dahon Folding Bikes Malaysia', 'Dahon started the revolution of their day with the worlds first folding bicycle small enough to fit under a train seat. 220+ patents and 30 years of quiet evolution and genius technologies later, Dahon is the leader in folding bike technology. Changing the way people around the world get from \"A\" to \"B\".', 'Japan'),
(3, 'Tern Bikes Malaysia', 'Tern Bikes (Malaysia), We\'re developing a sustainable future based on a fundamental philosophy that the bicycle , the ultimate high-efficiency folding bicycle, is core to that goal. Every path we pursue can be traced to this single, simple basis.\r\n\r\nPRODUCT PHILOSOPHY\r\nWe construct Tern folding bikes with an aim to changing the world. Or at least the way that people get around. Our folding bikes bring together all the things people need to drive less and ride more.\r\n\r\nOUR NAME\r\nWe picked our company after a small, lightweight bird that mates for life and holds the world record for the longest migration.', 'US'),
(4, 'CUBE Bikes Malaysia', 'CUBE is a German bicycle manufacturer that produces many types of bike from mtb, road bikes, hybrid bikes, electronic bike. The company was founded 1993. Today the company has expanded its production area to 20,000 m sq and sells to more than 34 countries in Europe and Asia.', 'Germany'),
(5, 'XDS Bikes Malaysia', 'Founded in 1995, XDS Shenzhen Xidesheng Bicycles Co., LTD is a bicycle enterprise that specializes in the integration of development, manufacturing, sales and services. Over the last 18 years of development, XDS has already become the top bicycle brand in China, and over 2000 stores across the country as well as exporting over 50 countries include Malaysia.', 'Australia'),
(6, 'Giant Bikes Malaysia', 'WELCOME TO THE ULTIMATE CYCLING EXPERIENCE.\r\n\r\nHow do you define the ultimate cycling experience? That\'s up to you. Giant team mission is to help make it happen. To create the ultimate cycling experience for all riders, all around the world.\r\n\r\nGiant Bikes is builders and innovators, but they are also a global community of cyclists. They are athletes, adventurers and advocates for cycling. They are Tour de France racers, single-track explorers, neighbors and friends.\r\n\r\nIt\'s true that Giant Bikes is the world\'s largest producer of high-quality bikes, but they never forget where we came from. They started small. And they were founded on the idea that the best way to inspire passion for cycling is to create the best products, and make them accessible to all riders.\r\n\r\nMuch has changed since we started in 1972. In fact, Giant Bikes has long been one of cycling\'s main catalysts for change. We introduced lighter, stronger aluminum frames at a time when the industry standard was steel. We were first to make carbon fiber bikes widely available to the world. We defined the look and feel of modern road racing bikes with our Compact Road technology. And we revolutionized off-road performance bikes with Maestro Suspension.\r\n\r\nToday, this spirit of innovation is stronger than ever. Giant collection of gear and apparel, developed and tested by some of the top teams and athletes in pro racing, continues to expand. Our industry-leading E-bikes are redefining what\'s possible for riders of all abilities.', 'Taiwan'),
(7, 'KONA Bikes Malaysia', 'Kona Bikes established in 1988 based in the pacific of Canada, Kona has gone on to develop a complete range of road, commuter, cyclocross in addition to a complete range of mountain bikes. Using a range of materials including Carbon Fiber, Titanium, Aluminum and Steel, Kona\'s bikes are sold in over 60 countries worldwide.', 'Ferndale'),
(8, 'Trinx Bikes Malaysia', 'Founded in 1992, Trinx successfully established foundations of research and development in Chinese mainland, SEA, Russia. Trinx’s bikes have the superior quality, fashionable design and excellent performance and enjoy great popularity in the west, Southeast Asia, the Middle East and Africa so on.', 'Taiwan');

-- --------------------------------------------------------

--
-- Stand-in structure for view `user`
-- (See below for the actual view)
--
CREATE TABLE `user` (
`username` varchar(20)
,`hash` varchar(255)
,`name` varchar(100)
,`email` varchar(100)
,`role` varchar(6)
);

-- --------------------------------------------------------

--
-- Structure for view `prod_supplier`
--
DROP TABLE IF EXISTS `prod_supplier`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `prod_supplier`  AS  select `p`.`prod_id` AS `prod_id`,`p`.`prod_name` AS `prod_name`,`p`.`prod_type` AS `prod_type`,`p`.`price` AS `price`,`p`.`description` AS `description`,`p`.`imgs` AS `imgs`,`p`.`weight` AS `weight`,`p`.`tires` AS `tires`,`p`.`brakes` AS `brakes`,`p`.`rims` AS `rims`,`p`.`supplier_id` AS `supplier_id`,`s`.`supplier_name` AS `supplier_name`,`s`.`supplier_desc` AS `supplier_desc`,`s`.`origin` AS `origin` from (`product` `p` join `supplier` `s`) where (`p`.`supplier_id` = `s`.`supplier_id`) ;

-- --------------------------------------------------------

--
-- Structure for view `user`
--
DROP TABLE IF EXISTS `user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user`  AS  select `admin`.`username` AS `username`,`admin`.`hash` AS `hash`,`admin`.`name` AS `name`,`admin`.`email` AS `email`,'admin' AS `role` from `admin` union select `member`.`username` AS `username`,`member`.`hash` AS `hash`,`member`.`name` AS `name`,`member`.`email` AS `email`,'member' AS `role` from `member` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orderline`
--
ALTER TABLE `orderline`
  ADD PRIMARY KEY (`order_id`,`prod_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`prod_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10006;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
