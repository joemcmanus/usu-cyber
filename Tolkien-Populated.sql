CREATE DATABASE  IF NOT EXISTS `tolkien` /*!40100 DEFAULT CHARACTER SET latin1 */;
GRANT SELECT, INSERT, UPDATE, DELETE on tolkien.* to 'aggies'@'localhost' IDENTIFIED BY 'is3800';

USE `tolkien`;
-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: 127.0.0.1    Database: tolkien
-- ------------------------------------------------------
-- Server version	5.6.22

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
-- Table structure for table `appears`
--

DROP TABLE IF EXISTS `appears`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appears` (
  `appearsid` int(11) NOT NULL AUTO_INCREMENT,
  `bookid` int(11) NOT NULL,
  `characterid` int(11) NOT NULL,
  PRIMARY KEY (`appearsid`),
  KEY `bookid_idx` (`bookid`),
  KEY `characterid_idx` (`characterid`),
  CONSTRAINT `bookid` FOREIGN KEY (`bookid`) REFERENCES `books` (`bookid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `characterid` FOREIGN KEY (`characterid`) REFERENCES `characters` (`characterid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appears`
--

LOCK TABLES `appears` WRITE;
/*!40000 ALTER TABLE `appears` DISABLE KEYS */;
INSERT INTO `appears` VALUES (1,1,1),(2,1,2),(3,3,1),(4,3,2),(5,3,3),(6,3,4),(7,3,5),(8,3,6),(9,4,10),(10,4,1),(11,4,2),(12,4,3),(13,4,4),(14,4,5),(15,4,6),(16,5,1),(17,5,2),(18,5,3),(19,5,4),(20,5,5);
/*!40000 ALTER TABLE `appears` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `bookid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) DEFAULT NULL,
  `storyid` int(11) NOT NULL,
  PRIMARY KEY (`bookid`),
  UNIQUE KEY `title_UNIQUE` (`title`),
  KEY `storyid_idx` (`storyid`),
  CONSTRAINT `storyid` FOREIGN KEY (`storyid`) REFERENCES `stories` (`storyid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'The Hobbit',1),(3,'The Fellowship of the Ring',2),(4,'The Two Towers',2),(5,'The Return of the King',2);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters` (
  `characterid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `race` varchar(45) NOT NULL,
  `side` varchar(45) NOT NULL,
  PRIMARY KEY (`characterid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` VALUES (1,'Gandolf','Man','good'),(2,'Bilbo','Hobbit','good'),(3,'Samwise','Hobbit','good'),(4,'Pippin','Hobbit','good'),(5,'Merry','Hobbit','good'),(6,'Saruman','Man','evil'),(10,'Treebeard','Ent','good');
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pictures`
--

DROP TABLE IF EXISTS `pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pictures` (
  `pictureid` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(512) NOT NULL,
  `characterid` int(11) NOT NULL,
  PRIMARY KEY (`pictureid`),
  KEY `characterid_idx` (`characterid`),
  CONSTRAINT `piccharacterid` FOREIGN KEY (`characterid`) REFERENCES `characters` (`characterid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pictures`
--

LOCK TABLES `pictures` WRITE;
/*!40000 ALTER TABLE `pictures` DISABLE KEYS */;
INSERT INTO `pictures` VALUES (1,'http://img4.wikia.nocookie.net/__cb20140731215229/lotr/images/thumb/a/a6/GandalfTDOMTextlessPoster.jpg/220px-GandalfTDOMTextlessPoster.jpg',1),(2,'http://img1.wikia.nocookie.net/__cb20131211160320/lotr/images/thumb/c/ca/148531_433225943406882_1431199174_n.jpg/220px-148531_433225943406882_1431199174_n.jpg',2),(3,'http://img4.wikia.nocookie.net/__cb20070623123241/lotr/images/thumb/2/20/Sam.jpg/220px-Sam.jpg',3),(4,'http://img2.wikia.nocookie.net/__cb20060310083048/lotr/images/0/0a/Pippinprintscreen.jpg',4),(5,'http://img4.wikia.nocookie.net/__cb20080318214905/lotr/images/thumb/d/d8/Merry1.jpg/220px-Merry1.jpg',5),(6,'http://img3.wikia.nocookie.net/__cb20140426125614/lotr/images/thumb/a/a0/Saruman_%21.jpeg/220px-Saruman_%21.jpeg',6),(7,'http://img4.wikia.nocookie.net/__cb20120312183330/lotr/images/thumb/2/23/TreebeardatIsengard.png/220px-TreebeardatIsengard.png',10);
/*!40000 ALTER TABLE `pictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stories`
--

DROP TABLE IF EXISTS `stories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stories` (
  `storyid` int(11) NOT NULL AUTO_INCREMENT,
  `story` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`storyid`),
  UNIQUE KEY `title_UNIQUE` (`story`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stories`
--

LOCK TABLES `stories` WRITE;
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
INSERT INTO `stories` VALUES (1,'The Hobbit'),(2,'The Lord of the Rings');
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-01 21:25:35
