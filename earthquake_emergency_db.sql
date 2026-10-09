-- MySQL dump 10.13  Distrib 26.7.0, for macos15 (arm64)
--
-- Host: localhost    Database: disaster_management
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Hospital`
--

DROP TABLE IF EXISTS `Hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Hospital` (
  `hospital_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `available_capacity` int DEFAULT NULL,
  PRIMARY KEY (`hospital_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hospital`
--

LOCK TABLES `Hospital` WRITE;
/*!40000 ALTER TABLE `Hospital` DISABLE KEYS */;
INSERT INTO `Hospital` VALUES (1,'Maastricht Medical Center','Maastricht',120),(2,'Heerlen General Hospital','Heerlen',80),(3,'Valkenburg Emergency Center','Valkenburg',40);
/*!40000 ALTER TABLE `Hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_Allergy`
--

DROP TABLE IF EXISTS `Patient_Allergy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient_Allergy` (
  `allergy_id` int NOT NULL,
  `record_id` int DEFAULT NULL,
  `allergy_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`allergy_id`),
  KEY `record_id` (`record_id`),
  CONSTRAINT `patient_allergy_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `Patient_Record` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_Allergy`
--

LOCK TABLES `Patient_Allergy` WRITE;
/*!40000 ALTER TABLE `Patient_Allergy` DISABLE KEYS */;
INSERT INTO `Patient_Allergy` VALUES (1,101,'Penicillin'),(2,102,'Pollen'),(3,103,'Peanuts'),(4,104,'Dust'),(5,105,'Latex');
/*!40000 ALTER TABLE `Patient_Allergy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_Medication`
--

DROP TABLE IF EXISTS `Patient_Medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient_Medication` (
  `medication_id` int NOT NULL,
  `record_id` int DEFAULT NULL,
  `medication_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`medication_id`),
  KEY `record_id` (`record_id`),
  CONSTRAINT `patient_medication_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `Patient_Record` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_Medication`
--

LOCK TABLES `Patient_Medication` WRITE;
/*!40000 ALTER TABLE `Patient_Medication` DISABLE KEYS */;
INSERT INTO `Patient_Medication` VALUES (1,101,'Ibuprofen'),(2,101,'Paracetamol'),(3,102,'Salbutamol'),(4,103,'Paracetamol'),(5,104,'Electrolyte'),(6,105,'Ibuprofen');
/*!40000 ALTER TABLE `Patient_Medication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_Record`
--

DROP TABLE IF EXISTS `Patient_Record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient_Record` (
  `record_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `hospital_id` int DEFAULT NULL,
  `admission_date` datetime DEFAULT NULL,
  `discharge_date` datetime DEFAULT NULL,
  `medical_condition` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `person_id` (`person_id`),
  KEY `hospital_id` (`hospital_id`),
  CONSTRAINT `patient_record_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `Person` (`person_id`),
  CONSTRAINT `patient_record_ibfk_2` FOREIGN KEY (`hospital_id`) REFERENCES `Hospital` (`hospital_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_Record`
--

LOCK TABLES `Patient_Record` WRITE;
/*!40000 ALTER TABLE `Patient_Record` DISABLE KEYS */;
INSERT INTO `Patient_Record` VALUES (101,1,1,'2026-09-15 09:30:00','2026-09-16 14:00:00','Minor fracture'),(102,2,3,'2026-09-15 11:00:00',NULL,'Smoke inhalation'),(103,3,2,'2026-09-16 08:45:00',NULL,'Head injury'),(104,4,1,'2026-09-16 12:20:00','2026-09-17 10:00:00','Dehydration'),(105,5,2,'2026-09-17 07:15:00',NULL,'Leg injury');
/*!40000 ALTER TABLE `Patient_Record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Person` (
  `person_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone_number` varchar(100) DEFAULT NULL,
  `emergency_contact` varchar(100) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `has_children` tinyint(1) DEFAULT NULL,
  `marital_status` varchar(100) DEFAULT NULL,
  `distance_from_incident` int DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (1,'Anna de Vries','+31612345671','Mark de Vries','Maastricht',1,'Married',3),(2,'Lucas Janssen','+31612345672','Emma Janssen','Valkenburg',0,'Single',8),(3,'Sofia Peters','+31612345673','Daniel Peters','Heerlen',1,'Married',12),(4,'Noah Smit','+31612345674','Lisa Smit','Meerssen',0,'Single',5),(5,'Mila Bakker','+31612345675','Tom Bakker','Gulpen',1,'Divorced',15);
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Safety_Update`
--

DROP TABLE IF EXISTS `Safety_Update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Safety_Update` (
  `update_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `electricity` tinyint(1) DEFAULT NULL,
  `gas` tinyint(1) DEFAULT NULL,
  `clean_water` tinyint(1) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`update_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `safety_update_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `Person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Safety_Update`
--

LOCK TABLES `Safety_Update` WRITE;
/*!40000 ALTER TABLE `Safety_Update` DISABLE KEYS */;
INSERT INTO `Safety_Update` VALUES (1,1,'Safe',1,1,1,'2026-09-15 08:00:00'),(2,2,'Needs assistance',0,0,0,'2026-09-15 08:30:00'),(3,3,'Relocated',0,0,1,'2026-09-15 09:00:00'),(4,4,'Safe',1,0,1,'2026-09-15 09:30:00'),(5,5,'Needs shelter',0,0,0,'2026-09-15 10:00:00'),(6,2,'Relocated',0,0,1,'2026-09-16 10:30:00');
/*!40000 ALTER TABLE `Safety_Update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supplies`
--

DROP TABLE IF EXISTS `Supplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Supplies` (
  `supply_id` int NOT NULL,
  `supply_name` varchar(100) DEFAULT NULL,
  `quantity_left` int DEFAULT NULL,
  PRIMARY KEY (`supply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplies`
--

LOCK TABLES `Supplies` WRITE;
/*!40000 ALTER TABLE `Supplies` DISABLE KEYS */;
INSERT INTO `Supplies` VALUES (1,'Drinking Water',500),(2,'Food Packages',300),(3,'Blankets',200),(4,'First Aid Kits',100),(5,'Flashlights',150);
/*!40000 ALTER TABLE `Supplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supply_Order`
--

DROP TABLE IF EXISTS `Supply_Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Supply_Order` (
  `order_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `supply_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `order_time` datetime DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `person_id` (`person_id`),
  KEY `supply_id` (`supply_id`),
  CONSTRAINT `supply_order_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `Person` (`person_id`),
  CONSTRAINT `supply_order_ibfk_2` FOREIGN KEY (`supply_id`) REFERENCES `Supplies` (`supply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supply_Order`
--

LOCK TABLES `Supply_Order` WRITE;
/*!40000 ALTER TABLE `Supply_Order` DISABLE KEYS */;
INSERT INTO `Supply_Order` VALUES (1,1,1,5,'2026-09-15 10:00:00','Completed'),(2,2,2,3,'2026-09-15 10:15:00','Pending'),(3,2,3,2,'2026-09-15 10:20:00','Completed'),(4,3,4,1,'2026-09-15 11:00:00','Completed'),(5,4,1,4,'2026-09-16 09:00:00','Pending'),(6,5,3,3,'2026-09-16 09:30:00','Processing');
/*!40000 ALTER TABLE `Supply_Order` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-07 14:51:53
