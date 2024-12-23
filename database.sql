-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mysoft_task
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `age` int NOT NULL,
  `dob` date NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `gender` enum('FEMALE','MALE','OTHERS') NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `mobile_no` varchar(11) DEFAULT NULL,
  `permanent_address` varchar(255) DEFAULT NULL,
  `present_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (2,29,'1995-11-15','Sabiha','FEMALE','ad2e4bf8-d14f-494a-881e-6c8799a86908.jpg','Mahbuba','01234567892','House No. 12, Road No. 5, Block B, Bashundhara R/A, Dhaka-1229, Bangladesh','Flat No. 3A, 4th Floor, 45/1, New Elephant Road, Dhaka-1205, Bangladesh'),(3,34,'1990-05-30','Fatema','FEMALE','eba4eae4-4d93-4a01-9745-b186b8015346.jpg','Zohra','01234567894','House No. 22, Block C, Bashundhara R/A, Dhaka-1229, Bangladesh','House No. 5, Road No. 7, Gulshan-1, Dhaka-1212, Bangladesh'),(5,4,'2020-01-01','Sadia','FEMALE','f3123a7f-cd9d-41fd-821e-ece63ac88c44.jpeg','Jahan','01987654321','House No. 9, Block D, Bashundhara R/A, Dhaka-1229, Bangladesh','House No. 9, Block D, Bashundhara R/A, Dhaka-1229, Bangladesh'),(6,37,'1987-06-25','Sakib','MALE','68ddbf05-704f-451c-98c7-1d977a774592.png','Nizam','01234567901','House No. 3, Road No. 9, Khilji Road, Dhaka-1212, Bangladesh','Flat No. 2A, 3rd Floor, 15, Gulshan-1, Dhaka-1212, Bangladesh'),(7,23,'2001-06-25','Muntaha','FEMALE','be0ac45f-3dc5-408e-9435-388c8f5a3b4f.jpg','Malik','01234567901','House No. 3, Road No. 9, Khilji Road, Sylhet, Bangladesh','Flat No. 2A, 3rd Floor, 15, Gulshan-1, Dhaka-1212, Bangladesh'),(8,14,'2010-06-25','Zakaria','MALE','46b3322c-881c-4927-ab0d-798a9058097d.jpg','Mahmud','01234567911','House No. 5, Road No. 9, Nizam Road, Khulna, Bangladesh','Flat No. 2A, 3rd Floor, 15, Mirpur, Dhaka-1212, Bangladesh'),(9,70,'1954-07-01','Shafiqul','MALE','aec3daea-d811-4e3e-8872-aec05f57f17d.jpeg','Mowla','09876123455','House No. 3, Road No. 9, Agrabad, Chattogram-4100, Bangladesh','Flat No. 2A, 3rd Floor, 15, Mohammadpur, Dhaka, Bangladesh'),(10,7,'2017-06-25','Zakia','FEMALE','7ae94467-b466-42ff-bb08-b62e1d75ae4f.png','Sultana','01234567711','House No. 5, Road No. 9, Nizam Road, Bagura, Bangladesh','Flat No. 2D, 3rd Floor, 15, Mirpur, Dhaka-1212, Bangladesh'),(11,21,'2003-06-25','Abrar','MALE','56132c35-707f-4f3d-bc8f-c92d1d7e6ef2.png','Fahad','01234567711','House No. 5, Road No. 9, Nizam Road, Khulna, Bangladesh','Flat No. 2D, 3rd Floor, 15, Mirpur, Dhaka-1212, Bangladesh'),(12,21,'2003-06-25','Abu','MALE','7ac836ec-1abf-4448-a2bf-4e781cca940a.png','Sayed','01234567721','House No. 5, Road No. 9, Nizam Road, Bagura, Bangladesh','Flat No. 2D, 3rd Floor, 15, Uttora, Dhaka-1212, Bangladesh');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-19 17:09:18
