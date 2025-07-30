-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kita_coffee
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `cafe_information`
--

DROP TABLE IF EXISTS `cafe_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cafe_information` (
  `id` int NOT NULL AUTO_INCREMENT,
  `alamat` text,
  `no_telp` varchar(255) DEFAULT NULL,
  `link_gmaps` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafe_information`
--

LOCK TABLES `cafe_information` WRITE;
/*!40000 ALTER TABLE `cafe_information` DISABLE KEYS */;
INSERT INTO `cafe_information` VALUES (1,'Jl. Raya Cibanteng No.64, Cihideung Ilir, Kec. Ciampea, Kabupaten Bogor, Jawa Barat 16620','081-23209-4644','Jl. Raya Cibanteng No.64, Cihideung Ilir, Kec. Ciampea, Kabupaten Bogor, Jawa Barat 16620, Bogor, Indonesia 16620');
/*!40000 ALTER TABLE `cafe_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drink_menu`
--

DROP TABLE IF EXISTS `drink_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drink_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `drink_name` varchar(255) DEFAULT NULL,
  `deksripsi` text,
  `harga` decimal(10,0) DEFAULT NULL,
  `category` enum('Coffee','Non Coffee') DEFAULT NULL,
  `image_filename` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drink_menu`
--

LOCK TABLES `drink_menu` WRITE;
/*!40000 ALTER TABLE `drink_menu` DISABLE KEYS */;
INSERT INTO `drink_menu` VALUES (1,'Kopi Susu Kita','Perpaduan harmonis antara espresso robusta pilihan dan susu segar berkualitas, menciptakan rasa manis yang pas dengan sentuhan pahit khas kopi. Cocok buat yang suka kopi tapi nggak mau terlalu kuat—bisa dinikmati kapan pun, dari pagi sampai lembur malam.',12000,'Coffee','kopisusu.jpg'),(2,'Original Tea','Teh asli tanpa basa-basi. Diseduh dari daun teh pilihan, menghasilkan rasa segar, ringan, dan alami—pas banget buat yang pengen minum tanpa ribet. Nggak kemanisan, nggak kepahitan. Cuma teh, tapi teh yang ngerti kamu.',6000,'Non Coffee','tea.jpg'),(3,'Peach Tea','Teh segar dengan sentuhan manis buah peach yang juicy—sekali seruput langsung berasa summer vibes! Perpaduan antara teh yang ringan dan aroma peach yang harum bikin minuman ini jadi moodbooster di segala suasana.',15000,'Non Coffee','pichti.jpg'),(4,'Espresso','Single shot espresso dengan cita rasa bold, cocok buat kamu yang butuh nyetrum.',18000,'Coffee','espreso.jpg'),(5,'Americano','Espresso yang diseduh dengan air panas. Hitam, smooth, tanpa drama.',20000,'Coffee','amerikano.jpg'),(6,'Cappuccino','Perpaduan espresso, susu steamed, dan foam yang pas – klasik dan elegan.',25000,'Coffee','kapucino.jpg'),(7,'Café Latte','Kopi susu yang lembut, cocok buat nongkrong lama-lama sambil kerja.',25000,'Coffee','kafelate.jpg'),(8,'Caramel Macchiato','Susu steamed dengan espresso dan sirup karamel, manis tapi tetap dewasa.',28000,'Coffee','maciato.jpg'),(9,'Iced Coffee Aren','Kopi dingin dengan gula aren asli – no fake vibes.',22000,'Coffee','gulaaren.jpg'),(10,'Matcha Latte','Teh hijau Jepang dengan susu creamy. Pahit, manis, dan zen.',27000,'Non Coffee','macalate.jpg'),(11,'Choco Hazelnut','Minuman coklat premium dengan sentuhan hazelnut – mood booster banget!',28000,'Non Coffee','hazelnut.jpg'),(12,'Lychee Tea','Teh hitam dengan sirup leci dan potongan buah. Segar & cocok buat cuaca panas.',22000,'Non Coffee','leciti.jpg'),(13,'Lemon Mojito','Soda lemon dengan mint dan es batu – seger banget, auto fresh otak.',23000,'Non Coffee','mojito.jpg'),(14,'Strawberry Milk','Susu segar dengan sirup stroberi homemade – imut tapi nikmat.',24000,'Non Coffee','stroberi.jpg');
/*!40000 ALTER TABLE `drink_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_menu`
--

DROP TABLE IF EXISTS `food_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(255) DEFAULT NULL,
  `deksripsi` text,
  `harga` decimal(10,0) DEFAULT NULL,
  `category` enum('Snack','Makanan berat') DEFAULT NULL,
  `image_filename` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_menu`
--

LOCK TABLES `food_menu` WRITE;
/*!40000 ALTER TABLE `food_menu` DISABLE KEYS */;
INSERT INTO `food_menu` VALUES (1,'Chicken Wings','Sayap ayam goreng dengan pilihan saus BBQ, Honey Garlic, atau Spicy Korean.',28000,'Snack','wing.jpg'),(2,'Mozzarella Stick','Keju mozzarella digoreng crispy, lumer di dalam, cocok untuk dicocol saus marinara.',25000,'Snack','mozastik.jpg'),(3,'Onion Rings','Bawang bombay iris goreng tepung, kriuk gurih, cocok sebagai teman ngopi.',20000,'Snack','onion.jpg'),(4,'Mini Tofu Bites','Tahu crispy berbumbu, dilengkapi saus pedas manis ala kafe.',16000,'Snack','tofu.jpg'),(5,'Nasi Chicken Katsu Curry','Nasi hangat dengan chicken katsu crispy dan kuah kari Jepang gurih.',35000,'Makanan berat','curry.jpg'),(6,'Spaghetti Aglio e Olio','Spaghetti dengan minyak zaitun, bawang putih, cabai, dan topping smoked beef.',32000,'Makanan berat','olio.jpg'),(7,'Rice Bowl Teriyaki','Nasi dengan ayam tumis saus teriyaki, disajikan dengan sayur dan telur setengah matang.',30000,'Makanan berat','teriyaki.jpg'),(8,'Indomie Carbonara','Indomie rebus di-twist ala creamy carbonara, dengan topping keju parut dan sosis.',27000,'Makanan berat','carbonara.jpg'),(9,'Chicken Sandwich + Fries','Roti isi ayam grilled, lettuce, dan saus creamy, disajikan dengan kentang goreng.',33000,'Makanan berat','sanwit.jpg');
/*!40000 ALTER TABLE `food_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jam_operasional`
--

DROP TABLE IF EXISTS `jam_operasional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jam_operasional` (
  `hari` varchar(20) DEFAULT NULL,
  `jam_buka` time DEFAULT NULL,
  `jam_tutup` time DEFAULT NULL,
  `catatan` varchar(100) DEFAULT NULL,
  `category` enum('Weekdays','Weekend') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jam_operasional`
--

LOCK TABLES `jam_operasional` WRITE;
/*!40000 ALTER TABLE `jam_operasional` DISABLE KEYS */;
INSERT INTO `jam_operasional` VALUES ('Senin-Jumat','13:00:00','21:00:00','Hari libur nasional Tutup','Weekdays'),('Sabtu-Minggu','12:00:00','22:00:00','Last order 21:45','Weekend');
/*!40000 ALTER TABLE `jam_operasional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer` varchar(100) DEFAULT NULL,
  `address` text,
  `item_name` varchar(100) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `harga` int DEFAULT NULL,
  `status` enum('pending','paid','cancelled','done') DEFAULT 'pending',
  `order_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'pipi','cibinong','Kopi Susu Kita',1,'Coffee',12000,'pending','2025-07-08 13:04:12');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-30 16:45:03
