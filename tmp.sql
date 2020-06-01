-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: apollo7_conceptize
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cid_UNIQUE` (`cid`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (7,'all'),(1,'design'),(2,'digital marketing'),(5,'inventions'),(6,'music'),(3,'original characters'),(4,'writing');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `pic_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(16) NOT NULL,
  `path` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`pic_id`),
  UNIQUE KEY `pic_id_UNIQUE` (`pic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'test','https://66.media.tumblr.com/0b9907fdd0cef168f1d789f214fe1f8e/tumblr_pf7xynYOGR1t2c4f8o5_250.png'),(2,'test','https://66.media.tumblr.com/0b9907fdd0cef168f1d789f214fe1f8e/tumblr_pf7xynYOGR1t2c4f8o5_250.png'),(3,'test','https://66.media.tumblr.com/0b9907fdd0cef168f1d789f214fe1f8e/tumblr_pf7xynYOGR1t2c4f8o5_250.png'),(4,'test','https://66.media.tumblr.com/0b9907fdd0cef168f1d789f214fe1f8e/tumblr_pf7xynYOGR1t2c4f8o5_250.png'),(5,'test','https://66.media.tumblr.com/0b9907fdd0cef168f1d789f214fe1f8e/tumblr_pf7xynYOGR1t2c4f8o5_250.png');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `pid` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'test',4,'2019-12-08 16:24:37'),(2,'test',3,'2019-12-08 16:38:58');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `price` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `negotiable` tinyint(4) NOT NULL,
  `cid` int(11) NOT NULL,
  `description` varchar(2048) NOT NULL,
  `img` varchar(1024) NOT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (2,'Seviss',70,'Neptune Anime Painting',1,1,'This is a painting of Neptune.','./WebsiteUsage/Anime.png'),(3,'Seviss',80,'Neptune God Painting',1,1,'This is a painting of Neptune the God.','./WebsiteUsage/God.png'),(4,'Seviss',90,'Neptune Planet Painting',1,1,'This is a painting of Neptune the Planet.','./WebsiteUsage/Planet.png');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saveforlater`
--

DROP TABLE IF EXISTS `saveforlater`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saveforlater` (
  `pid` int(11) NOT NULL,
  `uid` varchar(16) NOT NULL,
  PRIMARY KEY (`pid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saveforlater`
--

LOCK TABLES `saveforlater` WRITE;
/*!40000 ALTER TABLE `saveforlater` DISABLE KEYS */;
/*!40000 ALTER TABLE `saveforlater` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `pid` int(11) NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uid` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `pwd` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `coins` int(11) NOT NULL DEFAULT '10000',
  `regdate` datetime NOT NULL,
  `about` varchar(1024) NOT NULL DEFAULT '""',
  `interests` varchar(1024) NOT NULL DEFAULT '""',
  `pic` varchar(1024) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Gucci','gucci flip flop','9fbbbb5a0f329f9782e2356fa41d89cf9b3694327c1a934d6af2a9df2d7f936ce83717fb513196a4ce5548471708cd7134c2ae99b3c357bcabb2eafc7b9b7570',10000,'2019-12-08 15:39:10','','','http://icons.iconarchive.com/icons/graphicloads/100-flat/256/home-icon.png'),('Test',NULL,'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff',10000,'2019-12-04 20:14:49','\"\"','\"\"','0'),('shiro',NULL,'24e3d7cc7ca65f051cfac8ff8a297ee409eee12e461fb05bf0cea472d545ea30',10000,'2019-11-27 09:38:07','\"\"','\"\"','0'),('shiro2',NULL,'24e3d7cc7ca65f051cfac8ff8a297ee409eee12e461fb05bf0cea472d545ea3098621045af04bcc656d45ed49f4bbfb79bd46b101497e3671451314b545cd071',10000,'2019-11-27 09:39:55','\"\"','\"\"','0'),('test','sup','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',9830,'2019-12-08 14:24:56','test','a','https://66.media.tumblr.com/0b9907fdd0cef168f1d789f214fe1f8e/tumblr_pf7xynYOGR1t2c4f8o5_250.png'),('yo',NULL,'9fbbbb5a0f329f9782e2356fa41d89cf9b3694327c1a934d6af2a9df2d7f936ce83717fb513196a4ce5548471708cd7134c2ae99b3c357bcabb2eafc7b9b7570',10000,'2019-12-08 15:37:56','\"\"','\"\"','0');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-08 17:14:59
