-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: sp_tour
-- ------------------------------------------------------
-- Server version	8.0.19

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
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `desc` text NOT NULL,
  `image` text NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Solo','Tours that you can go solo','https://via.placeholder.com/400'),(2,'Dates','Tours that you can go on a date','https://via.placeholder.com/400'),(3,'Family','Family tours!','https://via.placeholder.com/400');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `tour_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int NOT NULL,
  `score` int NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `fk_user_id_idx` (`user_id`),
  KEY `fk_tour_id _idx` (`tour_id`),
  CONSTRAINT `fk_review_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`),
  CONSTRAINT `fk_review_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour`
--

DROP TABLE IF EXISTS `tour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour` (
  `tour_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `brief_desc` varchar(255) NOT NULL,
  `detail_desc` text NOT NULL,
  `location` text NOT NULL,
  PRIMARY KEY (`tour_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour`
--

LOCK TABLES `tour` WRITE;
/*!40000 ALTER TABLE `tour` DISABLE KEYS */;
/*!40000 ALTER TABLE `tour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_category`
--

DROP TABLE IF EXISTS `tour_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour_category` (
  `tour_category_id` int NOT NULL AUTO_INCREMENT,
  `tour_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`tour_category_id`),
  KEY `fk_tour_id_idx` (`tour_id`),
  KEY `fk_cat_id_idx` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `fk_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_category`
--

LOCK TABLES `tour_category` WRITE;
/*!40000 ALTER TABLE `tour_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `tour_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_date`
--

DROP TABLE IF EXISTS `tour_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour_date` (
  `tour_date_id` int NOT NULL AUTO_INCREMENT,
  `tour_id` int NOT NULL,
  `tour_start` timestamp NOT NULL,
  `tour_end` timestamp NOT NULL,
  `show_tour` tinyint DEFAULT '1',
  `price` double NOT NULL,
  `avail_slot` int NOT NULL,
  `max_slot` int NOT NULL,
  PRIMARY KEY (`tour_date_id`),
  KEY `fk_tour_date_tour_id_idx` (`tour_id`),
  CONSTRAINT `fk_tour_date_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_date`
--

LOCK TABLES `tour_date` WRITE;
/*!40000 ALTER TABLE `tour_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `tour_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_image`
--

DROP TABLE IF EXISTS `tour_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour_image` (
  `tour_image_id` int NOT NULL AUTO_INCREMENT,
  `alt_text` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`tour_image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_image`
--

LOCK TABLES `tour_image` WRITE;
/*!40000 ALTER TABLE `tour_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `tour_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_registration`
--

DROP TABLE IF EXISTS `tour_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour_registration` (
  `tour_registration_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `tour_date_id` int NOT NULL,
  PRIMARY KEY (`tour_registration_id`),
  KEY `fk_tour_registration_tour_id_idx` (`tour_date_id`),
  KEY `fk_tour_registration_user_id_idx` (`user_id`),
  CONSTRAINT `fk_tour_registration_tour_id` FOREIGN KEY (`tour_date_id`) REFERENCES `tour_date` (`tour_date_id`),
  CONSTRAINT `fk_tour_registration_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_registration`
--

LOCK TABLES `tour_registration` WRITE;
/*!40000 ALTER TABLE `tour_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `tour_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_tour_image`
--

DROP TABLE IF EXISTS `tour_tour_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour_tour_image` (
  `tour_tour_image_id` int NOT NULL AUTO_INCREMENT,
  `tour_id` int NOT NULL,
  `tour_image_id` int NOT NULL,
  PRIMARY KEY (`tour_tour_image_id`),
  KEY `fk_tour_image_tour_id_idx` (`tour_id`),
  KEY `fk_tour_image_tour_image_id_idx` (`tour_image_id`),
  CONSTRAINT `fk_tour_image_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`),
  CONSTRAINT `fk_tour_image_tour_image_id` FOREIGN KEY (`tour_image_id`) REFERENCES `tour_image` (`tour_image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_tour_image`
--

LOCK TABLES `tour_tour_image` WRITE;
/*!40000 ALTER TABLE `tour_tour_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `tour_tour_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `profile_pic_url` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'user',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `wishlist_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `tour_date_id` int NOT NULL,
  PRIMARY KEY (`wishlist_id`),
  KEY `fk_user_id_idx` (`user_id`),
  KEY `fk_tour_date_id_idx` (`tour_date_id`),
  CONSTRAINT `fk_tour_date_id` FOREIGN KEY (`tour_date_id`) REFERENCES `tour_date` (`tour_date_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
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

-- Dump completed on 2022-05-31 22:39:06
