-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: jad
-- ------------------------------------------------------
-- Server version	8.0.30

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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Solo','Tours that you can go solo','https://images.unsplash.com/photo-1605274280779-a4732e176f4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c29sbyUyMHRyYXZlbHxlbnwwfHwwfHw%3D&w=1000&q=80'),(2,'Dates','Tours that you can go on a date','https://www.honeymoonbug.com/blog/wp-content/uploads/2018/07/most-romantic-date-ideas.jpg'),(3,'Family','Family tours!','https://www.vietnamonline.com/media/uploads/froala_editor/images/VNO_GD.jpg'),(18,'Japan','Tours in Japan!','https://res.cloudinary.com/dqxawxewb/image/upload/v1659409396/category/%242a%2410%24ZQRg8cvcbiX4xYKMNdu02u.jpg');
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
  CONSTRAINT `fk_review_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_review_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (2,1,1,4,0,'I love this place! It\'s so nice!'),(3,3,3,4,0,'This place is so colourful'),(4,3,3,5,0,'Okay im trying this again'),(5,3,3,3,0,'For the last time, oh my god');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour`
--

LOCK TABLES `tour` WRITE;
/*!40000 ALTER TABLE `tour` DISABLE KEYS */;
INSERT INTO `tour` VALUES (1,'Universal Studios Singapore Tours','Make it a holiday to remember as you meet your favorite Universal Stars, enjoy musical meet-and-greets, our thrilling rides, and more.','- Go on a tour in Southeast Asia\'s first and only Universal Studios theme park, featuring thrilling rides, shows and attractions based on popular films and TV shows\n- Delight your little ones as they catch their favorite characters like Elmo and also see the Minions at their despicable best!\n- Make it a holiday to remember as you meet your favorite Universal Stars, enjoy musical meet-and-greets, our thrilling rides, and more\n- Taste the spring season with our new sweet offerings! Enjoy mouthwatering big bites with extraordinary and oversized desserts and tapas platters at KT’s Grill','8 Sentosa Gateway, Singapore 098269'),(2,'S.E.A. Aquarium Tour','Get a SEA Aquarium tourto marve and learn about at the ocean realm with over 100000 marine animals.','- S.E.A. Aquarium at Resorts World Sentosa is one of the world?s largest aquariums and home to more than 100,000 marine life representing 1,000 species in more than 45 diverse habitats- See exhibits close to 80 threatened species including the manta ray, Napoleon wrasse and a variety of corals that mirror a pristine aquatic environment- Explore nine distinct zones, each boosted with refreshed educational content, interactive and immersive experiences, up-close animal encounters and more','8 Sentosa Gateway, Singapore 098269'),(3,'Gardens by the Bay Ticket Singapore','\nSakura featuring tokidoki is on display at Gardens by the Bay from 4 Mar to 3 Apr!','- Roam around the Flower Dome to see thousand-year-old olive trees, giant baobabs, and a wide range of exotic plants\n- Visit the Cloud Forest and feel refreshed by the mist coming from the world\'s tallest indoor waterfall; Plunge into the fascinating world of plant and animal kingdom in National Geographic\'s latest \"Weird But True\" exhibition!','18 Marina Gardens Dr, Singapore 018953'),(4,'Sentosa Luge Ticket: Skyline Luge & Skyride','An exciting & fun adventure with family & friends','- An exciting & fun adventure with family & friends\n- Choose your adventure between 4 thrilling tracks: Kuppu Kuppu Trail, Expedition Trail, Jungle Trail, and Dragon Trail\n- Check out a night Luge experience as you ride down tracks designed with vibrant colors to light the evening\n- Fly above Sentosa onboard the Sentosa Skyride, a 4-seater chairlift for views of the Island and South China Sea','8 Sentosa Gateway, Singapore 098269'),(5,'Singapore Zoo Tickets','Get the chance to feed different animals like elephants, giraffes, goats, and white rhinoceroses!','- Get your Singapore Zoo tickets and see over 300 species from elevated platforms, glass observatories, and more!\n- Get the chance to feed different animals like elephants, giraffes, goats, and white rhinoceroses','80 Mandai Lake Rd, Singapore 729826'),(6,'Singapore City Tour','Let us take you to explore the civic and cultural district of our Lion City and tell you inspiring stories of a resilient nation that fought against all odds','There was a time when fishing boats and spices lined our colonial shore. From a fishing village to a modern metropolis, the transformation of Singapore is an impressive story, best told through historical landmarks like the Old Parliament House nestled in the Civic District of Singapore. This tour revolves around the heartbeat of our city - the Singapore River. Join our tour guides on this exploratory walking tour of Singapore and learn more about our rich history through inspiring stories that have shaped our Lion City. \n\n \n\nOther highlights include visiting the iconic Merlion Park, the historically-significant Padang and the neoclassical Victoria Theatre.\n\n​','Meeting Point:\nRaffles Place MRT Exit A (Street Level)'),(7,'Changi Airport Tour','Let us take you to explore the beauty of Changi Airport and how it developed to become a world-class transportation hub since it was built in 1981','A landmark of Singapore and a gateway to the world. What makes Changi Airport the World\'s Best Airport since 2013? What keeps it going? Discover the stories behind its development and learn about the daily operations. Presenting to you, the insider tour of Changi Airport and Jewel Changi. \n\n \n\nAlthough international travel has come to a temporary standstill, there are plenty of family- and date-friendly things to do at our Jewel Changi Airport Tour, making it a sweet weekend getaway. Expect to explore the free amenities and gain behind-the-scenes knowledge of modern architecture in the picturesque Shiseido Forest Valley and Rain Vortex.','Meeting Point:\nChangi Airport MRT Terminal 3 (Exit)'),(8,'Chinatown Tour','Journey back in time to the 1900s in our Chinese ethnic enclave!','Explore hidden streets and be wowed by the intricate architecture of shophouses and famous temples on this Chinatown walking tour. Let our tour guides take you back in time with amazing stories of the early Chinese immigrants, and learn how they braved many obstacles to build a life in Singapore. \n\n \n\nOther highlights include a peek insider 100 year old shophouses, learn more about local Chinese prayer practices, check our wet markets, hawker centres, heritage sites and even The World\'s Cheapest Michelin-Starred Meal Restaurant!','Meeting Point:\nTelok Ayer MRT Exit B (Street Level)'),(9,'Marina Bay Tour','Let us take you to discover Marina Bay and explore the iconic landmark of Marina Bay Sands and Gardens by the Bay','Take a scenic stroll with our guides on the Marina Bay walking tour and marvel at the architectural icons that dot the city\'s skyline. Be wowed by impressive views as you tour within Gardens by the Bay and the highlights of the Marina Bay walk that surrounds the dazzling waterfront promenade. \n\n \n\nThinking of what to do in Marina Bay Sands that does not break the bank? This tour is perfect for you as our guide will bring you to places within the mall that cannot be accessed publicly, so locals and foreigners alike can expect to learn new things from this tour.','Meeting Point:\n\nBayfront MRT Exit A (Street Level)'),(10,'Nabil','briefdesc','desclong','Singapore'),(11,'Empire States Building','Go see the empire states building','Take your time to go to the states and see the empire states building',' New York City, USA');
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
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_category`
--

LOCK TABLES `tour_category` WRITE;
/*!40000 ALTER TABLE `tour_category` DISABLE KEYS */;
INSERT INTO `tour_category` VALUES (2,2,1),(3,3,1),(4,5,1),(5,6,1),(6,7,1),(7,8,1),(8,9,1),(10,2,2),(11,3,2),(12,4,2),(13,5,2),(15,2,3),(16,3,3),(17,4,3),(18,5,3),(19,6,3),(20,7,3),(21,8,3),(22,9,3),(23,1,1),(24,1,2),(25,1,3),(26,11,1),(27,11,3);
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
  CONSTRAINT `fk_tour_date_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_date`
--

LOCK TABLES `tour_date` WRITE;
/*!40000 ALTER TABLE `tour_date` DISABLE KEYS */;
INSERT INTO `tour_date` VALUES (1,1,'2022-06-29 08:00:00','2022-06-29 22:00:00',1,69,0,50),(2,2,'2022-06-29 08:00:00','2022-06-29 22:00:00',1,34,13,50),(3,3,'2022-06-30 00:00:00','2022-06-30 04:00:00',1,26,0,0),(5,5,'2022-06-29 08:00:00','2022-06-29 22:00:00',1,12,12,50),(6,6,'2022-06-29 08:00:00','2022-06-29 22:00:00',1,49.9,3,20),(7,7,'2022-06-29 08:00:00','2022-06-29 22:00:00',1,49.9,6,20),(8,8,'2022-06-29 08:00:00','2022-06-29 22:00:00',1,49.9,2,20),(9,9,'2022-06-29 08:00:00','2022-06-29 22:00:00',1,49.9,5,20),(10,1,'2022-06-30 08:00:00','2022-06-30 22:00:00',1,69,14,50),(11,1,'2022-07-01 08:00:00','2022-07-01 22:00:00',1,69,25,50),(12,10,'2022-06-26 09:00:01','2022-06-27 12:00:01',1,25,60,60),(13,4,'2022-06-26 11:39:00','2022-06-26 11:39:00',1,45,51,60),(14,11,'2022-08-10 20:00:00','2022-08-15 13:00:00',1,2560,25,25);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_image`
--

LOCK TABLES `tour_image` WRITE;
/*!40000 ALTER TABLE `tour_image` DISABLE KEYS */;
INSERT INTO `tour_image` VALUES (1,'Default Image','https://via.placeholder.com/400'),(2,'Pink Sky at Gardens by the bay','https://res.cloudinary.com/dqxawxewb/image/upload/v1659167966/category/%242a%2410%24k4lWSl8Xg06bWF.Zietv0e.jpg'),(3,'Clownery','https://media.istockphoto.com/photos/clown-makes-funny-face-picture-id119148040?k=20&m=119148040&s=612x612&w=0&h=kx9DnkiWccAmZdiLMYRzLyG8DIRTFejz1g4DHT0ra44='),(4,'USS Singapore','https://res.klook.com/images/fl_lossy.progressive,q_65/c_fill,w_3000,h_2000,f_auto/activities/kj6fu2hxkctjk41a1vde/Upto20Off%7CUniversalStudiosSingaporeTickets-KlookSingapore.jpg'),(5,' SEA Aquarium','https://res.klook.com/images/fl_lossy.progressive,q_65/c_fill,w_3000,h_2002,f_auto/w_80,x_15,y_15,g_south_west,l_Klook_water_br_trans_yhcmh3/activities/ccfgnagsrilolytkoegu/Tagesticketf%C3%BCrSEAAquarium%E2%84%A2-Klook.jpg'),(6,'Skyline Luge','https://www.skylineluge.com/media/2312/skyline-luge-calgary-7.jpg'),(7,'Singapore Zoo','https://youimg1.tripcdn.com/target/100d1f000001got14A9B5.jpg?proc=source%2Ftrip'),(8,' Singapore City','https://upload.wikimedia.org/wikipedia/commons/f/fa/The_Esplanade_%E2%80%93_Theatres_on_the_Bay.jpg'),(9,'Changi Airport - Jewel','http://cdn.cnn.com/cnnnext/dam/assets/190416100039-singapore-changi-airport-jewel-guide.jpg'),(10,'Chinatown Singapore','https://www.visitsingapore.com/walking-tour/culture/in-the-neighbourhood-chinatown/_jcr_content/par-carousel/carousel_detailpage/carousel/item1.thumbnail.carousel-img.740.416.jpg'),(11,'Marina Bay Sands','https://www.marinabaysands.com/content/dam/singapore/marinabaysands/master/main/home/home/2021-masthead-600x400_2.jpg'),(13,'Empire State Building from the sky','https://res.cloudinary.com/dqxawxewb/image/upload/v1659759700/category/%242a%2410%24J.pbYYKbWn5thTMRnG5/9..png'),(14,'Empire State Building from the bottom','https://res.cloudinary.com/dqxawxewb/image/upload/v1659759716/category/%242a%2410%24ZAgymUCGTXo1fHCsISF1xe.png');
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
  `pax` smallint DEFAULT '1',
  `stripe_transaction_id` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tour_registration_id`),
  KEY `fk_tour_registration_tour_id_idx` (`tour_date_id`),
  KEY `fk_tour_registration_user_id_idx` (`user_id`),
  CONSTRAINT `fk_tour_registration_tour_id` FOREIGN KEY (`tour_date_id`) REFERENCES `tour_date` (`tour_date_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tour_registration_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_registration`
--

LOCK TABLES `tour_registration` WRITE;
/*!40000 ALTER TABLE `tour_registration` DISABLE KEYS */;
INSERT INTO `tour_registration` VALUES (256,86,14,2,'pi_3LThqeGruISt8Q6B1uTdotRj','2022-08-06 07:54:53');
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
  CONSTRAINT `fk_tour_image_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tour_image_tour_image_id` FOREIGN KEY (`tour_image_id`) REFERENCES `tour_image` (`tour_image_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_tour_image`
--

LOCK TABLES `tour_tour_image` WRITE;
/*!40000 ALTER TABLE `tour_tour_image` DISABLE KEYS */;
INSERT INTO `tour_tour_image` VALUES (2,2,5),(3,3,2),(4,4,6),(5,5,7),(6,6,8),(7,7,9),(8,8,10),(9,9,11),(10,10,3),(11,1,4),(13,11,13),(14,11,14);
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
  `phone` varchar(25) NOT NULL DEFAULT '00000000',
  `address_1` varchar(45) NOT NULL,
  `address_2` varchar(45) NOT NULL,
  `apt_suite` varchar(45) NOT NULL,
  `postal_code` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Admin Amy','https://i.pinimg.com/736x/0b/09/cc/0b09cc0b7340b7ed9ca3f96897eac7c5.jpg','amy@admin.com','$2a$10$1SbsG94jz3fCAZzBZqo/Ye5x4ES7slFmHrpI/4B7x61CLvrFqlCxC','admin','00000000','','','','','2022-07-21 12:08:07'),(3,'Nabil','https://via.placeholder.com/400','nabil@test.com','$2a$10$FczHfIxJGnEvIs56alVmA.CRvR8G3dDZpulRO73yKnJJ98Y7d2SG.','admin','','','','','','2022-07-21 12:08:07'),(85,'UwU','https://c.tenor.com/kiBbs5cxnmYAAAAC/pusheen-cat.gif','blazing.arrow46@gmail.com','$2a$10$1SbsG94jz3fCAZzBZqo/Ye5x4ES7slFmHrpI/4B7x61CLvrFqlCxC','user','00000000','','','','','2022-07-21 12:08:07'),(86,'Nabil','https://via.placeholder.com/400','nabridhwan@gmail.com','$2a$10$1SbsG94jz3fCAZzBZqo/Ye5x4ES7slFmHrpI/4B7x61CLvrFqlCxC','admin','64663675','1 Dover Road','Singapore Polytechnic','N/A','347001','2022-07-21 12:08:07'),(88,'Great Testing User','https://via.placeholder.com/400','user.test@test.com','$2a$10$1SbsG94jz3fCAZzBZqo/Ye5x4ES7slFmHrpI/4B7x61CLvrFqlCxC','user','','266 Bits Road','Street 12','#01-266','640266','2022-07-21 12:08:47'),(93,'Test User 1','https://via.placeholder.com/400','test@test.com','$2a$10$toloSmXgkvIs/pCdvq/k2.uXDzEUfQYSmp35ckzKDB9wT3B9ww2x.','user','99999999','A1','A2','AS1','000111','2022-08-05 11:37:08');
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
  `tour_id` int NOT NULL,
  PRIMARY KEY (`wishlist_id`),
  KEY `fk_user_id_idx` (`user_id`),
  KEY `fk_tour_id_wishlist_idx` (`tour_id`),
  CONSTRAINT `fk_tour_id_wishlist` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`tour_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (4,1,4),(11,86,3);
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

-- Dump completed on 2022-08-06 16:00:50
