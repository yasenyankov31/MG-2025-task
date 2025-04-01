-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: Hangman
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.21-MariaDB-ubu2004

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
-- Table structure for table `ranking_per_gamer`
--

DROP TABLE IF EXISTS `ranking_per_gamer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ranking_per_gamer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_data_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt6kxgtyev4tgj7bfelxcxgddi` (`user_data_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranking_per_gamer`
--

LOCK TABLES `ranking_per_gamer` WRITE;
/*!40000 ALTER TABLE `ranking_per_gamer` DISABLE KEYS */;
INSERT INTO `ranking_per_gamer` VALUES (1,1),(2,1);
/*!40000 ALTER TABLE `ranking_per_gamer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_data`
--

DROP TABLE IF EXISTS `user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `age` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_data`
--

LOCK TABLES `user_data` WRITE;
/*!40000 ALTER TABLE `user_data` DISABLE KEYS */;
INSERT INTO `user_data` VALUES (1,12,'2025-04-15','admin','admin','admin');
/*!40000 ALTER TABLE `user_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `completed_game`
--

DROP TABLE IF EXISTS `completed_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `completed_game` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `finish_date` datetime DEFAULT NULL,
  `game_status` varchar(255) DEFAULT NULL,
  `game_id` bigint(20) DEFAULT NULL,
  `ranking_per_gamer_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjas8719ejn5kx0oyyhdvwkupd` (`game_id`),
  KEY `FK1gt4jvy1sev6pa5dfvv1jycj4` (`ranking_per_gamer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completed_game`
--

LOCK TABLES `completed_game` WRITE;
/*!40000 ALTER TABLE `completed_game` DISABLE KEYS */;
INSERT INTO `completed_game` VALUES (1,'2025-04-01 15:35:09','LOST',1,1),(2,'2025-04-01 15:35:52','LOST',2,2);
/*!40000 ALTER TABLE `completed_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attempts_left` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `guessed_word` varchar(255) DEFAULT NULL,
  `letters_used` varchar(255) DEFAULT NULL,
  `word` varchar(255) DEFAULT NULL,
  `word_num` int(11) NOT NULL,
  `user_game_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKq04sakkpenfu3vkpe42cwg2yk` (`user_game_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,0,'2025-04-01 15:34:08','s**king','bfkojntaeip','sucking',8630,1),(2,0,'2025-04-01 15:35:19','malp*ac*ice','cbafjilpoushy','malpractice',5394,1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-01 18:39:59
