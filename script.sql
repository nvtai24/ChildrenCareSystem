-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: childrencare
-- ------------------------------------------------------
-- Server version	9.1.0

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
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
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
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`reservationdetail_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`reservationdetail_id`) REFERENCES `reservationdetail` (`id`),
  CONSTRAINT `feedback_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
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
  CONSTRAINT `labelpost_ibfk_1` FOREIGN KEY (`label_id`) REFERENCES `label` (`id`),
  CONSTRAINT `labelpost_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labelpost`
--

LOCK TABLES `labelpost` WRITE;
/*!40000 ALTER TABLE `labelpost` DISABLE KEYS */;
INSERT INTO `labelpost` VALUES (1,1),(2,2),(3,3);
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
  `reservation_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `examination_date` datetime DEFAULT NULL,
  `diagnosis` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `notes` text,
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `IX_MedicalExamination_Reservation` (`reservation_id`),
  CONSTRAINT `medicalexamination_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `medicalexamination_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalexamination`
--

LOCK TABLES `medicalexamination` WRITE;
/*!40000 ALTER TABLE `medicalexamination` DISABLE KEYS */;
INSERT INTO `medicalexamination` VALUES (1,1,2,'2023-10-15 10:30:00','Healthy','No issues found during the checkup.',1,'2025-01-31 23:46:55',NULL),(2,2,2,'2023-10-20 14:30:00','Vaccinated','Child received all scheduled vaccinations.',1,'2025-01-31 23:46:55',NULL),(3,3,2,'2023-10-25 09:30:00','Nutritional Advice','Provided dietary recommendations.',1,'2025-01-31 23:46:55',NULL);
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
  CONSTRAINT `medicalprescription_ibfk_1` FOREIGN KEY (`examination_id`) REFERENCES `medicalexamination` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalprescription`
--

LOCK TABLES `medicalprescription` WRITE;
/*!40000 ALTER TABLE `medicalprescription` DISABLE KEYS */;
INSERT INTO `medicalprescription` VALUES (1,1,'Multivitamin',1,'Take once daily with meals.','2025-01-31 23:46:55'),(2,3,'Calcium Supplement',1,'Take once daily with breakfast.','2025-01-31 23:46:55');
/*!40000 ALTER TABLE `medicalprescription` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,'Importance of Regular Checkups','Regular health checkups are essential for monitoring the growth and development of children.','checkup.jpg',1,'2025-01-31 23:46:56',NULL),(2,2,'Vaccination Schedule for Children','Ensure your child is up-to-date with their vaccinations to protect them from diseases.','vaccination.jpg',1,'2025-01-31 23:46:56',NULL),(3,3,'Nutrition Tips for Kids','A balanced diet is crucial for the healthy development of children.','nutrition.jpg',1,'2025-01-31 23:46:56',NULL);
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
  `full_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`),
  CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (1,'Admin User',1,'1980-01-01','123 Admin Street','123-456-7890','admin.jpg','2025-01-31 23:46:55',NULL),(2,'Dr. John Doe',1,'1975-05-15','456 Health Lane','234-567-8901','doctor1.jpg','2025-01-31 23:46:55',NULL),(3,'Jane Smith',0,'1985-08-20','789 Parent Road','345-678-9012','parent1.jpg','2025-01-31 23:46:55',NULL),(4,'Staff Member',1,'1990-03-10','101 Staff Avenue','456-789-0123','staff1.jpg','2025-01-31 23:46:55',NULL);
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
  `status_id` int NOT NULL,
  `reserved_date` datetime NOT NULL,
  `notes` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `IX_Reservation_Customer` (`customer_id`),
  KEY `IX_Reservation_Date` (`reserved_date`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `reservationstatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,3,1,'2023-10-15 10:00:00','Regular checkup for my child.','2025-01-31 23:46:55',NULL),(2,3,2,'2023-10-20 14:00:00','Vaccination appointment.','2025-01-31 23:46:55',NULL),(3,3,3,'2023-10-25 09:00:00','Nutrition consultation.','2025-01-31 23:46:55',NULL);
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
  PRIMARY KEY (`id`),
  KEY `reservation_id` (`reservation_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `reservationdetail_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `reservationdetail_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationdetail`
--

LOCK TABLES `reservationdetail` WRITE;
/*!40000 ALTER TABLE `reservationdetail` DISABLE KEYS */;
INSERT INTO `reservationdetail` VALUES (1,1,1,1,50.00,'2025-01-31 23:46:55'),(2,2,2,1,120.00,'2025-01-31 23:46:55'),(3,3,3,1,80.00,'2025-01-31 23:46:55');
/*!40000 ALTER TABLE `reservationdetail` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin','Administrator with full access to the system.',1),(2,'Doctor','Medical professional providing health services.',1),(3,'Parent','Parent or guardian of a child using the services.',1),(4,'Staff','Support staff assisting in the operations.',1);
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
  CONSTRAINT `rolefeature_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `rolefeature_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolefeature`
--

LOCK TABLES `rolefeature` WRITE;
/*!40000 ALTER TABLE `rolefeature` DISABLE KEYS */;
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
  `category_id` int DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `brief_info` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `thumbnail` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IX_Service_Category` (`category_id`),
  CONSTRAINT `service_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,1,'Advanced Health Checkup','A detailed health checkup including blood tests, urine tests, and more.','Advanced health checkup for children',100.00,0.00,'assets/images/services/service1.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(2,1,'Annual Health Screening','Comprehensive annual health screening for children.','Annual health screening',150.00,5.00,'assets/images/services/service2.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(3,2,'Flu Vaccination','Annual flu vaccination to protect children from seasonal flu.','Flu vaccination for children',40.00,0.00,'assets/images/services/service3.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(4,2,'MMR Vaccination','Vaccination against Measles, Mumps, and Rubella.','MMR vaccination',60.00,0.00,'assets/images/services/service4.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(5,2,'Hepatitis B Vaccination','Vaccination to protect against Hepatitis B.','Hepatitis B vaccination',70.00,0.00,'assets/images/services/service5.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(6,3,'Weight Management Consultation','Consultation for children struggling with weight issues.','Weight management for children',90.00,0.00,'assets/images/services/service6.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(7,3,'Allergy Testing and Diet Plan','Testing for food allergies and creating a safe diet plan.','Allergy testing and diet plan',120.00,0.00,'assets/images/services/service7.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(8,4,'Tooth Extraction','Safe and painless tooth extraction for children.','Tooth extraction for children',80.00,0.00,'assets/images/services/service8.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(9,4,'Braces Consultation','Consultation for orthodontic treatment and braces.','Braces consultation',50.00,0.00,'assets/images/services/service9.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(10,4,'Teeth Whitening','Teeth whitening treatment for children.','Teeth whitening',100.00,10.00,'assets/images/services/service10.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(11,5,'24/7 Emergency Consultation','Round-the-clock emergency consultation for children.','24/7 emergency consultation',250.00,0.00,'assets/images/services/service11.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(12,5,'Injury Treatment','Treatment for minor injuries and wounds.','Injury treatment for children',150.00,0.00,'assets/images/services/service12.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(13,6,'Post-Surgery Rehabilitation','Rehabilitation services for children after surgery.','Post-surgery rehabilitation',120.00,0.00,'assets/images/services/service13.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(14,6,'Sports Injury Therapy','Therapy for children recovering from sports injuries.','Sports injury therapy',110.00,0.00,'assets/images/services/service14.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(15,6,'Developmental Delay Therapy','Therapy for children with developmental delays.','Developmental delay therapy',130.00,0.00,'assets/images/services/service15.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(16,7,'Anxiety Counseling','Counseling for children dealing with anxiety.','Anxiety counseling',110.00,0.00,'assets/images/services/service16.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(17,7,'Behavioral Therapy','Therapy for children with behavioral issues.','Behavioral therapy',120.00,0.00,'assets/images/services/service17.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(18,7,'ADHD Management','Counseling and management for children with ADHD.','ADHD management',130.00,0.00,'assets/images/services/service18.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(19,1,'Newborn Health Checkup','Comprehensive health checkup for newborns.','Newborn health checkup',70.00,0.00,'assets/images/services/service19.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(20,1,'Growth Monitoring','Regular monitoring of child growth and development.','Growth monitoring',60.00,0.00,'assets/images/services/service20.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(21,2,'Chickenpox Vaccination','Vaccination to protect against chickenpox.','Chickenpox vaccination',50.00,0.00,'assets/images/services/service21.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27'),(22,2,'Pneumococcal Vaccination','Vaccination to protect against pneumococcal diseases.','Pneumococcal vaccination',80.00,0.00,'assets/images/services/service22.jpg',1,'2025-01-31 23:46:55','2025-02-02 11:01:27');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text,
  `setting_type` varchar(50) DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
INSERT INTO `slider` VALUES (1,'Welcome to Children Care','welcome.jpg','/',1,1,'2025-01-31 23:46:55',NULL),(2,'Healthy Kids, Happy Parents','healthy_kids.jpg','/services',1,1,'2025-01-31 23:46:55',NULL),(3,'Book an Appointment Today','appointment.jpg','/appointment',1,1,'2025-01-31 23:46:55',NULL);
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
  `role_id` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  KEY `IX_User_Email` (`email`),
  KEY `IX_User_Username` (`username`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin123','admin@childrencare.com',1,1,'2025-01-31 23:46:55',NULL),(2,'doctor1','doctor123','doctor1@childrencare.com',2,1,'2025-01-31 23:46:55',NULL),(3,'parent1','parent123','parent1@childrencare.com',3,1,'2025-01-31 23:46:55',NULL),(4,'staff1','staff123','staff1@childrencare.com',4,1,'2025-01-31 23:46:55',NULL);
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

-- Dump completed on 2025-02-02 11:41:06
