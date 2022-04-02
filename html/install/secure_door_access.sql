-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 02, 2022 at 12:57 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `secure_door_access`
--

-- --------------------------------------------------------

--
-- Table structure for table `access_list`
--

CREATE TABLE `access_list` (
  `access_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `door_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  `is_approved` int(1) NOT NULL,
  `accessed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `api_keys`
--

CREATE TABLE `api_keys` (
  `api_key_id` int(11) NOT NULL,
  `api_key` varchar(1000) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(1) NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `asset_id` int(11) NOT NULL,
  `asset_tag` varchar(100) NOT NULL,
  `asset_info` varchar(500) NOT NULL,
  `is_active` int(1) NOT NULL,
  `asset_token` varchar(1000) NOT NULL,
  `token_created_at` datetime DEFAULT NULL,
  `door_id` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `card_id` int(11) NOT NULL,
  `uid` varchar(50) NOT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `is_active` int(1) NOT NULL DEFAULT 1,
  `expires_at` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `card_to_door`
--

CREATE TABLE `card_to_door` (
  `card_to_door_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `door_id` int(11) NOT NULL,
  `is_allowed` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `card_to_level`
--

CREATE TABLE `card_to_level` (
  `card_to_level_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `level_id` int(11) NOT NULL,
  `is_allowed` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `doors`
--

CREATE TABLE `doors` (
  `door_id` int(11) NOT NULL,
  `door_identifier` varchar(100) NOT NULL,
  `door_access_level_id` int(11) NOT NULL,
  `is_active` int(1) NOT NULL DEFAULT 1,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `levels`
--

CREATE TABLE `levels` (
  `level_id` int(11) NOT NULL,
  `level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `log_id` int(11) NOT NULL,
  `log_category` varchar(200) NOT NULL,
  `message` varchar(5000) NOT NULL,
  `severity` int(1) DEFAULT NULL,
  `logged_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_notified` int(1) NOT NULL DEFAULT 0,
  `has_investigated` int(11) NOT NULL DEFAULT 0,
  `investigated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `request_id` int(11) NOT NULL,
  `request_header` varchar(1000) NOT NULL,
  `request_body` varchar(5000) NOT NULL,
  `request_time` datetime NOT NULL DEFAULT current_timestamp(),
  `response` mediumtext NOT NULL,
  `response_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(75) NOT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `password` varchar(500) DEFAULT NULL,
  `user_access_level_id` int(11) DEFAULT NULL,
  `allow_global_level_access` int(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(50) NOT NULL DEFAULT '2',
  `is_active` int(1) NOT NULL DEFAULT 0,
  `employee_id` varchar(30) DEFAULT NULL,
  `comments` varchar(5000) DEFAULT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `access_list`
--
ALTER TABLE `access_list`
  ADD PRIMARY KEY (`access_id`),
  ADD KEY `asset_id` (`asset_id`),
  ADD KEY `card_id` (`card_id`),
  ADD KEY `door_id` (`door_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD PRIMARY KEY (`api_key_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`asset_id`),
  ADD KEY `door_id` (`door_id`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`card_id`),
  ADD KEY `assigned_to` (`assigned_to`),
  ADD KEY `modified_by` (`modified_by`);

--
-- Indexes for table `card_to_door`
--
ALTER TABLE `card_to_door`
  ADD PRIMARY KEY (`card_to_door_id`),
  ADD KEY `card_id` (`card_id`),
  ADD KEY `door_id` (`door_id`);

--
-- Indexes for table `card_to_level`
--
ALTER TABLE `card_to_level`
  ADD PRIMARY KEY (`card_to_level_id`),
  ADD KEY `card_id` (`card_id`),
  ADD KEY `level_id` (`level_id`);

--
-- Indexes for table `doors`
--
ALTER TABLE `doors`
  ADD PRIMARY KEY (`door_id`),
  ADD KEY `door_access_level_id` (`door_access_level_id`);

--
-- Indexes for table `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`level_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`request_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_access_level_id` (`user_access_level_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `access_list`
--
ALTER TABLE `access_list`
  MODIFY `access_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_keys`
--
ALTER TABLE `api_keys`
  MODIFY `api_key_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `asset_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `card_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `card_to_door`
--
ALTER TABLE `card_to_door`
  MODIFY `card_to_door_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `card_to_level`
--
ALTER TABLE `card_to_level`
  MODIFY `card_to_level_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doors`
--
ALTER TABLE `doors`
  MODIFY `door_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `levels`
--
ALTER TABLE `levels`
  MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `access_list`
--
ALTER TABLE `access_list`
  ADD CONSTRAINT `access_list_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  ADD CONSTRAINT `access_list_ibfk_3` FOREIGN KEY (`card_id`) REFERENCES `cards` (`card_id`),
  ADD CONSTRAINT `access_list_ibfk_4` FOREIGN KEY (`door_id`) REFERENCES `doors` (`door_id`),
  ADD CONSTRAINT `access_list_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD CONSTRAINT `api_keys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `assets`
--
ALTER TABLE `assets`
  ADD CONSTRAINT `assets_ibfk_1` FOREIGN KEY (`door_id`) REFERENCES `doors` (`door_id`);

--
-- Constraints for table `card_to_door`
--
ALTER TABLE `card_to_door`
  ADD CONSTRAINT `card_to_door_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `cards` (`card_id`),
  ADD CONSTRAINT `card_to_door_ibfk_2` FOREIGN KEY (`door_id`) REFERENCES `doors` (`door_id`);

--
-- Constraints for table `card_to_level`
--
ALTER TABLE `card_to_level`
  ADD CONSTRAINT `card_to_level_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `cards` (`card_id`),
  ADD CONSTRAINT `card_to_level_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `levels` (`level_id`);

--
-- Constraints for table `doors`
--
ALTER TABLE `doors`
  ADD CONSTRAINT `doors_ibfk_1` FOREIGN KEY (`door_access_level_id`) REFERENCES `levels` (`level_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
