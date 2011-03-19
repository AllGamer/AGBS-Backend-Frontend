-- MySQL dump 10.13  Distrib 5.1.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: agsbans
-- ------------------------------------------------------
-- Server version	5.1.49-1ubuntu8.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `api_key`
--

DROP TABLE IF EXISTS `api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_key` (
  `id` int(11) NOT NULL,
  `public` varchar(45) DEFAULT NULL,
  `private` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_key`
--

LOCK TABLES `api_key` WRITE;
/*!40000 ALTER TABLE `api_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ban`
--

DROP TABLE IF EXISTS `ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban` (
  `id` int(11) NOT NULL,
  `type` enum('global','server') DEFAULT NULL,
  `server_id` int(11) DEFAULT NULL,
  `status` enum('new','enforced','deleted') DEFAULT NULL,
  `last_update` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ban`
--

LOCK TABLES `ban` WRITE;
/*!40000 ALTER TABLE `ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ban_flag`
--

DROP TABLE IF EXISTS `ban_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban_flag` (
  `id` int(11) NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ban_flag`
--

LOCK TABLES `ban_flag` WRITE;
/*!40000 ALTER TABLE `ban_flag` DISABLE KEYS */;
/*!40000 ALTER TABLE `ban_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ban_has_ban_flag`
--

DROP TABLE IF EXISTS `ban_has_ban_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban_has_ban_flag` (
  `ban_id` int(11) NOT NULL,
  `ban_flag_id` int(11) NOT NULL,
  PRIMARY KEY (`ban_id`,`ban_flag_id`),
  KEY `fk_ban_has_ban_flag_ban_flag1` (`ban_flag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ban_has_ban_flag`
--

LOCK TABLES `ban_has_ban_flag` WRITE;
/*!40000 ALTER TABLE `ban_has_ban_flag` DISABLE KEYS */;
/*!40000 ALTER TABLE `ban_has_ban_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) DEFAULT NULL,
  `server_ban_flags` int(11) DEFAULT NULL,
  `global_ban_flags` int(11) DEFAULT NULL,
  `priv_api_key_id` int(11) DEFAULT NULL,
  `shared_api_key_id` int(11) DEFAULT NULL,
  `global_ban_trust` enum('shunned','trusted') DEFAULT NULL,
  `status` enum('active','inactive','deleted') DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fs_s_pubapi` (`id`),
  KEY `fk_s_privapi` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server`
--

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;
/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_admin`
--

DROP TABLE IF EXISTS `server_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_admin` (
  `id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `realname` varchar(45) DEFAULT NULL,
  `passwd_hash` varchar(45) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `status` enum('new','verified','deleted') DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_admin`
--

LOCK TABLES `server_admin` WRITE;
/*!40000 ALTER TABLE `server_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_has_admin`
--

DROP TABLE IF EXISTS `server_has_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_has_admin` (
  `server_id` int(11) NOT NULL,
  `server_admin_id` int(11) NOT NULL,
  PRIMARY KEY (`server_id`,`server_admin_id`),
  KEY `fk_HSA_s` (`server_id`),
  KEY `fk_SHA_a` (`server_admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_has_admin`
--

LOCK TABLES `server_has_admin` WRITE;
/*!40000 ALTER TABLE `server_has_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_has_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_has_ban`
--

DROP TABLE IF EXISTS `server_has_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_has_ban` (
  `server_id` int(11) NOT NULL,
  `ban_id` int(11) NOT NULL,
  PRIMARY KEY (`server_id`,`ban_id`),
  KEY `fk_server_has_ban_ban1` (`ban_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_has_ban`
--

LOCK TABLES `server_has_ban` WRITE;
/*!40000 ALTER TABLE `server_has_ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_has_ban` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-03-19 13:44:44
