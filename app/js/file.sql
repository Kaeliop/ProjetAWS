CREATE DATABASE  IF NOT EXISTS `jeu` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `jeu`;
-- MySQL dump 10.16  Distrib 10.1.24-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: user
-- ------------------------------------------------------
-- Server version	10.1.24-MariaDB-6

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
-- Table structure for table `amis`
--

DROP TABLE IF EXISTS `amis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amis` (
  `origine` int(11) NOT NULL,
  `cible` int(11) NOT NULL,
  PRIMARY KEY (`origine`,`cible`),
  KEY `fk_amis_1_idx` (`origine`),
  KEY `fk_amis_2_idx` (`cible`),
  CONSTRAINT `fk_amis_1` FOREIGN KEY (`origine`) REFERENCES `joueur` (`id_joueur`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_amis_2` FOREIGN KEY (`cible`) REFERENCES `joueur` (`id_joueur`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amis`
--

LOCK TABLES `amis` WRITE;
/*!40000 ALTER TABLE `amis` DISABLE KEYS */;
/*!40000 ALTER TABLE `amis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bateau`
--

DROP TABLE IF EXISTS `bateau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bateau` (
  `id_bateau` int(11) NOT NULL,
  `origine_x` int(11) NOT NULL,
  `origine_y` int(11) NOT NULL,
  `grille` int(11) NOT NULL,
  `direction` enum('haut','droite','bas','gauche') NOT NULL,
  `taille` enum('2','3','4','5') NOT NULL,
  PRIMARY KEY (`origine_x`,`origine_y`,`grille`,`id_bateau`),
  CONSTRAINT `fk_bateau_1` FOREIGN KEY (`origine_x`, `origine_y`, `grille`) REFERENCES `case` (`x`, `y`, `grille`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bateau`
--

LOCK TABLES `bateau` WRITE;
/*!40000 ALTER TABLE `bateau` DISABLE KEYS */;
/*!40000 ALTER TABLE `bateau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case`
--

DROP TABLE IF EXISTS `case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `case` (
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `grille` int(11) NOT NULL,
  `etat` enum('0','1','2') NOT NULL,
  PRIMARY KEY (`x`,`y`,`grille`),
  KEY `fk_case_1_idx` (`grille`),
  CONSTRAINT `fk_case_1` FOREIGN KEY (`grille`) REFERENCES `grille` (`id_grille`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case`
--

LOCK TABLES `case` WRITE;
/*!40000 ALTER TABLE `case` DISABLE KEYS */;
/*!40000 ALTER TABLE `case` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flotteJoueur`
--

DROP TABLE IF EXISTS `flotteJoueur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flotteJoueur` (
  `joueur` int(11) NOT NULL,
  `bateau` int(11) NOT NULL,
  PRIMARY KEY (`joueur`,`bateau`),
  KEY `fk_flotteJoueur_2_idx` (`bateau`),
  CONSTRAINT `fk_flotteJoueur_1` FOREIGN KEY (`joueur`) REFERENCES `joueur` (`id_joueur`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flotteJoueur_2` FOREIGN KEY (`bateau`) REFERENCES `bateau` (`origine_x`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flotteJoueur`
--

LOCK TABLES `flotteJoueur` WRITE;
/*!40000 ALTER TABLE `flotteJoueur` DISABLE KEYS */;
/*!40000 ALTER TABLE `flotteJoueur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grille`
--

DROP TABLE IF EXISTS `grille`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grille` (
  `id_grille` int(11) NOT NULL,
  `id_joueur` int(11) NOT NULL,
  PRIMARY KEY (`id_grille`,`id_joueur`),
  KEY `fk_grille_1_idx` (`id_joueur`),
  CONSTRAINT `fk_grille_1` FOREIGN KEY (`id_joueur`) REFERENCES `joueur` (`id_joueur`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grille`
--

LOCK TABLES `grille` WRITE;
/*!40000 ALTER TABLE `grille` DISABLE KEYS */;
/*!40000 ALTER TABLE `grille` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `joueur`
--

DROP TABLE IF EXISTS `joueur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `joueur` (
  `id_joueur` int(11) NOT NULL,
  `pseudo` varchar(45) NOT NULL,
  `pass` varchar(45) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `mail` varchar(45) DEFAULT NULL,
  `status` enum('En ligne','Absent','Hors ligne') DEFAULT NULL,
  `victoires` int(11) DEFAULT NULL,
  `défaites` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_joueur`,`pseudo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `joueur`
--

LOCK TABLES `joueur` WRITE;
/*!40000 ALTER TABLE `joueur` DISABLE KEYS */;
/*!40000 ALTER TABLE `joueur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partie`
--

DROP TABLE IF EXISTS `partie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partie` (
  `idpartie` int(11) NOT NULL,
  `joueur1` int(11) NOT NULL,
  `joueur2` int(11) NOT NULL,
  PRIMARY KEY (`idpartie`,`joueur1`,`joueur2`),
  KEY `fk_partie_2_idx` (`joueur2`),
  KEY `fk_partie_1_idx` (`joueur1`),
  CONSTRAINT `fk_partie_1` FOREIGN KEY (`joueur1`) REFERENCES `joueur` (`id_joueur`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_partie_2` FOREIGN KEY (`joueur2`) REFERENCES `joueur` (`id_joueur`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partie`
--

LOCK TABLES `partie` WRITE;
/*!40000 ALTER TABLE `partie` DISABLE KEYS */;
/*!40000 ALTER TABLE `partie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-08 17:22:23