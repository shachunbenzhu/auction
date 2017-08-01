-- MySQL dump 10.11
--
-- Host: localhost    Database: auction
-- ------------------------------------------------------
-- Server version	5.0.41-community-nt

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
-- Table structure for table `auction_user`
--

DROP TABLE IF EXISTS `auction_user`;
CREATE TABLE `auction_user` (
  `user_id` int(11) NOT NULL auto_increment,
  `username` varchar(50) NOT NULL,
  `userpass` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `auction_user`
--

LOCK TABLES `auction_user` WRITE;
/*!40000 ALTER TABLE `auction_user` DISABLE KEYS */;
INSERT INTO `auction_user` VALUES (1,'tomcat','tomcat','spring_test@163.com'),(2,'mysql','mysql','spring_test@163.com');
/*!40000 ALTER TABLE `auction_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid` (
  `bid_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `bid_price` double NOT NULL,
  `bid_date` date NOT NULL,
  PRIMARY KEY  (`bid_id`),
  UNIQUE KEY `item_id` (`item_id`,`bid_price`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auction_user` (`user_id`),
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
INSERT INTO `bid` VALUES (1,2,1,250,'2006-07-09'),(2,1,3,25000,'2006-07-05');
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL auto_increment,
  `item_name` varchar(255) NOT NULL,
  `item_remark` varchar(255) NOT NULL,
  `item_desc` varchar(255) default NULL,
  `kind_id` int(11) NOT NULL,
  `addtime` date NOT NULL,
  `endtime` date NOT NULL,
  `init_price` double NOT NULL,
  `max_price` double NOT NULL,
  `owner_id` int(11) NOT NULL,
  `winer_id` int(11) default NULL,
  `state_id` int(11) NOT NULL,
  PRIMARY KEY  (`item_id`),
  KEY `kind_id` (`kind_id`),
  KEY `owner_id` (`owner_id`),
  KEY `winer_id` (`winer_id`),
  KEY `state_id` (`state_id`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`kind_id`) REFERENCES `kind` (`kind_id`),
  CONSTRAINT `item_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `auction_user` (`user_id`),
  CONSTRAINT `item_ibfk_3` FOREIGN KEY (`winer_id`) REFERENCES `auction_user` (`user_id`),
  CONSTRAINT `item_ibfk_4` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'主板','老式主板','老主板，还可以用',1,'2006-07-06','2008-07-10',230,250,1,NULL,1),(2,'显卡','老式显卡','老显卡，还可以用',1,'2006-07-03','2008-07-05',210,210,2,NULL,3),(3,'老房子','老式房子','40年的老房子',2,'2006-07-03','2008-07-06',21000,25000,2,1,2);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kind`
--

DROP TABLE IF EXISTS `kind`;
CREATE TABLE `kind` (
  `kind_id` int(11) NOT NULL auto_increment,
  `kind_name` varchar(50) NOT NULL,
  `kind_desc` varchar(255) NOT NULL,
  PRIMARY KEY  (`kind_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kind`
--

LOCK TABLES `kind` WRITE;
/*!40000 ALTER TABLE `kind` DISABLE KEYS */;
INSERT INTO `kind` VALUES (1,'电脑硬件','这里并不是很主流的产品，但价格绝对令你心动'),(2,'房产','提供非常稀缺的房源');
/*!40000 ALTER TABLE `kind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `state_id` int(11) NOT NULL auto_increment,
  `state_name` varchar(10) default NULL,
  PRIMARY KEY  (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'拍卖中'),(2,'拍卖成功'),(3,'流拍');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-19  5:22:56
