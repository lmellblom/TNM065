-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Dec 15, 2015 at 04:27 PM
-- Server version: 5.5.42
-- PHP Version: 5.6.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `blogposts`
--

-- --------------------------------------------------------

--
-- Table structure for table `hashtags`
--

CREATE TABLE `hashtags` (
  `postid` smallint(5) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_swedish_ci NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

--
-- Dumping data for table `hashtags`
--

INSERT INTO `hashtags` (`postid`, `name`) VALUES
(30, 'quote'),
(31, 'quote'),
(31, 'end'),
(31, 'life'),
(31, 'hurt'),
(35, 'life'),
(28, 'quote'),
(28, 'life'),
(34, 'alfabetet'),
(35, 'yourself'),
(36, 'DrSeuss'),
(36, 'quote');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `postid` smallint(5) NOT NULL,
  `userid` smallint(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`postid`, `userid`) VALUES
(30, 15),
(34, 14),
(35, 14),
(28, 14);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `title` varchar(255) COLLATE utf8_swedish_ci NOT NULL DEFAULT '',
  `text` mediumtext COLLATE utf8_swedish_ci NOT NULL,
  `userid` smallint(5) unsigned DEFAULT NULL,
  `id` smallint(5) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`title`, `text`, `userid`, `id`, `date`) VALUES
('You', 'Life isn&#8217;t about finding yourself. Life is about creating yourself.', 17, 35, '2015-12-09 11:36:16'),
('Time', 'How did it get so late so soon? Its night before its afternoon. December is here before its June. My goodness how the time has flewn. How did it get so late so soon?', 14, 36, '2015-12-11 16:33:49'),
('hej då', 'å ä ö. funkar nu! superglad.', 15, 34, '2015-12-08 11:06:04'),
('Livet', 'When I need someone the most is when I shut everyone out.  Have such high walls around me. Do not want to get hurt. But in the end, it is me that hurt myself the most..', 15, 31, '2015-12-08 11:00:11'),
('Live', 'Vital things to do while living; Chilling out. Dancing. Strolling in the sun. Having dinner with your friends. Making mistakes and more.', 15, 28, '2015-12-08 09:57:34'),
('Tanke', 'Happiness is not a destination. It is a way of life.', 14, 30, '2015-12-08 10:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` smallint(5) NOT NULL,
  `name` varchar(100) COLLATE utf8_swedish_ci NOT NULL DEFAULT '',
  `pwd` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  `authority` smallint(5) NOT NULL DEFAULT '1',
  `picture` smallint(6) NOT NULL DEFAULT '1',
  `salt` varchar(100) COLLATE utf8_swedish_ci NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `pwd`, `authority`, `picture`, `salt`) VALUES
(15, 'hanna', '7044102b555e06a471a07820d1f25ed3750f476ff5ff1bb71b8cf301c70fceef', 1, 4, '2252182bbe895e57b3d587a4e381b594b7ded1d3b5d5d4920bab3deb9c7a78dd'),
(14, 'linnea', '2852f978b443756b65bae65669ea6e10eb27773435d52f4eaf793c32b764849d', 0, 3, '92480ba18ca2532ad674b7fb4e51d486243b54226070922852b3ef3c1028b499'),
(17, 'hugo', '733fa60b2258a2399165feca44a6e0eaa9e4a3741c931ebdae7f41345b787bae', 1, 1, 'c5a162658dc96da9db3099ae62773072b32cfe90f73422f379ac74b08c2d1b13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` smallint(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;