-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: childrencare
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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'General Checkup','Regular health checkups for children to monitor growth and development.',1),(2,'Vaccination','Vaccination services to protect children from various diseases.',1),(3,'Nutrition','Nutritional advice and dietary plans for children.',1),(4,'Dental Care','Dental health services for children, including checkups and treatments.',1),(5,'Emergency Care','Emergency medical services for children.',1),(6,'Physical Therapy','Physical therapy services to support children with physical disabilities or injuries.',1),(7,'Mental Health','Mental health support and counseling for children.',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
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
  `url` varchar(200) DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (2,'Reservation Details','/reservation/detail','',_binary ''),(3,'Reservation Contact','/reservation/contact','',_binary ''),(4,'Reservation Completion','/reservation/completion','',_binary ''),(5,'My reservations','/my-reservation','',_binary ''),(6,'Reservation Information','/reservation/info','',_binary ''),(7,'Posts List','/posts','',_binary ''),(8,'Post Details','/post','',_binary ''),(9,'Sliders List','/sliders','',_binary ''),(10,'Slider Details','/slider','',_binary ''),(11,'Services List (Manager)','/services/manager','',_binary ''),(12,'Service Details (Manager)','/services/update','',_binary ''),(13,'Customers List','/customers','',_binary ''),(14,'Customer Details','/customer','',_binary ''),(15,'Feedbacks List','/feedbacks','',_binary ''),(16,'Feedback Details','/feedback','',_binary ''),(17,'Reservations List','/reservations','',_binary ''),(18,'Reservation Details','/reservation','',_binary ''),(19,'Medical examination','/medical','',_binary ''),(20,'Admin Dashboard','/admin','',_binary ''),(21,'Users List','/users','',_binary ''),(22,'User Details','/users/update','',_binary ''),(23,'Settings List','/settings','',_binary ''),(24,'Setting Details','/setting','',_binary ''),(25,'Feedback','/reservation/feedback','',_binary ''),(26,'Add Service','/services/add',' ',_binary ''),(27,'Reservation Information','/reservation/info',NULL,_binary ''),(28,'Permission Control','/permissions',NULL,_binary ''),(29,'Add User','/users/add',NULL,_binary ''),(30,'Add Customer','/customer/add',NULL,_binary ''),(31,'Add Service','/services/add',NULL,_binary ''),(32,'Update Service','/services/update',NULL,_binary ''),(33,'Add Setting','/settings/add',NULL,_binary '');
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
  `rating` int DEFAULT NULL,
  `comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` bit(1) DEFAULT b'1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
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
INSERT INTO `feedback` VALUES (14,5,'Great service, very satisfied with the care provided',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(15,4,'Good experience overall, would recommend',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(16,5,'Excellent staff, very attentive to needs',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(17,3,'Satisfactory service, some areas need improvement',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(18,4,'Professional and caring staff',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(19,5,'Highly recommended for quality childcare',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(20,4,'Good facilities and activities',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(21,3,'Average experience, could be better',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(22,5,'Fantastic care and attention to detail',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(23,4,'Very good service, child enjoyed their time',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(24,5,'Excellent communication from staff',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(25,3,'Decent service but room for improvement',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(26,4,'Good quality care, child felt comfortable',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(27,5,'Outstanding service, exceeded expectations',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(28,4,'Reliable and trustworthy service',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(29,3,'Adequate care provided, but limited activities',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(30,5,'Exceptional care and attention',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(31,4,'Very satisfied with the service',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(32,5,'Amazing staff, very friendly and helpful',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(33,3,'Service was okay, staff could be more attentive',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(34,4,'Good environment for children',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(35,5,'Wonderful experience, will use again',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(36,4,'Very good service and facilities',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(37,3,'Average service, nothing special',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(38,5,'Superb care, child loved it',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(39,4,'Good quality care and activities',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(40,5,'Excellent service, highly recommended',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(41,3,'Satisfactory but could improve communication',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(42,4,'Good care provided, child was happy',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(43,5,'Fantastic service from start to finish',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(44,4,'Very professional and caring staff',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(45,3,'Decent service but understaffed at times',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(46,5,'Outstanding care and facilities',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(47,4,'Good experience, would use again',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(48,5,'Exceptional service, very satisfied',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(49,3,'Average experience, some improvements needed',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(50,4,'Good quality care provided',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(51,5,'Excellent service and staff',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(52,4,'Very good experience overall',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(53,3,'Satisfactory service provided',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(54,5,'Wonderful care, child was very happy',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(55,4,'Good staff and facilities',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(56,5,'Excellent care and attention to detail',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(57,3,'Average service, could be more engaging',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(58,4,'Good quality childcare service',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(59,5,'Fantastic experience, will definitely return',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(60,4,'Very satisfied with the care provided',_binary '','2025-03-20 09:38:07','2025-03-20 09:38:07'),(61,1,'Very poor service, would not recommend',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(62,1,'Disappointing experience, staff was inattentive',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(63,1,'Inadequate facilities and supervision',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(64,1,'Poor communication and service quality',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(65,1,'Unsatisfactory experience, many issues',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(66,1,'Very unhappy with the service provided',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(67,1,'Extremely disappointed, will not return',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(68,2,'Below average service, needs significant improvement',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(69,2,'Not satisfied with the quality of care',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(70,2,'Poor facilities but staff tried their best',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(71,2,'Subpar experience, many areas need attention',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(72,2,'Disappointed with the level of service',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(73,2,'Below expectations, would not recommend',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41'),(74,2,'Mediocre service and facilities',_binary '','2025-03-20 09:38:41','2025-03-20 09:38:41');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `label`
--

DROP TABLE IF EXISTS `label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `label` (
  `id` int NOT NULL,
  `labelName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `label`
--

LOCK TABLES `label` WRITE;
/*!40000 ALTER TABLE `label` DISABLE KEYS */;
INSERT INTO `label` VALUES (1,'Health Tips','Posts related to health tips for children.',1),(2,'Vaccination','Posts related to vaccination information.',1),(3,'Nutrition','Posts related to child nutrition.',1);
/*!40000 ALTER TABLE `label` ENABLE KEYS */;
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
-- Table structure for table `medicalexamination`
--

DROP TABLE IF EXISTS `medicalexamination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalexamination` (
  `id` int NOT NULL AUTO_INCREMENT,
  `examination_date` datetime DEFAULT NULL,
  `diagnosis` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `notes` text,
  `status` tinyint(1) DEFAULT '1',
  `done_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `reservationdetail_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reservationdetail_id` (`reservationdetail_id`),
  CONSTRAINT `fk_reservationdetail_id` FOREIGN KEY (`reservationdetail_id`) REFERENCES `reservationdetail` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalexamination`
--

LOCK TABLES `medicalexamination` WRITE;
/*!40000 ALTER TABLE `medicalexamination` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicalexamination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicalprescription`
--

DROP TABLE IF EXISTS `medicalprescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalprescription` (
  `id` int NOT NULL,
  `examination_id` int NOT NULL,
  `medicine_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `dosage` int DEFAULT NULL,
  `instructions` text,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `examination_id` (`examination_id`),
  CONSTRAINT `medicalprescription_ibfk_1` FOREIGN KEY (`examination_id`) REFERENCES `medicalexamination` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalprescription`
--

LOCK TABLES `medicalprescription` WRITE;
/*!40000 ALTER TABLE `medicalprescription` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicalprescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymenthistory`
--

DROP TABLE IF EXISTS `paymenthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymenthistory` (
  `reservation_id` int NOT NULL,
  `amount` int DEFAULT NULL,
  `transactiondate` varchar(100) DEFAULT NULL,
  `txnref` varchar(100) DEFAULT NULL,
  `transactiono` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  CONSTRAINT `fk1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymenthistory`
--

LOCK TABLES `paymenthistory` WRITE;
/*!40000 ALTER TABLE `paymenthistory` DISABLE KEYS */;
INSERT INTO `paymenthistory` VALUES (38,846000000,'20250317183305','99641153187120802800','14850430'),(40,94000000,'20250317183443','76231131315511322900','14850433');
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
  `author_id` int DEFAULT NULL,
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` text,
  `thumbnail` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `brief_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,'Importance of Regular Checkups','<p>Regular health checkups are essential for monitoring the growth and development of children.</p>\r\n\r\n<p><a href=\"https://letsenhance.io/\"><img alt=\"\" src=\"https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/6e61b/MainAfter.avif\" style=\"height:113px; width:200px\" /></a></p>\r\n\r\n<p>adnvaudviladv</p>\r\n\r\n<p>&nbsp;</p>\r\n','assets/images/blog/blog1.jpg',1,'2025-01-31 23:46:56','2025-03-19 22:00:01','Regular health checkups are essential for monitoring the growth and development of children.'),(2,2,'Vaccination Schedule for Children','Ensure your child is up-to-date with their vaccinations to protect them from diseases.','assets/images/blog/blog2.jpg',1,'2025-01-31 23:46:56','2025-03-19 22:00:01','Ensure your child is up-to-date with their vaccinations to protect them from diseases.'),(3,3,'Nutrition Tips for Kids','A balanced diet is crucial for the healthy development of children.','assets/images/blog/blog3.jpg',1,'2025-01-31 23:46:56','2025-03-19 22:00:01','A balanced diet is crucial for the healthy development of children.'),(16,1,'Common Childhood Illnesses','Understanding and preventing common childhood illnesses helps keep your child healthy.','assets/images/blog/blog16.jpg',1,'2025-02-01 09:12:45','2025-03-19 22:00:01','Understanding and preventing common childhood illnesses helps keep your child healthy.'),(17,1,'How to Build Strong Immunity','Learn about the best ways to boost your child’s immune system.','assets/images/blog/blog17.jpg',1,'2025-02-01 09:15:20','2025-03-19 22:00:01','Learn about the best ways to boost your child’s immune system.'),(18,1,'First Aid for Children','Essential first aid tips for dealing with common injuries in children.','assets/images/blog/blog18.jpg',1,'2025-02-01 09:20:10','2025-03-19 22:00:01','Essential first aid tips for dealing with common injuries in children.'),(19,1,'Sleep Routines for Kids','Establishing healthy sleep routines is vital for your child’s development.','assets/images/blog/blog19.jpg',1,'2025-02-01 09:22:35','2025-03-19 22:00:01','Establishing healthy sleep routines is vital for your child’s development.'),(20,1,'Dental Care for Children','Starting dental care early can prevent future dental problems.','assets/images/blog/blog20.jpg',1,'2025-02-01 09:25:00','2025-03-19 22:00:01','Starting dental care early can prevent future dental problems.'),(21,1,'Mental Health in Children','Supporting your child’s mental health is as important as their physical health.','assets/images/blog/blog21.jpg',1,'2025-02-01 09:30:15','2025-03-19 22:00:01','Supporting your child’s mental health is as important as their physical health.'),(22,1,'Exercise for Kids','Regular physical activity is key for your child’s growth and well-being.','assets/images/blog/blog22.jpg',1,'2025-02-01 09:35:10','2025-03-19 22:00:01','Regular physical activity is key for your child’s growth and well-being.'),(23,1,'Skin Care for Children','Learn the importance of gentle skin care for young children.','assets/images/blog/blog23.jpg',1,'2025-02-01 09:40:25','2025-03-19 22:00:01','Learn the importance of gentle skin care for young children.'),(24,1,'Sun Protection for Kids','Protect your child from harmful UV rays with the right sun protection.','assets/images/blog/blog24.jpg',1,'2025-02-01 09:45:35','2025-03-19 22:00:01','Protect your child from harmful UV rays with the right sun protection.'),(25,1,'edu','<p>yrhtegr</p>\r\n','assets/images/blog/pic2.jpg',1,'2025-03-19 22:16:52',NULL,'jtyhrge');
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
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(200) DEFAULT 'assets/images/profile/default.jpg',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
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
INSERT INTO `profile` VALUES (1,'Tai 123123','Nguyen Van',1,'2004-11-10','Nghi Loc, Nghe An','037628123','assets/images/profile/profile_1.jpg','2025-01-31 23:46:55','2025-03-19 16:37:37'),(2,'Anh','Do Minh',1,'1975-05-15','456 Health Lane kkk','124356789','assets/images/profile/profile_2.jpg','2025-01-31 23:46:55','2025-02-20 08:05:47'),(3,'Quyen','Nguyen Duc',0,'1985-08-20','789 Parent Road','345-678-9012','assets/images/profile/profile_3.jpg','2025-01-31 23:46:55','2025-02-20 08:05:47'),(4,'Long','Nguyen Hoang',1,'1990-03-10','101 Staff Avenue','456-789-0123','assets/images/profile/profile_4.jpg','2025-01-31 23:46:55','2025-02-20 08:05:47'),(29,'a','a',1,'2025-03-06','a','a','assets/images/profile/default.jpg','2025-03-06 09:00:12',NULL),(32,'qwe','qwe',1,'2025-03-11','sdsd','214122231','assets/images/profile/default.jpg','2025-03-06 02:17:41','2025-03-06 02:17:41'),(35,'Tai 123123','Nguyen Van',1,'2004-11-20','Nghi Loc, Nghe An 1233112231','1234546345','assets/images/profile/profile_35.jpg','2025-03-15 23:36:25','2025-03-19 17:24:12'),(36,'Long','Nguyen Hoang',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_35.jpg','2025-03-19 22:06:11',NULL),(37,'A','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_35.jpg','2025-03-20 07:46:35',NULL),(42,'B','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_36.jpg','2025-03-20 07:52:49',NULL),(43,'C','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_37.jpg','2025-03-20 07:52:53',NULL),(53,'D','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_38.jpg','2025-03-20 07:54:43',NULL),(59,'E','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_39.jpg','2025-03-20 07:54:54',NULL),(60,'F','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_40.jpg','2025-03-20 07:57:38',NULL),(61,'G','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_41.jpg','2025-03-20 07:59:04',NULL),(62,'H','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_42.jpg','2025-03-20 07:59:11',NULL),(63,'I','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_43.jpg','2025-03-20 07:59:18',NULL),(64,'J','Nguyen Van',1,'2003-08-22','Hanoi','0123456789','assets/images/profile/profile_44.jpg','2025-03-20 07:59:25',NULL);
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
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `banking` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `IX_Reservation_Customer` (`customer_id`),
  KEY `IX_Reservation_Date` (`reserve_date`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `reservationstatus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (14,1,3,'2025-03-22 07:30:00','','2025-03-05 15:22:27','2025-03-19 21:40:15','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(15,1,1,'2025-03-29 07:30:00','','2025-03-05 15:23:01',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(16,1,1,'2025-03-15 07:30:00','','2025-03-06 02:28:47',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(17,3,1,'2025-03-13 07:30:00','','2025-03-06 09:27:15',NULL,'Quyen','Nguyen Duc','parent1@childrencare.com','0373517718',_binary '\0'),(18,35,1,'2025-03-16 14:30:00','','2025-03-15 23:38:07',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(19,35,1,'2025-03-28 14:30:00','','2025-03-15 23:39:25','2025-03-16 00:58:53','Tai 1','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(20,35,1,'2025-03-18 00:08:00','','2025-03-17 10:08:15',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(21,35,1,'2025-03-18 07:30:00','','2025-03-17 10:09:54',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(22,35,1,'2025-03-18 07:30:00','','2025-03-17 10:10:26',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(23,35,1,'2025-03-18 08:30:00','','2025-03-17 10:11:08','2025-03-17 15:57:13','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(24,35,2,'2025-03-18 07:30:00','','2025-03-17 10:13:22','2025-03-17 10:52:28','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(25,35,2,'2025-03-18 07:30:00','','2025-03-17 10:16:36','2025-03-17 10:52:08','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(26,35,4,'2025-03-18 07:30:00','','2025-03-17 10:20:19','2025-03-17 10:51:58','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(27,35,1,'2025-03-18 14:30:00','','2025-03-17 15:58:52',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(28,35,1,'2025-03-18 14:30:00','','2025-03-17 16:00:54',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(29,35,1,'2025-03-18 14:30:00','','2025-03-17 16:10:20',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(30,35,1,'2025-03-18 14:30:00','','2025-03-17 16:18:38',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(31,35,1,'2025-03-18 07:30:00','','2025-03-17 16:47:14',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(32,35,1,'2025-03-18 14:30:00','','2025-03-17 17:42:27',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(33,35,1,'2025-03-18 07:30:00','','2025-03-17 18:17:38',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(34,35,1,'2025-03-18 07:30:00','','2025-03-17 18:18:41',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(35,35,1,'2025-03-18 14:30:00','','2025-03-17 18:21:03',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(36,35,1,'2025-03-18 14:30:00','','2025-03-17 18:21:55',NULL,'Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(37,35,4,'2025-03-18 07:30:00','','2025-03-17 18:24:13','2025-03-19 15:02:40','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(38,35,2,'2025-03-18 14:30:00','','2025-03-17 18:33:14','2025-03-19 15:01:55','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary ''),(39,35,2,'2025-03-18 07:30:00','','2025-03-17 18:34:19','2025-03-19 03:41:55','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '\0'),(40,35,2,'2025-03-18 07:30:00','','2025-03-17 18:34:53','2025-03-19 03:41:45','Tai','Nguyen Van','buiblue123@gmail.com','0373517718',_binary '');
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
  `reservation_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `price` decimal(10,2) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `staff_id` int DEFAULT NULL,
  `status_id` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `reservation_id` (`reservation_id`),
  KEY `service_id` (`service_id`),
  KEY `fk_staff_id` (`staff_id`),
  KEY `reservationdetail_ibfk_3_idx` (`status_id`),
  CONSTRAINT `fk_staff_id` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `reservationdetail_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reservationdetail_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reservationdetail_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `reservationdetailstatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationdetail`
--

LOCK TABLES `reservationdetail` WRITE;
/*!40000 ALTER TABLE `reservationdetail` DISABLE KEYS */;
INSERT INTO `reservationdetail` VALUES (14,14,2,1,142.50,'2025-03-05 15:22:27',30,6),(15,15,1,1,100.00,'2025-03-05 15:23:01',NULL,1),(16,15,2,1,150.00,'2025-03-05 15:23:01',NULL,1),(17,15,3,1,40.00,'2025-03-05 15:23:01',NULL,1),(18,15,5,1,70.00,'2025-03-05 15:23:01',NULL,1),(19,16,5,1,70.00,'2025-03-06 02:28:47',NULL,1),(20,17,1,1,100.00,'2025-03-06 09:27:15',NULL,1),(21,18,2,1,142.50,'2025-03-15 23:38:07',NULL,1),(22,19,1,1,100.00,'2025-03-15 23:39:25',NULL,1),(23,20,2,1,142.50,'2025-03-17 10:08:15',NULL,1),(24,21,6,1,90.00,'2025-03-17 10:09:54',NULL,1),(25,22,8,1,80.00,'2025-03-17 10:10:26',NULL,1),(26,23,6,1,90.00,'2025-03-17 10:11:08',NULL,1),(27,23,7,1,120.00,'2025-03-17 10:11:08',NULL,1),(28,23,8,1,80.00,'2025-03-17 10:11:08',NULL,1),(29,23,12,1,150.00,'2025-03-17 10:11:08',NULL,1),(30,24,2,2,150.00,'2025-03-17 10:13:22',NULL,1),(31,24,15,1,130.00,'2025-03-17 10:13:22',NULL,1),(32,24,16,1,110.00,'2025-03-17 10:13:22',NULL,1),(33,24,17,1,120.00,'2025-03-17 10:13:22',NULL,1),(34,24,18,1,130.00,'2025-03-17 10:13:22',NULL,1),(35,25,2,1,142.50,'2025-03-17 10:16:36',4,1),(36,26,1,1,100.00,'2025-03-17 10:20:19',NULL,1),(37,26,2,2,150.00,'2025-03-17 10:20:19',NULL,1),(38,26,3,2,40.00,'2025-03-17 10:20:19',NULL,1),(39,26,4,1,60.00,'2025-03-17 10:20:19',NULL,1),(40,26,5,1,70.00,'2025-03-17 10:20:19',NULL,1),(41,26,6,1,90.00,'2025-03-17 10:20:19',NULL,1),(42,27,2,1,150.00,'2025-03-17 15:58:52',NULL,1),(43,27,3,1,40.00,'2025-03-17 15:58:52',NULL,1),(44,28,2,1,150.00,'2025-03-17 16:00:54',NULL,1),(45,28,3,1,40.00,'2025-03-17 16:00:54',NULL,1),(46,28,4,1,60.00,'2025-03-17 16:00:54',NULL,1),(47,28,5,1,70.00,'2025-03-17 16:00:54',NULL,1),(48,28,6,1,90.00,'2025-03-17 16:00:54',NULL,1),(49,29,1,1,100.00,'2025-03-17 16:10:20',NULL,1),(50,29,2,1,150.00,'2025-03-17 16:10:20',NULL,1),(51,29,3,1,40.00,'2025-03-17 16:10:20',NULL,1),(52,29,4,1,60.00,'2025-03-17 16:10:20',NULL,1),(53,29,5,1,70.00,'2025-03-17 16:10:20',NULL,1),(54,29,6,1,90.00,'2025-03-17 16:10:20',NULL,1),(55,29,7,1,120.00,'2025-03-17 16:10:20',NULL,1),(56,29,8,1,80.00,'2025-03-17 16:10:20',NULL,1),(57,29,9,1,50.00,'2025-03-17 16:10:20',NULL,1),(58,29,10,1,100.00,'2025-03-17 16:10:20',NULL,1),(59,29,12,1,150.00,'2025-03-17 16:10:20',NULL,1),(60,29,13,1,120.00,'2025-03-17 16:10:20',NULL,1),(61,29,14,1,110.00,'2025-03-17 16:10:20',NULL,1),(62,29,15,1,130.00,'2025-03-17 16:10:20',NULL,1),(63,29,16,1,110.00,'2025-03-17 16:10:20',NULL,1),(64,29,17,1,120.00,'2025-03-17 16:10:20',NULL,1),(65,29,18,1,130.00,'2025-03-17 16:10:20',NULL,1),(66,29,19,1,70.00,'2025-03-17 16:10:20',NULL,1),(67,30,1,1,100.00,'2025-03-17 16:18:38',NULL,1),(68,30,2,1,150.00,'2025-03-17 16:18:38',NULL,1),(69,30,3,1,40.00,'2025-03-17 16:18:38',NULL,1),(70,30,4,1,60.00,'2025-03-17 16:18:38',NULL,1),(71,30,5,1,70.00,'2025-03-17 16:18:38',NULL,1),(72,30,6,1,90.00,'2025-03-17 16:18:38',NULL,1),(73,31,2,1,142.50,'2025-03-17 16:47:14',NULL,1),(74,32,1,1,100.00,'2025-03-17 17:42:27',NULL,1),(75,32,2,1,150.00,'2025-03-17 17:42:27',NULL,1),(76,32,3,1,40.00,'2025-03-17 17:42:27',NULL,1),(77,33,2,1,142.50,'2025-03-17 18:17:38',NULL,1),(78,34,2,1,142.50,'2025-03-17 18:18:41',NULL,1),(79,35,2,1,150.00,'2025-03-17 18:21:03',NULL,1),(80,35,3,1,40.00,'2025-03-17 18:21:03',NULL,1),(81,35,4,1,60.00,'2025-03-17 18:21:03',NULL,1),(82,35,5,1,70.00,'2025-03-17 18:21:03',NULL,1),(83,35,6,1,90.00,'2025-03-17 18:21:03',NULL,1),(84,36,1,1,100.00,'2025-03-17 18:21:55',NULL,1),(85,36,2,1,150.00,'2025-03-17 18:21:55',NULL,1),(86,36,3,1,40.00,'2025-03-17 18:21:55',NULL,1),(87,36,5,1,70.00,'2025-03-17 18:21:55',NULL,1),(88,36,6,1,90.00,'2025-03-17 18:21:55',NULL,1),(89,37,2,1,142.50,'2025-03-17 18:24:13',2,1),(90,38,1,1,100.00,'2025-03-17 18:33:14',NULL,1),(91,38,2,1,150.00,'2025-03-17 18:33:14',2,1),(92,38,3,1,40.00,'2025-03-17 18:33:14',4,1),(93,38,5,1,70.00,'2025-03-17 18:33:14',NULL,1),(94,39,2,1,142.50,'2025-03-17 18:34:19',NULL,1),(95,40,3,1,40.00,'2025-03-17 18:34:53',NULL,1);
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
  `status` varchar(45) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationstatus`
--

LOCK TABLES `reservationstatus` WRITE;
/*!40000 ALTER TABLE `reservationstatus` DISABLE KEYS */;
INSERT INTO `reservationstatus` VALUES (1,'Pending'),(2,'Confirmed'),(3,'Completed'),(4,'Cancelled');
/*!40000 ALTER TABLE `reservationstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin','Administrator with full access to the system.',_binary ''),(2,'Doctor','Medical professional providing health services.',_binary ''),(3,'Customer','Parent or guardian of a child using the services.',_binary ''),(4,'Manager','Support staff assisting in the operations.',_binary '');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
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
  `status` tinyint(1) DEFAULT '1',
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
INSERT INTO `rolefeature` VALUES (12,20,1),(12,21,1),(12,22,1),(12,23,1),(12,24,1),(12,28,1),(12,29,1),(12,33,1),(13,17,1),(13,18,1),(13,19,1),(14,7,1),(14,8,1),(14,9,1),(14,10,1),(14,11,1),(14,12,1),(14,13,1),(14,14,1),(14,15,1),(14,16,1),(14,26,1),(14,30,1),(14,31,1),(14,32,1),(15,2,1),(15,3,1),(15,4,1),(15,5,1),(15,25,1),(15,27,1),(16,2,1),(16,3,1),(16,4,1),(16,5,1),(16,6,1),(16,7,1),(16,8,1),(16,9,1),(16,10,1),(16,11,1),(16,12,1),(16,13,1),(16,14,1),(16,15,1),(16,16,1),(16,17,1),(16,18,1),(16,19,1),(16,20,1),(16,21,1),(16,22,1),(16,23,1),(16,24,1),(16,25,1),(16,26,1),(16,27,1),(16,28,1),(16,29,1),(16,30,1),(16,31,1),(16,32,1),(16,33,1);
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
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `_idx` (`category_id`),
  CONSTRAINT `` FOREIGN KEY (`category_id`) REFERENCES `setting` (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `type_id` int DEFAULT NULL,
  `value` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `status` bit(1) DEFAULT b'1',
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
INSERT INTO `setting` VALUES (2,1,'General Checkup','Regular health checkups for 1children to monitor growth.',_binary ''),(3,1,'Vaccination','Vaccination services to protect children from various diseases.',_binary ''),(4,1,'Nutrition','Nutritional advice and dietary plans for children.',_binary ''),(5,1,'Dental Care','Dental health services for children, including checkups and treatments.',_binary ''),(6,1,'Emergency Care','Emergency medical services for children.',_binary ''),(7,1,'Physical Therapy','Physical therapy services to support children with movement issues.',_binary ''),(8,1,'Mental Health','Mental health support and counseling for children.',_binary ''),(9,2,'Health Tips','Posts related to health tips for children.',_binary ''),(10,2,'Vaccination','Posts related to vaccination information.',_binary ''),(11,2,'Nutrition','Posts related to child nutrition.',_binary ''),(12,3,'Admin','Adminstrator with permissions for config',_binary ''),(13,3,'Staff','Medical professional providing health services',_binary ''),(14,3,'Manager','Manage and assign staff in the operations',_binary ''),(15,3,'Customer','User who using the services.',_binary ''),(16,3,'Dev','Role for developer',_binary '');
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
  `name` varchar(200) DEFAULT NULL,
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
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `image_url` varchar(200) DEFAULT NULL,
  `back_link` varchar(200) DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
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
INSERT INTO `slider` VALUES (1,'Welcome to Children Care','assets/images/slider/slider1.jpg','/app',1,1,'2025-01-31 23:46:55','2025-02-15 17:00:57'),(2,'Healthy Kids, Happy Parents','assets/images/slider/slider2.jpg','/services',1,1,'2025-01-31 23:46:55','2025-02-15 17:00:58'),(3,'Book an Appointment Today','assets/images/slider/slider3.jpg','/appointment',1,1,'2025-01-31 23:46:55','2025-02-15 17:00:59'),(4,'Fun Activities for Kids','assets/images/slider/slider4.jpg','/activities',1,1,'2025-02-08 23:38:14','2025-02-15 17:01:00'),(5,'Expert Childcare Services','assets/images/slider/slider5.jpg','/services',1,1,'2025-02-08 23:38:14','2025-02-15 17:00:56'),(6,'Your Child’s Health Matters','assets/images/slider/slider6.jpg','/health',1,0,'2025-02-08 23:38:14','2025-02-11 21:25:42'),(7,'Educational Programs','assets/images/slider/slider7.jpg','/education',1,1,'2025-02-08 23:38:14','2025-02-08 23:52:35'),(8,'Nutritional Guidance','assets/images/slider/slider8.jpg','/nutrition',1,1,'2025-02-08 23:38:14','2025-02-08 23:52:35'),(9,'Safe and Secure Environment','assets/images/slider/slider9.jpg','/safety',1,1,'2025-02-08 23:38:14','2025-02-08 23:52:35'),(10,'Engaging Playtime','assets/images/slider/slider10.jpg','/play',1,1,'2025-02-08 23:38:14','2025-02-08 23:52:35'),(11,'Caring and Supportive Staff','assets/images/slider/slider11.jpg','/team',1,1,'2025-02-08 23:38:14','2025-02-08 23:52:35'),(12,'Parental Involvement','assets/images/slider/slider12.jpg','/parents',1,1,'2025-02-08 23:38:14','2025-02-08 23:52:35'),(13,'Book a Consultation','assets/images/slider/slider13.jpg','/consultation',1,1,'2025-02-08 23:38:14','2025-02-08 23:52:35');
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
  `role_id` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','123','nvtai24norip@gmail.com',0,NULL,NULL,16,1,'2025-01-31 23:46:55','2025-03-19 15:10:21',NULL,NULL),(2,'doctor1','123','doctor1@childrencare.com',0,NULL,NULL,13,1,'2025-01-31 23:46:55','2025-03-08 00:16:22',NULL,NULL),(3,'parent1','123','parent1@childrencare.com',0,NULL,NULL,15,1,'2025-01-31 23:46:55','2025-03-08 00:16:22',NULL,NULL),(4,'staff1','123','staff1@childrencare.com',0,NULL,NULL,13,1,'2025-01-31 23:46:55','2025-03-08 00:16:22',NULL,NULL),(29,'anhdm','Minhanh140904','ameebro99@gmail.com',1,NULL,NULL,14,1,'2025-03-06 09:00:12','2025-03-08 00:16:22','58f15957-fd71-412e-af6d-57999285bedc','2025-03-06 12:05:05'),(30,'dev','123','abc@gmail.com',1,NULL,NULL,16,1,'2025-03-06 09:07:53','2025-03-08 00:16:22',NULL,NULL),(31,'dev2','123','abc1@gmail.com',0,NULL,NULL,16,1,'2025-03-06 09:38:11','2025-03-08 00:16:22',NULL,NULL),(32,'quyen123','Ducquyen123','milo9a5@gmail.com',0,'82ecff6c-3e11-4962-92e3-4cd06639fa5a','2025-03-06 12:17:41',16,1,'2025-03-06 09:17:41','2025-03-08 00:16:22',NULL,NULL),(35,'devip','123','buiblue123@gmail.com',0,NULL,NULL,16,1,'2025-03-15 23:35:07',NULL,NULL,NULL),(36,'long','123','long@gmail.com',0,NULL,NULL,14,1,'2025-03-19 22:05:14','2025-03-19 22:15:53',NULL,NULL),(37,'staffA','123','abc2@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:45:11',NULL,NULL,NULL),(42,'staffB','123','abc3@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:51:59',NULL,NULL,NULL),(43,'staffC','123','abc4@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:52:08',NULL,NULL,NULL),(53,'staffD','123','abc5@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:54:02',NULL,NULL,NULL),(59,'staffE','123','abc6@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:54:48',NULL,NULL,NULL),(60,'staffF','123','abc7@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:54:59',NULL,NULL,NULL),(61,'staffG','123','abc8@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:59:01',NULL,NULL,NULL),(62,'staffH','123','abc9@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:59:08',NULL,NULL,NULL),(63,'staffI','123','abc10@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:59:14',NULL,NULL,NULL),(64,'staffJ','123','abc11@gmail.com',0,NULL,NULL,13,1,'2025-03-20 07:59:21',NULL,NULL,NULL);
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
  `quantity` int DEFAULT NULL,
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
INSERT INTO `wishlist` VALUES (1,1,1),(1,2,8),(1,3,18),(1,4,1),(1,5,1),(30,2,1),(35,2,2),(35,4,2),(35,6,1),(35,9,1),(35,15,3);
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

-- Dump completed on 2025-03-21  9:13:37
