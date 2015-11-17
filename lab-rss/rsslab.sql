-- phpMyAdmin SQL Dump
-- version 4.4.13.1
-- http://www.phpmyadmin.net
--
-- Värd: localhost:3306
-- Tid vid skapande: 12 nov 2015 kl 02:15
-- Serverversion: 5.6.26
-- PHP-version: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `rsslab`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `bookcatalog`
--

CREATE TABLE IF NOT EXISTS `bookcatalog` (
  `link` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `author` varchar(255) NOT NULL DEFAULT '',
  `publish_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `bookcatalog`
--

INSERT INTO `bookcatalog` (`link`, `title`, `description`, `author`, `publish_date`) VALUES
('http://www.amazon.com/XML-Developers-Guide-Fabio-Arciniegas/dp/0072126485', 'XML Developers Guide', 'This is a comprehensive guide to XML for intermediate to advanced professional developers', 'Arciniegas, Fabio', '2000-12-21 09:00:00'),
('http://www.amazon.com/Beginning-XML-Joe-Fawcett/dp/1118162137/', 'Beginning XML', 'A complete update covering the many advances to the XML language. The XML language has become the standard for writing documents on the Internet and is constantly improving & evolving', 'Fawcett, Joe', '2012-07-10 15:00:00'),
('http://www.amazon.com/Personal-Internet-Address-Password-Book/dp/1441303251/ref=sr_1_23?s=books&ie=UTF8&qid=1447234618&sr=1-23&refinements=p_28%3A%22%26%22', 'The Personal Internet Address & Password Log Book', 'Are you tired of losing track of those login, usernames and passwords you create every time you visit a new website? Now you can keep important website addresses, usernames, and passwords in one convenient place!', 'Peter Pauper', '2010-07-04 12:00:00'),
('http://www.amazon.com/Modern-PHP-Features-Good-Practices/dp/1491905018/ref=sr_1_2?s=books&ie=UTF8&qid=1447246420&sr=1-2&keywords=PHP', 'Modern PHP: New Features and Good Practices', 'PHP is experiencing a renaissance, though it may be difficult to tell with all of the outdated PHP tutorials online. With this practical guide, you will learn how PHP has become a full-featured, mature language with object-orientation, namespaces, and a growing collection of reusable component libraries. Author Josh Lockhart, creator of PHP The Right Way, reveals these new language features in action. You will learn best practices for application architecture and planning, databases, security, testing, debugging, and deployment. If you have a basic understanding of PHP and want to bolster your skills, this is your book.', 'Lockhart, Josh', '2015-02-19 08:00:00'),
('http://www.amazon.com/RDF-Database-Systems-Triples-Processing/dp/0127999574/ref=sr_1_1?s=books&ie=UTF8&qid=1447246658&sr=1-1&keywords=RDF', 'RDF Database Systems: Triples Storage and SPARQL Query Processing', 'RDF Database Systems is a cutting-edge guide that distills everything you need to know to effectively use or design an RDF database. This book starts with the basics of linked open data and covers the most recent research, practice, and technologies to help you leverage semantic technology. With an approach that combines technical detail with theoretical background, this book shows how to design and develop semantic web applications, data models, indexing and query processing solutions.', 'Cure, Olivier', '2014-11-26 13:00:00');

-- --------------------------------------------------------

--
-- Tabellstruktur `calendar`
--

CREATE TABLE IF NOT EXISTS `calendar` (
  `name` varchar(70) NOT NULL DEFAULT '',
  `year` int(11) NOT NULL DEFAULT '0',
  `week` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `calendar`
--

INSERT INTO `calendar` (`name`, `year`, `week`) VALUES
('Daniel Nyström', 2015, 43),
('Sasan Gooran', 2015, 44),
('Paula Zittinski', 2015, 45),
('Carlo	Navarra', 2015, 46),
('Jonas Lundberg', 2015, 47);

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `bookcatalog`
--
ALTER TABLE `bookcatalog`
  ADD PRIMARY KEY (`link`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
