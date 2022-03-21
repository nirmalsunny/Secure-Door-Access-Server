-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 21, 2022 at 01:51 AM
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
  `accessed_at` timestamp NOT NULL DEFAULT current_timestamp()
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

--
-- Dumping data for table `api_keys`
--

INSERT INTO `api_keys` (`api_key_id`, `api_key`, `user_id`, `is_active`, `expires_at`) VALUES
(2, 'cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df', 1, 0, '2022-03-21 19:24:57'),
(3, '9f298c84e4b56288fbf4182db63bc58cc49e4ce9fa2f8fd01e4a4b23e58aa16f330f867ead485fbbcb1baf7fb1243e857b30c88897c2705cd13c2d4b554e65c6', 1, 0, '2022-03-21 22:19:18'),
(4, '999294a16ec2805526b63aa5b9e43ae404a674170304bcd3deea8830b3278e6590cd99576fa2a5f904144775183b88718061d1a9266a0702d96ef046d528cb4b', 1, 0, '2022-03-21 22:19:21'),
(5, '788d592f47b7a4d1d0337ba929de659e9caa52e2cff5f1842c38d186814ae40e983a22da3a19fde327662e4672569c8accb98aeb3a09298e9dd27dbf6d66d6a7', 1, 1, '2022-03-21 22:19:59');

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `asset_id` int(11) NOT NULL,
  `asset_tag` varchar(100) NOT NULL,
  `asset_info` varchar(500) NOT NULL,
  `is_active` int(1) NOT NULL,
  `asset_encryption_key` varchar(1000) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`asset_id`, `asset_tag`, `asset_info`, `is_active`, `asset_encryption_key`, `modified_by`, `modified_at`) VALUES
(1, 'ESP8266-A1', 'The scanner hardware for Door A1', 1, 'klhaekfns ljfhaifas kasbhfiapnksf kawpg;asnklh', 3, '2022-03-20 11:13:42'),
(2, 'ESP8266-A2', 'The scanner hardware for Door A2', 1, 'bzv zdjbvjz vzdzdjn jshgioadsnvladhgad vaghak', 3, '2022-03-20 11:13:42');

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `card_id` int(11) NOT NULL,
  `uid` varchar(50) NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `is_active` int(1) NOT NULL,
  `expires_at` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`card_id`, `uid`, `assigned_to`, `is_active`, `expires_at`, `modified_by`, `modified_at`) VALUES
(1, 'FA 45 GT 6Y H7', 1, 1, '2023-03-14 11:06:42', 3, '2022-03-20 11:07:44');

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

--
-- Dumping data for table `card_to_door`
--

INSERT INTO `card_to_door` (`card_to_door_id`, `card_id`, `door_id`, `is_allowed`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `doors`
--

CREATE TABLE `doors` (
  `door_id` int(11) NOT NULL,
  `door_identifier` varchar(100) NOT NULL,
  `door_access_level_id` int(11) NOT NULL,
  `is_active` int(1) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doors`
--

INSERT INTO `doors` (`door_id`, `door_identifier`, `door_access_level_id`, `is_active`, `modified_at`) VALUES
(1, 'A1', 1, 1, '2022-03-20 11:08:53'),
(2, 'A2', 1, 0, '2022-03-20 11:08:53');

-- --------------------------------------------------------

--
-- Table structure for table `levels`
--

CREATE TABLE `levels` (
  `level_id` int(11) NOT NULL,
  `level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `levels`
--

INSERT INTO `levels` (`level_id`, `level`) VALUES
(1, 'Level 1'),
(2, 'Level 2');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `log_id` int(11) NOT NULL,
  `log_category` varchar(200) NOT NULL,
  `message` varchar(5000) NOT NULL,
  `severity` int(1) NOT NULL,
  `logged_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_notified` int(1) NOT NULL DEFAULT 0,
  `has_investigated` int(11) NOT NULL DEFAULT 0,
  `investigated_at` datetime NOT NULL
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

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`request_id`, `request_header`, `request_body`, `request_time`, `response`, `response_time`) VALUES
(1, '{\"Host\":\"localhost\",\"Connection\":\"keep-alive\",\"Cache-Control\":\"max-age=0\",\"sec-ch-ua\":\"\\\" Not A;Brand\\\";v=\\\"99\\\", \\\"Chromium\\\";v=\\\"99\\\", \\\"Microsoft Edge\\\";v=\\\"99\\\"\",\"sec-ch-ua-mobile\":\"?0\",\"sec-ch-ua-platform\":\"\\\"Windows\\\"\",\"Upgrade-Insecure-Requests\":\"1\",\"User-Agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/99.0.4844.74 Safari\\/537.36 Edg\\/99.0.1150.46\",\"Accept\":\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.9\",\"Sec-Fetch-Site\":\"none\",\"Sec-Fetch-Mode\":\"navigate\",\"Sec-Fetch-User\":\"?1\",\"Sec-Fetch-Dest\":\"document\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Accept-Language\":\"en-GB,en;q=0.9,en-US;q=0.8\",\"Cookie\":\"remember_web_59ba36addc2b2f9401580f014c7f58ea4e30989d=eyJpdiI6IkNPaEpzQ0I1dDdzeERBdUpsbzVzYmc9PSIsInZhbHVlIjoiTzl6d2hURkp0YTFNQjlYcHZ4ejZ1WTRYOXNaaklnTkp4bzVhTkpWMEtMT3JPZGoyRkt4aDJ4SmlFRTZ0OE1JVytNamZ6YjA2bElwN05ZOVVYWDZyUVRkWTMrWm9saVhpR0xhc2ZKTnFrS', '{\"route\":\"api\\/doors\\/all\",\"page\":\"2\",\"page_limit\":\"1\"}', '2022-03-20 12:26:32', '', '0000-00-00 00:00:00'),
(2, '{\"Host\":\"localhost\",\"Connection\":\"keep-alive\",\"Cache-Control\":\"max-age=0\",\"sec-ch-ua\":\"\\\" Not A;Brand\\\";v=\\\"99\\\", \\\"Chromium\\\";v=\\\"99\\\", \\\"Microsoft Edge\\\";v=\\\"99\\\"\",\"sec-ch-ua-mobile\":\"?0\",\"sec-ch-ua-platform\":\"\\\"Windows\\\"\",\"Upgrade-Insecure-Requests\":\"1\",\"User-Agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/99.0.4844.74 Safari\\/537.36 Edg\\/99.0.1150.46\",\"Accept\":\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.9\",\"Sec-Fetch-Site\":\"none\",\"Sec-Fetch-Mode\":\"navigate\",\"Sec-Fetch-User\":\"?1\",\"Sec-Fetch-Dest\":\"document\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Accept-Language\":\"en-GB,en;q=0.9,en-US;q=0.8\",\"Cookie\":\"remember_web_59ba36addc2b2f9401580f014c7f58ea4e30989d=eyJpdiI6IkNPaEpzQ0I1dDdzeERBdUpsbzVzYmc9PSIsInZhbHVlIjoiTzl6d2hURkp0YTFNQjlYcHZ4ejZ1WTRYOXNaaklnTkp4bzVhTkpWMEtMT3JPZGoyRkt4aDJ4SmlFRTZ0OE1JVytNamZ6YjA2bElwN05ZOVVYWDZyUVRkWTMrWm9saVhpR0xhc2ZKTnFrS', '{\"route\":\"api\\/doors\\/all\",\"page\":\"3\",\"page_limit\":\"1\"}', '2022-03-20 12:36:23', '{\"status_code\":401,\"body\":{\"error\":\"unauthorized\"}}', '2022-03-20 12:36:23'),
(3, '{\"Host\":\"localhost\",\"Connection\":\"keep-alive\",\"Cache-Control\":\"max-age=0\",\"sec-ch-ua\":\"\\\" Not A;Brand\\\";v=\\\"99\\\", \\\"Chromium\\\";v=\\\"99\\\", \\\"Microsoft Edge\\\";v=\\\"99\\\"\",\"sec-ch-ua-mobile\":\"?0\",\"sec-ch-ua-platform\":\"\\\"Windows\\\"\",\"Upgrade-Insecure-Requests\":\"1\",\"User-Agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/99.0.4844.74 Safari\\/537.36 Edg\\/99.0.1150.46\",\"Accept\":\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.9\",\"Sec-Fetch-Site\":\"none\",\"Sec-Fetch-Mode\":\"navigate\",\"Sec-Fetch-User\":\"?1\",\"Sec-Fetch-Dest\":\"document\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Accept-Language\":\"en-GB,en;q=0.9,en-US;q=0.8\",\"Cookie\":\"remember_web_59ba36addc2b2f9401580f014c7f58ea4e30989d=eyJpdiI6IkNPaEpzQ0I1dDdzeERBdUpsbzVzYmc9PSIsInZhbHVlIjoiTzl6d2hURkp0YTFNQjlYcHZ4ejZ1WTRYOXNaaklnTkp4bzVhTkpWMEtMT3JPZGoyRkt4aDJ4SmlFRTZ0OE1JVytNamZ6YjA2bElwN05ZOVVYWDZyUVRkWTMrWm9saVhpR0xhc2ZKTnFrS', '{\"route\":\"api\\/doors\\/all\",\"page\":\"1\",\"page_limit\":\"1\"}', '2022-03-20 19:45:31', '{\"status_code\":401,\"body\":{\"error\":\"unauthorized\"}}', '2022-03-20 19:45:31'),
(4, '{\"x-authorization-token\":\"cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df\",\"User-Agent\":\"PostmanRuntime\\/7.29.0\",\"Accept\":\"*\\/*\",\"Postman-Token\":\"229769ec-decc-4514-9eed-65523c6832df\",\"Host\":\"localhost\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Connection\":\"keep-alive\"}', '{\"route\":\"api\\/doors\\/all\",\"page\":\"1\",\"page_limit\":\"1\"}', '2022-03-20 19:56:37', '{\"status_code\":401,\"body\":{\"error\":\"unauthorized\"}}', '2022-03-20 19:56:37'),
(5, '{\"x-authorization-token\":\"cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df\",\"User-Agent\":\"PostmanRuntime\\/7.29.0\",\"Accept\":\"*\\/*\",\"Postman-Token\":\"d9223489-aa3f-48fc-914c-88481a2bcf49\",\"Host\":\"localhost\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Connection\":\"keep-alive\"}', '{\"route\":\"api\\/doors\\/all\",\"page\":\"1\",\"page_limit\":\"1\"}', '2022-03-20 20:25:39', '', '0000-00-00 00:00:00'),
(6, '{\"x-authorization-token\":\"cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df\",\"User-Agent\":\"PostmanRuntime\\/7.29.0\",\"Accept\":\"*\\/*\",\"Postman-Token\":\"e90904c0-3c53-4612-b74b-ae8207970a55\",\"Host\":\"localhost\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Connection\":\"keep-alive\"}', '{\"route\":\"api\\/doors\\/all\",\"page\":\"1\",\"page_limit\":\"1\"}', '2022-03-20 21:17:50', '', '0000-00-00 00:00:00'),
(7, '{\"x-authorization-token\":\"cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df\",\"User-Agent\":\"PostmanRuntime\\/7.29.0\",\"Accept\":\"*\\/*\",\"Postman-Token\":\"eca56a50-b29a-476b-b7b0-278e28272d4a\",\"Host\":\"localhost\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Connection\":\"keep-alive\"}', '{\"route\":\"api\\/doors\\/all\"}', '2022-03-20 22:08:21', '', '0000-00-00 00:00:00'),
(8, '{\"x-authorization-token\":\"cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df\",\"User-Agent\":\"PostmanRuntime\\/7.29.0\",\"Accept\":\"*\\/*\",\"Postman-Token\":\"df48f4e6-bd6f-4412-a86f-5987e0fd0652\",\"Host\":\"localhost\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Connection\":\"keep-alive\"}', '{\"route\":\"api\\/doors\\/all\"}', '2022-03-20 22:08:26', '', '0000-00-00 00:00:00'),
(9, '{\"x-authorization-token\":\"cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df\",\"User-Agent\":\"PostmanRuntime\\/7.29.0\",\"Accept\":\"*\\/*\",\"Postman-Token\":\"a53fc9dd-fa3e-4126-a290-f478ce03e477\",\"Host\":\"localhost\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Connection\":\"keep-alive\"}', '{\"route\":\"api\\/doors\\/all\\/aaa\"}', '2022-03-20 22:08:35', '', '0000-00-00 00:00:00'),
(10, '{\"x-authorization-token\":\"cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df\",\"User-Agent\":\"PostmanRuntime\\/7.29.0\",\"Accept\":\"*\\/*\",\"Postman-Token\":\"8a187601-7f51-4a71-ac7b-559f8e905457\",\"Host\":\"localhost\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Connection\":\"keep-alive\"}', '{\"route\":\"api\\/doors\\/all\\/aaa\"}', '2022-03-20 22:10:03', '', '0000-00-00 00:00:00'),
(11, '{\"x-authorization-token\":\"cb239b95b74f93662349b2920cfb80e3fd5dc64a88740a66c3d357f39b0fdf73293bd7d2c0cd560fd77acb267bf417011da73b71a4e1908c9697b9f35d9a78df\",\"User-Agent\":\"PostmanRuntime\\/7.29.0\",\"Accept\":\"*\\/*\",\"Postman-Token\":\"38b5893a-8e90-4548-a7d3-123c9da85882\",\"Host\":\"localhost\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Connection\":\"keep-alive\"}', '{\"route\":\"api\\/doors\\/all\\/aaa\"}', '2022-03-20 22:10:50', '', '0000-00-00 00:00:00'),
(12, '{\"Host\":\"localhost\",\"Connection\":\"keep-alive\",\"Cache-Control\":\"max-age=0\",\"sec-ch-ua\":\"\\\" Not A;Brand\\\";v=\\\"99\\\", \\\"Chromium\\\";v=\\\"99\\\", \\\"Microsoft Edge\\\";v=\\\"99\\\"\",\"sec-ch-ua-mobile\":\"?0\",\"sec-ch-ua-platform\":\"\\\"Windows\\\"\",\"Upgrade-Insecure-Requests\":\"1\",\"User-Agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/99.0.4844.74 Safari\\/537.36 Edg\\/99.0.1150.46\",\"Accept\":\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.9\",\"Sec-Fetch-Site\":\"none\",\"Sec-Fetch-Mode\":\"navigate\",\"Sec-Fetch-User\":\"?1\",\"Sec-Fetch-Dest\":\"document\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Accept-Language\":\"en-GB,en;q=0.9,en-US;q=0.8\",\"Cookie\":\"remember_web_59ba36addc2b2f9401580f014c7f58ea4e30989d=eyJpdiI6IkNPaEpzQ0I1dDdzeERBdUpsbzVzYmc9PSIsInZhbHVlIjoiTzl6d2hURkp0YTFNQjlYcHZ4ejZ1WTRYOXNaaklnTkp4bzVhTkpWMEtMT3JPZGoyRkt4aDJ4SmlFRTZ0OE1JVytNamZ6YjA2bElwN05ZOVVYWDZyUVRkWTMrWm9saVhpR0xhc2ZKTnFrS', '{\"route\":\"api\\/doors\\/all\"}', '2022-03-20 23:50:06', '{\"status_code\":401,\"body\":{\"error\":\"unauthorized\"}}', '2022-03-20 23:50:06'),
(13, '{\"Host\":\"localhost\",\"Connection\":\"keep-alive\",\"Cache-Control\":\"max-age=0\",\"sec-ch-ua\":\"\\\" Not A;Brand\\\";v=\\\"99\\\", \\\"Chromium\\\";v=\\\"99\\\", \\\"Microsoft Edge\\\";v=\\\"99\\\"\",\"sec-ch-ua-mobile\":\"?0\",\"sec-ch-ua-platform\":\"\\\"Windows\\\"\",\"Upgrade-Insecure-Requests\":\"1\",\"User-Agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/99.0.4844.74 Safari\\/537.36 Edg\\/99.0.1150.46\",\"Accept\":\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.9\",\"Sec-Fetch-Site\":\"none\",\"Sec-Fetch-Mode\":\"navigate\",\"Sec-Fetch-User\":\"?1\",\"Sec-Fetch-Dest\":\"document\",\"Accept-Encoding\":\"gzip, deflate, br\",\"Accept-Language\":\"en-GB,en;q=0.9,en-US;q=0.8\",\"Cookie\":\"remember_web_59ba36addc2b2f9401580f014c7f58ea4e30989d=eyJpdiI6IkNPaEpzQ0I1dDdzeERBdUpsbzVzYmc9PSIsInZhbHVlIjoiTzl6d2hURkp0YTFNQjlYcHZ4ejZ1WTRYOXNaaklnTkp4bzVhTkpWMEtMT3JPZGoyRkt4aDJ4SmlFRTZ0OE1JVytNamZ6YjA2bElwN05ZOVVYWDZyUVRkWTMrWm9saVhpR0xhc2ZKTnFrS', '{\"route\":\"api\\/doors\\/all\"}', '2022-03-20 23:50:07', '{\"status_code\":401,\"body\":{\"error\":\"unauthorized\"}}', '2022-03-20 23:50:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(75) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `password` varchar(500) NOT NULL,
  `user_access_level_id` int(11) NOT NULL,
  `allow_global_level_access` int(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(50) NOT NULL,
  `is_active` int(1) NOT NULL DEFAULT 0,
  `employee_id` varchar(30) NOT NULL,
  `comments` varchar(5000) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `user_name`, `password`, `user_access_level_id`, `allow_global_level_access`, `created_at`, `role`, `is_active`, `employee_id`, `comments`, `modified_at`) VALUES
(1, 'Test', 'Person', 'test@example.com', 'test', '$2y$09$S3h4GhFtyYoN3gV66MhtwuxGNluUcGlsrGSNp97VTH8f35kGkVMuu', 1, 0, '2022-03-19 12:01:42', '2', 1, '10052', 'Nothing much about this user.', '2022-03-19 12:01:42'),
(2, 'Lorem', 'Ipsum', 'lorem@ipsum.co.uk', 'lorem', 'lorem', 1, 0, '2022-03-19 12:01:42', '2', 0, '10023', 'User on holiday.', '2022-03-19 12:01:42'),
(3, 'Admin', 'Test', 'admin@test.com', 'admin-test', 'admin-test', 1, 1, '2022-03-19 12:03:19', '1', 1, '10001', 'Administrator with global access', '2022-03-19 12:03:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `access_list`
--
ALTER TABLE `access_list`
  ADD PRIMARY KEY (`access_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `asset_id` (`asset_id`),
  ADD KEY `card_id` (`card_id`),
  ADD KEY `door_id` (`door_id`);

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
  ADD PRIMARY KEY (`asset_id`);

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
-- AUTO_INCREMENT for table `api_keys`
--
ALTER TABLE `api_keys`
  MODIFY `api_key_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `asset_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `card_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `card_to_door`
--
ALTER TABLE `card_to_door`
  MODIFY `card_to_door_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `doors`
--
ALTER TABLE `doors`
  MODIFY `door_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `levels`
--
ALTER TABLE `levels`
  MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `access_list`
--
ALTER TABLE `access_list`
  ADD CONSTRAINT `access_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `access_list_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  ADD CONSTRAINT `access_list_ibfk_3` FOREIGN KEY (`card_id`) REFERENCES `cards` (`card_id`),
  ADD CONSTRAINT `access_list_ibfk_4` FOREIGN KEY (`door_id`) REFERENCES `doors` (`door_id`);

--
-- Constraints for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD CONSTRAINT `api_keys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `cards_ibfk_1` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `cards_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `card_to_door`
--
ALTER TABLE `card_to_door`
  ADD CONSTRAINT `card_to_door_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `cards` (`card_id`),
  ADD CONSTRAINT `card_to_door_ibfk_2` FOREIGN KEY (`door_id`) REFERENCES `doors` (`door_id`);

--
-- Constraints for table `doors`
--
ALTER TABLE `doors`
  ADD CONSTRAINT `doors_ibfk_1` FOREIGN KEY (`door_access_level_id`) REFERENCES `levels` (`level_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_access_level_id`) REFERENCES `levels` (`level_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
