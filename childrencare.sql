-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: childrencare
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `comment` text NOT NULL,
  `author_id` int NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `post_id` (`post_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feature_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `url` varchar(200) NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url_UNIQUE` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (2,'Reservation Details','/reservation/detail','',_binary ''),(3,'Reservation Contact','/reservation/contact','',_binary ''),(4,'Reservation Completion','/reservation/completion','',_binary ''),(5,'My reservations','/history','',_binary ''),(6,'Reservation Information','/reservation/info','',_binary ''),(7,'Posts List','/posts','',_binary ''),(8,'Post Details','/post','',_binary ''),(9,'Sliders List','/sliders','',_binary ''),(10,'Slider Details','/slider','',_binary ''),(11,'Services List (Manager)','/services/manager','',_binary ''),(13,'Customers List','/customers','',_binary ''),(14,'Customer Details','/customer','',_binary ''),(15,'Feedbacks List','/feedbacks','',_binary ''),(16,'Feedback Details','/feedback','',_binary ''),(17,'Reservations List','/reservations','',_binary ''),(18,'Reservation Details','/reservation','',_binary ''),(20,'Dashboard','/dashboard','',_binary ''),(21,'Users List','/users','',_binary ''),(22,'User Details','/users/update','',_binary ''),(23,'Settings List','/settings','',_binary ''),(24,'Setting Details','/setting','',_binary ''),(26,'Add Service','/services/add',' ',_binary ''),(28,'Permission Control','/permissions',NULL,_binary ''),(29,'Add User','/users/add',NULL,_binary ''),(30,'Add Customer','/customer/add',NULL,_binary ''),(32,'Update Service','/services/update',NULL,_binary ''),(33,'Add Setting','/settings/add',NULL,_binary ''),(34,'Customer Feedback','/customer-feedback',NULL,_binary ''),(35,'Reservation Return','/reservation/return',NULL,_binary ''),(36,'Reservation Refund','/reservation/refund',NULL,_binary ''),(37,'Ban User','/ban-ajax',NULL,_binary ''),(38,'Reset Password Mail','/reset-ajax',NULL,_binary ''),(39,'Reservation Payment','/reservation/payment',NULL,_binary '');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `reservationdetail_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`reservationdetail_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`reservationdetail_id`) REFERENCES `reservationdetail` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labelpost`
--

DROP TABLE IF EXISTS `labelpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labelpost` (
  `label_id` int NOT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`label_id`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `labelpost_ibfk_1` FOREIGN KEY (`label_id`) REFERENCES `setting` (`setting_id`),
  CONSTRAINT `labelpost_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labelpost`
--

LOCK TABLES `labelpost` WRITE;
/*!40000 ALTER TABLE `labelpost` DISABLE KEYS */;
INSERT INTO `labelpost` VALUES (9,1),(10,2),(11,3),(9,16),(10,17),(11,18),(9,19),(10,20),(10,21),(9,22),(9,23),(11,24);
/*!40000 ALTER TABLE `labelpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymenthistory`
--

DROP TABLE IF EXISTS `paymenthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymenthistory` (
  `reservation_id` int NOT NULL,
  `amount` bigint NOT NULL,
  `transactiondate` varchar(100) NOT NULL,
  `txnref` varchar(100) DEFAULT NULL,
  `transactiono` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  UNIQUE KEY `txnref_UNIQUE` (`txnref`),
  UNIQUE KEY `transactiono_UNIQUE` (`transactiono`),
  CONSTRAINT `fk1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymenthistory`
--

LOCK TABLES `paymenthistory` WRITE;
/*!40000 ALTER TABLE `paymenthistory` DISABLE KEYS */;
INSERT INTO `paymenthistory` VALUES (61,235000000,'20250329215828','88381825103288005339500','14878835'),(63,799000000,'20250329223534','95705717105566195699400','14878911'),(65,493500000,'20250329223655','28699256105651326427400','14878913'),(67,705000000,'20250329223832','98638550105748490528300','14878917'),(70,799000000,'20250329224006','67769792105843494554400','14878922'),(73,1175000000,'20250330080520','09199766139746344854900','14879419'),(74,334875000,'20250330081302','29445423140171635386400','14879426');
/*!40000 ALTER TABLE `paymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `author_id` int NOT NULL,
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` text,
  `thumbnail` varchar(200) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `brief_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,72,'       ','<p>Regular health checkups are essential for monitoring the growth and development of children.</p>\r\n\r\n<p><a href=\"https://letsenhance.io/\"><img alt=\"\" src=\"https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/6e61b/MainAfter.avif\" style=\"height:113px; width:200px\" /></a></p>\r\n\r\n<p>adnvaudviladv</p>\r\n\r\n<p>&nbsp;</p>\r\n','assets/images/blog/se-metadata.json',1,'2025-01-31 23:46:56','2025-03-30 08:17:54','Regular health checkups are essential for monitoring the growth and development of children.'),(2,72,'Vaccination Schedule for Children','Ensure your child is up-to-date with their vaccinations to protect them from diseases.','assets/images/blog/blog2.jpg',1,'2025-01-31 23:46:56','2025-03-30 00:34:52','Ensure your child is up-to-date with their vaccinations to protect them from diseases.'),(3,72,'Nutrition Tips for Kids','A balanced diet is crucial for the healthy development of children.','assets/images/blog/blog3.jpg',1,'2025-01-31 23:46:56','2025-03-30 00:34:52','A balanced diet is crucial for the healthy development of children.'),(16,72,'Common Childhood Illnesses','Understanding and preventing common childhood illnesses helps keep your child healthy.','assets/images/blog/blog16.jpg',1,'2025-02-01 09:12:45','2025-03-30 00:34:52','Understanding and preventing common childhood illnesses helps keep your child healthy.'),(17,72,'How to Build Strong Immunity','Learn about the best ways to boost your child’s immune system.','assets/images/blog/blog17.jpg',1,'2025-02-01 09:15:20','2025-03-30 00:34:52','Learn about the best ways to boost your child’s immune system.'),(18,72,'First Aid for Children','Essential first aid tips for dealing with common injuries in children.','assets/images/blog/blog18.jpg',1,'2025-02-01 09:20:10','2025-03-30 00:34:52','Essential first aid tips for dealing with common injuries in children.'),(19,72,'Sleep Routines for Kids','Establishing healthy sleep routines is vital for your child’s development.','assets/images/blog/blog19.jpg',1,'2025-02-01 09:22:35','2025-03-30 00:34:52','Establishing healthy sleep routines is vital for your child’s development.'),(20,72,'Dental Care for Children','Starting dental care early can prevent future dental problems.','assets/images/blog/blog20.jpg',1,'2025-02-01 09:25:00','2025-03-30 00:34:52','Starting dental care early can prevent future dental problems.'),(21,72,'Mental Health in Children','Supporting your child’s mental health is as important as their physical health.','assets/images/blog/blog21.jpg',1,'2025-02-01 09:30:15','2025-03-30 00:34:52','Supporting your child’s mental health is as important as their physical health.'),(22,72,'Exercise for Kids','Regular physical activity is key for your child’s growth and well-being.','assets/images/blog/blog22.jpg',1,'2025-02-01 09:35:10','2025-03-30 00:34:52','Regular physical activity is key for your child’s growth and well-being.'),(23,72,'Skin Care for Children','Learn the importance of gentle skin care for young children.','assets/images/blog/blog23.jpg',1,'2025-02-01 09:40:25','2025-03-30 00:34:52','Learn the importance of gentle skin care for young children.'),(24,72,'Sun Protection for Kids','Protect your child from harmful UV rays with the right sun protection.','assets/images/blog/blog24.jpg',1,'2025-02-01 09:45:35','2025-03-30 00:34:52','Protect your child from harmful UV rays with the right sun protection.'),(27,72,'wrgh','<p>wrh</p>\r\n','assets/images/blog/logo-light.png',1,'2025-03-30 00:00:30',NULL,'wrgh');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `dob` date NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(20) NOT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`),
  CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (66,'Do Minh ','Anh',1,'2004-09-14','Thach That - Ha Noi','0389822669',NULL,'2025-03-28 22:53:15',NULL),(67,'Do Minh','Chi',0,'2004-09-12','Phu O - Thach That','0981663009',NULL,'2025-03-28 22:59:12',NULL),(68,'Nguyen Duc','Quyen',1,'2003-06-04','My Dinh - Ha Noi','0123456788',NULL,'2025-03-28 23:04:12',NULL),(69,'Nguyen Van','Tai',1,'2000-09-19','Nghi Loc - Nghe An','0123456789',NULL,'2025-03-28 23:05:33',NULL),(70,'Nguyen Hoang','Long',1,'2003-02-14','Thanh Son - Phu Tho','0987654321',NULL,'2025-03-28 23:06:41',NULL),(71,'Tran Duc','Anh',1,'2004-06-09','Thanh Son - Phu Tho','0373517718',NULL,'2025-03-28 23:15:20',NULL),(72,'Nguyen Lam','Hoang',1,'2004-12-31','Bac Giang','0964354306',NULL,'2025-03-28 23:19:33',NULL),(73,'Nguyen Duc','Manh',1,'2001-06-05','Yen Bai','0362406325',NULL,'2025-03-28 23:21:59',NULL),(74,'Vu Thi','Bich',0,'2004-01-01','Huu Bang - Ha Noi','0384408427',NULL,'2025-03-28 23:26:11',NULL),(75,'Nguyen Tuan','Anh',1,'2004-06-09','Huu Bang - Ha Noi','0981439283',NULL,'2025-03-28 23:28:12',NULL);
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `status_id` int NOT NULL DEFAULT '1',
  `reserve_date` datetime NOT NULL,
  `note` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `banking` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `IX_Reservation_Customer` (`customer_id`),
  KEY `IX_Reservation_Date` (`reserve_date`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `reservationstatus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (60,74,1,'2025-03-30 07:30:00','','2025-03-29 01:32:02',NULL,'Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '\0'),(61,74,1,'2025-03-30 07:30:00','','2025-03-29 21:58:33',NULL,'Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary ''),(62,74,1,'2025-03-30 14:30:00','','2025-03-29 22:34:39',NULL,'Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '\0'),(63,74,1,'2025-03-30 14:30:00','','2025-03-29 22:35:35',NULL,'Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary ''),(64,74,4,'2025-03-30 14:30:00','','2025-03-29 22:36:10','2025-03-29 22:45:14','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '\0'),(65,74,5,'2025-03-30 14:30:00','','2025-03-29 22:37:00','2025-03-29 22:44:58','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary ''),(66,74,1,'2025-03-30 12:39:00','','2025-03-29 22:37:17','2025-03-29 22:44:53','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '\0'),(67,75,1,'2025-03-30 14:30:00','','2025-03-29 22:38:37',NULL,'Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary ''),(68,75,1,'2025-03-30 14:30:00','','2025-03-29 22:39:00',NULL,'Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '\0'),(69,75,2,'2025-03-30 17:30:00','','2025-03-29 22:39:17','2025-03-30 00:09:28','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '\0'),(70,75,5,'2025-03-30 14:30:00','','2025-03-29 22:40:09','2025-03-29 22:46:18','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary ''),(71,75,3,'2025-03-30 14:30:00','','2025-03-29 22:40:54','2025-03-30 00:13:06','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '\0'),(72,75,4,'2025-03-30 14:30:00','','2025-03-29 22:41:08','2025-03-29 22:45:55','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '\0'),(73,74,2,'2025-03-31 14:30:00','','2025-03-30 08:05:24','2025-03-30 08:08:35','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary ''),(74,74,5,'2025-03-31 07:30:00','','2025-03-30 08:13:03','2025-03-30 08:13:23','Vu Thi','Bich','ameebro99@gmail.com','0384408427',_binary '');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservationdetail`
--

DROP TABLE IF EXISTS `reservationdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationdetail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int NOT NULL,
  `service_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `price` decimal(10,2) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `staff_id` int DEFAULT NULL,
  `status_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `reservation_id` (`reservation_id`),
  KEY `service_id` (`service_id`),
  KEY `fk_staff_id` (`staff_id`),
  KEY `reservationdetail_ibfk_3_idx` (`status_id`),
  CONSTRAINT `fk_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `fk_reservationdetailstatus_id` FOREIGN KEY (`status_id`) REFERENCES `reservationdetailstatus` (`id`),
  CONSTRAINT `fk_service_id` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`),
  CONSTRAINT `fk_staff_id` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationdetail`
--

LOCK TABLES `reservationdetail` WRITE;
/*!40000 ALTER TABLE `reservationdetail` DISABLE KEYS */;
INSERT INTO `reservationdetail` VALUES (138,60,1,1,100.00,'2025-03-29 01:32:02',NULL,1),(139,61,1,1,100.00,'2025-03-29 21:58:33',NULL,1),(140,62,1,3,100.00,'2025-03-29 22:34:39',NULL,1),(141,63,2,2,150.00,'2025-03-29 22:35:35',NULL,1),(142,63,3,1,40.00,'2025-03-29 22:35:35',NULL,1),(143,64,4,3,60.00,'2025-03-29 22:36:10',NULL,1),(144,65,5,3,70.00,'2025-03-29 22:37:00',NULL,1),(145,66,6,4,90.00,'2025-03-29 22:37:17',NULL,1),(146,67,1,3,100.00,'2025-03-29 22:38:37',NULL,1),(147,68,2,3,150.00,'2025-03-29 22:39:00',NULL,1),(148,69,3,3,40.00,'2025-03-29 22:39:17',67,2),(149,69,4,2,60.00,'2025-03-29 22:39:17',66,2),(150,70,5,1,70.00,'2025-03-29 22:40:09',NULL,1),(151,70,6,3,90.00,'2025-03-29 22:40:09',NULL,1),(152,71,7,4,120.00,'2025-03-29 22:40:54',66,6),(153,72,8,1,80.00,'2025-03-29 22:41:08',NULL,1),(154,72,9,1,50.00,'2025-03-29 22:41:08',NULL,1),(155,73,1,2,100.00,'2025-03-30 08:05:24',66,2),(156,73,2,2,150.00,'2025-03-30 08:05:24',70,2),(157,74,2,1,142.50,'2025-03-30 08:13:03',NULL,1);
/*!40000 ALTER TABLE `reservationdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservationdetailstatus`
--

DROP TABLE IF EXISTS `reservationdetailstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationdetailstatus` (
  `id` int NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationdetailstatus`
--

LOCK TABLES `reservationdetailstatus` WRITE;
/*!40000 ALTER TABLE `reservationdetailstatus` DISABLE KEYS */;
INSERT INTO `reservationdetailstatus` VALUES (1,'Not yet'),(2,'Assigned'),(3,'Rejected'),(4,'Confirmed'),(5,'Processing'),(6,'Completed ');
/*!40000 ALTER TABLE `reservationdetailstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservationstatus`
--

DROP TABLE IF EXISTS `reservationstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationstatus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationstatus`
--

LOCK TABLES `reservationstatus` WRITE;
/*!40000 ALTER TABLE `reservationstatus` DISABLE KEYS */;
INSERT INTO `reservationstatus` VALUES (1,'Pending'),(2,'Confirmed'),(3,'Completed'),(4,'Cancelled'),(5,'Pending Refund');
/*!40000 ALTER TABLE `reservationstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolefeature`
--

DROP TABLE IF EXISTS `rolefeature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rolefeature` (
  `role_id` int NOT NULL,
  `feature_id` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`role_id`,`feature_id`),
  KEY `feature_id` (`feature_id`),
  KEY `rolefeature_ibfk_1_idx` (`role_id`),
  CONSTRAINT `rolefeature_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `setting` (`setting_id`),
  CONSTRAINT `rolefeature_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolefeature`
--

LOCK TABLES `rolefeature` WRITE;
/*!40000 ALTER TABLE `rolefeature` DISABLE KEYS */;
INSERT INTO `rolefeature` VALUES (12,20,1),(12,21,1),(12,22,1),(12,23,1),(12,24,1),(12,28,1),(12,29,1),(12,33,1),(12,37,1),(12,38,1),(13,17,1),(13,18,1),(14,7,1),(14,8,1),(14,9,1),(14,10,1),(14,11,1),(14,13,1),(14,14,1),(14,15,1),(14,16,1),(14,17,1),(14,18,1),(14,20,1),(14,26,1),(14,30,1),(14,32,1),(14,36,1),(15,2,1),(15,3,1),(15,4,1),(15,5,1),(15,6,1),(15,34,1),(15,35,1),(15,39,1);
/*!40000 ALTER TABLE `rolefeature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text,
  `brief_info` text,
  `category_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `thumbnail` varchar(200) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `_idx` (`category_id`),
  CONSTRAINT `` FOREIGN KEY (`category_id`) REFERENCES `setting` (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Advanced Health Checkup','The Advanced Health Checkup service provides a thorough health examination for children, including a general assessment, blood tests, vision and hearing screening, growth index measurement (height, weight, BMI), and nutritional consultation. The goal of this service is to help parents monitor their child\'s health scientifically, detect any abnormalities early, and recommend timely interventions.','Advanced Health Checkup is a comprehensive health screening service for children, designed to detect potential health issues early and monitor their overall development. The service is conducted by experienced pediatricians using modern medical equipment.',2,100.00,0.00,'assets/images/services/service1.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(2,'Annual Health Screening','The Annual Health Screening service provides a full-body health checkup for children on a yearly basis. It includes a general physical examination, blood tests, vision and hearing assessments, dental checkups, growth monitoring (height, weight, BMI), and nutritional counseling. This service helps parents stay informed about their child’s health status, detect early signs of illness, and take preventive measures.','Annual Health Screening is a yearly comprehensive health assessment for children, aimed at tracking their growth, identifying potential health concerns, and ensuring their overall well-being. This service is conducted by professional pediatricians with advanced medical equipment.',3,150.00,5.00,'assets/images/services/service2.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(3,'Flu Vaccination','The Flu Vaccination service offers a safe and effective way to protect children from the flu virus, which can cause severe health complications if left untreated. The vaccine helps strengthen the immune system, reducing the risk of infection and minimizing flu-related symptoms.\n\nThis service is suitable for children of all ages and is recommended annually, especially before the flu season. Our healthcare professionals ensure that each vaccination follows strict safety protocols and is tailored to the child’s age and medical history. By getting a flu shot, children can stay healthy and active, reducing the chances of school absences and severe flu-related complications.','Flu Vaccination is a preventive healthcare service that provides children with annual flu shots to protect them from seasonal influenza. The vaccination is administered by qualified medical professionals to ensure safety and effectiveness.',4,40.00,0.00,'assets/images/services/service3.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(4,'MMR Vaccination','The MMR Vaccination service provides a highly effective vaccine to safeguard children from Measles, Mumps, and Rubella—three contagious diseases that can lead to severe complications if not prevented. The vaccine helps build strong immunity, reducing the risk of infection and contributing to overall public health protection.\n\nThe MMR vaccine is typically given in two doses, with the first dose administered at 12-15 months of age and the second dose at 4-6 years old. Our medical team ensures that each child receives the vaccination according to recommended guidelines, prioritizing safety and comfort.\n\nBy getting the MMR vaccine, children are protected from life-threatening illnesses, ensuring a healthier future and reducing the spread of these diseases within the community.','MMR Vaccination is an essential immunization service that protects children against three serious diseases: Measles, Mumps, and Rubella. The vaccine is administered by experienced healthcare professionals following strict safety guidelines.',5,60.00,0.00,'assets/images/services/service4.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(5,'Hepatitis B Vaccination','The Hepatitis B Vaccination service provides a safe and effective way to prevent Hepatitis B, a potentially life-threatening liver disease that can cause chronic infections and serious complications such as liver failure or cancer. The vaccine stimulates the immune system to develop long-term protection against the virus.\n\nThe Hepatitis B vaccine is usually given in a series of three to four doses, starting at birth, with additional doses administered in infancy and early childhood. Our medical team ensures that each vaccination follows the latest health guidelines to provide maximum protection.\n\nBy receiving the Hepatitis B vaccine, children are safeguarded from this infectious disease, contributing to better long-term health and preventing the spread of the virus within the community.','Hepatitis B Vaccination is a crucial immunization service that protects children from Hepatitis B, a serious liver infection caused by the Hepatitis B virus (HBV). The vaccine is administered by qualified healthcare professionals following recommended immunization schedules.',6,70.00,0.00,'assets/images/services/service5.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(6,'Weight Management Consultation','The Weight Management Consultation service provides expert guidance for children who may be underweight, overweight, or at risk of obesity. Our specialists assess the child\'s growth patterns, dietary habits, and physical activity levels to develop a customized plan that promotes a balanced and healthy lifestyle.\n\nDuring the consultation, parents receive professional advice on nutrition, portion control, exercise routines, and healthy eating habits tailored to their child’s needs. Regular follow-ups help track progress and make necessary adjustments to ensure sustainable weight management.\n\nThis service is ideal for parents seeking proactive solutions to support their child’s overall health and well-being, ensuring they grow strong, active, and confident.','Weight Management Consultation is a specialized service designed to help children achieve and maintain a healthy weight through personalized nutrition and lifestyle guidance. This service is conducted by experienced healthcare professionals, including pediatricians and nutritionists.',7,90.00,0.00,'assets/images/services/service6.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(7,'Allergy Testing and Diet Plan','The Allergy Testing and Diet Plan service helps parents understand their child\'s allergies through specialized tests that detect common allergens, including food, pollen, dust, pet dander, and more. Our medical team uses safe and accurate diagnostic methods, such as skin prick tests and blood tests, to identify potential allergic triggers.\n\nOnce the allergens are identified, a customized diet plan is created by expert nutritionists to ensure that the child receives balanced nutrition while avoiding allergy-inducing foods. The plan includes safe food alternatives, meal recommendations, and strategies for managing accidental exposure.\n\nThis service is ideal for children with known or suspected allergies, helping parents prevent allergic reactions, improve their child’s quality of life, and ensure their overall well-being.','Allergy Testing and Diet Plan is a comprehensive service that identifies food and environmental allergies in children and provides a tailored diet plan to prevent allergic reactions and promote a healthy lifestyle. This service is conducted by experienced allergists and nutritionists.',8,120.00,0.00,'assets/images/services/service7.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(8,'Tooth Extraction','The Tooth Extraction service provides a painless and stress-free solution for children who need to have a tooth removed due to severe decay, overcrowding, or dental infections. Our pediatric dentists use child-friendly approaches and local anesthesia to minimize discomfort during the procedure.\n\nBefore extraction, a thorough dental assessment is conducted to determine the best course of action. Post-extraction care instructions are provided to ensure proper healing and prevent complications. In cases where necessary, recommendations for orthodontic treatments or space maintainers are given to support healthy dental development.\n\nThis service ensures that children receive the best dental care, helping them maintain a healthy smile and preventing future oral health issues.','Tooth Extraction is a safe and professional dental service designed to remove damaged, decayed, or problematic teeth in children to maintain their oral health. The procedure is performed by experienced pediatric dentists using gentle techniques to ensure comfort and safety.',3,80.00,0.00,'assets/images/services/service8.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(9,'Braces Consultation','The Braces Consultation service helps parents understand whether their child needs braces and what type of orthodontic treatment would be most suitable. During the consultation, our orthodontists conduct a thorough examination of the child\'s teeth, jaw alignment, and bite structure using advanced diagnostic tools.\n\nBased on the assessment, a personalized treatment plan is provided, outlining the best options for braces, including traditional metal braces, ceramic braces, or clear aligners. The consultation also includes discussions on treatment duration, costs, and expected outcomes.\n\nThis service is ideal for children with crooked teeth, bite issues, or misaligned jaws, ensuring they receive early intervention for a healthier, straighter smile.','Braces Consultation is a professional orthodontic service that assesses a child’s dental alignment and provides expert recommendations on braces or other corrective treatments. The consultation is conducted by experienced orthodontists to ensure optimal dental health and a confident smile.',5,50.00,0.00,'assets/images/services/service9.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(10,'Teeth Whitening','The Teeth Whitening service helps improve the appearance of children\'s teeth by reducing stains caused by food, drinks, or natural discoloration. Using safe and mild whitening agents, our pediatric dentists ensure that the procedure is gentle on young teeth while delivering noticeable results.\n\nBefore the treatment, a dental assessment is conducted to determine the best whitening method for the child. The procedure is quick, painless, and tailored to protect developing teeth and gums. Parents also receive guidance on maintaining their child’s bright smile through proper oral hygiene and dietary habits.\n\nThis service is ideal for children who want a healthier, whiter smile while ensuring their dental health remains a top priority.','Teeth Whitening is a safe and gentle dental service designed to brighten children\'s teeth by removing stains and discoloration. This service is performed by experienced pediatric dentists using kid-friendly, non-invasive whitening techniques.',6,100.00,10.00,'assets/images/services/service10.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(11,'24/7 Emergency Consultation','The 24/7 Emergency Consultation service offers parents peace of mind by providing instant access to pediatricians and medical experts whenever urgent health concerns arise. Whether it\'s a high fever, allergic reaction, injury, or unexpected illness, our medical team is available 24/7 to provide immediate guidance and support.\n\nConsultations can be conducted via phone or video calls, allowing parents to receive professional advice without the need for immediate hospital visits. If necessary, our experts will recommend further medical attention or emergency care.\n\nThis service is ideal for parents seeking quick, reliable, and professional healthcare assistance at any time, ensuring their child\'s safety and well-being around the clock.','24/7 Emergency Consultation is a round-the-clock medical service providing immediate access to healthcare professionals for urgent child health concerns. This service ensures that parents can receive expert medical advice and guidance anytime, day or night.',7,250.00,0.00,'assets/images/services/service11.jpg',0,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(12,'Injury Treatment','The Injury Treatment service offers immediate and professional medical care for children who have sustained injuries during play, sports, or daily activities. Our healthcare team assesses the severity of the injury and provides appropriate treatment, including wound cleaning, stitches (if necessary), bandaging, pain management, and follow-up care.\n\nFor more serious injuries such as fractures, sprains, or deep wounds, our specialists will provide emergency stabilization and recommend further treatment if required. Parents also receive guidance on home care and recovery to ensure the child heals quickly and safely.\n\nThis service is essential for ensuring children receive proper medical attention for their injuries, reducing the risk of infection and long-term complications.','Injury Treatment is a specialized medical service that provides prompt and effective care for children’s injuries, ranging from minor cuts and bruises to more serious wounds. The service is delivered by experienced pediatric healthcare professionals to ensure proper healing and prevent complications.',8,150.00,0.00,'assets/images/services/service12.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(13,'Post-Surgery Rehabilitation','The Post-Surgery Rehabilitation service offers personalized care and therapy to support a child’s recovery following a surgical procedure. Our rehabilitation specialists develop customized recovery plans that may include physical therapy, pain management, mobility exercises, and nutritional guidance to promote healing.\n\nThe program focuses on helping children restore their normal activities safely and comfortably while preventing complications. Regular progress assessments ensure that the child is recovering effectively, and parents receive expert guidance on post-surgery care at home.\n\nThis service is ideal for children recovering from orthopedic, neurological, or other major surgeries, ensuring a smooth and successful rehabilitation process for long-term health and mobility.','Post-Surgery Rehabilitation is a specialized recovery program designed to help children regain strength, mobility, and overall well-being after surgery. This service is provided by experienced pediatric healthcare professionals, including physiotherapists and rehabilitation specialists.',3,120.00,0.00,'assets/images/services/service13.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(14,'Sports Injury Therapy','The Sports Injury Therapy service provides targeted treatment for children who have sustained injuries while participating in sports or physical activities. Our team of experts assesses the severity of the injury and designs a personalized rehabilitation plan that includes physical therapy, strength training, flexibility exercises, and pain management strategies.\n\nThe therapy focuses on accelerating recovery, improving muscle function, and reducing the risk of reinjury. We also educate young athletes on proper techniques, warm-up routines, and injury prevention strategies to ensure long-term safety in sports.\n\nThis service is ideal for active children recovering from sprains, fractures, muscle strains, or joint injuries, helping them return to their favorite activities stronger and more resilient.','Sports Injury Therapy is a specialized rehabilitation service designed to help children recover from sports-related injuries, restore mobility, and prevent future injuries. The therapy is conducted by experienced physiotherapists and pediatric sports medicine specialists.',4,110.00,0.00,'assets/images/services/service14.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(15,'Developmental Delay Therapy','The Developmental Delay Therapy service provides personalized treatment plans for children who show signs of delayed growth in key developmental areas such as motor skills, language, social interactions, and cognitive abilities. Our expert team conducts comprehensive assessments to identify specific challenges and tailors therapy sessions to meet each child’s unique needs.\n\nTherapies may include speech and language therapy, occupational therapy, physical therapy, and behavioral interventions to improve the child’s ability to communicate, move, and interact with their surroundings effectively. Parental guidance and home-based strategies are also provided to ensure continuous progress.\n\nThis service is ideal for children who need extra support in their developmental journey, helping them build confidence, achieve milestones, and reach their full potential.','Developmental Delay Therapy is a specialized intervention service designed to support children experiencing delays in physical, cognitive, speech, or social development. The therapy is conducted by experienced pediatric specialists, including speech therapists, occupational therapists, and developmental psychologists.',5,130.00,0.00,'assets/images/services/service15.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(16,'Anxiety Counseling','The Anxiety Counseling service provides a safe and supportive environment where children can express their feelings and learn coping strategies to manage anxiety. Our trained child psychologists assess the child’s emotional well-being and develop personalized therapy plans that may include cognitive-behavioral therapy (CBT), relaxation techniques, and mindfulness exercises.\n\nThrough guided sessions, children learn how to identify triggers, build emotional resilience, and develop healthy ways to handle stress. Parents also receive expert advice on how to support their child at home and foster a positive mental health environment.\n\nThis service is ideal for children experiencing excessive worry, social anxiety, school-related stress, or emotional distress, ensuring they gain confidence and emotional stability in their daily lives.','Anxiety Counseling is a professional mental health service designed to help children manage anxiety, stress, and emotional challenges. The counseling sessions are conducted by experienced child psychologists and therapists using age-appropriate techniques.',2,110.00,0.00,'assets/images/services/service16.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(17,'Behavioral Therapy','The Behavioral Therapy service focuses on improving a child\'s ability to regulate emotions, develop positive behaviors, and interact effectively with others. Our specialists work closely with children to identify problematic behaviors, understand underlying causes, and implement structured interventions tailored to their needs.\n\nUsing approaches such as Cognitive Behavioral Therapy (CBT), Applied Behavior Analysis (ABA), and social skills training, children learn how to handle frustration, improve communication, and build self-control. Parents are also provided with strategies to reinforce positive behavior at home and support their child’s progress.\n\nThis service is ideal for children dealing with issues such as ADHD, aggression, anxiety, defiance, or social difficulties, helping them develop healthier behaviors and thrive in their daily lives.','Behavioral Therapy is a specialized psychological service designed to help children manage emotional, social, and behavioral challenges. Therapy sessions are conducted by experienced child psychologists and behavioral therapists using evidence-based techniques.',3,120.00,0.00,'assets/images/services/service17.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(18,'ADHD Management','The ADHD Management service provides comprehensive support for children diagnosed with Attention-Deficit/Hyperactivity Disorder (ADHD) through a combination of behavioral therapy, educational interventions, and medication when necessary. Our specialists develop personalized treatment plans to help children improve focus, self-regulation, and impulse control. Behavioral therapy teaches coping strategies and self-discipline, while educational support involves collaborating with schools to create learning accommodations that enhance academic performance. In some cases, stimulant or non-stimulant medications may be prescribed to help manage symptoms effectively. Additionally, parents receive expert guidance on how to support their child’s development at home. This service ensures that children with ADHD receive the right tools and interventions to thrive in their daily lives, improving their overall well-being and future success.','ADHD Management is a comprehensive service designed to support children diagnosed with Attention-Deficit/Hyperactivity Disorder (ADHD). This service combines medical treatment, behavioral therapy, and educational interventions to help children manage symptoms, improve functioning, and enhance their quality of life.',4,130.00,0.00,'assets/images/services/service18.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(19,'Newborn Health Checkup','The Newborn Health Checkup typically occurs within 3 to 5 days after birth. During this visit, healthcare providers perform a thorough physical examination, which includes measuring the baby\'s weight, length, and head circumference to monitor growth patterns. They also assess vital signs, examine the baby\'s eyes, heart, hips, and, in boys, testicles, to identify any abnormalities. Screening tests are conducted to detect rare but serious conditions; for instance, a small blood sample is taken from the baby\'s heel to test for various disorders. Additionally, a hearing test and oxygen level assessment are performed to ensure the baby\'s auditory and respiratory health. This checkup provides an opportunity for parents to discuss any concerns, receive advice on feeding, sleeping, and general newborn care, and establish a schedule for future well-baby visits to monitor the baby\'s ongoing health and development.','\nBrief Info:\nNewborn Health Checkup is a comprehensive medical examination conducted within the first few days after birth to assess a newborn\'s overall health, growth, and development. This initial checkup is crucial for early detection of any potential health issues and to provide parents with guidance on newborn care.',7,70.00,0.00,'assets/images/services/service19.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(20,'Growth Monitoring','The Growth Monitoring service entails periodic evaluations of a child\'s physical development, typically conducted monthly during the early years. Healthcare providers measure and record key growth indicators, plotting them on standardized growth charts to track progress over time. This process helps identify any deviations from expected growth patterns, which may signal underlying health or nutritional issues. When such concerns are detected, tailored counseling and interventions are provided to address the specific needs of the child. Regular growth monitoring not only ensures that children are developing appropriately but also serves as a platform for caregivers to receive guidance on nutrition, feeding practices, and overall child care. By closely observing growth trends, healthcare providers can implement preventive measures and promote healthy development, thereby reducing the risk of malnutrition and associated health complications.','Growth Monitoring is a routine health service that involves the regular measurement and assessment of a child\'s growth parameters, such as weight, height, and head circumference, to ensure proper development. This practice is essential for early detection of growth faltering or malnutrition, allowing for timely interventions to promote optimal health outcomes.',9,60.00,0.00,'assets/images/services/service20.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(21,'Chickenpox Vaccination','The Chickenpox Vaccination service provides immunization to safeguard children from chickenpox, a highly contagious disease characterized by an itchy rash and fever. The vaccination schedule includes two doses: the first dose is recommended between 12 and 15 months of age, and the second dose between 4 and 6 years old. For children older than 6 who have not been vaccinated or had chickenpox, two doses are administered at least three months apart. The vaccine is highly effective, with two doses providing approximately 98% protection in children. Vaccinated individuals who contract chickenpox typically experience milder symptoms. Common side effects are mild and may include soreness or swelling at the injection site. This vaccination is essential for preventing chickenpox and its potential complications, ensuring children\'s health and well-being.','Chickenpox Vaccination is a preventive immunization service that protects children against varicella-zoster virus, the cause of chickenpox. The vaccine is administered in two doses to ensure effective immunity.',3,50.00,0.00,'assets/images/services/service21.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46'),(22,'Pneumococcal Vaccination','The Pneumococcal Vaccination service involves administering a series of pneumococcal conjugate vaccines (PCV) to children, following a recommended immunization schedule. The Centers for Disease Control and Prevention (CDC) advises that all children younger than 5 years old receive a 4-dose PCV series, with one dose at each of the following ages: 2 months, 4 months, 6 months, and 12 through 15 months. The vaccines used, such as PCV15 or PCV20, are effective in preventing pneumococcal diseases and are administered by qualified healthcare professionals. Adhering to the vaccination schedule is crucial for ensuring optimal protection during the early years of a child\'s life. Parents are encouraged to consult with their pediatrician to keep their child\'s immunizations up to date and to discuss any concerns regarding the vaccine.\n\nBy completing the pneumococcal vaccination series, children gain significant protection against potentially life-threatening infections, contributing to their overall health and well-being.','Pneumococcal Vaccination is a preventive immunization service designed to protect children against infections caused by the bacterium Streptococcus pneumoniae, commonly known as pneumococcus. These infections can lead to serious illnesses such as pneumonia, meningitis, and bloodstream infections.',2,80.00,0.00,'assets/images/services/service22.jpg',1,'2025-01-31 23:46:55','2025-02-16 11:38:46');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `setting_id` int NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL,
  `value` varchar(200) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`setting_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `setting_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `settingtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` VALUES (2,1,'General Checkup','Regular health checkups for 1children to monitor growth.',_binary ''),(3,1,'Vaccination','Vaccination services to protect children from various diseases.',_binary ''),(4,1,'Nutrition','Nutritional advice and dietary plans for children.',_binary ''),(5,1,'Dental Care','Dental health services for children, including checkups and treatments.',_binary ''),(6,1,'Emergency Care','Emergency medical services for children.',_binary ''),(7,1,'Physical Therapy','Physical therapy services to support children with movement issues.',_binary ''),(8,1,'Mental Health','Mental health support and counseling for children.',_binary ''),(9,2,'Health Tips','Posts related to health tips for children.',_binary ''),(10,2,'Vaccination','Posts related to vaccination information.',_binary ''),(11,2,'Nutrition','Posts related to child nutrition.',_binary ''),(12,3,'Admin','Adminstrator with permissions for config',_binary ''),(13,3,'Staff','Medical professional providing health services',_binary ''),(14,3,'Manager','Manage and assign staff in the operations',_binary ''),(15,3,'Customer','User who using the services.',_binary '');
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settingtype`
--

DROP TABLE IF EXISTS `settingtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settingtype` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settingtype`
--

LOCK TABLES `settingtype` WRITE;
/*!40000 ALTER TABLE `settingtype` DISABLE KEYS */;
INSERT INTO `settingtype` VALUES (1,'Category'),(2,'Label'),(3,'Role');
/*!40000 ALTER TABLE `settingtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slider`
--

DROP TABLE IF EXISTS `slider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slider` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `image_url` varchar(200) NOT NULL,
  `back_link` varchar(200) DEFAULT NULL,
  `author_id` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `slider_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
INSERT INTO `slider` VALUES (1,'Welcome to Children Care','assets/images/slider/slider1.jpg','/blog?id=1',72,1,'2025-01-31 23:46:55','2025-03-30 00:39:44'),(2,'Healthy Kids, Happy Parents','assets/images/slider/slider2.jpg','/blog?id=2',72,1,'2025-01-31 23:46:55','2025-03-30 00:39:44'),(3,'Book an Appointment Today','assets/images/slider/slider3.jpg','/blog?id=3',72,1,'2025-01-31 23:46:55','2025-03-30 00:39:44'),(4,'Fun Activities for Kids','assets/images/slider/slider4.jpg','/blog?id=16',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(5,'Expert Childcare Services','assets/images/slider/slider5.jpg','/blog?id=17',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(6,'Your Child’s Health Matters','assets/images/slider/slider6.jpg','/blog?id=18',72,0,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(7,'Educational Programs','assets/images/slider/slider7.jpg','/blog?id=19',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(8,'Nutritional Guidance','assets/images/slider/slider8.jpg','/blog?id=20',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(9,'Safe and Secure Environment','assets/images/slider/slider9.jpg','/blog?id=21',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(10,'Engaging Playtime','assets/images/slider/slider10.jpg','/blog?id=22',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(11,'Caring and Supportive Staff','assets/images/slider/slider11.jpg','/blog?id=23',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(12,'Parental Involvement','assets/images/slider/slider12.jpg','/blog?id=24',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44'),(13,'Book a Consultation','assets/images/slider/slider13.jpg','/blog?id=25',72,1,'2025-02-08 23:38:14','2025-03-30 00:39:44');
/*!40000 ALTER TABLE `slider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `email_verified` tinyint(1) DEFAULT '0',
  `verification_token` varchar(255) DEFAULT NULL,
  `token_expiration` datetime DEFAULT NULL,
  `role_id` int NOT NULL DEFAULT '15',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiration` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `IX_User_Email` (`email`),
  KEY `IX_User_Username` (`username`),
  KEY `userrole_fk1_idx` (`role_id`),
  CONSTRAINT `userrole_fk1` FOREIGN KEY (`role_id`) REFERENCES `setting` (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (66,'staffA','p4WJw3jDgrGaeH59dEFuRLuzwXY=','dominhchi235@gmail.com',1,NULL,NULL,13,1,'2025-03-28 22:53:15','2025-03-28 22:55:33',NULL,NULL),(67,'staffB','p4WJw3jDgrGaeH59dEFuRLuzwXY=','anhdmhe181481@fpt.edu.vn',1,NULL,NULL,13,1,'2025-03-28 22:59:12','2025-03-28 23:08:45',NULL,NULL),(68,'staffC','p4WJw3jDgrGaeH59dEFuRLuzwXY=','staff1@gmail.com',1,NULL,NULL,13,1,'2025-03-28 23:04:12','2025-03-28 23:08:57',NULL,NULL),(69,'staffD','p4WJw3jDgrGaeH59dEFuRLuzwXY=','staff2@gmail.com',1,NULL,NULL,13,1,'2025-03-28 23:05:33','2025-03-28 23:08:57',NULL,NULL),(70,'staffE','p4WJw3jDgrGaeH59dEFuRLuzwXY=','staff3@gmail.com',1,NULL,NULL,13,1,'2025-03-28 23:06:41','2025-03-28 23:08:57',NULL,NULL),(71,'adminA','p4WJw3jDgrGaeH59dEFuRLuzwXY=','buiblue123@gmail.com',1,NULL,NULL,12,1,'2025-03-28 23:15:20','2025-03-29 21:41:38',NULL,NULL),(72,'managerA','p4WJw3jDgrGaeH59dEFuRLuzwXY=','milo9a5@gmail.com',1,NULL,NULL,14,1,'2025-03-28 23:19:33','2025-03-28 23:20:30',NULL,NULL),(73,'managerB','p4WJw3jDgrGaeH59dEFuRLuzwXY=','quyenndhe181686@fpt.edu.vn',1,NULL,NULL,14,1,'2025-03-28 23:21:59','2025-03-28 23:22:31',NULL,NULL),(74,'customerA','p4WJw3jDgrGaeH59dEFuRLuzwXY=','ameebro99@gmail.com',1,NULL,NULL,15,1,'2025-03-28 23:26:11','2025-03-30 00:17:22',NULL,NULL),(75,'customerB','p4WJw3jDgrGaeH59dEFuRLuzwXY=','tainvhe187366@fpt.edu.vn',1,NULL,NULL,15,1,'2025-03-28 23:28:12','2025-03-28 23:28:41',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `user_id` int NOT NULL,
  `service_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`user_id`,`service_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-06 12:52:22
