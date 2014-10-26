CREATE DATABASE  IF NOT EXISTS `cs585_hw1` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `cs585_hw1`;
-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: 127.0.0.1    Database: cs585_hw1
-- ------------------------------------------------------
-- Server version	5.6.21

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
-- Table structure for table `COUPON`
--

DROP TABLE IF EXISTS `COUPON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COUPON` (
  `coupon_id` varchar(20) NOT NULL,
  `villa_id` varchar(20) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `discount` int(2) DEFAULT NULL,
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `coupon_id` (`coupon_id`),
  KEY `villa_id` (`villa_id`),
  CONSTRAINT `coupon_ibfk_1` FOREIGN KEY (`villa_id`) REFERENCES `VILLA` (`villa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COUPON`
--

LOCK TABLES `COUPON` WRITE;
/*!40000 ALTER TABLE `COUPON` DISABLE KEYS */;
INSERT INTO `COUPON` VALUES ('Coup1','Vil1','2013-09-01','2014-01-31',20),('Coup2','Vil2','2013-09-01','2013-12-31',15),('Coup3','Vil3','2013-09-01','2013-12-31',25),('Coup4','Vil4','2013-09-01','2013-12-31',10),('Coup5','Vil1','2014-01-01','2014-08-31',15);
/*!40000 ALTER TABLE `COUPON` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEATURES`
--

DROP TABLE IF EXISTS `FEATURES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FEATURES` (
  `feature_id` varchar(20) NOT NULL,
  `feature_name` varchar(20) NOT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `feature_id` (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEATURES`
--

LOCK TABLES `FEATURES` WRITE;
/*!40000 ALTER TABLE `FEATURES` DISABLE KEYS */;
INSERT INTO `FEATURES` VALUES ('Fea1','swimming pool'),('Fea2','Jacuzzi'),('Fea3','billiard table'),('Fea4','Xbox 360'),('Fea5','board games'),('Fea6','pets allowed');
/*!40000 ALTER TABLE `FEATURES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LIKED_REVIEWS`
--

DROP TABLE IF EXISTS `LIKED_REVIEWS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LIKED_REVIEWS` (
  `review_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  KEY `review_id` (`review_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `liked_reviews_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `REVIEW` (`review_id`),
  CONSTRAINT `liked_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LIKED_REVIEWS`
--

LOCK TABLES `LIKED_REVIEWS` WRITE;
/*!40000 ALTER TABLE `LIKED_REVIEWS` DISABLE KEYS */;
INSERT INTO `LIKED_REVIEWS` VALUES ('Rev1','U4'),('Rev1','U2'),('Rev1','U3'),('Rev2','U7'),('Rev2','U4'),('Rev3','U8'),('Rev4','U9'),('Rev5','U2'),('Rev5','U4'),('Rev14','U2'),('Rev14','U4'),('Rev14','U6'),('Rev15','U3'),('Rev15','U6'),('Rev15','U7');
/*!40000 ALTER TABLE `LIKED_REVIEWS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MANAGER`
--

DROP TABLE IF EXISTS `MANAGER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MANAGER` (
  `manager_id` varchar(20) NOT NULL,
  `managed_by` varchar(20) DEFAULT NULL,
  KEY `manager_id` (`manager_id`),
  KEY `managed_by` (`managed_by`),
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `USER` (`user_id`),
  CONSTRAINT `manager_ibfk_2` FOREIGN KEY (`managed_by`) REFERENCES `USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MANAGER`
--

LOCK TABLES `MANAGER` WRITE;
/*!40000 ALTER TABLE `MANAGER` DISABLE KEYS */;
INSERT INTO `MANAGER` VALUES ('U14',NULL),('U15','U14');
/*!40000 ALTER TABLE `MANAGER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OWNER`
--

DROP TABLE IF EXISTS `OWNER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OWNER` (
  `owner_id` varchar(20) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `managed_by` varchar(20) DEFAULT NULL,
  KEY `owner_id` (`owner_id`),
  KEY `managed_by` (`managed_by`),
  CONSTRAINT `owner_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `USER` (`user_id`),
  CONSTRAINT `owner_ibfk_2` FOREIGN KEY (`managed_by`) REFERENCES `USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OWNER`
--

LOCK TABLES `OWNER` WRITE;
/*!40000 ALTER TABLE `OWNER` DISABLE KEYS */;
INSERT INTO `OWNER` VALUES ('U11','111-111-1111','U15'),('U12','222-222-2222','U15'),('U13','333-333-3333','U15'),('U14','444-444-4444',NULL);
/*!40000 ALTER TABLE `OWNER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RATE`
--

DROP TABLE IF EXISTS `RATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RATE` (
  `rate_id` varchar(20) NOT NULL,
  `villa_id` varchar(20) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `rate` int(5) NOT NULL,
  UNIQUE KEY `rate_id` (`rate_id`),
  KEY `villa_id` (`villa_id`),
  CONSTRAINT `rate_ibfk_1` FOREIGN KEY (`villa_id`) REFERENCES `VILLA` (`villa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RATE`
--

LOCK TABLES `RATE` WRITE;
/*!40000 ALTER TABLE `RATE` DISABLE KEYS */;
INSERT INTO `RATE` VALUES ('Rat1','Vil1','2013-01-01','2013-08-31',150),('Rat10','Vil10','2013-01-01','2013-08-31',250),('Rat11','Vil11','2013-01-01','2013-08-31',170),('Rat12','Vil12','2013-01-01','2013-08-31',110),('Rat13','Vil1','2013-09-01','2013-12-31',120),('Rat14','Vil2','2013-09-01','2013-12-31',75),('Rat15','Vil3','2013-09-01','2013-12-31',160),('Rat16','Vil4','2013-09-01','2013-12-31',90),('Rat17','Vil5','2013-09-01','2013-12-31',80),('Rat18','Vil6','2013-09-01','2013-12-31',100),('Rat19','Vil7','2013-09-01','2013-12-31',150),('Rat2','Vil2','2013-01-01','2013-08-31',100),('Rat20','Vil8','2013-09-01','2013-12-31',200),('Rat21','Vil9','2013-09-01','2013-12-31',50),('Rat22','Vil10','2013-09-01','2013-12-31',200),('Rat23','Vil11','2013-09-01','2013-12-31',120),('Rat24','Vil12','2013-09-01','2013-12-31',90),('Rat25','Vil1','2014-01-01','2014-08-31',180),('Rat26','Vil2','2014-01-01','2014-08-31',120),('Rat27','Vil3','2014-01-01','2014-08-31',240),('Rat28','Vil4','2014-01-01','2014-08-31',150),('Rat29','Vil5','2014-01-01','2014-08-31',150),('Rat3','Vil3','2013-01-01','2013-08-31',200),('Rat30','Vil6','2014-01-01','2014-08-31',180),('Rat31','Vil7','2014-01-01','2014-08-31',250),('Rat32','Vil8','2014-01-01','2014-08-31',400),('Rat33','Vil9','2014-01-01','2014-08-31',110),('Rat34','Vil10','2014-01-01','2014-08-31',320),('Rat35','Vil11','2014-01-01','2014-08-31',210),('Rat36','Vil12','2014-01-01','2014-08-31',140),('Rat4','Vil4','2013-01-01','2013-08-31',130),('Rat5','Vil5','2013-01-01','2013-08-31',120),('Rat6','Vil6','2013-01-01','2013-08-31',140),('Rat7','Vil7','2013-01-01','2013-08-31',180),('Rat8','Vil8','2013-01-01','2013-08-31',300),('Rat9','Vil9','2013-01-01','2013-08-31',80);
/*!40000 ALTER TABLE `RATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESERVATION`
--

DROP TABLE IF EXISTS `RESERVATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESERVATION` (
  `reservation_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `villa_id` varchar(20) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `coupon_id` varchar(20) DEFAULT NULL,
  `deposit` int(5) DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  UNIQUE KEY `reservation_id` (`reservation_id`),
  KEY `user_id` (`user_id`),
  KEY `villa_id` (`villa_id`),
  KEY `coupon_id` (`coupon_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `USER` (`user_id`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`villa_id`) REFERENCES `VILLA` (`villa_id`),
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`coupon_id`) REFERENCES `COUPON` (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESERVATION`
--

LOCK TABLES `RESERVATION` WRITE;
/*!40000 ALTER TABLE `RESERVATION` DISABLE KEYS */;
INSERT INTO `RESERVATION` VALUES ('Res1','U1','Vil1','2013-01-02','2013-01-04',NULL,50),('Res10','U2','Vil10','2013-08-19','2013-08-21',NULL,75),('Res11','U5','Vil11','2013-08-15','2013-08-17',NULL,51),('Res12','U6','Vil12','2013-08-27','2013-08-28',NULL,33),('Res13','U2','Vil1','2013-09-01','2013-09-03',NULL,40),('Res14','U5','Vil2','2013-09-02','2013-09-03',NULL,25),('Res15','U9','Vil3','2013-09-15','2013-09-20','Coup3',36),('Res16','U5','Vil4','2013-10-01','2013-10-03','Coup4',27),('Res17','U4','Vil5','2013-10-15','2013-10-16',NULL,24),('Res18','U5','Vil6','2013-11-02','2013-11-04',NULL,30),('Res19','U10','Vil7','2013-11-06','2013-11-07',NULL,50),('Res2','U7','Vil2','2013-01-05','2013-01-06',NULL,30),('Res20','U9','Vil8','2013-11-06','2013-11-10',NULL,60),('Res21','U4','Vil9','2013-11-10','2013-11-13',NULL,15),('Res22','U4','Vil10','2013-11-11','2013-11-13',NULL,60),('Res23','U6','Vil11','2013-12-01','2013-12-04',NULL,40),('Res24','U5','Vil12','2013-12-23','2013-12-26',NULL,30),('Res25','U7','Vil1','2014-01-12','2014-01-15','Coup1',48),('Res26','U9','Vil2','2014-01-06','2014-01-07','Coup2',34),('Res27','U6','Vil2','2014-02-05','2014-02-09',NULL,40),('Res28','U5','Vil5','2014-02-09','2014-02-15',NULL,50),('Res29','U4','Vil8','2014-03-18','2014-03-19',NULL,120),('Res3','U2','Vil3','2013-02-03','2013-02-07',NULL,60),('Res30','U2','Vil4','2014-04-27','2014-04-30',NULL,50),('Res31','U4','Vil10','2014-05-29','2014-06-01',NULL,96),('Res32','U9','Vil12','2014-07-28','2014-08-02',NULL,42),('Res33','U9','Vil7','2014-08-11','2014-08-12',NULL,75),('Res34','U7','Vil4','2014-08-15','2014-08-21',NULL,50),('Res35','U8','Vil8','2014-08-13','2014-08-17',NULL,120),('Res36','U3','Vil2','2014-08-27','2014-08-28',NULL,40),('Res37','U2','Vil11','2014-06-20','2014-06-23',NULL,70),('Res38','U1','Vil2','2014-08-28','2014-08-30',NULL,40),('Res39','U9','Vil1','2014-04-10','2014-04-15',NULL,60),('Res4','U4','Vil4','2013-02-04','2013-02-05',NULL,39),('Res40','U9','Vil7','2014-02-05','2014-02-09',NULL,75),('Res41','U8','Vil7','2014-02-09','2014-02-15',NULL,75),('Res42','U5','Vil7','2014-03-18','2014-03-19',NULL,75),('Res43','U6','Vil1','2014-05-12','2014-05-13','Coup5',51),('Res5','U4','Vil5','2013-03-06','2013-03-12',NULL,40),('Res6','U4','Vil6','2013-04-23','2013-04-25',NULL,42),('Res7','U6','Vil7','2013-05-29','2013-06-01',NULL,60),('Res8','U10','Vil8','2013-07-30','2013-08-02',NULL,100),('Res9','U3','Vil9','2013-08-11','2013-08-12',NULL,24);
/*!40000 ALTER TABLE `RESERVATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REVIEW`
--

DROP TABLE IF EXISTS `REVIEW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REVIEW` (
  `review_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `villa_id` varchar(20) NOT NULL,
  `text` varchar(100) DEFAULT NULL,
  `rating` int(1) DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  UNIQUE KEY `review_id` (`review_id`),
  KEY `user_id` (`user_id`),
  KEY `villa_id` (`villa_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `USER` (`user_id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`villa_id`) REFERENCES `VILLA` (`villa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REVIEW`
--

LOCK TABLES `REVIEW` WRITE;
/*!40000 ALTER TABLE `REVIEW` DISABLE KEYS */;
INSERT INTO `REVIEW` VALUES ('Rev1','U1','Vil1','Poor maintainance considering the price.',2),('Rev10','U3','Vil9','A must visit villa',5),('Rev11','U10','Vil8','Nice',1),('Rev13','U6','Vil7','poor one',1),('Rev14','U1','Vil7','popular one',4),('Rev15','U7','Vil3','wanna go back!',5),('Rev2','U2','Vil3','Boring and Dull',1),('Rev3','U4','Vil6','Love it!',4),('Rev4','U2','Vil1','Best vila error',2),('Rev5','U7','Vil1','Though not clean, has fantastic scenery around it',3),('Rev6','U5','Vil2','not recommended',1),('Rev7','U6','Vil1','Good one',4),('Rev8','U4','Vil4','I gonna rent again and again',5),('Rev9','U9','Vil3','Good work',5);
/*!40000 ALTER TABLE `REVIEW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER`
--

DROP TABLE IF EXISTS `USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER` (
  `user_id` varchar(20) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER`
--

LOCK TABLES `USER` WRITE;
/*!40000 ALTER TABLE `USER` DISABLE KEYS */;
INSERT INTO `USER` VALUES ('U1','Jackie','Jones','jack_killer@gmail.com','1983-02-28'),('U10','Carlos','Santana','danamoon@louti.com','1977-07-07'),('U11','Roberto','Carlos','owner1@villa.com','1955-05-05'),('U12','De','Vilardo','owner2@villa.com','1944-04-04'),('U13','villa','Blanka','owner3@villa.com','1974-11-11'),('U14','nino','bino','ceo@villa.com','1991-01-01'),('U15','Bookish','Morinio','manager2@villa.com','1950-04-17'),('U2','Jessie','Jackson','Hello_macy@yahoo.com','1986-03-04'),('U3','Tommy','Trojan','john_black@hotmail.com','1990-04-22'),('U4','Niki','Nanjan','ny_robert@usc.edu','1980-06-10'),('U5','Jalli','Shadan','cool_andrew@bbc.co.uk','1984-11-27'),('U6','Houtan','Khandan','coryphillip@voa.gov','1966-06-06'),('U7','Naz','Nazi','DaneilJ@msnbc.com','2000-04-20'),('U8','Ab','Bazi','rohanau@cs.mit.edu','1956-12-12'),('U9','Ben','Ghazi','edmorales@houti.com','1973-11-10');
/*!40000 ALTER TABLE `USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FAVORITES`
--

DROP TABLE IF EXISTS `USER_FAVORITES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FAVORITES` (
  `user_id` varchar(20) NOT NULL,
  `villa_id` varchar(20) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `villa_id` (`villa_id`),
  CONSTRAINT `user_favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `USER` (`user_id`),
  CONSTRAINT `user_favorites_ibfk_2` FOREIGN KEY (`villa_id`) REFERENCES `VILLA` (`villa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FAVORITES`
--

LOCK TABLES `USER_FAVORITES` WRITE;
/*!40000 ALTER TABLE `USER_FAVORITES` DISABLE KEYS */;
INSERT INTO `USER_FAVORITES` VALUES ('U1','Vil2'),('U1','Vil4'),('U2','Vil8'),('U3','Vil10'),('U3','Vil3'),('U3','Vil7'),('U4','Vil10'),('U4','Vil4'),('U5','Vil1'),('U6','Vil3'),('U7','Vil2'),('U7','Vil4'),('U7','Vil12'),('U8','Vil1'),('U8','Vil9'),('U9','Vil6'),('U10','Vil11'),('U10','Vil12'),('U13','Vil1'),('U14','Vil2');
/*!40000 ALTER TABLE `USER_FAVORITES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VILLA`
--

DROP TABLE IF EXISTS `VILLA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VILLA` (
  `villa_id` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `features` varchar(100) DEFAULT NULL,
  `owner` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`villa_id`),
  UNIQUE KEY `villa_id` (`villa_id`),
  KEY `owner` (`owner`),
  CONSTRAINT `villa_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VILLA`
--

LOCK TABLES `VILLA` WRITE;
/*!40000 ALTER TABLE `VILLA` DISABLE KEYS */;
INSERT INTO `VILLA` VALUES ('Vil1','Fifi','Fea1,Fea2','U11'),('Vil10','Kelley','Fea5','U12'),('Vil11','Dori','Fea2','U12'),('Vil12','Houti','Fea2','U13'),('Vil2','Lulu','Fea1','U12'),('Vil3','Penny','Fea1,Fea4,Fea5','U13'),('Vil4','Kiki','Fea2','U11'),('Vil5','Vivi','Fea4','U11'),('Vil6','Gigi','Fea6','U11'),('Vil7','Kitty','Fea3,Fea4,Fea5,Fea6','U12'),('Vil8','Ellie','Fea6','U13'),('Vil9','Ali','Fea5','U14');
/*!40000 ALTER TABLE `VILLA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VILLA_FEATURES`
--

DROP TABLE IF EXISTS `VILLA_FEATURES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VILLA_FEATURES` (
  `villa_id` varchar(20) NOT NULL,
  `feature_id` varchar(20) NOT NULL,
  KEY `villa_id` (`villa_id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `villa_features_ibfk_1` FOREIGN KEY (`villa_id`) REFERENCES `VILLA` (`villa_id`),
  CONSTRAINT `villa_features_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `FEATURES` (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VILLA_FEATURES`
--

LOCK TABLES `VILLA_FEATURES` WRITE;
/*!40000 ALTER TABLE `VILLA_FEATURES` DISABLE KEYS */;
INSERT INTO `VILLA_FEATURES` VALUES ('Vil1','Fea1'),('Vil1','Fea2'),('Vil2','Fea1'),('Vil3','Fea1'),('Vil3','Fea4'),('Vil3','Fea5'),('Vil4','Fea2'),('Vil5','Fea4'),('Vil6','Fea6'),('Vil7','Fea3'),('Vil7','Fea4'),('Vil7','Fea5'),('Vil7','Fea6'),('Vil8','Fea6'),('Vil9','Fea5'),('Vil10','Fea5'),('Vil11','Fea2'),('Vil12','Fea2');
/*!40000 ALTER TABLE `VILLA_FEATURES` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-10  9:14:19
