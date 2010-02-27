-- MySQL dump 10.13  Distrib 5.1.37, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: zoolu
-- ------------------------------------------------------
-- Server version	5.1.37-1ubuntu5.1

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
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (1,'add'),(2,'edit'),(3,'change_template'),(4,'change_template_id');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idParentCategory` bigint(20) unsigned NOT NULL DEFAULT '0',
  `idRootCategory` bigint(20) unsigned DEFAULT NULL,
  `idCategoryTypes` bigint(20) unsigned NOT NULL,
  `matchCode` varchar(255) DEFAULT NULL,
  `lft` int(10) unsigned DEFAULT NULL,
  `rgt` int(10) unsigned DEFAULT NULL,
  `depth` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`),
  KEY `idRootCategory` (`idRootCategory`),
  KEY `idParentCategory` (`idParentCategory`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,0,1,1,NULL,1,22,0),(11,0,11,2,NULL,1,20,0),(12,11,11,2,NULL,2,13,1),(13,11,11,2,NULL,14,19,1),(14,13,11,2,'DESC',15,16,2),(15,13,11,2,'ASC',17,18,2),(16,12,11,2,'alpha',3,4,2),(17,12,11,2,'sort',5,6,2),(18,12,11,2,'created',7,8,2),(19,12,11,2,'changed',9,10,2),(21,0,21,3,NULL,1,10,0),(27,0,27,2,NULL,1,14,0),(28,27,27,2,'col-1',2,3,1),(29,27,27,2,'col-1-img',4,5,1),(30,27,27,2,'col-2',6,7,1),(31,27,27,2,'col-2-img',8,9,1),(35,27,27,2,'list',10,11,1),(36,27,27,2,'list-img',12,13,1),(40,12,11,2,'published',11,12,2),(42,0,42,2,NULL,1,4,0),(43,42,42,2,'similar_pages',2,3,1),(48,0,48,2,NULL,1,10,0),(49,48,48,2,NULL,2,9,1),(50,49,48,2,NULL,3,4,2),(51,49,48,2,NULL,5,6,2),(52,49,48,2,NULL,7,8,2),(54,1,1,1,NULL,6,11,1),(56,21,21,3,NULL,2,3,1),(64,0,64,2,NULL,1,6,0),(65,64,64,2,NULL,2,3,1),(66,64,64,2,NULL,4,5,1),(71,1,1,1,NULL,12,13,1),(72,1,1,1,NULL,14,21,1),(73,72,1,1,NULL,15,16,2),(74,72,1,1,NULL,17,18,2),(75,72,1,1,NULL,19,20,2),(76,54,1,1,NULL,7,8,2),(77,54,1,1,NULL,9,10,2),(78,21,21,3,NULL,4,5,1),(80,21,21,3,NULL,6,7,1),(81,21,21,3,NULL,8,9,1),(82,0,82,2,NULL,1,6,0),(83,82,82,2,NULL,2,3,1),(84,82,82,2,NULL,4,5,1),(85,0,85,2,NULL,1,22,0),(86,85,85,2,NULL,2,3,1),(87,85,85,2,NULL,4,11,1),(88,85,85,2,NULL,12,13,1),(89,85,85,2,NULL,14,15,1),(90,85,85,2,NULL,16,17,1),(91,85,85,2,NULL,18,19,1),(92,85,85,2,NULL,20,21,1),(93,87,85,2,NULL,5,6,2),(94,87,85,2,NULL,7,8,2),(95,87,85,2,NULL,9,10,2);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoryCodes`
--

DROP TABLE IF EXISTS `categoryCodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoryCodes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idCategories` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `code` varchar(64) DEFAULT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idCategories` (`idCategories`),
  CONSTRAINT `categoryCodes_ibfk_1` FOREIGN KEY (`idCategories`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoryCodes`
--

LOCK TABLES `categoryCodes` WRITE;
/*!40000 ALTER TABLE `categoryCodes` DISABLE KEYS */;
INSERT INTO `categoryCodes` VALUES (1,64,1,'SUB_NAV_PAGES',3,'2010-02-10 16:18:01'),(2,48,1,'STATUS',3,'2010-02-10 16:18:16'),(3,82,1,'MEDIA_DISPLAY_OPTIONS',3,'2010-02-10 16:19:03'),(4,83,1,'LEFT_ALIGNED',3,'2010-02-10 16:20:34'),(5,84,1,'RIGHT_ALIGNED',3,'2010-02-10 16:20:39'),(6,85,1,'countries',1,'2010-02-26 21:44:07'),(7,86,1,'asia',1,'2010-02-26 21:44:44'),(8,87,1,'europe',1,'2010-02-26 21:45:08'),(9,87,2,'europe',1,'2010-02-26 21:45:35'),(10,86,2,'asia',1,'2010-02-26 21:46:09'),(11,88,1,'northamerica',1,'2010-02-26 21:47:11'),(12,88,2,'northamerica',1,'2010-02-26 21:47:43'),(13,89,1,'southamerica',1,'2010-02-26 22:07:28'),(14,89,2,'southamerica',1,'2010-02-26 22:07:28'),(15,90,1,'africa',1,'2010-02-26 21:50:11'),(16,90,2,'africa',1,'2010-02-26 21:49:53'),(17,91,1,'australia_oceania',1,'2010-02-26 21:52:08'),(18,91,2,'australia_oceania',1,'2010-02-26 21:52:33'),(19,92,1,'centralamerica',1,'2010-02-26 21:53:08'),(20,92,2,'centralamerica',1,'2010-02-26 21:53:34'),(21,93,1,'at',1,'2010-02-26 21:54:25'),(22,93,2,'at',1,'2010-02-26 21:54:43'),(23,94,1,'ge',1,'2010-02-26 21:56:28'),(24,94,2,'ge',1,'2010-02-26 21:56:46'),(25,95,1,'ch',1,'2010-02-26 21:57:07'),(26,95,2,'ch',1,'2010-02-26 21:57:26');
/*!40000 ALTER TABLE `categoryCodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoryTitles`
--

DROP TABLE IF EXISTS `categoryTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoryTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idCategories` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(500) DEFAULT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idCategories` (`idCategories`),
  CONSTRAINT `categoryTitles_ibfk_1` FOREIGN KEY (`idCategories`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoryTitles`
--

LOCK TABLES `categoryTitles` WRITE;
/*!40000 ALTER TABLE `categoryTitles` DISABLE KEYS */;
INSERT INTO `categoryTitles` VALUES (1,1,1,'Seiten Kategorien',0,'0000-00-00 00:00:00'),(11,11,1,'Sortierung',0,'0000-00-00 00:00:00'),(12,12,1,'Sortierarten',0,'0000-00-00 00:00:00'),(13,13,1,'Reihenfolge',0,'0000-00-00 00:00:00'),(14,14,1,'absteigend',0,'0000-00-00 00:00:00'),(15,15,1,'aufsteigend',0,'0000-00-00 00:00:00'),(16,16,1,'Alphabet',0,'0000-00-00 00:00:00'),(17,17,1,'Sortierung',0,'0000-00-00 00:00:00'),(18,18,1,'Erstelldatum',0,'0000-00-00 00:00:00'),(19,19,1,'Änderungsdatum',0,'0000-00-00 00:00:00'),(21,21,1,'Seiten Etiketten',0,'0000-00-00 00:00:00'),(27,27,1,'Darstellungsformen',0,'0000-00-00 00:00:00'),(28,28,1,'1-spaltig ohne Bilder',0,'0000-00-00 00:00:00'),(29,29,1,'1-spaltig mit Bilder',0,'0000-00-00 00:00:00'),(30,30,1,'2-spaltig ohne Bilder',0,'0000-00-00 00:00:00'),(31,31,1,'2-spaltig mit Bilder',0,'0000-00-00 00:00:00'),(35,35,1,'Liste ohne Bilder',0,'0000-00-00 00:00:00'),(36,36,1,'Liste mit Bilder',0,'0000-00-00 00:00:00'),(40,40,1,'Veröffentlichungsdatum',0,'0000-00-00 00:00:00'),(42,42,1,'Darstellungsoptionen',0,'0000-00-00 00:00:00'),(43,43,1,'Ähnliche Seiten anzeigen',0,'0000-00-00 00:00:00'),(48,48,1,'Status',3,'2010-02-10 16:18:16'),(49,49,1,'Veranstaltung',0,'0000-00-00 00:00:00'),(50,50,1,'Anmeldung offen',0,'0000-00-00 00:00:00'),(51,51,1,'Wenige Restplätze',0,'0000-00-00 00:00:00'),(52,52,1,'Ausgebucht',0,'0000-00-00 00:00:00'),(54,54,1,'Bereiche',1,'2010-01-27 12:33:29'),(56,56,1,'Startseite',1,'2009-11-11 11:17:29'),(59,54,2,'Regions',1,'2010-01-27 12:33:41'),(63,56,2,'Test 1 EN',0,'0000-00-00 00:00:00'),(79,64,1,'Sub-Navigations-Seiten',3,'2010-02-10 16:18:01'),(80,65,1,'nicht miteinbeziehen',3,'2009-06-23 08:28:09'),(81,66,1,'miteinbeziehen',3,'2009-06-23 08:28:34'),(86,71,1,'Startseiten Karussell',1,'2010-01-27 12:34:25'),(87,72,1,'Competences',1,'2009-12-21 09:05:14'),(88,73,1,'All Ceramics',1,'2009-12-21 09:05:26'),(89,74,1,'Implant Esthetics',1,'2009-12-21 09:05:39'),(90,75,1,'Composites',1,'2009-12-21 09:05:50'),(91,76,1,'Labor',1,'2010-01-27 12:34:34'),(92,76,2,'Labor',1,'2010-01-27 12:34:39'),(93,77,1,'Dental',1,'2010-01-27 12:34:44'),(94,77,2,'Dental',1,'2010-01-27 12:34:56'),(95,78,1,'Top Video',1,'2010-01-27 12:36:39'),(97,80,1,'Top Produkt',1,'2010-01-27 12:57:59'),(98,80,2,'Top Product',1,'2010-01-27 12:58:06'),(99,81,1,'Patientenstudie',1,'2010-01-27 12:59:36'),(100,82,1,'Medien-Darstellungsformen',3,'2010-02-10 16:19:03'),(101,83,1,'linksbündig',3,'2010-02-10 16:20:34'),(102,84,1,'rechtsbündig',3,'2010-02-10 16:20:39'),(103,85,1,'Länder/Kontinente',1,'2010-02-26 21:44:07'),(104,86,1,'Asien',1,'2010-02-26 21:44:44'),(105,87,1,'Europa',1,'2010-02-26 21:45:08'),(106,87,2,'Europe',1,'2010-02-26 21:45:35'),(107,86,2,'Asia',1,'2010-02-26 21:46:09'),(108,88,1,'Nordamerika',1,'2010-02-26 21:47:11'),(109,88,2,'North america',1,'2010-02-26 21:47:43'),(110,89,1,'Südamerika',1,'2010-02-26 21:48:29'),(111,89,2,'South america',1,'2010-02-26 21:48:55'),(112,90,1,'Afrika',1,'2010-02-26 21:50:11'),(113,90,2,'Africa',1,'2010-02-26 21:49:53'),(114,91,1,'Australien/Ozeanien',1,'2010-02-26 21:52:08'),(115,91,2,'Australia/Oceania',1,'2010-02-26 21:52:33'),(116,92,1,'Zentralamerika',1,'2010-02-26 21:53:08'),(117,92,2,'Central America',1,'2010-02-26 21:53:34'),(118,93,1,'Österreich',1,'2010-02-26 21:54:25'),(119,93,2,'Austria',1,'2010-02-26 21:54:43'),(120,94,1,'Deutschland',1,'2010-02-26 21:56:28'),(121,94,2,'Germany',1,'2010-02-26 21:56:46'),(122,95,1,'Schweiz',1,'2010-02-26 21:57:07'),(123,95,2,'Switzerland',1,'2010-02-26 21:57:26');
/*!40000 ALTER TABLE `categoryTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoryTypes`
--

DROP TABLE IF EXISTS `categoryTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoryTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoryTypes`
--

LOCK TABLES `categoryTypes` WRITE;
/*!40000 ALTER TABLE `categoryTypes` DISABLE KEYS */;
INSERT INTO `categoryTypes` VALUES (1,'default'),(2,'system'),(3,'label');
/*!40000 ALTER TABLE `categoryTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact-DEFAULT_CONTACT-1-InstanceFiles`
--

DROP TABLE IF EXISTS `contact-DEFAULT_CONTACT-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact-DEFAULT_CONTACT-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idContacts` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idContacts` (`idContacts`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `contact-DEFAULT_CONTACT-1-InstanceFiles_ibfk_1` FOREIGN KEY (`idContacts`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contact-DEFAULT_CONTACT-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact-DEFAULT_CONTACT-1-InstanceFiles`
--

LOCK TABLES `contact-DEFAULT_CONTACT-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `contact-DEFAULT_CONTACT-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact-DEFAULT_CONTACT-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact-DEFAULT_CONTACT-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `contact-DEFAULT_CONTACT-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact-DEFAULT_CONTACT-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idContacts` bigint(20) unsigned NOT NULL,
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idContacts` (`idContacts`),
  CONSTRAINT `contact-DEFAULT_CONTACT-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`idContacts`) REFERENCES `contacts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact-DEFAULT_CONTACT-1-InstanceMultiFields`
--

LOCK TABLES `contact-DEFAULT_CONTACT-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `contact-DEFAULT_CONTACT-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact-DEFAULT_CONTACT-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact-DEFAULT_CONTACT-1-Instances`
--

DROP TABLE IF EXISTS `contact-DEFAULT_CONTACT-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact-DEFAULT_CONTACT-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idContacts` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idContacts` (`idContacts`),
  CONSTRAINT `contact-DEFAULT_CONTACT-1-Instances_ibfk_1` FOREIGN KEY (`idContacts`) REFERENCES `contacts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact-DEFAULT_CONTACT-1-Instances`
--

LOCK TABLES `contact-DEFAULT_CONTACT-1-Instances` WRITE;
/*!40000 ALTER TABLE `contact-DEFAULT_CONTACT-1-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact-DEFAULT_CONTACT-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `creator` bigint(20) unsigned NOT NULL,
  `idUnits` bigint(20) unsigned NOT NULL,
  `salutation` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `fname` varchar(255) NOT NULL,
  `sname` varchar(255) NOT NULL,
  `position` varchar(255) DEFAULT NULL,
  `phone` varchar(128) DEFAULT NULL,
  `mobile` varchar(128) DEFAULT NULL,
  `fax` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `website` varchar(128) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,10,3,3,1,'','','Thomas','Schedler','','','','','','','2009-04-24 08:26:40','2009-04-24 08:26:40'),(2,10,3,3,1,'','','Bernd','Hepberger','','','','','','','2009-06-08 14:28:48','2009-06-08 14:28:48'),(3,10,1,1,1,'Herr','DI','Rainer','Schönherr','','+43.699.16609060','+43.699.16609060','+43.699.16609060','rainer.schoenherr@massiveart.com','www.massiveart.com','2009-11-11 11:10:20','2009-11-11 11:10:20'),(4,10,1,1,2,'','','Jürgen','Büchel','Web & Multimedia Projects / Corporate Marketing Services','+423 235 33 80 ','','','juergen.buechel@ivoclarvivadent.com',' www.ivoclarvivadent.com','2009-11-11 11:11:36','2009-11-11 11:11:36');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `decorators`
--

DROP TABLE IF EXISTS `decorators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `decorators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `decorators`
--

LOCK TABLES `decorators` WRITE;
/*!40000 ALTER TABLE `decorators` DISABLE KEYS */;
INSERT INTO `decorators` VALUES (1,'Input'),(2,'Template'),(3,'Tag'),(4,'Overflow'),(5,'Url'),(6,'VideoSelect'),(7,'Gmaps'),(8,'DocumentFilter');
/*!40000 ALTER TABLE `decorators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldPermissions`
--

DROP TABLE IF EXISTS `fieldPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldPermissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFields` bigint(20) unsigned NOT NULL,
  `idPermissions` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idFields` (`idFields`),
  KEY `idPermissions` (`idPermissions`),
  KEY `idGroups` (`idGroups`),
  CONSTRAINT `fieldPermissions_ibfk_1` FOREIGN KEY (`idFields`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldPermissions_ibfk_2` FOREIGN KEY (`idPermissions`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldPermissions_ibfk_3` FOREIGN KEY (`idGroups`) REFERENCES `groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldPermissions`
--

LOCK TABLES `fieldPermissions` WRITE;
/*!40000 ALTER TABLE `fieldPermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `fieldPermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldProperties`
--

DROP TABLE IF EXISTS `fieldProperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldProperties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFields` bigint(20) unsigned NOT NULL,
  `idProperties` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idFields` (`idFields`),
  KEY `idProperties` (`idProperties`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldProperties`
--

LOCK TABLES `fieldProperties` WRITE;
/*!40000 ALTER TABLE `fieldProperties` DISABLE KEYS */;
INSERT INTO `fieldProperties` VALUES (1,3,1,'2'),(2,4,1,'1'),(3,1,1,'1');
/*!40000 ALTER TABLE `fieldProperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldTitles`
--

DROP TABLE IF EXISTS `fieldTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFields` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(500) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `idFields` (`idFields`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldTitles`
--

LOCK TABLES `fieldTitles` WRITE;
/*!40000 ALTER TABLE `fieldTitles` DISABLE KEYS */;
INSERT INTO `fieldTitles` VALUES (1,1,1,'Titel',NULL),(2,2,1,'Beschreibung',NULL),(3,3,1,'Titel',NULL),(4,4,1,'Überschrift für den Artikel',NULL),(5,11,1,'Aktuelles Template',NULL),(6,5,1,NULL,NULL),(7,7,1,NULL,''),(8,8,1,NULL,NULL),(9,12,1,'Multiselect Test',NULL),(11,15,1,'Radiobuttons',NULL),(12,16,1,'Checkboxes',NULL),(13,17,1,'Titel',NULL),(14,20,1,'Titel',NULL),(15,21,1,'Tags',NULL),(16,22,1,'Kategorien',NULL),(17,24,1,'Embed Code',NULL),(18,23,1,'Titel',NULL),(19,25,1,'Titel',NULL),(20,26,1,'Titel',NULL),(21,28,1,'Verlinkte Seite',NULL),(22,30,1,'Titel',NULL),(23,31,1,'Anzahl',NULL),(26,37,1,'Titel',NULL),(29,34,1,'Nur Seiten mit Kategorie',NULL),(30,41,1,'Anzahl',NULL),(31,42,1,'Nur Seiten mit Kategorie',NULL),(32,43,1,'Titel',NULL),(33,47,1,'Sortierung nach',NULL),(34,48,1,'Reihenfolge',NULL),(35,49,1,'Sortierung nach',NULL),(36,50,1,'Reihenfolge',NULL),(37,51,1,'Sortierung nach',NULL),(38,52,1,'Reihenfolge',NULL),(39,44,1,'Anzahl',NULL),(40,45,1,'Navigationspunkt',NULL),(41,46,1,'Titel',NULL),(42,53,1,'Nur Seiten mit Kategorie',NULL),(43,54,1,'Video Service',NULL),(44,10,1,'Kurzbeschreibung des Artikels',NULL),(45,56,1,'Eigene Etiketten',NULL),(47,59,1,'Darstellungsform',NULL),(49,60,1,'Nur Seiten mit Etikett',NULL),(50,61,1,'Nur Seiten mit Etikett',NULL),(51,62,1,'Nur Seiten mit Etikett',NULL),(53,64,1,'Darstellungsoptionen',NULL),(54,65,1,'Vorname',NULL),(55,66,1,'Nachname',NULL),(56,67,1,'Datum, Zeit (Format: dd.mm.yyyy hh:mm)',NULL),(57,68,1,'Dauer (z.B.: 90 Minuten)',NULL),(58,69,1,'Strasse',NULL),(59,70,1,'Hausnummer',NULL),(60,71,1,'Postleitzahl',NULL),(61,72,1,'Ort',NULL),(62,73,1,'Schauplatz',NULL),(63,74,1,'Max. Teilnehmeranzahl',NULL),(64,75,1,'Kosten (in EUR)',NULL),(65,76,1,'Anrede',NULL),(66,77,1,'Titel',NULL),(67,78,1,'Funktion / Position',NULL),(68,79,1,'Telefon',NULL),(69,80,1,'Mobil',NULL),(70,81,1,'Fax ',NULL),(71,82,1,'E-Mail',NULL),(72,83,1,'Internet URL',NULL),(73,84,1,'Kontaktbilder',NULL),(74,85,1,'Vortragende',NULL),(75,86,1,'Kontakt',NULL),(76,87,1,'Veranstaltungsstatus',NULL),(77,90,1,'Titel',NULL),(78,91,1,'Headerbild',NULL),(79,92,1,'Embed Code',NULL),(80,93,1,'Url (z.B. http://www.getzoolu.com)',NULL),(81,94,1,'Titel',NULL),(82,95,1,'Sub-Navigations-Seiten',NULL),(83,97,1,'Titel',NULL),(84,98,1,'Beschreibung',NULL),(85,99,1,'Beschreibung',NULL),(86,100,1,'Abteilung',NULL),(87,101,1,'Stelle',NULL),(88,102,1,'Inhaltiche Verantwortung',NULL),(89,103,1,'Organisatorische Verantwortung',NULL),(90,104,1,'Aktivität',NULL),(91,105,1,'Beschreibung',NULL),(92,107,1,'Wer?',NULL),(93,110,1,'Beschreibung / Ursache',NULL),(94,111,1,'Titel',NULL),(95,113,1,'Präventive und korrektive Maßnahme',NULL),(96,112,1,'Beschreibung',NULL),(97,119,1,'Titel',NULL),(98,121,1,'Titel',NULL),(99,124,1,'Titel',NULL),(100,125,1,'Url (z.B. http://www.getzoolu.org)',NULL),(101,130,1,'Produktbaum',NULL),(102,131,1,'Nur Produkte mit Kategorie',NULL),(103,132,1,'Nur Produkte mit Etikett',NULL),(104,133,1,'Schlüssel',NULL);
/*!40000 ALTER TABLE `fieldTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldTypeGroups`
--

DROP TABLE IF EXISTS `fieldTypeGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldTypeGroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldTypeGroups`
--

LOCK TABLES `fieldTypeGroups` WRITE;
/*!40000 ALTER TABLE `fieldTypeGroups` DISABLE KEYS */;
INSERT INTO `fieldTypeGroups` VALUES (1,'files'),(2,'selects'),(3,'multi_fields'),(4,'special_fields'),(5,'zend'),(6,'file_filters');
/*!40000 ALTER TABLE `fieldTypeGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldTypes`
--

DROP TABLE IF EXISTS `fieldTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idDecorator` bigint(20) unsigned NOT NULL,
  `sqlType` varchar(30) NOT NULL,
  `size` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `defaultValue` varchar(255) NOT NULL,
  `idFieldTypeGroup` int(10) unsigned NOT NULL DEFAULT '5',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldTypes`
--

LOCK TABLES `fieldTypes` WRITE;
/*!40000 ALTER TABLE `fieldTypes` DISABLE KEYS */;
INSERT INTO `fieldTypes` VALUES (1,1,'',0,'text','',5),(2,1,'',0,'textarea','',5),(3,1,'',0,'multiCheckbox','',3),(4,1,'',0,'radio','',5),(5,1,'',0,'submit','',5),(6,1,'',0,'button','',5),(7,1,'',0,'reset','',5),(8,1,'',0,'hidden','',5),(9,1,'',0,'select','',2),(10,1,'',0,'texteditor','',5),(11,2,'',0,'template','',5),(12,1,'',0,'media','',1),(13,1,'',0,'document','',1),(14,1,'',0,'multiselect','',2),(15,1,'',0,'dselect','',5),(16,3,'',0,'tag','',4),(17,4,'',0,'multiCheckboxTree','',3),(18,5,'',0,'url','',4),(19,1,'',0,'internalLink','',4),(20,1,'',0,'selectTree','',2),(21,1,'',0,'textDisplay','',5),(22,6,'',0,'videoSelect','',4),(24,1,'',0,'contact','',4),(25,7,'',0,'gmaps','',4),(26,1,'',0,'internalLinks','',4),(27,1,'',0,'collection','',4),(28,8,'',0,'documentFilter','',6);
/*!40000 ALTER TABLE `fieldTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldValidators`
--

DROP TABLE IF EXISTS `fieldValidators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldValidators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFields` bigint(20) unsigned NOT NULL,
  `idValidators` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldValidators`
--

LOCK TABLES `fieldValidators` WRITE;
/*!40000 ALTER TABLE `fieldValidators` DISABLE KEYS */;
INSERT INTO `fieldValidators` VALUES (1,1,17),(2,3,17),(3,1,2),(4,31,17),(5,32,17),(6,47,17),(7,48,17),(8,59,17);
/*!40000 ALTER TABLE `fieldValidators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFieldTypes` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `idSearchFieldTypes` int(10) NOT NULL DEFAULT '1',
  `idRelationPage` bigint(20) unsigned DEFAULT NULL,
  `idCategory` bigint(20) unsigned DEFAULT NULL,
  `sqlSelect` varchar(2000) DEFAULT NULL,
  `columns` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL DEFAULT '0',
  `isCoreField` tinyint(1) NOT NULL DEFAULT '0',
  `isKeyField` tinyint(1) NOT NULL DEFAULT '0',
  `isSaveField` tinyint(1) NOT NULL DEFAULT '1',
  `isRegionTitle` tinyint(1) NOT NULL DEFAULT '0',
  `isDependentOn` bigint(20) unsigned DEFAULT NULL COMMENT 'must be an ID',
  `showDisplayOptions` tinyint(1) NOT NULL DEFAULT '0',
  `copyValue` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'decision if we addittionally write the value into the table (result: id and e.g. title in table)',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0,0),(2,10,'description',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(3,1,'title',5,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0,0),(4,1,'articletitle',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(5,12,'mainpics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(6,10,'description',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(7,12,'pics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(8,13,'docs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(10,2,'shortdescription',5,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0,0),(11,11,'template',1,NULL,NULL,NULL,12,0,0,0,0,0,NULL,0,0),(17,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0,0),(18,12,'block_pics',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,1,0),(19,10,'block_description',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0,0),(20,1,'block_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(21,16,'page_tags',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(22,17,'category',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, tbl.depth AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,1,0,1,0,NULL,0,0),(23,1,'video_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(24,2,'video_embed_code',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(25,1,'pics_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(26,1,'docs_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(27,18,'url',3,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(28,19,'internal_link',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(29,10,'sidebar_description',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(30,1,'sidebar_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(31,1,'entry_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0,0),(34,20,'entry_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(37,1,'entry_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(40,21,'title',5,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0,0),(41,1,'top_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0,0),(42,20,'top_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(43,1,'top_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(44,1,'entry_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0,0),(45,20,'entry_nav_point',1,NULL,NULL,'SELECT folders.id, folderTitles.title, folders.depth FROM folders INNER JOIN folderTitles ON folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = %LANGUAGE_ID% INNER JOIN rootLevels ON rootLevels.id = folders.idRootLevels INNER JOIN rootLevelTitles ON rootLevelTitles.idRootLevels = rootLevels.id WHERE folders.idRootLevels = %ROOTLEVEL_ID% ORDER BY folders.lft, folders.sortPosition ASC, folders.sortTimestamp DESC',4,0,0,0,1,0,NULL,0,0),(46,1,'entry_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(47,9,'entry_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(48,4,'entry_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(49,9,'top_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(50,4,'top_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(51,9,'entry_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(52,4,'entry_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(53,20,'entry_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(54,22,'video',1,NULL,NULL,'SELECT tbl.id AS id, tbl.title AS title FROM videoTypes AS tbl',12,0,0,0,1,0,NULL,0,0),(55,12,'pic_shortdescription',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0,0),(56,17,'label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, tbl.depth AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,1,0,1,0,NULL,0,0),(59,9,'entry_viewtype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 27 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(60,20,'entry_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(61,20,'top_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(62,20,'entry_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(64,3,'option',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 42 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,0,0,1,0,NULL,0,0),(65,1,'fname',1,NULL,NULL,NULL,6,0,1,1,1,0,NULL,0,0),(66,1,'sname',1,NULL,NULL,NULL,6,0,1,1,1,0,NULL,0,0),(67,1,'datetime',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0,0),(68,1,'event_duration',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0,0),(69,1,'event_street',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0,0),(70,1,'event_streetnr',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0,0),(71,1,'event_plz',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0,0),(72,1,'event_city',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0,0),(73,1,'event_location',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(74,1,'event_max_members',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0,0),(75,1,'event_costs',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0,0),(76,1,'salutation',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0,0),(77,1,'title',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0,0),(78,1,'position',1,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0,0),(79,1,'phone',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0,0),(80,1,'mobile',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0,0),(81,1,'fax',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0,0),(82,1,'email',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0,0),(83,1,'website',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0,0),(84,12,'pics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(85,24,'speakers',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(86,9,'contact',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',12,0,0,0,1,0,NULL,0,0),(87,9,'event_status',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 49 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',6,0,0,0,1,0,NULL,0,0),(88,12,'banner_pics',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0,0),(89,10,'banner_description',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0,0),(90,1,'banner_title',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(91,12,'headerpics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(92,2,'header_embed_code',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(93,1,'external',1,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0,0),(94,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0,0),(95,4,'entry_depth',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 64 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft %WHERE_ADDON% BETWEEN (rootCat.lft+1) AND rootCat.rgt ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(96,21,'title',5,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0,0),(97,1,'instruction_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(98,10,'instruction_description',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(99,1,'description',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(100,1,'department',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0,0),(101,1,'position',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0,0),(102,1,'content_responsible',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',6,0,0,0,1,0,NULL,0,0),(103,1,'organizational_responsible',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',6,0,0,0,1,0,NULL,0,0),(104,1,'steps_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(105,10,'steps_text',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(106,10,'shortdescription',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(107,1,'steps_who',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(108,12,'process_pic',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(109,10,'process_inputs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(110,10,'risk_description',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(111,1,'rule_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(112,10,'rule_text',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(113,10,'risk_measure',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(114,10,'process_output',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(115,10,'process_indicator',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(116,10,'process_instructions',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(117,10,'process_techniques',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(118,25,'gmaps',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(119,1,'internal_links_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(120,26,'internal_links',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(121,1,'collection_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(122,27,'collection',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(123,13,'block_docs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(124,1,'link_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0,0),(125,1,'link_url',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(126,12,'header_pics',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0,0),(127,10,'header_description',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0,0),(128,12,'sidebar_pics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(129,28,'docs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0,0),(130,20,'entry_product_point',1,NULL,NULL,'SELECT folders.id, folderTitles.title, folders.depth FROM folders INNER JOIN folderTitles ON folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = %LANGUAGE_ID% INNER JOIN rootLevels ON rootLevels.id = folders.idRootLevels INNER JOIN rootLevelTitles ON rootLevelTitles.idRootLevels = rootLevels.id WHERE folders.idRootLevels = 12 ORDER BY folders.lft, folders.sortPosition ASC, folders.sortTimestamp DESC',4,0,0,0,1,0,NULL,0,0),(131,20,'entry_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(132,20,'entry_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0,0),(133,1,'code',1,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0,0);
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileAttributes`
--

DROP TABLE IF EXISTS `fileAttributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileAttributes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFiles` bigint(20) unsigned NOT NULL,
  `xDim` int(10) DEFAULT NULL,
  `yDim` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `fileAttributes_ibfk_1` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileAttributes`
--

LOCK TABLES `fileAttributes` WRITE;
/*!40000 ALTER TABLE `fileAttributes` DISABLE KEYS */;
INSERT INTO `fileAttributes` VALUES (1,1,2716,1810);
/*!40000 ALTER TABLE `fileAttributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filePermissions`
--

DROP TABLE IF EXISTS `filePermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filePermissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idPermissions` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filePermissions`
--

LOCK TABLES `filePermissions` WRITE;
/*!40000 ALTER TABLE `filePermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `filePermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileTitles`
--

DROP TABLE IF EXISTS `fileTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `isDisplayTitle` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(500) DEFAULT NULL,
  `description` text,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `fileTitles_ibfk_1` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileTitles`
--

LOCK TABLES `fileTitles` WRITE;
/*!40000 ALTER TABLE `fileTitles` DISABLE KEYS */;
INSERT INTO `fileTitles` VALUES (3,2,1,1,'JavaScript Performance Rocks Checklist','','2010-02-27 06:44:53'),(4,1,1,1,'Marathonläufer in der Wüste','','2010-02-27 06:50:21');
/*!40000 ALTER TABLE `fileTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileTypes`
--

DROP TABLE IF EXISTS `fileTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `isImage` tinyint(1) DEFAULT NULL COMMENT 'If filetyp ecan be rendered to image',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileTypes`
--

LOCK TABLES `fileTypes` WRITE;
/*!40000 ALTER TABLE `fileTypes` DISABLE KEYS */;
INSERT INTO `fileTypes` VALUES (1,'Work',NULL),(2,'Private',NULL);
/*!40000 ALTER TABLE `fileTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileVersions`
--

DROP TABLE IF EXISTS `fileVersions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileVersions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idFiles` bigint(20) unsigned NOT NULL,
  `fileId` varchar(64) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `path` varchar(500) NOT NULL,
  `idParent` bigint(20) unsigned NOT NULL,
  `idParentTypes` int(10) unsigned NOT NULL,
  `isS3Stored` tinyint(4) NOT NULL DEFAULT '0',
  `isImage` tinyint(4) NOT NULL DEFAULT '0',
  `isLanguageSpecific` tinyint(1) NOT NULL DEFAULT '0',
  `filename` varchar(500) DEFAULT NULL,
  `idFileTypes` bigint(20) unsigned DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `size` bigint(20) unsigned NOT NULL COMMENT 'Filesize in KB',
  `extension` varchar(10) NOT NULL,
  `mimeType` varchar(255) NOT NULL,
  `version` int(10) NOT NULL,
  `archiver` bigint(20) unsigned DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `downloadCounter` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idFiles` (`idFiles`),
  KEY `version` (`version`),
  KEY `idFiles_2` (`idFiles`,`version`),
  CONSTRAINT `fileVersions_ibfk_1` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileVersions`
--

LOCK TABLES `fileVersions` WRITE;
/*!40000 ALTER TABLE `fileVersions` DISABLE KEYS */;
INSERT INTO `fileVersions` VALUES (1,1,'marathonlaeufer-in-der-wueste',3,'02/',16,2,0,1,0,'marathonlaeufer-in-der-wueste.jpg',NULL,3,'2010-02-26 21:11:14','0000-00-00 00:00:00',4461836,'jpg','image/jpeg',1,3,'2010-02-27 05:34:16',2),(2,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-26 21:11:54','0000-00-00 00:00:00',141286,'pdf','application/pdf',1,3,'2010-02-27 05:18:29',8),(3,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-27 05:18:29','0000-00-00 00:00:00',833693,'pdf','application/pdf',2,3,'2010-02-27 05:18:51',8),(4,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-27 05:18:51','0000-00-00 00:00:00',833693,'pdf','application/pdf',3,3,'2010-02-27 05:23:04',11),(5,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-27 05:23:04','0000-00-00 00:00:00',141286,'pdf','application/pdf',4,3,'2010-02-27 06:19:31',13),(6,1,'marathonlaeufer-in-der-wueste',3,'02/',16,2,0,1,0,'marathonlaeufer-in-der-wueste.jpg',NULL,3,'2010-02-27 05:34:45','0000-00-00 00:00:00',10583640,'jpg','image/jpeg',2,3,'2010-02-27 05:40:07',2),(7,1,'marathonlaeufer-in-der-wueste',3,'02/',16,2,0,1,0,'marathonlaeufer-in-der-wueste.jpg',NULL,3,'2010-02-27 05:40:23','0000-00-00 00:00:00',4461836,'jpg','image/jpeg',3,3,'2010-02-27 06:14:21',2),(8,1,'marathonlaeufer-in-der-wueste',3,'02/',16,2,0,1,0,'marathonlaeufer-in-der-wueste.jpg',NULL,3,'2010-02-27 06:14:52','0000-00-00 00:00:00',10583640,'jpg','image/jpeg',4,3,'2010-02-27 06:50:03',2),(9,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.zip',NULL,3,'2010-02-27 06:19:31','0000-00-00 00:00:00',507510,'zip','application/zip',5,3,'2010-02-27 06:21:26',13),(10,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-27 06:21:26','0000-00-00 00:00:00',833693,'pdf','application/pdf',6,3,'2010-02-27 06:24:43',13),(11,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-27 06:24:43','0000-00-00 00:00:00',833693,'pdf','application/pdf',7,3,'2010-02-27 06:27:19',13),(12,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-27 06:27:19','0000-00-00 00:00:00',833693,'pdf','application/pdf',8,3,'2010-02-27 06:34:32',13),(13,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.zip',NULL,3,'2010-02-27 06:34:32','0000-00-00 00:00:00',507510,'zip','application/zip',9,3,'2010-02-27 06:40:41',13),(14,2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-27 06:40:41','0000-00-00 00:00:00',833693,'pdf','application/pdf',10,NULL,NULL,0),(15,1,'marathonlaeufer-in-der-wueste',3,'02/',16,2,0,1,0,'marathonlaeufer-in-der-wueste.jpg',NULL,3,'2010-02-27 06:50:20','0000-00-00 00:00:00',4461836,'jpg','image/jpeg',5,NULL,NULL,0);
/*!40000 ALTER TABLE `fileVersions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` varchar(64) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `path` varchar(500) NOT NULL,
  `idParent` bigint(20) unsigned NOT NULL,
  `idParentTypes` int(10) unsigned NOT NULL,
  `isS3Stored` tinyint(4) NOT NULL DEFAULT '0',
  `isImage` tinyint(4) NOT NULL DEFAULT '0',
  `isLanguageSpecific` tinyint(1) NOT NULL DEFAULT '0',
  `filename` varchar(500) DEFAULT NULL,
  `idFileTypes` bigint(20) unsigned DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `size` bigint(20) unsigned NOT NULL,
  `extension` varchar(10) NOT NULL,
  `mimeType` varchar(255) NOT NULL,
  `version` int(10) NOT NULL,
  `downloadCounter` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (1,'marathonlaeufer-in-der-wueste',3,'02/',16,2,0,1,0,'marathonlaeufer-in-der-wueste.jpg',NULL,3,'2010-02-26 21:11:03','0000-00-00 00:00:00',4461836,'jpg','image/jpeg',5,2),(2,'javascript_performance_rocks_checklist',3,'03/',27,2,0,0,0,'javascript_performance_rocks_checklist.pdf',NULL,3,'2010-02-26 21:11:54','0000-00-00 00:00:00',833693,'pdf','application/pdf',10,13);
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folder-DEFAULT_FOLDER-1-Instances`
--

DROP TABLE IF EXISTS `folder-DEFAULT_FOLDER-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folder-DEFAULT_FOLDER-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `description` text,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `folderId` (`folderId`),
  CONSTRAINT `folder-DEFAULT_FOLDER-1-Instances_ibfk_1` FOREIGN KEY (`folderId`) REFERENCES `folders` (`folderId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folder-DEFAULT_FOLDER-1-Instances`
--

LOCK TABLES `folder-DEFAULT_FOLDER-1-Instances` WRITE;
/*!40000 ALTER TABLE `folder-DEFAULT_FOLDER-1-Instances` DISABLE KEYS */;
INSERT INTO `folder-DEFAULT_FOLDER-1-Instances` VALUES (1,'4b4da1506da54',1,1,'',3,3,'2010-01-13 10:32:48','2010-02-04 08:24:30'),(2,'4b4da2626c26e',1,1,'',3,3,'2010-01-13 10:37:22','2010-01-19 14:27:19'),(3,'4b4da2f3d8262',1,1,'',3,3,'2010-01-13 10:39:47','2010-01-19 14:27:10'),(4,'4b4da3e1ad508',1,1,'',3,3,'2010-01-13 10:43:45','2010-01-13 10:43:45'),(5,'4b4da3edf28c7',1,1,'',3,3,'2010-01-13 10:43:58','2010-01-13 10:43:58'),(6,'4b4da40d9c160',1,1,'',3,3,'2010-01-13 10:44:29','2010-01-13 10:44:29'),(7,'4b4da41aece41',1,1,'',3,3,'2010-01-13 10:44:42','2010-01-13 10:44:42'),(9,'4b4da6aa0a4a3',1,1,'',3,3,'2010-01-13 10:55:38','2010-01-19 14:32:46'),(10,'4b4da6bddd20a',1,1,'',3,3,'2010-01-13 10:55:57','2010-01-19 14:32:51'),(11,'4b4da6c8a2c78',1,1,'',3,3,'2010-01-13 10:56:08','2010-01-19 14:32:54'),(12,'4b4da6d555ee4',1,1,'',3,3,'2010-01-13 10:56:21','2010-01-19 14:32:57'),(13,'4b4dc2cc9ce44',1,1,'',3,3,'2010-01-13 12:55:40','2010-01-14 18:15:34'),(15,'4b558571344f9',1,1,'',3,3,'2010-01-19 10:12:01','2010-01-19 10:12:01'),(16,'4b5812d626983',1,1,'',3,3,'2010-01-21 08:39:50','2010-02-25 13:05:42'),(17,'4b5860d16f5ef',1,1,'',3,3,'2010-01-21 14:12:33','2010-02-03 15:48:04'),(18,'4b5860df6fe3a',1,1,'',3,3,'2010-01-21 14:12:47','2010-01-21 14:12:47'),(19,'4b5860fbec736',1,1,'',3,3,'2010-01-21 14:13:15','2010-02-03 15:10:44'),(20,'4b58612aaedcc',1,1,'',3,3,'2010-01-21 14:14:02','2010-02-15 17:38:42'),(21,'4b58619f3bbb3',1,1,'',3,3,'2010-01-21 14:15:59','2010-02-08 15:39:29'),(22,'4b5861a9e7d3a',1,1,'',3,3,'2010-01-21 14:16:09','2010-01-21 14:16:09'),(23,'4b5861b97748a',1,1,'',3,3,'2010-01-21 14:16:25','2010-01-21 14:16:25'),(24,'4b5861c7cbbb0',1,1,'',3,3,'2010-01-21 14:16:39','2010-01-21 14:16:39'),(25,'4b4da1506da54',1,2,'',3,3,'2010-02-01 13:56:30','2010-02-03 15:05:11'),(26,'4b4da2626c26e',1,2,'',3,3,'2010-02-01 13:56:45','2010-02-03 14:43:52'),(27,'4b4da2f3d8262',1,2,'',3,3,'2010-02-01 13:56:59','2010-02-03 14:44:15'),(28,'4b4da3e1ad508',1,2,'',3,3,'2010-02-01 13:57:41','2010-02-03 14:44:25'),(29,'4b4da3edf28c7',1,2,'',3,3,'2010-02-01 13:57:51','2010-02-03 14:44:34'),(30,'4b4da40d9c160',1,2,'',3,3,'2010-02-01 13:58:40','2010-02-03 14:44:40'),(31,'4b558571344f9',1,2,'',3,3,'2010-02-01 14:00:56','2010-02-03 14:44:56'),(32,'4b4da41aece41',1,2,'',3,3,'2010-02-01 14:01:09','2010-02-03 14:44:48'),(33,'4b5860d16f5ef',1,2,'',3,3,'2010-02-02 15:29:18','2010-02-03 15:09:51'),(34,'4b5860fbec736',1,3,'',3,3,'2010-02-02 15:32:27','2010-02-02 15:32:27'),(35,'4b5860fbec736',1,2,'',3,3,'2010-02-02 15:32:43','2010-02-03 15:10:48'),(37,'4b5860df6fe3a',1,2,'',3,3,'2010-02-03 15:09:37','2010-02-03 15:09:37'),(38,'4b58612aaedcc',1,2,'',3,3,'2010-02-03 15:27:23','2010-02-03 15:27:23'),(40,'4b6a8acc8ed3e',1,1,'',3,3,'2010-02-04 08:52:28','2010-02-04 08:52:28'),(41,'4b6fc9a0ef8e3',1,1,'',3,3,'2010-02-08 08:21:53','2010-02-08 16:10:10'),(42,'4b5860fbec736',1,4,'',3,3,'2010-02-08 16:13:42','2010-02-08 16:13:42'),(43,'4b58612aaedcc',1,4,'',3,3,'2010-02-09 08:22:40','2010-02-09 08:22:40'),(48,'4b5812d626983',1,2,'',3,3,'2010-02-17 16:11:46','2010-02-17 16:11:46');
/*!40000 ALTER TABLE `folder-DEFAULT_FOLDER-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderCategories`
--

DROP TABLE IF EXISTS `folderCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderCategories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `category` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `folderId` (`folderId`),
  KEY `version` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folderCategories`
--

LOCK TABLES `folderCategories` WRITE;
/*!40000 ALTER TABLE `folderCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `folderCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderPermissions`
--

DROP TABLE IF EXISTS `folderPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderPermissions` (
  `idFolders` bigint(20) unsigned NOT NULL,
  `environment` int(10) unsigned NOT NULL COMMENT '1 => ZOOLU, 2 => Website, 3 ... ???',
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`idFolders`,`environment`,`idGroups`),
  KEY `idFolders` (`idFolders`),
  KEY `idGroups` (`idGroups`),
  CONSTRAINT `folderPermissions_ibfk_1` FOREIGN KEY (`idFolders`) REFERENCES `folders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `folderPermissions_ibfk_2` FOREIGN KEY (`idGroups`) REFERENCES `groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folderPermissions`
--

LOCK TABLES `folderPermissions` WRITE;
/*!40000 ALTER TABLE `folderPermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `folderPermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderProperties`
--

DROP TABLE IF EXISTS `folderProperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderProperties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idFolderTypes` bigint(20) unsigned NOT NULL,
  `showInNavigation` smallint(5) unsigned NOT NULL DEFAULT '0',
  `isUrlFolder` tinyint(1) NOT NULL DEFAULT '1',
  `isVirtualFolder` tinyint(1) NOT NULL DEFAULT '0',
  `virtualFolderType` int(10) unsigned DEFAULT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `publisher` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `published` timestamp NULL DEFAULT NULL,
  `idStatus` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `folderId_2` (`folderId`,`version`,`idLanguages`),
  KEY `version` (`version`),
  KEY `idLanguages` (`idLanguages`),
  KEY `publisher` (`publisher`),
  KEY `creator` (`creator`),
  KEY `idUsers` (`idUsers`),
  KEY `folderId` (`folderId`),
  CONSTRAINT `folderProperties_ibfk_1` FOREIGN KEY (`folderId`) REFERENCES `folders` (`folderId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folderProperties`
--

LOCK TABLES `folderProperties` WRITE;
/*!40000 ALTER TABLE `folderProperties` DISABLE KEYS */;
INSERT INTO `folderProperties` VALUES (1,'4b4da1506da54',1,1,1,1,2,1,0,NULL,3,3,0,'2010-01-13 10:32:48','2010-02-04 08:24:30',NULL,2),(2,'4b4da2626c26e',1,1,1,1,2,1,0,NULL,3,3,0,'2010-01-13 10:37:22','2010-02-02 15:37:59',NULL,2),(3,'4b4da2f3d8262',1,1,1,1,2,1,0,NULL,3,3,0,'2010-01-13 10:39:47','2010-02-02 15:38:04',NULL,2),(4,'4b4da3e1ad508',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 10:43:45','2010-02-02 15:38:09',NULL,2),(5,'4b4da3edf28c7',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 10:43:57','2010-02-02 15:38:13',NULL,2),(6,'4b4da40d9c160',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 10:44:29','2010-02-02 15:38:18',NULL,2),(7,'4b4da41aece41',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 10:44:42','2010-02-02 15:38:23',NULL,2),(8,'4b4da6aa0a4a3',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 10:55:38','2010-01-19 14:33:38',NULL,2),(9,'4b4da6bddd20a',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 10:55:57','2010-01-19 14:33:38',NULL,2),(10,'4b4da6c8a2c78',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 10:56:08','2010-01-19 14:33:38',NULL,2),(11,'4b4da6d555ee4',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 10:56:21','2010-01-19 14:33:38',NULL,2),(12,'4b4dc2cc9ce44',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-13 12:55:40','2010-01-19 14:33:38',NULL,2),(13,'4b558571344f9',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-19 10:12:01','2010-02-02 15:38:27',NULL,2),(14,'4b5812d626983',1,1,1,1,0,1,0,NULL,3,3,0,'2010-01-21 08:39:50','2010-02-25 13:05:42',NULL,1),(15,'4b5860d16f5ef',1,1,1,1,0,1,0,NULL,3,3,0,'2010-01-21 14:12:33','2010-02-03 15:48:04',NULL,2),(16,'4b5860df6fe3a',1,1,1,1,0,1,0,NULL,3,3,0,'2010-01-21 14:12:47','2010-01-21 14:16:39',NULL,2),(17,'4b5860fbec736',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-21 14:13:15','2010-02-03 15:10:44',NULL,2),(18,'4b58612aaedcc',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-21 14:14:02','2010-02-15 17:38:42',NULL,2),(19,'4b58619f3bbb3',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-21 14:15:59','2010-02-08 15:39:29',NULL,2),(20,'4b5861a9e7d3a',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-21 14:16:09','2010-01-21 14:16:09',NULL,2),(21,'4b5861b97748a',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-21 14:16:25','2010-01-21 14:16:25',NULL,2),(22,'4b5861c7cbbb0',1,1,1,1,1,1,0,NULL,3,3,0,'2010-01-21 14:16:39','2010-01-21 14:16:39',NULL,2),(24,'4b4da1506da54',1,2,1,1,2,1,0,NULL,3,3,3,'2010-02-03 14:37:58','2010-02-03 15:05:11',NULL,2),(25,'4b4da2626c26e',1,2,1,1,2,1,0,NULL,3,3,3,'2010-02-03 14:43:52','2010-02-03 14:43:52',NULL,2),(26,'4b4da2f3d8262',1,2,1,1,2,1,0,NULL,3,3,3,'2010-02-03 14:44:15','2010-02-03 14:44:15',NULL,2),(27,'4b4da3e1ad508',1,2,1,1,1,1,0,NULL,3,3,3,'2010-02-03 14:44:25','2010-02-03 14:44:25',NULL,2),(28,'4b4da3edf28c7',1,2,1,1,1,1,0,NULL,3,3,3,'2010-02-03 14:44:34','2010-02-03 14:44:34',NULL,2),(29,'4b4da40d9c160',1,2,1,1,1,1,0,NULL,3,3,3,'2010-02-03 14:44:40','2010-02-03 14:44:40',NULL,2),(30,'4b4da41aece41',1,2,1,1,1,1,0,NULL,3,3,3,'2010-02-03 14:44:48','2010-02-03 14:44:48',NULL,2),(31,'4b558571344f9',1,2,1,1,1,1,0,NULL,3,3,3,'2010-02-03 14:44:56','2010-02-03 14:44:56',NULL,2),(32,'4b5860df6fe3a',1,2,1,1,0,1,0,NULL,3,3,3,'2010-02-03 15:09:37','2010-02-03 15:09:37',NULL,2),(33,'4b5860d16f5ef',1,2,1,1,0,1,0,NULL,3,3,3,'2010-02-03 15:09:48','2010-02-03 15:09:51',NULL,2),(34,'4b5860fbec736',1,2,1,1,1,1,0,NULL,3,3,3,'2010-02-03 15:10:14','2010-02-03 15:10:48',NULL,2),(35,'4b58612aaedcc',1,2,1,1,1,1,0,NULL,3,3,3,'2010-02-03 15:27:23','2010-02-03 15:27:23',NULL,2),(37,'4b6a8acc8ed3e',1,1,1,1,0,1,0,NULL,3,3,3,'2010-02-04 08:52:28','2010-02-04 08:52:28',NULL,1),(38,'4b6fc9a0ef8e3',1,1,1,1,0,1,0,NULL,3,3,3,'2010-02-08 08:21:53','2010-02-08 16:10:10',NULL,2),(39,'4b5860fbec736',1,4,1,1,1,1,0,NULL,3,3,3,'2010-02-08 16:13:42','2010-02-08 16:13:42',NULL,2),(40,'4b58612aaedcc',1,4,1,1,1,1,0,NULL,3,3,3,'2010-02-09 08:22:40','2010-02-09 08:22:40',NULL,2),(45,'4b5812d626983',1,2,1,1,0,1,0,NULL,3,3,3,'2010-02-17 16:11:46','2010-02-17 16:11:46',NULL,1);
/*!40000 ALTER TABLE `folderProperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderTitles`
--

DROP TABLE IF EXISTS `folderTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `folderId` (`folderId`),
  CONSTRAINT `folderTitles_ibfk_1` FOREIGN KEY (`folderId`) REFERENCES `folders` (`folderId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folderTitles`
--

LOCK TABLES `folderTitles` WRITE;
/*!40000 ALTER TABLE `folderTitles` DISABLE KEYS */;
INSERT INTO `folderTitles` VALUES (1,'4b4da1506da54',1,1,'Dental Professional',3,3,'2010-01-13 10:32:48','2010-02-04 08:24:30'),(2,'4b4da2626c26e',1,1,'Laboratory Professional',3,3,'2010-01-13 10:37:22','2010-01-19 14:27:19'),(3,'4b4da2f3d8262',1,1,'Alle Produkte',3,3,'2010-01-13 10:39:47','2010-01-19 14:27:10'),(4,'4b4da3e1ad508',1,1,'Unternehmen',3,3,'2010-01-13 10:43:45','2010-01-13 10:43:45'),(5,'4b4da3edf28c7',1,1,'Presse',3,3,'2010-01-13 10:43:58','2010-01-13 10:43:58'),(6,'4b4da40d9c160',1,1,'Karriere',3,3,'2010-01-13 10:44:29','2010-01-13 10:44:29'),(7,'4b4da41aece41',1,1,'Support',3,3,'2010-01-13 10:44:42','2010-01-13 10:44:42'),(9,'4b4da6aa0a4a3',1,1,'Passion x Vision x Innovation',3,3,'2010-01-13 10:55:38','2010-01-19 14:32:46'),(10,'4b4da6bddd20a',1,1,'Geschichte',3,3,'2010-01-13 10:55:57','2010-01-19 14:32:51'),(11,'4b4da6c8a2c78',1,1,'Zahlen und Fakten',3,3,'2010-01-13 10:56:08','2010-01-19 14:32:54'),(12,'4b4da6d555ee4',1,1,'Management',3,3,'2010-01-13 10:56:21','2010-01-19 14:32:57'),(13,'4b4dc2cc9ce44',1,1,'Jobs',3,3,'2010-01-13 12:55:40','2010-01-14 18:15:34'),(15,'4b558571344f9',1,1,'Kontakt',3,3,'2010-01-19 10:12:01','2010-01-19 10:12:01'),(16,'4b5812d626983',1,1,'Test',3,3,'2010-01-21 08:39:50','2010-02-25 13:05:42'),(17,'4b5860d16f5ef',1,1,'Produkte',3,3,'2010-01-21 14:12:33','2010-02-03 15:48:04'),(18,'4b5860df6fe3a',1,1,'Kompetenzen',3,3,'2010-01-21 14:12:47','2010-01-21 14:12:47'),(19,'4b5860fbec736',1,1,'Zähne',3,3,'2010-01-21 14:13:15','2010-02-03 15:10:44'),(20,'4b58612aaedcc',1,1,'Zahnzubehör',3,3,'2010-01-21 14:14:02','2010-02-15 17:38:42'),(21,'4b58619f3bbb3',1,1,'Füllungsmaterialie',3,3,'2010-01-21 14:15:59','2010-02-08 15:39:29'),(22,'4b5861a9e7d3a',1,1,'Composites',3,3,'2010-01-21 14:16:09','2010-01-21 14:16:09'),(23,'4b5861b97748a',1,1,'Compomere',3,3,'2010-01-21 14:16:25','2010-01-21 14:16:25'),(24,'4b5861c7cbbb0',1,1,'Amalgame',3,3,'2010-01-21 14:16:39','2010-01-21 14:16:39'),(25,'4b4da1506da54',1,2,'Dental Professional',3,3,'2010-02-01 13:56:30','2010-02-03 15:05:11'),(26,'4b4da2626c26e',1,2,'Laboratory Professional',3,3,'2010-02-01 13:56:45','2010-02-03 14:43:52'),(27,'4b4da2f3d8262',1,2,'All Products',3,3,'2010-02-01 13:56:59','2010-02-03 14:44:15'),(28,'4b4da3e1ad508',1,2,'Company',3,3,'2010-02-01 13:57:41','2010-02-03 14:44:25'),(29,'4b4da3edf28c7',1,2,'Press',3,3,'2010-02-01 13:57:51','2010-02-03 14:44:34'),(30,'4b4da40d9c160',1,2,'Career',3,3,'2010-02-01 13:58:40','2010-02-03 14:44:40'),(31,'4b558571344f9',1,2,'Contact',3,3,'2010-02-01 14:00:56','2010-02-03 14:44:56'),(32,'4b4da41aece41',1,2,'Support',3,3,'2010-02-01 14:01:09','2010-02-03 14:44:48'),(33,'4b5860d16f5ef',1,2,'Products',3,3,'2010-02-02 15:29:18','2010-02-03 15:09:51'),(34,'4b5860fbec736',1,3,'Teeths',3,3,'2010-02-02 15:32:27','2010-02-02 15:32:27'),(35,'4b5860fbec736',1,2,'Teeths',3,3,'2010-02-02 15:32:43','2010-02-03 15:10:48'),(37,'4b5860df6fe3a',1,2,'Competences',3,3,'2010-02-03 15:09:37','2010-02-03 15:09:37'),(38,'4b58612aaedcc',1,2,'Teeth Accessory',3,3,'2010-02-03 15:27:23','2010-02-03 15:27:23'),(40,'4b6a8acc8ed3e',1,1,'Test',3,3,'2010-02-04 08:52:28','2010-02-04 08:52:28'),(41,'4b6fc9a0ef8e3',1,1,'Zahnschrank',3,3,'2010-02-08 08:21:53','2010-02-08 16:10:10'),(42,'4b5860fbec736',1,4,'Zähne',3,3,'2010-02-08 16:13:42','2010-02-08 16:13:42'),(43,'4b58612aaedcc',1,4,'Zahnzubehör',3,3,'2010-02-09 08:22:40','2010-02-09 08:22:40'),(48,'4b5812d626983',1,2,'Test 2',3,3,'2010-02-17 16:11:46','2010-02-17 16:11:46');
/*!40000 ALTER TABLE `folderTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderTypes`
--

DROP TABLE IF EXISTS `folderTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folderTypes`
--

LOCK TABLES `folderTypes` WRITE;
/*!40000 ALTER TABLE `folderTypes` DISABLE KEYS */;
INSERT INTO `folderTypes` VALUES (1,'folder'),(2,'blog');
/*!40000 ALTER TABLE `folderTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folders`
--

DROP TABLE IF EXISTS `folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idParentFolder` bigint(20) unsigned DEFAULT NULL,
  `idRootLevels` bigint(20) unsigned DEFAULT NULL,
  `lft` int(10) unsigned DEFAULT NULL,
  `rgt` int(10) unsigned DEFAULT NULL,
  `depth` int(10) unsigned DEFAULT NULL,
  `idSortTypes` bigint(20) unsigned NOT NULL,
  `sortOrder` varchar(255) DEFAULT NULL,
  `sortPosition` bigint(20) unsigned NOT NULL,
  `sortTimestamp` timestamp NULL DEFAULT NULL,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `folderId` (`folderId`),
  KEY `idParentFolder` (`idParentFolder`),
  KEY `idRootLevels` (`idRootLevels`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders`
--

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
INSERT INTO `folders` VALUES (1,0,1,1,2,0,0,NULL,1,'2010-01-19 10:37:27','4b4da1506da54',1,3,3,'2010-01-13 10:32:48','2010-02-04 08:24:30'),(2,0,1,3,4,0,0,NULL,2,'2010-01-19 10:37:27','4b4da2626c26e',1,3,3,'2010-01-13 10:37:22','2010-02-03 14:43:52'),(3,0,1,5,6,0,0,NULL,3,'2010-01-19 10:37:27','4b4da2f3d8262',1,3,3,'2010-01-13 10:39:47','2010-02-03 14:44:15'),(4,0,1,7,18,0,0,NULL,4,'2010-01-19 10:37:27','4b4da3e1ad508',1,3,3,'2010-01-13 10:43:45','2010-02-03 14:44:25'),(5,0,1,19,20,0,0,NULL,5,'2010-01-19 10:37:27','4b4da3edf28c7',1,3,3,'2010-01-13 10:43:57','2010-02-03 14:44:34'),(6,0,1,21,22,0,0,NULL,6,'2010-01-19 10:37:27','4b4da40d9c160',1,3,3,'2010-01-13 10:44:29','2010-02-03 14:44:40'),(7,0,1,23,24,0,0,NULL,7,'2010-01-19 10:37:27','4b4da41aece41',1,3,3,'2010-01-13 10:44:42','2010-02-03 14:44:48'),(9,4,1,8,9,1,0,NULL,1,'2010-02-08 16:25:27','4b4da6aa0a4a3',1,3,3,'2010-01-13 10:55:38','2010-02-08 16:25:27'),(10,4,1,10,11,1,0,NULL,2,'2010-02-08 16:25:27','4b4da6bddd20a',1,3,3,'2010-01-13 10:55:57','2010-02-08 16:25:27'),(11,4,1,12,13,1,0,NULL,3,'2010-02-08 16:25:27','4b4da6c8a2c78',1,3,3,'2010-01-13 10:56:08','2010-02-08 16:25:27'),(12,4,1,14,15,1,0,NULL,4,'2010-02-08 16:25:27','4b4da6d555ee4',1,3,3,'2010-01-13 10:56:21','2010-02-08 16:25:27'),(13,4,1,16,17,1,0,NULL,6,'2010-02-08 16:25:27','4b4dc2cc9ce44',1,3,3,'2010-01-13 12:55:40','2010-02-08 16:25:27'),(15,0,1,25,26,0,0,NULL,8,'2010-01-19 10:37:27','4b558571344f9',1,3,3,'2010-01-19 10:12:01','2010-02-03 14:44:56'),(16,0,2,1,2,0,0,NULL,0,'2010-01-21 08:39:50','4b5812d626983',1,3,3,'2010-01-21 08:39:50','2010-02-25 13:05:42'),(17,0,12,1,16,0,0,NULL,0,'2010-01-21 14:12:33','4b5860d16f5ef',1,3,3,'2010-01-21 14:12:33','2010-02-08 08:21:53'),(18,0,12,17,18,0,0,NULL,1,'2010-01-21 14:12:47','4b5860df6fe3a',1,3,3,'2010-01-21 14:12:47','2010-02-08 08:21:53'),(19,17,12,2,7,1,0,NULL,0,'2010-01-21 14:13:15','4b5860fbec736',1,3,3,'2010-01-21 14:13:15','2010-02-08 16:13:42'),(20,19,12,3,6,2,0,NULL,1,'2010-02-08 16:25:35','4b58612aaedcc',1,3,3,'2010-01-21 14:14:02','2010-02-15 17:38:42'),(21,17,12,8,15,1,0,NULL,1,'2010-01-21 14:15:59','4b58619f3bbb3',1,3,3,'2010-01-21 14:15:59','2010-02-08 15:39:29'),(22,21,12,9,10,2,0,NULL,0,'2010-01-21 14:16:09','4b5861a9e7d3a',1,3,3,'2010-01-21 14:16:09','2010-02-08 08:21:53'),(23,21,12,11,12,2,0,NULL,1,'2010-01-21 14:16:25','4b5861b97748a',1,3,3,'2010-01-21 14:16:25','2010-02-08 08:21:53'),(24,21,12,13,14,2,0,NULL,2,'2010-01-21 14:16:39','4b5861c7cbbb0',1,3,3,'2010-01-21 14:16:39','2010-02-08 08:21:53'),(27,0,3,1,2,0,0,NULL,0,'2010-02-04 08:52:28','4b6a8acc8ed3e',1,3,3,'2010-02-04 08:52:28','2010-02-19 10:34:15'),(28,20,12,4,5,3,0,NULL,1,'2010-02-08 09:05:25','4b6fc9a0ef8e3',1,3,3,'2010-02-08 08:21:52','2010-02-08 16:10:10');
/*!40000 ALTER TABLE `folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genericFormTabs`
--

DROP TABLE IF EXISTS `genericFormTabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genericFormTabs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idGenericForms` bigint(20) NOT NULL,
  `idTabs` bigint(20) NOT NULL,
  `order` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genericFormTabs`
--

LOCK TABLES `genericFormTabs` WRITE;
/*!40000 ALTER TABLE `genericFormTabs` DISABLE KEYS */;
INSERT INTO `genericFormTabs` VALUES (1,1,1,1),(2,2,2,1),(3,3,3,1),(4,4,4,1),(5,5,5,1),(6,6,6,1),(7,7,7,1),(8,8,8,1),(9,9,9,1),(10,10,10,1),(11,11,11,1),(12,12,12,1),(13,13,13,1),(14,14,14,1),(15,14,15,2),(16,14,16,3),(17,14,17,4),(18,14,18,5),(19,14,19,6),(20,15,7,1),(21,16,20,1),(22,17,21,1),(23,18,22,1);
/*!40000 ALTER TABLE `genericFormTabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genericFormTitles`
--

DROP TABLE IF EXISTS `genericFormTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genericFormTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(255) DEFAULT NULL,
  `idAction` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `genericFormTitles_ibfk_1` (`idGenericForms`),
  CONSTRAINT `genericFormTitles_ibfk_1` FOREIGN KEY (`idGenericForms`) REFERENCES `genericForms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genericFormTitles`
--

LOCK TABLES `genericFormTitles` WRITE;
/*!40000 ALTER TABLE `genericFormTitles` DISABLE KEYS */;
INSERT INTO `genericFormTitles` VALUES (1,6,1,'Interne Verlinkung',1),(2,6,1,'Interne Verlinkung',2),(3,13,1,'Externe Verlinkung',1),(4,13,1,'Externe Verlinkung',2);
/*!40000 ALTER TABLE `genericFormTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genericFormTypes`
--

DROP TABLE IF EXISTS `genericFormTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genericFormTypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genericFormTypes`
--

LOCK TABLES `genericFormTypes` WRITE;
/*!40000 ALTER TABLE `genericFormTypes` DISABLE KEYS */;
INSERT INTO `genericFormTypes` VALUES (1,'folder'),(2,'page'),(3,'category'),(4,'unit'),(5,'contact'),(6,'product');
/*!40000 ALTER TABLE `genericFormTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genericForms`
--

DROP TABLE IF EXISTS `genericForms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genericForms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idUsers` bigint(20) unsigned NOT NULL,
  `genericFormId` varchar(32) NOT NULL,
  `version` int(10) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idGenericFormTypes` int(10) unsigned NOT NULL,
  `mandatoryUpgrade` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genericForms`
--

LOCK TABLES `genericForms` WRITE;
/*!40000 ALTER TABLE `genericForms` DISABLE KEYS */;
INSERT INTO `genericForms` VALUES (1,2,'DEFAULT_FOLDER',1,'2008-11-14 08:54:39','2008-11-14 08:54:39',1,0),(2,2,'DEFAULT_PAGE_1',1,'2009-01-29 07:27:34','2009-01-29 07:27:34',2,0),(5,2,'DEFAULT_CATEGORY',1,'2009-03-17 16:01:58','2009-03-17 16:01:58',3,0),(6,3,'DEFAULT_LINKING',1,'2009-02-11 15:37:37','2009-02-11 15:37:37',2,0),(7,2,'DEFAULT_OVERVIEW',1,'2009-02-17 13:30:42','2009-02-17 13:30:42',2,0),(8,2,'DEFAULT_STARTPAGE',1,'2009-02-27 09:51:14','2009-02-27 09:51:14',2,0),(9,3,'DEFAULT_UNIT',1,'2009-04-07 19:23:58','2009-04-07 19:23:58',4,0),(10,3,'DEFAULT_CONTACT',1,'2009-04-07 19:23:58','2009-04-07 19:23:58',5,0),(11,2,'DEFAULT_EVENT',1,'2009-04-09 15:04:57','2009-04-09 15:04:57',2,0),(12,2,'DEFAULT_EVENT_OVERVIEW',1,'2009-04-17 08:09:45','2009-04-17 08:09:45',2,0),(13,2,'DEFAULT_EXTERNAL',1,'2009-05-18 13:15:16','2009-02-11 15:37:37',2,0),(14,3,'DEFAULT_PROCESS',1,'2009-08-28 12:04:14','2009-08-28 12:04:14',2,0),(15,3,'DEFAULT_COLLECTION',1,'2009-08-28 12:04:01','2009-08-28 12:04:01',2,0),(16,3,'DEFAULT_PRODUCT',1,'2009-10-30 09:53:00','2009-10-30 09:53:00',6,0),(17,3,'DEFAULT_PRODUCT_OVERVIEW',1,'2009-12-09 14:37:56','2009-12-09 14:37:56',6,0),(18,2,'DEFAULT_PRODUCT_TREE',1,'2009-12-23 13:52:14','2009-02-17 13:30:42',2,0);
/*!40000 ALTER TABLE `genericForms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupPermissions`
--

DROP TABLE IF EXISTS `groupPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupPermissions` (
  `idGroups` bigint(20) unsigned NOT NULL,
  `idLanguages` bigint(20) unsigned NOT NULL,
  `idPermissions` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`idGroups`,`idLanguages`,`idPermissions`),
  KEY `idPermissions` (`idPermissions`),
  CONSTRAINT `groupPermissions_ibfk_1` FOREIGN KEY (`idGroups`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `groupPermissions_ibfk_2` FOREIGN KEY (`idPermissions`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupPermissions`
--

LOCK TABLES `groupPermissions` WRITE;
/*!40000 ALTER TABLE `groupPermissions` DISABLE KEYS */;
INSERT INTO `groupPermissions` VALUES (1,0,1),(2,0,1),(3,0,1),(4,1,1),(4,2,1),(5,0,1),(6,0,1),(7,0,1),(1,0,2),(2,0,2),(3,0,2),(5,0,2),(6,0,2),(7,0,2),(1,0,3),(2,0,3),(3,0,3),(4,2,3),(5,0,3),(6,0,3),(7,0,3),(1,0,4),(2,0,4),(3,0,4),(5,0,4),(6,0,4),(7,0,4),(1,0,5),(2,0,5),(3,0,5),(5,0,5),(7,0,5),(1,0,6),(2,0,6),(3,0,6),(5,0,6),(7,0,6),(1,0,7);
/*!40000 ALTER TABLE `groupPermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupTypes`
--

DROP TABLE IF EXISTS `groupTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Typen für Gruppen CMS,...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupTypes`
--

LOCK TABLES `groupTypes` WRITE;
/*!40000 ALTER TABLE `groupTypes` DISABLE KEYS */;
INSERT INTO `groupTypes` VALUES (1,'cms'),(2,'extranet'),(3,'intranet');
/*!40000 ALTER TABLE `groupTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `key` varchar(64) NOT NULL,
  `description` text,
  `idGroupTypes` bigint(20) unsigned DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Admin','admin','',NULL,3,3,'2009-10-16 09:48:44','2009-10-23 08:48:12'),(2,'Content Manager','content_manager','',NULL,3,3,'2009-10-16 09:58:37','2009-10-23 08:40:13'),(3,'Media Manager','media_manager','',NULL,3,3,'2009-10-16 10:02:54','2009-10-19 14:20:32'),(4,'Übersetzer Englisch','translate_en','',NULL,1,1,'2009-10-20 06:35:46','2009-10-20 06:35:46'),(5,'Content Administrator','content_admin','',NULL,1,1,'2009-10-20 06:36:41','2009-10-20 06:36:41'),(6,'Productmanager','product_manager','',NULL,1,1,'2009-10-20 06:38:33','2009-10-20 06:38:33'),(7,'Product Administrator','product_admin','',NULL,1,1,'2009-10-20 06:38:58','2009-10-20 06:38:58');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guiTexts`
--

DROP TABLE IF EXISTS `guiTexts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guiTexts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idLanguanges` int(10) unsigned NOT NULL DEFAULT '1',
  `guiId` varchar(32) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idLanguanges` (`idLanguanges`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for multilanguage GUI';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guiTexts`
--

LOCK TABLES `guiTexts` WRITE;
/*!40000 ALTER TABLE `guiTexts` DISABLE KEYS */;
/*!40000 ALTER TABLE `guiTexts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `languageCode` varchar(5) NOT NULL,
  `title` varchar(255) NOT NULL,
  `sortOrder` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'DE','COM-Deutsch',1),(2,'EN','COM-English',2),(3,'ES','COM-Spanisch',3),(4,'DE-DE','Deutschland',99),(5,'IT','Italien',99),(6,'FR','Frankreich',99),(7,'PL','Polen',99),(8,'RU','Russland',99),(9,'SV','Schweden',99),(10,'EN-US','USA / Kanada',99),(11,'EN-NZ','Neuseeland',99),(12,'EN-AU','Australien',99),(13,'JP','Japan',99),(14,'ES-CO','Kolumbien',99),(15,'ES-MX','Mexiko',99),(16,'EN-AS','Asien',99),(17,'EN-ME','mitlerer Osten',99),(18,'PT-BR','Brasilien',99),(19,'CN','China',99),(20,'KO','Korea',99),(21,'EN-IN','Indien',99),(22,'SL','Slowenien',99),(23,'EL','Griechenland',99),(24,'TR','Türkei',99),(25,'EN-UK','UK',99),(26,'HR','Kroatien, Bosnien & Herzegowina, Serbien&Montenegro',99);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `resourceKey` varchar(64) DEFAULT NULL,
  `cssClass` varchar(64) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'cms','portals','navtop',1,1),(2,'media','media','navtop',3,1),(3,'properties','settings','navtopinnerright',4,1),(4,'users','user_administration','navtopinnerright',5,1),(5,'products','products','navtop',2,1);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigationOptionTitles`
--

DROP TABLE IF EXISTS `navigationOptionTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigationOptionTitles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idNavigationOptions` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idProductTypes` (`idNavigationOptions`),
  CONSTRAINT `navigationOptionTitles_ibfk_1` FOREIGN KEY (`idNavigationOptions`) REFERENCES `navigationOptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigationOptionTitles`
--

LOCK TABLES `navigationOptionTitles` WRITE;
/*!40000 ALTER TABLE `navigationOptionTitles` DISABLE KEYS */;
INSERT INTO `navigationOptionTitles` VALUES (1,1,1,'Top-Navigation'),(2,2,1,'Seiten-Navigation'),(3,3,1,'Seiten-Navigation'),(4,4,1,'Footer');
/*!40000 ALTER TABLE `navigationOptionTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigationOptions`
--

DROP TABLE IF EXISTS `navigationOptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigationOptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigationOptions`
--

LOCK TABLES `navigationOptions` WRITE;
/*!40000 ALTER TABLE `navigationOptions` DISABLE KEYS */;
INSERT INTO `navigationOptions` VALUES (1,'top',1),(2,'left',1),(3,'right',0),(4,'bottom',1);
/*!40000 ALTER TABLE `navigationOptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_COLLECTION-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_COLLECTION-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_COLLECTION-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_COLLECTION-1-InstanceFiles_ibfk_1` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_COLLECTION-1-InstanceFiles_ibfk_2` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_COLLECTION-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_COLLECTION-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_COLLECTION-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_COLLECTION-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_COLLECTION-1-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_COLLECTION-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_COLLECTION-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) DEFAULT NULL,
  `collection_title` varchar(255) DEFAULT NULL,
  `shortdescription` text,
  `description` text NOT NULL,
  `header_embed_code` text,
  `contact` varchar(255) DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_COLLECTION-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-Instances`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_COLLECTION-1-Region14-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_COLLECTION-1-Region14-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_COLLECTION-1-Region14-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_COLLECTION-1-Region14-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) DEFAULT NULL,
  `sidebar_description` text,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_COLLECTION-1-Region14-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_EVENT-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_EVENT-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_EVENT-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_EVENT-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_EVENT-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_EVENT-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_EVENT-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_EVENT-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_EVENT-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_EVENT-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_EVENT-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_EVENT-1-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_EVENT-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_EVENT-1-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_EVENT-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_EVENT-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` text NOT NULL,
  `description` text,
  `pics_title` varchar(255) DEFAULT NULL,
  `docs_title` varchar(255) DEFAULT '',
  `video_title` varchar(255) DEFAULT NULL,
  `video_embed_code` text,
  `shortdescription` text NOT NULL,
  `event_duration` varchar(255) DEFAULT NULL,
  `event_street` varchar(255) DEFAULT NULL,
  `event_streetnr` varchar(255) DEFAULT NULL,
  `event_plz` varchar(255) DEFAULT NULL,
  `event_city` varchar(255) DEFAULT NULL,
  `event_location` varchar(255) DEFAULT NULL,
  `event_max_members` varchar(255) DEFAULT NULL,
  `event_costs` varchar(255) DEFAULT NULL,
  `event_status` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_EVENT-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_EVENT-1-Instances`
--

LOCK TABLES `page-DEFAULT_EVENT-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT-1-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT_OVERVIEW-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_EVENT_OVERVIEW-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_EVENT_OVERVIEW-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_EVENT_OVERVIEW-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_EVENT_OVERVIEW-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_EVENT_OVERVIEW-1-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_EVENT_OVERVIEW-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT_OVERVIEW-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT_OVERVIEW-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_EVENT_OVERVIEW-1-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_EVENT_OVERVIEW-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_EVENT_OVERVIEW-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `shortdescription` text NOT NULL,
  `description` text NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_EVENT_OVERVIEW-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_EVENT_OVERVIEW-1-Instances`
--

LOCK TABLES `page-DEFAULT_EVENT_OVERVIEW-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT_OVERVIEW-1-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_EVENT_OVERVIEW-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) DEFAULT NULL,
  `shortdescription` text,
  `description` text NOT NULL,
  `header_embed_code` text,
  `contact` varchar(255) DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Instances` VALUES (1,'4b4dc2ccb3e8d',1,1,3,'','','',NULL,NULL,3,'2010-01-13 13:14:30','2010-01-18 13:01:50');
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_OVERVIEW-1-Region14-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-Region14-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-Region14-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-Region14-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) DEFAULT NULL,
  `sidebar_description` text,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Region14-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Region14-Instances` VALUES (4,'4b4dc2ccb3e8d',1,1,1,'','');
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-Region15-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-Region15-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-Region15-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `entry_title` varchar(255) DEFAULT NULL,
  `entry_category` bigint(20) unsigned DEFAULT NULL,
  `entry_label` bigint(20) unsigned DEFAULT NULL,
  `entry_viewtype` bigint(20) unsigned DEFAULT NULL,
  `entry_number` bigint(20) unsigned DEFAULT NULL,
  `entry_sorttype` bigint(20) unsigned DEFAULT NULL,
  `entry_sortorder` bigint(20) unsigned DEFAULT NULL,
  `entry_depth` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Region15-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Region15-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Region15-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region15-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Region15-Instances` VALUES (4,'4b4dc2ccb3e8d',1,1,1,'Jobs bei Ivoclar Vivadent',55,0,29,1000,0,0,0);
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region15-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PAGE_1-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` text NOT NULL,
  `description` text,
  `header_embed_code` text,
  `pics_title` varchar(255) DEFAULT NULL,
  `docs_title` varchar(255) DEFAULT '',
  `internal_links_title` varchar(255) DEFAULT NULL,
  `video_title` varchar(255) DEFAULT NULL,
  `video_embed_code` text,
  `shortdescription` text NOT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Instances`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PAGE_1-1-Instances` VALUES (1,'4b4d8dc9a138f',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 09:09:29','2010-01-13 09:09:29'),(2,'4b4da15087430',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:32:48','2010-01-13 10:37:01'),(3,'4b4da26279384',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:37:22','2010-01-13 10:37:22'),(4,'4b4da2f3f290d',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:39:48','2010-01-13 10:39:48'),(5,'4b4da3e1c4291',1,1,3,'Willkommen auf der Internetseite der Ivoclar Vivadent','<p>Das Internet ist zu einem wichtigen Informations- und Kommunikationsmedium im dentalen Bereich avanciert.&nbsp; Immer h&auml;ufiger nutzen Zahn&auml;rzte und Zahntechniker dieses Medium zur Beschaffung von Produktinformationen und zur Fortbildung. Mit der zunehmenden Nutzung ist auch der Bedarf nach einer Optimierung der Webseite gestiegen, um diese Ihren W&uuml;nschen und Bed&uuml;rfnissen entsprechend zu gestalten. Ihre Bed&uuml;rfnisse und die sich uns bietenden Kommunikationsm&ouml;glichkeiten haben uns dazu veranlasst, unsere Internet-Plattform weiter zu verbessern. Ich habe nun das Vergn&uuml;gen, Sie auf der Informations-Homepage der Ivoclar Vivadent AG willkommen zu heissen und Ihnen einen kurzen &Uuml;berblick zu bieten.<br /><br />Bei der Weiterentwicklung bzw. Neukonzeption stand der Online-Besucher -also Sie - im Mittelpunkt der &Uuml;berlegungen. Erste Priorit&auml;t war immer die Benutzerfreundlichkeit unserer Homepage - und sollte dies auch bleiben. In der Entwicklungs- und Planungsphase erhielten wir viele wertvolle Anregungen von Benutzern, die auch in die Konzeption einflossen. Unser Internetauftritt ist daher besonders benutzerfreundlich, da er durch Benutzer mitgestaltet wurde.<br /><br />Gebrauchsinformationen, wissenschaftliche Dokumentationen, Brosch&uuml;ren, Bilder, Videos und Sicherheitsdatenbl&auml;tter f&uuml;r viele Produkte lassen sich einfach und schnell herunterladen. Als JournalistIn finden Sie im&nbsp; Presseraum alle Pressemeldungen der letzten drei Jahre, sowie ein umfangreiches Bildarchiv. Die Sparte Medienresonanz bietet Ihnen einen &Uuml;berblick &uuml;ber publizierte Artikel rund um Ivoclar Vivadent.&nbsp; Seit&nbsp;Mai 2006 ist die deutsche und englische Version der Homepage aktiv, und im Laufe der n&auml;chsten Monate werden auch die italienischen, franz&ouml;sischen und spanischen Internetportale ge&ouml;ffnet.<br /><br />Wir hoffen, dass Ihnen der Besuch auf unserer Homepage Vergn&uuml;gen bereiten wird. Besuchen Sie unsere Webseite so oft wie m&ouml;glich und nutzen Sie die Informationsm&ouml;glichkeiten, die sie Ihnen bietet! Bitte haben Sie Verst&auml;ndnis daf&uuml;r, dass unsere Arbeit an der Homepage weitergehen wird - wir tun dies zu Ihrem Wohle und um dieses Kommunikations-<br />medium weiter zu verbessern. Bitte senden Sie uns weiterhin Ihre Ideen und Ihr Feedback. Bei Ivoclar Vivadent sind wir stets bem&uuml;ht, Ihnen umfassende Informationen sowie Dentalmaterialien h&ouml;chster Qualit&auml;t und &Auml;sthetik zur Verf&uuml;gung zu stellen.<br /><br />Nochmals willkommen auf der Internetseite der Ivoclar Vivadent!<br /><br />Robert A. Ganley / CEO</p>',NULL,'','','weiter Informationen (Test Michi)','','','','',3,'2010-01-13 10:43:45','2010-02-11 18:20:35'),(6,'4b4da3ee0b54d',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:43:58','2010-01-18 13:02:04'),(7,'4b4da40da918b',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:44:29','2010-01-18 13:02:14'),(8,'4b4da41b05a85',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:44:43','2010-01-18 13:02:18'),(9,'4b4da430b62f8',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:45:04','2010-01-18 13:02:21'),(10,'4b4da6aa1ac18',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:55:38','2010-01-18 12:57:24'),(11,'4b4da6bdeafc1',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:55:57','2010-01-18 12:57:58'),(12,'4b4da6c8b5347',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:56:08','2010-01-18 12:58:02'),(13,'4b4da6d5688cb',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 10:56:21','2010-01-18 13:01:43'),(14,'4b4dc2ac5fba0',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 12:55:08','2010-01-19 14:57:07'),(15,'4b4dc2ccb3e8d',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 12:55:40','2010-01-13 12:55:40'),(16,'4b4dc303af218',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 12:56:35','2010-01-18 13:01:54'),(17,'4b4dc31a83c14',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 12:56:58','2010-01-18 13:01:57'),(18,'4b4dc70098b2a',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-13 13:13:36','2010-01-18 13:02:00'),(19,'4b4f351e0300e',1,1,3,'','<ul>\n<li>asdf</li>\n<li>asdf</li>\n<li>asdf</li>\n</ul>\n<ol>\n<li>asdf</li>\n<li>asdf</li>\n<li>asdf</li>\n</ol>',NULL,'','','','','','','',3,'2010-01-14 15:15:42','2010-02-22 08:16:19'),(21,'4b55857146c18',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-19 10:12:01','2010-01-19 10:12:01'),(22,'4b558b4271b8e',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-19 10:36:50','2010-01-19 14:16:40'),(23,'4b558b613f159',1,1,3,'','',NULL,'','','','','','','',3,'2010-01-19 10:37:21','2010-02-03 13:58:48'),(24,'4b4da40da918b',1,2,3,'','',NULL,'','','','','','','',3,'2010-02-01 13:58:50','2010-02-01 13:58:50'),(25,'4b4da3ee0b54d',1,2,3,'','',NULL,'','','','','','','',3,'2010-02-01 13:58:58','2010-02-01 13:58:58'),(26,'4b4da3e1c4291',1,2,3,'','',NULL,'','','','','','','',3,'2010-02-01 13:59:05','2010-02-01 13:59:05'),(27,'4b558b613f159',1,2,3,'','',NULL,'','','','','','','',3,'2010-02-01 13:59:59','2010-02-03 13:58:55'),(28,'4b558b4271b8e',1,2,3,'','',NULL,'','','','','','','',3,'2010-02-01 14:00:28','2010-02-02 15:38:51'),(29,'4b4da41b05a85',1,2,3,'','',NULL,'','','','','','','',3,'2010-02-01 14:01:13','2010-02-01 14:01:13'),(30,'4b55857146c18',1,2,3,'','',NULL,'','','','','','','',3,'2010-02-01 14:01:21','2010-02-01 14:01:21'),(31,'4b6987a31e8e0',1,1,3,'','',NULL,'','','','','','','',3,'2010-02-03 14:26:43','2010-02-03 14:26:43'),(32,'4b4f351e0300e',1,2,3,'','',NULL,'','','','','','','',3,'2010-02-22 08:19:41','2010-02-22 08:20:04');
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles_ibfk_1` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_PAGE_1-1-Region11-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles_ibfk_3` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields_ibfk_1` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_PAGE_1-1-Region11-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields_ibfk_2` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-Region11-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-Region11-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-Region11-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `block_title` varchar(255) DEFAULT NULL,
  `block_description` text,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Region11-Instances`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Region11-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PAGE_1-1-Region11-Instances` VALUES (1,'4b4d8dc9a138f',1,1,1,'',''),(3,'4b4da15087430',1,1,1,'',''),(15,'4b4da6aa1ac18',1,1,1,'',''),(17,'4b4da6bdeafc1',1,1,1,'',''),(18,'4b4da6c8b5347',1,1,1,'',''),(20,'4b4da6d5688cb',1,1,1,'',''),(22,'4b4dc303af218',1,1,1,'',''),(23,'4b4dc31a83c14',1,1,1,'',''),(24,'4b4dc70098b2a',1,1,1,'',''),(25,'4b4da3ee0b54d',1,1,1,'',''),(27,'4b4da40da918b',1,1,1,'',''),(28,'4b4da41b05a85',1,1,1,'',''),(29,'4b4da430b62f8',1,1,1,'',''),(45,'4b558b4271b8e',1,1,1,'',''),(59,'4b4dc2ac5fba0',1,1,1,'',''),(63,'4b4da40da918b',1,2,1,'',''),(64,'4b4da3ee0b54d',1,2,1,'',''),(65,'4b4da3e1c4291',1,2,1,'',''),(68,'4b4da41b05a85',1,2,1,'',''),(69,'4b55857146c18',1,2,1,'',''),(72,'4b558b4271b8e',1,2,1,'',''),(74,'4b558b613f159',1,1,1,'',''),(75,'4b558b613f159',1,2,1,'',''),(89,'4b4da3e1c4291',1,1,1,'Lorem ipsum dolor sit amet!','<p>In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus.</p>'),(90,'4b4da3e1c4291',1,1,2,'Lorem ipsum dolor sit amet!','<p>In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus.</p>'),(96,'4b4f351e0300e',1,1,1,'',''),(98,'4b4f351e0300e',1,2,1,'','');
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_PAGE_1-1-Region14-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region14-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-Region14-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-Region14-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-Region14-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) DEFAULT NULL,
  `sidebar_description` text,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region14-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region14-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PROCESS-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PROCESS-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PROCESS-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PROCESS-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PROCESS-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PROCESS-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_PROCESS-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PROCESS-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PROCESS-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PROCESS-1-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PROCESS-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PROCESS-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `description` text,
  `shortdescription` text,
  `department` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `content_responsible` varchar(255) DEFAULT NULL,
  `organizational_responsible` varchar(255) DEFAULT NULL,
  `process_inputs` text,
  `process_output` text,
  `process_indicator` text,
  `process_instructions` text,
  `process_techniques` text,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PROCESS-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PROCESS-1-Region27-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PROCESS-1-Region27-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PROCESS-1-Region27-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `instruction_title` varchar(255) DEFAULT NULL,
  `instruction_description` text,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PROCESS-1-Region27-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Region27-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Region27-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region27-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region27-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PROCESS-1-Region29-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PROCESS-1-Region29-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PROCESS-1-Region29-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `steps_title` varchar(255) DEFAULT NULL,
  `steps_text` text,
  `steps_who` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PROCESS-1-Region29-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Region29-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Region29-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region29-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region29-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PROCESS-1-Region32-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PROCESS-1-Region32-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PROCESS-1-Region32-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `risk_description` text NOT NULL,
  `risk_measure` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PROCESS-1-Region32-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Region32-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Region32-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region32-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region32-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PROCESS-1-Region33-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PROCESS-1-Region33-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PROCESS-1-Region33-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `rule_title` varchar(255) DEFAULT NULL,
  `rule_text` text,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PROCESS-1-Region33-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Region33-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Region33-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region33-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region33-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PRODUCT_TREE-1-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PRODUCT_TREE-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PRODUCT_TREE-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) DEFAULT NULL,
  `entry_title` varchar(255) DEFAULT NULL,
  `entry_product_point` bigint(20) unsigned DEFAULT NULL,
  `entry_category` bigint(20) unsigned DEFAULT NULL,
  `entry_label` bigint(20) unsigned DEFAULT NULL,
  `shortdescription` text,
  `description` text,
  `contact` varchar(255) DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PRODUCT_TREE-1-Instances`
--

LOCK TABLES `page-DEFAULT_PRODUCT_TREE-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PRODUCT_TREE-1-Instances` VALUES (1,'4b4da15087430',1,1,3,'','',17,77,0,'','','',3,'2010-01-13 10:49:28','2010-02-08 15:26:47'),(2,'4b4da26279384',1,1,3,'','',17,76,0,'','','',3,'2010-01-13 10:52:25','2010-02-08 15:27:06'),(3,'4b4da2f3f290d',1,1,3,'','',17,0,0,'','','',3,'2010-01-13 10:52:32','2010-02-08 15:27:01'),(4,'4b4da2f3f290d',1,2,3,'','',17,0,0,'','','',3,'2010-02-01 13:59:12','2010-02-02 15:40:12'),(5,'4b4da26279384',1,2,3,'','',21,0,0,'','','',3,'2010-02-01 13:59:24','2010-02-02 15:39:55'),(6,'4b4da15087430',1,2,3,'','',17,53,0,'','','',3,'2010-02-01 13:59:32','2010-02-02 15:39:25');
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) DEFAULT NULL,
  `sidebar_description` text,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` VALUES (28,'4b4da15087430',1,2,1,'',''),(29,'4b4da26279384',1,2,1,'',''),(30,'4b4da2f3f290d',1,2,1,'',''),(31,'4b4da15087430',1,1,1,'',''),(33,'4b4da2f3f290d',1,1,1,'',''),(34,'4b4da26279384',1,1,1,'','');
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_STARTPAGE-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_STARTPAGE-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_STARTPAGE-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_STARTPAGE-1-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_STARTPAGE-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_STARTPAGE-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) DEFAULT NULL,
  `description` text,
  `header_embed_code` text,
  `top_title` text,
  `top_category` text,
  `top_label` text,
  `top_number` text,
  `top_sorttype` text,
  `top_sortorder` text,
  `banner_title` text,
  `banner_description` text,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-Instances`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_STARTPAGE-1-Instances` VALUES (1,'4b4d8dc9a138f',1,1,3,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2010-01-13 10:32:03','2010-02-18 10:23:02'),(2,'4b4d8dc9a138f',1,2,3,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2010-01-13 10:38:03','2010-02-01 14:02:55'),(3,'4b4d8dc9a138f',1,3,3,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2010-01-13 10:38:25','2010-01-18 13:02:33'),(4,'4b4d8dc9a138f',1,4,3,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2010-01-13 10:38:29','2010-01-18 13:02:36'),(5,'4b4d8dc9a138f',1,5,3,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2010-01-13 10:38:36','2010-01-18 13:02:43');
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles_ibfk_3` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_STARTPAGE-1-Region11-Instances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_STARTPAGE-1-Region11-Instances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_STARTPAGE-1-Region11-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_STARTPAGE-1-Region11-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_STARTPAGE-1-Region11-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `block_title` varchar(255) DEFAULT NULL,
  `block_description` text,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region11-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-Region11-Instances`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-Region11-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region11-Instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region11-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_STARTPAGE-1-Region17-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_STARTPAGE-1-Region17-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_STARTPAGE-1-Region17-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `entry_title` varchar(255) DEFAULT NULL,
  `entry_nav_point` bigint(20) unsigned DEFAULT NULL,
  `entry_category` bigint(20) unsigned DEFAULT NULL,
  `entry_label` bigint(20) unsigned DEFAULT NULL,
  `entry_number` bigint(20) unsigned DEFAULT NULL,
  `entry_sorttype` bigint(20) unsigned DEFAULT NULL,
  `entry_sortorder` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region17-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-Region17-Instances`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-Region17-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region17-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_STARTPAGE-1-Region17-Instances` VALUES (10,'4b4d8dc9a138f',1,3,1,'',0,0,0,0,0,0),(11,'4b4d8dc9a138f',1,4,1,'',0,0,0,0,0,0),(12,'4b4d8dc9a138f',1,5,1,'',0,0,0,0,0,0),(13,'4b4d8dc9a138f',1,2,1,'',0,0,0,0,0,0),(14,'4b4d8dc9a138f',1,1,1,'',0,0,0,0,0,0);
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region17-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageCategories`
--

DROP TABLE IF EXISTS `pageCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageCategories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `category` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageCategories_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageCategories`
--

LOCK TABLES `pageCategories` WRITE;
/*!40000 ALTER TABLE `pageCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageCollections`
--

DROP TABLE IF EXISTS `pageCollections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageCollections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) NOT NULL,
  `collectedPageId` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageCollections_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageCollections`
--

LOCK TABLES `pageCollections` WRITE;
/*!40000 ALTER TABLE `pageCollections` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageCollections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageContacts`
--

DROP TABLE IF EXISTS `pageContacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageContacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idContacts` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  KEY `pageId_2` (`pageId`,`version`),
  CONSTRAINT `pageContacts_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageContacts`
--

LOCK TABLES `pageContacts` WRITE;
/*!40000 ALTER TABLE `pageContacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageContacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageDatetimes`
--

DROP TABLE IF EXISTS `pageDatetimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageDatetimes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `datetime` varchar(255) DEFAULT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  KEY `pageId_2` (`pageId`,`version`),
  CONSTRAINT `pageDatetimes_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageDatetimes`
--

LOCK TABLES `pageDatetimes` WRITE;
/*!40000 ALTER TABLE `pageDatetimes` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageDatetimes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageExternals`
--

DROP TABLE IF EXISTS `pageExternals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageExternals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `external` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `pageExternals_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageExternals`
--

LOCK TABLES `pageExternals` WRITE;
/*!40000 ALTER TABLE `pageExternals` DISABLE KEYS */;
INSERT INTO `pageExternals` VALUES (1,'4b4f351e0300e',1,1,'http://www.getzoolu.org',3,3,'2010-01-14 15:17:25','2010-02-03 15:04:06');
/*!40000 ALTER TABLE `pageExternals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageGmaps`
--

DROP TABLE IF EXISTS `pageGmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageGmaps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageGmaps_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageGmaps`
--

LOCK TABLES `pageGmaps` WRITE;
/*!40000 ALTER TABLE `pageGmaps` DISABLE KEYS */;
INSERT INTO `pageGmaps` VALUES (1,'4b4d8dc9a138f',1,1,'47.503042','9.747067',3,NULL,'2010-01-13 09:09:30'),(3,'4b4da15087430',1,1,'47.503042','9.747067',3,NULL,'2010-01-13 10:37:01'),(15,'4b4da6aa1ac18',1,1,'47.503042','9.747067',3,NULL,'2010-01-18 12:57:24'),(17,'4b4da6bdeafc1',1,1,'47.503042','9.747067',3,NULL,'2010-01-18 12:57:58'),(18,'4b4da6c8b5347',1,1,'47.503042','9.747067',3,NULL,'2010-01-18 12:58:02'),(20,'4b4da6d5688cb',1,1,'47.503042','9.747067',3,NULL,'2010-01-18 13:01:43'),(22,'4b4dc303af218',1,1,'47.503042','9.747067',3,NULL,'2010-01-18 13:01:54'),(23,'4b4dc31a83c14',1,1,'47.503042','9.747067',3,NULL,'2010-01-18 13:01:57'),(24,'4b4dc70098b2a',1,1,'47.503042','9.747067',3,NULL,'2010-01-18 13:02:00'),(29,'4b4da430b62f8',1,1,'47.503042','9.747067',3,NULL,'2010-01-18 13:02:21'),(59,'4b4dc2ac5fba0',1,1,'47.503042','9.747067',3,NULL,'2010-01-19 14:57:07'),(63,'4b4da40da918b',1,2,'47.503042','9.747067',3,NULL,'2010-02-01 13:58:50'),(64,'4b4da3ee0b54d',1,2,'47.503042','9.747067',3,NULL,'2010-02-01 13:58:59'),(68,'4b4da41b05a85',1,2,'47.503042','9.747067',3,NULL,'2010-02-01 14:01:13'),(69,'4b55857146c18',1,2,'47.503042','9.747067',3,NULL,'2010-02-01 14:01:21'),(72,'4b558b4271b8e',1,2,'47.503042','9.747067',3,NULL,'2010-02-02 15:38:51'),(75,'4b558b613f159',1,2,'47.503042','9.747067',3,NULL,'2010-02-03 13:58:55'),(88,'4b4da3e1c4291',1,1,'47.503042','9.747067',3,NULL,'2010-02-11 18:20:35'),(96,'4b4f351e0300e',1,2,'47.503042','9.747067',3,NULL,'2010-02-22 08:20:04');
/*!40000 ALTER TABLE `pageGmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageInternalLinks`
--

DROP TABLE IF EXISTS `pageInternalLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageInternalLinks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) NOT NULL,
  `linkedPageId` varchar(32) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  KEY `linkedPageId` (`linkedPageId`),
  CONSTRAINT `pageInternalLinks_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `pageInternalLinks_ibfk_2` FOREIGN KEY (`linkedPageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageInternalLinks`
--

LOCK TABLES `pageInternalLinks` WRITE;
/*!40000 ALTER TABLE `pageInternalLinks` DISABLE KEYS */;
INSERT INTO `pageInternalLinks` VALUES (28,'4b4da3e1c4291',1,1,1,'4b4da15087430',3,3,'2010-02-11 18:20:35','2010-02-11 18:20:35'),(29,'4b4da3e1c4291',1,1,2,'4b4da2f3f290d',3,3,'2010-02-11 18:20:35','2010-02-11 18:20:35'),(45,'4b4f351e0300e',1,1,1,'4b4dc303af218',3,3,'2010-02-22 08:16:19','2010-02-22 08:16:19'),(46,'4b4f351e0300e',1,1,2,'4b4dc31a83c14',3,3,'2010-02-22 08:16:19','2010-02-22 08:16:19'),(47,'4b4f351e0300e',1,1,3,'4b4dc70098b2a',3,3,'2010-02-22 08:16:19','2010-02-22 08:16:19');
/*!40000 ALTER TABLE `pageInternalLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageLabels`
--

DROP TABLE IF EXISTS `pageLabels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageLabels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `label` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  KEY `pageId_2` (`pageId`,`version`),
  CONSTRAINT `pageLabels_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageLabels`
--

LOCK TABLES `pageLabels` WRITE;
/*!40000 ALTER TABLE `pageLabels` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageLabels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageLinks`
--

DROP TABLE IF EXISTS `pageLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageLinks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idPages` bigint(20) unsigned NOT NULL,
  `pageId` varchar(32) NOT NULL COMMENT 'linked page',
  PRIMARY KEY (`id`),
  KEY `idPages` (`idPages`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `pageLinks_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `pageLinks_ibfk_2` FOREIGN KEY (`idPages`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageLinks`
--

LOCK TABLES `pageLinks` WRITE;
/*!40000 ALTER TABLE `pageLinks` DISABLE KEYS */;
INSERT INTO `pageLinks` VALUES (2,19,'4b4dc2ac5fba0');
/*!40000 ALTER TABLE `pageLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagePermissions`
--

DROP TABLE IF EXISTS `pagePermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagePermissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idPages` bigint(20) unsigned NOT NULL,
  `idPermissions` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagePermissions`
--

LOCK TABLES `pagePermissions` WRITE;
/*!40000 ALTER TABLE `pagePermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagePermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageProperties`
--

DROP TABLE IF EXISTS `pageProperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageProperties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idPageTypes` bigint(20) unsigned NOT NULL,
  `showInNavigation` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `publisher` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `published` timestamp NULL DEFAULT NULL,
  `idStatus` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pageId_2` (`pageId`,`version`,`idLanguages`),
  KEY `version` (`version`),
  KEY `idLanguages` (`idLanguages`),
  KEY `publisher` (`publisher`),
  KEY `creator` (`creator`),
  KEY `idUsers` (`idUsers`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `pageProperties_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageProperties`
--

LOCK TABLES `pageProperties` WRITE;
/*!40000 ALTER TABLE `pageProperties` DISABLE KEYS */;
INSERT INTO `pageProperties` VALUES (1,'4b4d8dc9a138f',1,1,8,3,1,1,3,3,3,'2010-01-13 09:20:43','2010-02-18 10:23:02','2010-01-13 09:20:43',2),(2,'4b4da15087430',1,1,18,13,7,2,3,3,3,'2010-01-13 10:32:48','2010-02-08 15:26:47','2010-01-13 10:33:05',2),(3,'4b4da26279384',1,1,18,13,7,2,3,3,3,'2010-01-13 10:37:22','2010-02-08 15:27:06','2010-01-13 10:52:22',2),(4,'4b4d8dc9a138f',1,2,8,3,1,0,3,3,3,'2010-01-13 10:38:03','2010-02-01 14:02:55','2010-01-13 10:37:49',1),(5,'4b4d8dc9a138f',1,3,8,3,1,0,3,3,3,'2010-01-13 10:38:25','2010-01-18 13:02:33','2010-01-13 10:38:24',1),(6,'4b4d8dc9a138f',1,4,8,3,1,0,3,3,3,'2010-01-13 10:38:29','2010-01-18 13:02:36','2010-01-13 10:38:28',1),(7,'4b4d8dc9a138f',1,5,8,3,1,0,3,3,3,'2010-01-13 10:38:36','2010-01-18 13:02:43','2010-01-13 10:38:35',1),(8,'4b4da2f3f290d',1,1,18,13,7,2,3,3,3,'2010-01-13 10:39:47','2010-02-08 15:27:01','2010-01-13 10:52:31',2),(9,'4b4da3e1c4291',1,1,2,2,1,1,3,3,3,'2010-01-13 10:43:45','2010-02-11 18:20:35','2010-01-13 10:56:43',2),(10,'4b4da3ee0b54d',1,1,2,2,1,1,3,3,3,'2010-01-13 10:43:58','2010-02-02 15:38:13','2010-01-18 13:02:03',2),(11,'4b4da40da918b',1,1,2,2,1,1,3,3,3,'2010-01-13 10:44:29','2010-02-02 15:38:18','2010-01-18 13:02:13',2),(12,'4b4da41b05a85',1,1,2,2,1,1,3,3,3,'2010-01-13 10:44:43','2010-02-02 15:38:23','2010-01-14 18:13:46',2),(13,'4b4da430b62f8',1,1,2,2,1,1,3,3,3,'2010-01-13 10:45:04','2010-01-18 13:02:21','2010-01-18 13:02:20',2),(14,'4b4da6aa1ac18',1,1,2,2,1,1,3,3,3,'2010-01-13 10:55:38','2010-01-19 14:32:46','2010-01-18 12:57:22',2),(15,'4b4da6bdeafc1',1,1,2,2,1,1,3,3,3,'2010-01-13 10:55:57','2010-01-19 14:32:51','2010-01-18 12:57:56',2),(16,'4b4da6c8b5347',1,1,2,2,1,1,3,3,3,'2010-01-13 10:56:08','2010-01-19 14:32:54','2010-01-18 12:58:00',2),(17,'4b4da6d5688cb',1,1,2,2,1,1,3,3,3,'2010-01-13 10:56:21','2010-01-19 14:32:57','2010-01-18 12:58:05',2),(18,'4b4dc2ac5fba0',1,1,2,1,1,1,3,3,3,'2010-01-13 12:55:08','2010-01-19 14:57:07','2010-01-13 12:55:02',2),(19,'4b4dc2ccb3e8d',1,1,7,4,3,1,3,3,3,'2010-01-13 12:55:40','2010-01-18 13:01:50','2010-01-13 13:13:48',2),(20,'4b4dc303af218',1,1,2,1,1,0,3,3,3,'2010-01-13 12:56:35','2010-01-18 13:01:54','2010-01-13 12:55:56',2),(21,'4b4dc31a83c14',1,1,2,1,1,0,3,3,3,'2010-01-13 12:56:58','2010-01-18 13:01:57','2010-01-13 12:56:39',2),(22,'4b4dc70098b2a',1,1,2,1,1,0,3,3,3,'2010-01-13 13:13:36','2010-01-18 13:02:00','2010-01-13 13:13:32',2),(23,'4b4f351e0300e',1,1,2,1,1,1,3,3,3,'2010-01-14 15:15:42','2010-02-22 08:16:19','2010-01-14 15:15:33',2),(25,'4b55857146c18',1,1,2,2,1,1,3,3,3,'2010-01-19 10:12:01','2010-02-02 15:38:27',NULL,2),(26,'4b558b4271b8e',1,1,2,1,1,4,3,3,3,'2010-01-19 10:36:50','2010-01-19 14:16:40','2010-01-19 10:33:59',2),(27,'4b558b613f159',1,1,2,1,1,4,3,3,3,'2010-01-19 10:37:21','2010-02-03 13:58:48','2010-01-19 10:37:01',2),(28,'4b4da40da918b',1,2,2,2,1,1,3,3,3,'2010-02-01 13:58:50','2010-02-03 14:44:40','2010-02-01 13:58:47',2),(29,'4b4da3ee0b54d',1,2,2,2,1,1,3,3,3,'2010-02-01 13:58:58','2010-02-03 14:44:34','2010-02-01 13:58:57',2),(30,'4b4da3e1c4291',1,2,2,2,1,1,3,3,3,'2010-02-01 13:59:05','2010-02-03 14:44:25','2010-02-01 13:59:04',2),(31,'4b4da2f3f290d',1,2,18,13,7,2,3,3,3,'2010-02-01 13:59:12','2010-02-03 14:44:15','2010-02-01 13:59:11',2),(32,'4b4da26279384',1,2,18,13,7,2,3,3,3,'2010-02-01 13:59:24','2010-02-03 14:43:52','2010-02-01 13:59:20',2),(33,'4b4da15087430',1,2,18,13,7,2,3,3,3,'2010-02-01 13:59:32','2010-02-03 15:05:11','2010-02-01 13:59:31',2),(34,'4b558b613f159',1,2,2,1,1,4,3,3,3,'2010-02-01 13:59:59','2010-02-03 13:58:55','2010-02-01 13:59:43',2),(35,'4b558b4271b8e',1,2,2,1,1,4,3,3,3,'2010-02-01 14:00:28','2010-02-02 15:38:51','2010-02-01 14:00:20',2),(36,'4b4da41b05a85',1,2,2,2,1,1,3,3,3,'2010-02-01 14:01:13','2010-02-03 14:44:48','2010-02-01 14:01:12',2),(37,'4b55857146c18',1,2,2,2,1,1,3,3,3,'2010-02-01 14:01:21','2010-02-03 14:44:56','2010-02-01 14:01:20',2),(38,'4b6987a31e8e0',1,1,2,2,1,0,3,3,3,'2010-02-03 14:26:43','2010-02-03 14:26:43',NULL,1),(39,'4b4f351e0300e',1,2,2,1,1,0,3,3,3,'2010-02-22 08:19:41','2010-02-22 08:20:04','2010-02-22 08:19:33',2);
/*!40000 ALTER TABLE `pageProperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageRegistrations`
--

DROP TABLE IF EXISTS `pageRegistrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageRegistrations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idPage` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `sname` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `plz` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `club` varchar(255) DEFAULT NULL,
  `infos` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageRegistrations`
--

LOCK TABLES `pageRegistrations` WRITE;
/*!40000 ALTER TABLE `pageRegistrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageRegistrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageTitles`
--

DROP TABLE IF EXISTS `pageTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `pageTitles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTitles`
--

LOCK TABLES `pageTitles` WRITE;
/*!40000 ALTER TABLE `pageTitles` DISABLE KEYS */;
INSERT INTO `pageTitles` VALUES (1,'4b4d8dc9a138f',1,1,'Home',3,3,'2010-01-13 11:17:48','2010-02-18 10:23:02'),(2,'4b4da15087430',1,1,'Dental Professional',3,3,'2010-01-13 10:32:48','2010-02-08 15:26:47'),(3,'4b4da26279384',1,1,'Laboratory Professional',3,3,'2010-01-13 10:37:22','2010-02-08 15:27:06'),(4,'4b4da2f3f290d',1,1,'Alle Produkte',3,3,'2010-01-13 10:39:48','2010-02-08 15:27:01'),(5,'4b4da3e1c4291',1,1,'Unternehmen',3,3,'2010-01-13 10:43:45','2010-02-11 18:20:35'),(6,'4b4da3ee0b54d',1,1,'Presse',3,3,'2010-01-13 10:43:58','2010-01-18 13:02:04'),(7,'4b4da40da918b',1,1,'Karriere',3,3,'2010-01-13 10:44:29','2010-01-18 13:02:14'),(8,'4b4da41b05a85',1,1,'Support',3,3,'2010-01-13 10:44:43','2010-01-18 13:02:18'),(9,'4b4da430b62f8',1,1,'Kontakt',3,3,'2010-01-13 10:45:04','2010-01-18 13:02:21'),(10,'4b4da6aa1ac18',1,1,'Passion x Vision x Innovation',3,3,'2010-01-13 10:55:38','2010-01-19 14:32:46'),(11,'4b4da6bdeafc1',1,1,'Geschichte',3,3,'2010-01-13 10:55:57','2010-01-19 14:32:51'),(12,'4b4da6c8b5347',1,1,'Zahlen und Fakten',3,3,'2010-01-13 10:56:08','2010-01-19 14:32:54'),(13,'4b4da6d5688cb',1,1,'Management',3,3,'2010-01-13 10:56:21','2010-01-19 14:32:57'),(14,'4b4d8dc9a138f',1,2,'Home',3,3,'2010-01-13 11:18:12','2010-02-01 14:02:55'),(15,'4b4d8dc9a138f',1,3,'Home',3,3,'2010-01-13 11:18:58','2010-01-18 13:02:33'),(16,'4b4d8dc9a138f',1,4,'Home',3,3,'2010-01-13 11:19:09','2010-01-18 13:02:36'),(17,'4b4d8dc9a138f',1,5,'Home',3,3,'2010-01-13 11:19:19','2010-01-18 13:02:43'),(18,'4b4dc2ac5fba0',1,1,'Einkaufsbedingungen',3,3,'2010-01-13 12:55:08','2010-01-19 14:57:07'),(19,'4b4dc2ccb3e8d',1,1,'Jobs',3,3,'2010-01-13 12:55:40','2010-01-18 13:01:50'),(20,'4b4dc303af218',1,1,'HR Spezialist mit IT Flair (50 -60%, m/w) - 4.208',3,3,'2010-01-13 12:56:35','2010-01-18 13:01:54'),(21,'4b4dc31a83c14',1,1,'IT Software Developer (m/w, 100%) - 1.048',3,3,'2010-01-13 12:56:58','2010-01-18 13:01:57'),(22,'4b4dc70098b2a',1,1,'Marketing Assistenz CBE (100%, m/w) 4.206',3,3,'2010-01-13 13:13:36','2010-01-18 13:02:00'),(23,'4b4f351e0300e',1,1,'Test Thomas',3,3,'2010-01-14 15:15:42','2010-02-22 08:16:19'),(25,'4b55857146c18',1,1,'Kontakt',3,3,'2010-01-19 10:12:01','2010-01-19 10:12:01'),(26,'4b558b4271b8e',1,1,'Impressum',3,3,'2010-01-19 10:36:50','2010-01-19 14:16:40'),(27,'4b558b613f159',1,1,'Sitemap',3,3,'2010-01-19 10:37:21','2010-02-03 13:58:48'),(28,'4b4da15087430',1,2,'Dental Professional',3,3,NULL,'2010-02-03 15:05:11'),(29,'4b4da26279384',1,2,'Laboratory Professional',3,3,NULL,'2010-02-03 14:43:52'),(30,'4b4da2f3f290d',1,2,'All Products',3,3,NULL,'2010-02-03 14:44:15'),(31,'4b4da3e1c4291',1,2,'Company',3,3,NULL,'2010-02-03 14:44:25'),(32,'4b4da3ee0b54d',1,2,'Press',3,3,NULL,'2010-02-03 14:44:34'),(33,'4b4da40da918b',1,2,'Career',3,3,NULL,'2010-02-03 14:44:40'),(34,'4b558b613f159',1,2,'Sitemap',3,3,'2010-02-01 13:59:59','2010-02-03 13:58:55'),(35,'4b558b4271b8e',1,2,'Imprint',3,3,'2010-02-01 14:00:28','2010-02-02 15:38:51'),(36,'4b55857146c18',1,2,'Contact',3,3,NULL,'2010-02-03 14:44:56'),(37,'4b4da41b05a85',1,2,'Support',3,3,NULL,'2010-02-03 14:44:48'),(38,'4b6987a31e8e0',1,1,'test',3,3,'2010-02-03 14:26:43','2010-02-03 14:26:43'),(39,'4b4f351e0300e',1,2,'Test Thomas',3,3,'2010-02-22 08:19:41','2010-02-22 08:20:04');
/*!40000 ALTER TABLE `pageTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageTypeTitles`
--

DROP TABLE IF EXISTS `pageTypeTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageTypeTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idPageTypes` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTypeTitles`
--

LOCK TABLES `pageTypeTitles` WRITE;
/*!40000 ALTER TABLE `pageTypeTitles` DISABLE KEYS */;
INSERT INTO `pageTypeTitles` VALUES (1,1,1,'Standardseite'),(2,2,1,'Interne Verlinkung'),(3,3,1,'Übersicht'),(4,4,1,'Externe Verlinkung'),(5,5,1,'Prozessablauf'),(6,6,1,'Kollektion'),(7,7,1,'﻿﻿Produktbaum');
/*!40000 ALTER TABLE `pageTypeTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageTypes`
--

DROP TABLE IF EXISTS `pageTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `page` tinyint(1) NOT NULL DEFAULT '0',
  `startpage` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `page` (`page`),
  KEY `startpage` (`startpage`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTypes`
--

LOCK TABLES `pageTypes` WRITE;
/*!40000 ALTER TABLE `pageTypes` DISABLE KEYS */;
INSERT INTO `pageTypes` VALUES (1,'page',1,1,1),(2,'link',1,1,1),(3,'overview',0,1,1),(4,'external',1,1,1),(5,'process',1,1,0),(6,'collection',0,1,0),(7,'product_tree',0,1,1);
/*!40000 ALTER TABLE `pageTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageVideos`
--

DROP TABLE IF EXISTS `pageVideos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageVideos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `userId` varchar(32) NOT NULL,
  `videoId` varchar(64) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `idVideoTypes` int(10) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageVideos_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageVideos`
--

LOCK TABLES `pageVideos` WRITE;
/*!40000 ALTER TABLE `pageVideos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageVideos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `isStartPage` tinyint(1) NOT NULL DEFAULT '0',
  `idParent` bigint(20) unsigned NOT NULL,
  `idParentTypes` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `sortPosition` bigint(20) unsigned NOT NULL,
  `sortTimestamp` timestamp NULL DEFAULT NULL,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,1,1,1,3,0,'2010-01-13 09:20:56','4b4d8dc9a138f',1,3,'2010-01-13 09:20:56','2010-02-18 10:23:02'),(2,1,1,2,3,0,'2010-01-13 10:32:48','4b4da15087430',1,3,'2010-01-13 10:32:48','2010-02-08 15:26:47'),(3,1,2,2,3,0,'2010-01-13 10:37:22','4b4da26279384',1,3,'2010-01-13 10:37:22','2010-02-08 15:27:06'),(4,1,3,2,3,0,'2010-01-13 10:39:47','4b4da2f3f290d',1,3,'2010-01-13 10:39:47','2010-02-08 15:27:01'),(5,1,4,2,3,0,'2010-01-13 10:43:45','4b4da3e1c4291',1,3,'2010-01-13 10:43:45','2010-02-11 18:20:35'),(6,1,5,2,3,0,'2010-01-13 10:43:58','4b4da3ee0b54d',1,3,'2010-01-13 10:43:58','2010-02-01 13:58:58'),(7,1,6,2,3,0,'2010-01-13 10:44:29','4b4da40da918b',1,3,'2010-01-13 10:44:29','2010-02-01 13:58:50'),(8,1,7,2,3,0,'2010-01-13 10:44:43','4b4da41b05a85',1,3,'2010-01-13 10:44:43','2010-02-01 14:01:13'),(9,1,8,2,3,0,'2010-01-13 10:45:04','4b4da430b62f8',1,3,'2010-01-13 10:45:04','2010-01-18 13:02:21'),(10,1,9,2,3,0,'2010-01-13 10:55:38','4b4da6aa1ac18',1,3,'2010-01-13 10:55:38','2010-01-18 12:57:24'),(11,1,10,2,3,0,'2010-01-13 10:55:57','4b4da6bdeafc1',1,3,'2010-01-13 10:55:57','2010-01-18 12:57:58'),(12,1,11,2,3,0,'2010-01-13 10:56:08','4b4da6c8b5347',1,3,'2010-01-13 10:56:08','2010-01-18 12:58:02'),(13,1,12,2,3,0,'2010-01-13 10:56:21','4b4da6d5688cb',1,3,'2010-01-13 10:56:21','2010-01-18 13:01:43'),(14,0,4,2,3,5,'2010-02-08 16:25:27','4b4dc2ac5fba0',1,3,'2010-01-13 12:55:08','2010-02-08 16:25:27'),(15,1,13,2,3,0,'2010-01-13 12:55:40','4b4dc2ccb3e8d',1,3,'2010-01-13 12:55:40','2010-01-18 13:01:50'),(16,0,13,2,3,1,'2010-01-13 12:56:35','4b4dc303af218',1,3,'2010-01-13 12:56:35','2010-01-18 13:01:54'),(17,0,13,2,3,2,'2010-01-13 12:56:58','4b4dc31a83c14',1,3,'2010-01-13 12:56:58','2010-01-18 13:01:57'),(18,0,13,2,3,3,'2010-01-13 13:13:36','4b4dc70098b2a',1,3,'2010-01-13 13:13:36','2010-01-18 13:02:00'),(19,0,5,2,3,1,'2010-01-14 15:15:42','4b4f351e0300e',1,3,'2010-01-14 15:15:42','2010-02-22 08:20:04'),(21,1,15,2,3,0,'2010-01-19 10:12:01','4b55857146c18',1,3,'2010-01-19 10:12:01','2010-02-01 14:01:21'),(22,0,1,1,3,10,'2010-01-19 10:37:27','4b558b4271b8e',1,3,'2010-01-19 10:36:50','2010-02-02 15:38:51'),(23,0,1,1,3,9,'2010-01-19 10:37:27','4b558b613f159',1,3,'2010-01-19 10:37:21','2010-02-03 13:58:55'),(24,1,25,2,3,0,'2010-02-03 14:26:43','4b6987a31e8e0',1,3,'2010-02-03 14:26:43','2010-02-03 14:26:43');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parentTypes`
--

DROP TABLE IF EXISTS `parentTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parentTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parentTypes`
--

LOCK TABLES `parentTypes` WRITE;
/*!40000 ALTER TABLE `parentTypes` DISABLE KEYS */;
INSERT INTO `parentTypes` VALUES (1,'rootLevel'),(2,'folder');
/*!40000 ALTER TABLE `parentTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathReplacers`
--

DROP TABLE IF EXISTS `pathReplacers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathReplacers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `from` varchar(255) NOT NULL,
  `to` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathReplacers`
--

LOCK TABLES `pathReplacers` WRITE;
/*!40000 ALTER TABLE `pathReplacers` DISABLE KEYS */;
INSERT INTO `pathReplacers` VALUES (1,1,'ä','ae'),(2,1,'ö','oe'),(3,1,'ü','ue'),(4,1,'ß','ss'),(5,1,'Ä','Ae'),(6,1,'Ö','Oe'),(7,1,'Ü','Ue'),(8,1,'&','und'),(9,2,'&','and'),(10,4,'ä','ae'),(11,4,'ö','oe'),(12,4,'ü','ue'),(13,4,'ß','ss'),(14,4,'Ä','Ae'),(15,4,'Ö','Oe'),(16,4,'Ü','Ue'),(17,4,'&','und');
/*!40000 ALTER TABLE `pathReplacers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'view','Der Datensatz darf visualisiert werden'),(2,'add','Ein neuer Datensatz darf erzeugt werden'),(3,'update','Der Datensatz darf verändert werden'),(4,'delete','Der Datensatz darf gelöscht werden'),(5,'archive','Der Datensatz darf archiviert werden'),(6,'live','Live schalten'),(7,'security',NULL);
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-InstanceFiles` VALUES (2,'4b6aa33ede16d',1,1,1,1,NULL,5);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` text NOT NULL,
  `description` text,
  `header_embed_code` text,
  `pics_title` varchar(255) DEFAULT NULL,
  `internal_links_title` varchar(255) DEFAULT NULL,
  `video_title` varchar(255) DEFAULT NULL,
  `video_embed_code` text,
  `shortdescription` text NOT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Instances` VALUES (3,'4b585c594f35d',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 13:53:29','2010-02-17 15:10:06'),(4,'4b58613c3c9b0',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:14:20','2010-02-08 15:57:45'),(5,'4b58614f47b56',1,1,3,'Zahnschrank Z4 - Das Beste!','<h3>Lorem ipsum dolor sit amet</h3>\n<p>consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.</p>\n<p>Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus.</p>\n<p>Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc, quis gravida magna mi a libero. Fusce vulputate eleifend sapien. Vestibulum purus quam, scelerisque ut, mollis sed, nonummy id, metus. Nullam accumsan lorem in dui. Cras ultricies mi eu turpis hendrerit fringilla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In ac dui quis mi consectetuer lacinia.</p>\n<p>Nam pretium turpis et arcu. Duis arcu tortor, suscipit eget, imperdiet nec, imperdiet iaculis, ipsum. Sed aliquam ultrices mauris. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris. Praesent adipiscing. Phasellus ullamcorper ipsum rutrum nunc. Nunc nonummy metus. Vestibulum volutpat pretium libero. Cras id dui. Aenean ut eros et nisl sagittis vestibulum. Nullam nulla eros, ultricies sit amet, nonummy id, imperdiet feugiat, pede. Sed lectus. Donec mollis hendrerit risus. Phasellus nec sem in justo pellentesque facilisis. Etiam imperdiet imperdiet orci. Nunc nec neque. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi. Curabitur ligula sapien, tincidunt non, euismod vitae, posuere imperdiet, leo. Maecenas malesuada. Praesent congue erat at massa. Sed cursus turpis vitae tortor. Donec posuere vulputate arcu. Phasellus accumsan cursus velit.</p>',NULL,NULL,'','Video','','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.','',3,'2010-01-21 14:14:39','2010-02-11 18:31:53'),(6,'4b586165d67a2',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:15:01','2010-02-08 15:57:12'),(7,'4b586179c1713',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:15:21','2010-02-04 08:35:58'),(8,'4b58618e770f0',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:15:42','2010-02-08 15:57:39'),(9,'4b5861d9d4b67',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:16:57','2010-01-21 14:17:26'),(10,'4b58620d299c8',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:17:49','2010-01-21 14:17:49'),(11,'4b586224046a2',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:18:12','2010-01-21 14:18:12'),(12,'4b586238622fa',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:18:32','2010-01-21 14:18:32'),(13,'4b5862458f289',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:18:45','2010-01-21 14:18:45'),(14,'4b586253af457',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:18:59','2010-01-21 14:18:59'),(15,'4b58626062fd8',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-01-21 14:19:12','2010-01-21 14:19:12'),(16,'4b6aa33ede16d',1,1,3,'','<ul>\n<li>asdf</li>\n<li>asdf</li>\n<li>asdf            \n<ul>\n<li>TEST</li>\n<li>TEST</li>\n</ul>\n</li>\n</ul>\n<ol>\n<li>asdf</li>\n<li>asdf</li>\n<li>asdf</li>\n</ol>\n<h5>asdf</h5>',NULL,NULL,'','','','','',3,'2010-02-04 10:36:46','2010-02-26 22:11:28'),(17,'4b6aa3520f7de',1,1,3,'','',NULL,NULL,'','','','','',3,'2010-02-04 10:37:06','2010-02-04 10:37:06'),(18,'4b6aa33ede16d',1,2,3,'','',NULL,NULL,'','','','','',3,'2010-02-19 11:26:57','2010-02-22 08:27:34');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT-1-Region45-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region45-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region45-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region45-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `block_title` varchar(255) NOT NULL,
  `block_description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region45-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region45-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region45-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region45-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region45-Instances` VALUES (13,'4b5861d9d4b67',1,1,1,'',''),(14,'4b58620d299c8',1,1,1,'',''),(15,'4b586224046a2',1,1,1,'',''),(16,'4b586238622fa',1,1,1,'',''),(17,'4b5862458f289',1,1,1,'',''),(18,'4b586253af457',1,1,1,'',''),(19,'4b58626062fd8',1,1,1,'',''),(28,'4b586179c1713',1,1,1,'',''),(47,'4b6aa3520f7de',1,1,1,'',''),(53,'4b586165d67a2',1,1,1,'',''),(54,'4b58618e770f0',1,1,1,'',''),(55,'4b58613c3c9b0',1,1,1,'',''),(58,'4b58614f47b56',1,1,1,'Lorem ipsum dolor sit amet!','<p>In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus.</p>'),(59,'4b58614f47b56',1,1,2,'Aenean leo ligula','<p>Porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus.</p>'),(68,'4b585c594f35d',1,1,1,'',''),(77,'4b6aa33ede16d',1,2,1,'',''),(83,'4b6aa33ede16d',1,1,1,'','');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region45-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFilterTypes` int(10) unsigned NOT NULL,
  `referenceId` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT-1-Region47-Instances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` VALUES (11,'4b6aa33ede16d',1,2,66,1,1,129),(12,'4b6aa33ede16d',1,2,66,3,3,129),(23,'4b6aa33ede16d',1,1,72,1,1,129),(24,'4b6aa33ede16d',1,1,72,3,3,129);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT-1-Region47-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region47-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region47-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region47-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `docs_title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region47-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region47-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region47-Instances` VALUES (13,'4b5861d9d4b67',1,1,1,''),(14,'4b58620d299c8',1,1,1,''),(15,'4b586224046a2',1,1,1,''),(16,'4b586238622fa',1,1,1,''),(17,'4b5862458f289',1,1,1,''),(18,'4b586253af457',1,1,1,''),(19,'4b58626062fd8',1,1,1,''),(28,'4b586179c1713',1,1,1,''),(40,'4b6aa3520f7de',1,1,1,''),(44,'4b586165d67a2',1,1,1,''),(45,'4b58618e770f0',1,1,1,''),(46,'4b58613c3c9b0',1,1,1,''),(48,'4b58614f47b56',1,1,1,''),(57,'4b585c594f35d',1,1,1,''),(66,'4b6aa33ede16d',1,2,1,'Docs'),(72,'4b6aa33ede16d',1,1,1,'Dokumente');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region50-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region50-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region50-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `link_title` varchar(255) NOT NULL,
  `link_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region50-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region50-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region50-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region50-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region50-Instances` VALUES (13,'4b5861d9d4b67',1,1,1,'',''),(14,'4b58620d299c8',1,1,1,'',''),(15,'4b586224046a2',1,1,1,'',''),(16,'4b586238622fa',1,1,1,'',''),(17,'4b5862458f289',1,1,1,'',''),(18,'4b586253af457',1,1,1,'',''),(19,'4b58626062fd8',1,1,1,'',''),(28,'4b586179c1713',1,1,1,'',''),(40,'4b6aa3520f7de',1,1,1,'',''),(44,'4b586165d67a2',1,1,1,'',''),(45,'4b58618e770f0',1,1,1,'',''),(46,'4b58613c3c9b0',1,1,1,'',''),(48,'4b58614f47b56',1,1,1,'',''),(57,'4b585c594f35d',1,1,1,'',''),(66,'4b6aa33ede16d',1,2,1,'',''),(72,'4b6aa33ede16d',1,1,1,'','');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region50-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT-1-Region51-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region51-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region51-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region51-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `header_title` varchar(255) NOT NULL,
  `header_description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region51-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region51-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region51-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region51-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region51-Instances` VALUES (13,'4b5861d9d4b67',1,1,1,'',''),(14,'4b58620d299c8',1,1,1,'',''),(15,'4b586224046a2',1,1,1,'',''),(16,'4b586238622fa',1,1,1,'',''),(17,'4b5862458f289',1,1,1,'',''),(18,'4b586253af457',1,1,1,'',''),(19,'4b58626062fd8',1,1,1,'',''),(28,'4b586179c1713',1,1,1,'',''),(48,'4b6aa3520f7de',1,1,1,'',''),(54,'4b586165d67a2',1,1,1,'',''),(55,'4b58618e770f0',1,1,1,'',''),(56,'4b58613c3c9b0',1,1,1,'',''),(59,'4b58614f47b56',1,1,1,'','<p>Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus.</p>'),(60,'4b58614f47b56',1,1,2,'','<p>Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus.</p>'),(69,'4b585c594f35d',1,1,1,'',''),(78,'4b6aa33ede16d',1,2,1,'',''),(84,'4b6aa33ede16d',1,1,1,'','');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region51-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idFiles` (`idFiles`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` VALUES (5,'4b58612ac0a20',1,1,1,10,NULL,55);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields` DISABLE KEYS */;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) DEFAULT NULL,
  `shortdescription` text,
  `description` text NOT NULL,
  `header_embed_code` text,
  `contact` varchar(255) DEFAULT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` VALUES (2,'4b5860d198729',1,1,3,'','','',NULL,'',3,'2010-01-21 14:12:33','2010-02-08 15:25:44'),(3,'4b5860df83012',1,1,3,'','','',NULL,'',3,'2010-01-21 14:12:47','2010-01-21 14:12:47'),(4,'4b5860fc08fe4',1,1,3,'','','',NULL,'',3,'2010-01-21 14:13:16','2010-02-25 13:44:38'),(5,'4b58612ac0a20',1,1,3,'','','<p>Nam pretium turpis et arcu. Duis arcu tortor, suscipit eget, imperdiet nec, imperdiet iaculis, ipsum. Sed aliquam ultrices mauris. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris. Praesent adipiscing. Phasellus ullamcorper ipsum rutrum nunc. Nunc nonummy metus. Vestibulum volutpat pretium libero. Cras id dui. Aenean ut eros et nisl sagittis vestibulum. Nullam nulla eros, ultricies sit amet, nonummy id, imperdiet feugiat, pede. Sed lectus. Donec mollis hendrerit risus. Phasellus nec sem in justo pellentesque facilisis. Etiam imperdiet imperdiet orci. Nunc nec neque. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi. Curabitur ligula sapien, tincidunt non, euismod vitae, posuere imperdiet, leo. Maecenas malesuada. Praesent congue erat at massa. Sed cursus turpis vitae tortor. Donec posuere vulputate arcu. Phasellus accumsan cursus velit.</p>',NULL,'1',3,'2010-01-21 14:14:02','2010-02-08 15:55:44'),(6,'4b58619f4de8f',1,1,3,'','','',NULL,'',3,'2010-01-21 14:15:59','2010-02-08 15:56:05'),(7,'4b5861aa05ec3',1,1,3,'','','',NULL,'',3,'2010-01-21 14:16:10','2010-01-21 14:16:10'),(8,'4b5861b987a25',1,1,3,'','','',NULL,'',3,'2010-01-21 14:16:25','2010-01-21 14:16:25'),(9,'4b5861c7dc368',1,1,3,'','','',NULL,'',3,'2010-01-21 14:16:39','2010-01-21 14:16:39'),(10,'4b5860d198729',1,2,3,'','','',NULL,'',3,'2010-02-02 15:29:27','2010-02-02 15:53:16'),(11,'4b5860fc08fe4',1,2,3,'','','',NULL,'',3,'2010-02-02 15:32:34','2010-02-02 15:48:14'),(12,'4b58612ac0a20',1,2,3,'','','',NULL,'',3,'2010-02-03 15:27:56','2010-02-03 15:27:56'),(13,'4b6fc9a131dd8',1,1,3,'','','',NULL,'',3,'2010-02-08 08:21:53','2010-02-08 15:57:58'),(14,'4b5860fc08fe4',1,4,3,'','','',NULL,'',3,'2010-02-08 16:13:50','2010-02-09 08:22:23'),(15,'4b58612ac0a20',1,4,3,'','','',NULL,'',3,'2010-02-09 08:22:52','2010-02-09 08:22:52');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `displayOption` varchar(64) DEFAULT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` VALUES (13,'4b58612ac0a20',1,1,50,5,NULL,128),(14,'4b58612ac0a20',1,1,51,6,NULL,128);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) DEFAULT NULL,
  `sidebar_description` text,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` VALUES (12,'4b5860fc08fe4',1,2,1,'',''),(14,'4b5860d198729',1,2,1,'',''),(15,'4b58612ac0a20',1,2,1,'',''),(48,'4b5860d198729',1,1,1,'',''),(50,'4b58612ac0a20',1,1,1,'Lorem ipsum dolor sit amet','<p>Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>'),(51,'4b58612ac0a20',1,1,2,'Nulla consequat massa','<p>Nulla consequat massa quis enim. <b>Donec pede justo</b>, fringilla vel<sup>2</sup>, aliquet nec<sub>2</sub>, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>'),(53,'4b58619f4de8f',1,1,1,'',''),(55,'4b6fc9a131dd8',1,1,1,'',''),(61,'4b5860fc08fe4',1,4,1,'',''),(62,'4b58612ac0a20',1,4,1,'',''),(64,'4b5860fc08fe4',1,1,1,'','');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `entry_title` varchar(255) DEFAULT NULL,
  `entry_category` bigint(20) unsigned DEFAULT NULL,
  `entry_label` bigint(20) unsigned DEFAULT NULL,
  `entry_viewtype` bigint(20) unsigned DEFAULT NULL,
  `entry_number` bigint(20) unsigned DEFAULT NULL,
  `entry_sorttype` bigint(20) unsigned DEFAULT NULL,
  `entry_sortorder` bigint(20) unsigned DEFAULT NULL,
  `entry_depth` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` VALUES (12,'4b5860fc08fe4',1,2,1,'',0,0,0,0,0,0,0),(14,'4b5860d198729',1,2,1,'',0,0,0,0,0,0,0),(15,'4b58612ac0a20',1,2,1,'',0,0,0,0,0,0,0),(43,'4b5860d198729',1,1,1,'',0,0,31,10,17,15,65),(45,'4b58612ac0a20',1,1,1,'Zahnzubehör  Übersicht',0,0,31,100,17,15,66),(47,'4b58619f4de8f',1,1,1,'',0,0,0,0,0,0,0),(49,'4b6fc9a131dd8',1,1,1,'',0,0,0,0,0,0,0),(55,'4b5860fc08fe4',1,4,1,'',0,0,0,0,0,0,0),(56,'4b58612ac0a20',1,4,1,'',0,0,0,0,0,0,0),(58,'4b5860fc08fe4',1,1,1,'',0,0,31,10,0,0,65);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productCategories`
--

DROP TABLE IF EXISTS `productCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productCategories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `category` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  CONSTRAINT `productCategories_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productCategories`
--

LOCK TABLES `productCategories` WRITE;
/*!40000 ALTER TABLE `productCategories` DISABLE KEYS */;
INSERT INTO `productCategories` VALUES (13,'4b586179c1713',1,1,77,3,3,'2010-02-04 08:35:58','2010-02-04 08:35:58'),(14,'4b586179c1713',1,1,75,3,3,'2010-02-04 08:35:58','2010-02-04 08:35:58'),(61,'4b58612ac0a20',1,1,77,3,3,'2010-02-08 15:55:44','2010-02-08 15:55:44'),(63,'4b58619f4de8f',1,1,77,3,3,'2010-02-08 15:56:05','2010-02-08 15:56:05'),(71,'4b586165d67a2',1,1,76,3,3,'2010-02-08 15:57:11','2010-02-08 15:57:11'),(72,'4b586165d67a2',1,1,77,3,3,'2010-02-08 15:57:11','2010-02-08 15:57:11'),(73,'4b586165d67a2',1,1,74,3,3,'2010-02-08 15:57:11','2010-02-08 15:57:11'),(74,'4b58618e770f0',1,1,76,3,3,'2010-02-08 15:57:39','2010-02-08 15:57:39'),(75,'4b58618e770f0',1,1,73,3,3,'2010-02-08 15:57:39','2010-02-08 15:57:39'),(76,'4b58618e770f0',1,1,75,3,3,'2010-02-08 15:57:39','2010-02-08 15:57:39'),(77,'4b58613c3c9b0',1,1,76,3,3,'2010-02-08 15:57:45','2010-02-08 15:57:45'),(78,'4b6fc9a131dd8',1,1,77,3,3,'2010-02-08 15:57:58','2010-02-08 15:57:58'),(79,'4b6fc9a131dd8',1,1,73,3,3,'2010-02-08 15:57:58','2010-02-08 15:57:58'),(90,'4b58614f47b56',1,1,77,3,3,'2010-02-11 18:31:53','2010-02-11 18:31:53'),(91,'4b58614f47b56',1,1,73,3,3,'2010-02-11 18:31:53','2010-02-11 18:31:53'),(92,'4b58614f47b56',1,1,74,3,3,'2010-02-11 18:31:53','2010-02-11 18:31:53'),(93,'4b58614f47b56',1,1,75,3,3,'2010-02-11 18:31:53','2010-02-11 18:31:53'),(96,'4b5860fc08fe4',1,1,76,3,3,'2010-02-25 13:44:38','2010-02-25 13:44:38'),(97,'4b5860fc08fe4',1,1,77,3,3,'2010-02-25 13:44:38','2010-02-25 13:44:38');
/*!40000 ALTER TABLE `productCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productInternalLinks`
--

DROP TABLE IF EXISTS `productInternalLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productInternalLinks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `sortPosition` int(10) NOT NULL,
  `linkedProductId` varchar(32) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  KEY `linkedProductId` (`linkedProductId`),
  CONSTRAINT `productInternalLinks_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `productInternalLinks_ibfk_2` FOREIGN KEY (`linkedProductId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productInternalLinks`
--

LOCK TABLES `productInternalLinks` WRITE;
/*!40000 ALTER TABLE `productInternalLinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `productInternalLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productLabels`
--

DROP TABLE IF EXISTS `productLabels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productLabels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `label` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  KEY `productId_2` (`productId`,`version`),
  CONSTRAINT `productLabels_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productLabels`
--

LOCK TABLES `productLabels` WRITE;
/*!40000 ALTER TABLE `productLabels` DISABLE KEYS */;
INSERT INTO `productLabels` VALUES (12,'4b6fc9a131dd8',1,1,80,3,3,'2010-02-08 15:57:58','2010-02-08 15:57:58'),(14,'4b58614f47b56',1,1,80,3,3,'2010-02-11 18:31:53','2010-02-11 18:31:53');
/*!40000 ALTER TABLE `productLabels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productLinks`
--

DROP TABLE IF EXISTS `productLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productLinks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idProducts` bigint(20) unsigned NOT NULL,
  `productId` varchar(32) NOT NULL COMMENT 'linked product',
  PRIMARY KEY (`id`),
  KEY `idProducts` (`idProducts`),
  KEY `productId` (`productId`),
  CONSTRAINT `productLinks_ibfk_1` FOREIGN KEY (`idProducts`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `productLinks_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productLinks`
--

LOCK TABLES `productLinks` WRITE;
/*!40000 ALTER TABLE `productLinks` DISABLE KEYS */;
INSERT INTO `productLinks` VALUES (4,2,'4b585c594f35d'),(5,4,'4b5860d198729'),(6,6,'4b5860df83012'),(7,8,'4b5860fc08fe4'),(8,10,'4b58612ac0a20'),(9,12,'4b58613c3c9b0'),(10,14,'4b58614f47b56'),(11,16,'4b586165d67a2'),(12,18,'4b586179c1713'),(13,20,'4b58618e770f0'),(14,22,'4b58619f4de8f'),(15,24,'4b5861aa05ec3'),(16,26,'4b5861b987a25'),(17,28,'4b5861c7dc368'),(18,30,'4b5861d9d4b67'),(19,32,'4b58620d299c8'),(20,34,'4b586224046a2'),(21,36,'4b586238622fa'),(22,38,'4b5862458f289'),(23,40,'4b586253af457'),(24,42,'4b58626062fd8'),(25,43,'4b58614f47b56'),(26,45,'4b6aa33ede16d'),(27,47,'4b6aa3520f7de'),(28,49,'4b6fc9a131dd8');
/*!40000 ALTER TABLE `productLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productProperties`
--

DROP TABLE IF EXISTS `productProperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productProperties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idProductTypes` bigint(20) unsigned NOT NULL,
  `showInNavigation` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `publisher` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `published` timestamp NULL DEFAULT NULL,
  `idStatus` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `productId_2` (`productId`,`version`,`idLanguages`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  KEY `idLanguages` (`idLanguages`),
  KEY `publisher` (`publisher`),
  KEY `creator` (`creator`),
  KEY `idUsers` (`idUsers`),
  CONSTRAINT `productProperties_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productProperties`
--

LOCK TABLES `productProperties` WRITE;
/*!40000 ALTER TABLE `productProperties` DISABLE KEYS */;
INSERT INTO `productProperties` VALUES (4,'4b585c594f35d',1,1,16,11,1,0,3,3,3,'2010-01-21 13:53:29','2010-02-17 15:10:06','2010-01-21 13:53:23',2),(5,'4b5860d198729',1,1,17,12,3,0,3,3,3,'2010-01-21 14:12:33','2010-02-08 15:25:44','2010-01-21 14:13:20',2),(6,'4b5860df83012',1,1,17,12,3,0,3,3,3,'2010-01-21 14:12:47','2010-01-21 14:12:47',NULL,2),(7,'4b5860fc08fe4',1,1,17,12,3,1,3,3,3,'2010-01-21 14:13:16','2010-02-25 13:44:38','2010-02-08 14:40:44',2),(8,'4b58612ac0a20',1,1,17,12,3,1,3,3,3,'2010-01-21 14:14:02','2010-02-15 17:38:42','2010-02-04 09:26:32',2),(9,'4b58613c3c9b0',1,1,16,11,1,1,3,3,3,'2010-01-21 14:14:20','2010-02-08 15:57:45','2010-01-21 14:14:12',2),(10,'4b58614f47b56',1,1,16,11,1,1,3,3,3,'2010-01-21 14:14:39','2010-02-11 18:31:53','2010-01-21 14:14:32',2),(11,'4b586165d67a2',1,1,16,11,1,1,3,3,3,'2010-01-21 14:15:01','2010-02-08 15:57:11','2010-01-21 14:14:53',2),(12,'4b586179c1713',1,1,16,11,1,1,3,3,3,'2010-01-21 14:15:21','2010-02-04 08:35:58','2010-01-21 14:15:15',2),(13,'4b58618e770f0',1,1,16,11,1,1,3,3,3,'2010-01-21 14:15:42','2010-02-08 15:57:39','2010-01-21 14:15:35',2),(14,'4b58619f4de8f',1,1,17,12,3,1,3,3,3,'2010-01-21 14:15:59','2010-02-08 15:56:05','2010-02-08 15:39:35',2),(15,'4b5861aa05ec3',1,1,17,12,3,1,3,3,3,'2010-01-21 14:16:10','2010-01-21 14:16:10',NULL,2),(16,'4b5861b987a25',1,1,17,12,3,1,3,3,3,'2010-01-21 14:16:25','2010-01-21 14:16:25',NULL,2),(17,'4b5861c7dc368',1,1,17,12,3,1,3,3,3,'2010-01-21 14:16:39','2010-01-21 14:16:39',NULL,2),(18,'4b5861d9d4b67',1,1,16,11,1,1,3,3,3,'2010-01-21 14:16:57','2010-01-21 14:17:26','2010-01-21 14:16:50',2),(19,'4b58620d299c8',1,1,16,11,1,1,3,3,3,'2010-01-21 14:17:49','2010-01-21 14:17:49','2010-01-21 14:17:40',2),(20,'4b586224046a2',1,1,16,11,1,1,3,3,3,'2010-01-21 14:18:12','2010-01-21 14:18:12','2010-01-21 14:18:05',2),(21,'4b586238622fa',1,1,16,11,1,1,3,3,3,'2010-01-21 14:18:32','2010-01-21 14:18:32','2010-01-21 14:18:26',2),(22,'4b5862458f289',1,1,16,11,1,1,3,3,3,'2010-01-21 14:18:45','2010-01-21 14:18:45','2010-01-21 14:18:40',2),(23,'4b586253af457',1,1,16,11,1,1,3,3,3,'2010-01-21 14:18:59','2010-01-21 14:18:59','2010-01-21 14:18:53',2),(24,'4b58626062fd8',1,1,16,11,1,1,3,3,3,'2010-01-21 14:19:12','2010-01-21 14:19:12','2010-01-21 14:19:03',2),(25,'4b5860d198729',1,2,17,12,3,0,3,3,3,'2010-02-02 15:29:27','2010-02-03 15:09:51','2010-02-02 15:29:24',2),(26,'4b5860fc08fe4',1,2,17,12,3,1,3,3,3,'2010-02-02 15:32:33','2010-02-03 15:10:48','2010-02-02 15:32:31',2),(27,'4b58612ac0a20',1,2,17,12,1,0,3,3,3,'2010-02-03 15:27:56','2010-02-03 15:27:56','2010-02-03 15:27:54',1),(28,'4b6aa33ede16d',1,1,16,11,1,1,3,3,3,'2010-02-04 10:36:46','2010-02-26 22:11:28','2010-02-04 10:36:36',2),(29,'4b6aa3520f7de',1,1,16,11,1,1,3,3,3,'2010-02-04 10:37:06','2010-02-04 10:37:06','2010-02-04 10:36:58',2),(30,'4b6fc9a131dd8',1,1,17,12,3,0,3,3,3,'2010-02-08 08:21:53','2010-02-08 16:10:10','2010-02-08 08:21:59',2),(31,'4b5860fc08fe4',1,4,17,12,1,0,3,3,3,'2010-02-08 16:13:50','2010-02-09 08:22:23','2010-02-08 16:13:47',1),(32,'4b58612ac0a20',1,4,17,12,1,0,3,3,3,'2010-02-09 08:22:52','2010-02-09 08:22:52','2010-02-09 08:22:49',1),(33,'4b6aa33ede16d',1,2,16,11,1,0,3,3,3,'2010-02-19 11:26:57','2010-02-22 08:27:34','2010-02-19 11:26:51',1);
/*!40000 ALTER TABLE `productProperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productTitles`
--

DROP TABLE IF EXISTS `productTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productId_2` (`productId`,`version`,`idLanguages`),
  KEY `productId` (`productId`),
  CONSTRAINT `productTitles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productTitles`
--

LOCK TABLES `productTitles` WRITE;
/*!40000 ALTER TABLE `productTitles` DISABLE KEYS */;
INSERT INTO `productTitles` VALUES (4,'4b585c594f35d',1,1,'Produktbaum',3,3,'2010-01-21 13:53:29','2010-02-17 15:10:06'),(5,'4b5860d198729',1,1,'Produkte',3,3,'2010-01-21 14:12:33','2010-02-08 15:25:44'),(6,'4b5860df83012',1,1,'Kompetenzen',3,3,'2010-01-21 14:12:47','2010-01-21 14:12:47'),(7,'4b5860fc08fe4',1,1,'Zähne',3,3,'2010-01-21 14:13:16','2010-02-25 13:44:38'),(8,'4b58612ac0a20',1,1,'Zahnzubehör',3,3,'2010-01-21 14:14:02','2010-02-15 17:38:42'),(9,'4b58613c3c9b0',1,1,'SR Phonares FormSelector',3,3,'2010-01-21 14:14:20','2010-02-08 15:57:45'),(10,'4b58614f47b56',1,1,'Zahnschrank Z4',3,3,'2010-01-21 14:14:39','2010-02-11 18:31:53'),(11,'4b586165d67a2',1,1,'Zahnschrank Z6',3,3,'2010-01-21 14:15:01','2010-02-08 15:57:11'),(12,'4b586179c1713',1,1,'Zahnschrank Z12',3,3,'2010-01-21 14:15:21','2010-02-04 08:35:58'),(13,'4b58618e770f0',1,1,'SR Phonares Zahnschrank',3,3,'2010-01-21 14:15:42','2010-02-08 15:57:39'),(14,'4b58619f4de8f',1,1,'Füllungsmaterialie',3,3,'2010-01-21 14:15:59','2010-02-08 15:56:05'),(15,'4b5861aa05ec3',1,1,'Composites',3,3,'2010-01-21 14:16:10','2010-01-21 14:16:10'),(16,'4b5861b987a25',1,1,'Compomere',3,3,'2010-01-21 14:16:25','2010-01-21 14:16:25'),(17,'4b5861c7dc368',1,1,'Amalgame',3,3,'2010-01-21 14:16:39','2010-01-21 14:16:39'),(18,'4b5861d9d4b67',1,1,'Amalcap Plus',3,3,'2010-01-21 14:16:57','2010-01-21 14:17:26'),(19,'4b58620d299c8',1,1,'Vivacap',3,3,'2010-01-21 14:17:49','2010-01-21 14:17:49'),(20,'4b586224046a2',1,1,'World-Cap',3,3,'2010-01-21 14:18:12','2010-01-21 14:18:12'),(21,'4b586238622fa',1,1,'IPS Empress Direct',3,3,'2010-01-21 14:18:32','2010-01-21 14:18:32'),(22,'4b5862458f289',1,1,'Tetric EvoCeram',3,3,'2010-01-21 14:18:45','2010-01-21 14:18:45'),(23,'4b586253af457',1,1,'Tetric EvoFlow',3,3,'2010-01-21 14:18:59','2010-01-21 14:18:59'),(24,'4b58626062fd8',1,1,'Tetric',3,3,'2010-01-21 14:19:12','2010-01-21 14:19:12'),(25,'4b5860d198729',1,2,'Products',3,3,NULL,'2010-02-03 15:09:51'),(26,'4b5860fc08fe4',1,3,'Teeths',3,3,NULL,'2010-02-02 15:32:27'),(27,'4b5860fc08fe4',1,2,'Teeths',3,3,NULL,'2010-02-03 15:10:48'),(28,'4b5860df83012',1,2,'Competences',3,3,NULL,'2010-02-03 15:09:37'),(29,'4b58612ac0a20',1,2,'Teeth Accessory',3,3,NULL,'2010-02-03 15:27:56'),(30,'4b6aa33ede16d',1,1,'Vivoperl PE - Frontzähne',3,3,'2010-02-04 10:36:46','2010-02-26 22:11:28'),(31,'4b6aa3520f7de',1,1,'Vivoperl PE - Orthotyp',3,3,'2010-02-04 10:37:06','2010-02-04 10:37:06'),(32,'4b6fc9a131dd8',1,1,'Zahnschrank',3,3,'2010-02-08 08:21:53','2010-02-08 16:10:10'),(33,'4b5860fc08fe4',1,4,'Zähne',3,3,NULL,'2010-02-09 08:22:23'),(34,'4b58612ac0a20',1,4,'Zahnzubehör',3,3,NULL,'2010-02-09 08:22:52'),(35,'4b6aa33ede16d',1,2,'Vivoperl PE',3,3,'2010-02-19 11:26:57','2010-02-22 08:27:34');
/*!40000 ALTER TABLE `productTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productTypeTitles`
--

DROP TABLE IF EXISTS `productTypeTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productTypeTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idProductTypes` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idProductTypes` (`idProductTypes`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productTypeTitles`
--

LOCK TABLES `productTypeTitles` WRITE;
/*!40000 ALTER TABLE `productTypeTitles` DISABLE KEYS */;
INSERT INTO `productTypeTitles` VALUES (1,1,1,'Produkt'),(2,2,1,'Verlinkung'),(3,3,1,'Übersicht');
/*!40000 ALTER TABLE `productTypeTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productTypes`
--

DROP TABLE IF EXISTS `productTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `product` tinyint(1) NOT NULL DEFAULT '0',
  `startproduct` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product` (`product`),
  KEY `startproduct` (`startproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productTypes`
--

LOCK TABLES `productTypes` WRITE;
/*!40000 ALTER TABLE `productTypes` DISABLE KEYS */;
INSERT INTO `productTypes` VALUES (1,'product',1,1),(2,'link',0,0),(3,'overview',0,1);
/*!40000 ALTER TABLE `productTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productVideos`
--

DROP TABLE IF EXISTS `productVideos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productVideos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `userId` varchar(32) NOT NULL,
  `videoId` varchar(64) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `idVideoTypes` int(10) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  CONSTRAINT `productVideos_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productVideos`
--

LOCK TABLES `productVideos` WRITE;
/*!40000 ALTER TABLE `productVideos` DISABLE KEYS */;
INSERT INTO `productVideos` VALUES (11,'4b58614f47b56',1,1,'massiveart','4723789','http://ts.vimeo.com.s3.amazonaws.com/127/103/12710394_100.jpg',1,3,'2010-02-11 18:31:53');
/*!40000 ALTER TABLE `productVideos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idParent` bigint(20) unsigned NOT NULL,
  `idParentTypes` bigint(20) unsigned NOT NULL,
  `isStartProduct` tinyint(1) NOT NULL DEFAULT '0',
  `idUsers` bigint(20) unsigned NOT NULL,
  `sortPosition` bigint(20) unsigned NOT NULL,
  `sortTimestamp` timestamp NULL DEFAULT NULL,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `version` (`version`),
  KEY `productId` (`productId`),
  KEY `productId_2` (`productId`,`version`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,11,1,1,3,999999,'2010-01-21 13:55:23','4b585c594f35d',1,3,'2010-01-21 13:55:23','2010-02-17 15:10:06'),(2,12,1,1,3,0,'2010-01-21 13:55:23','4b585c59516f4',1,3,'2010-01-21 13:55:23','2010-01-21 13:55:23'),(3,11,1,1,3,999999,'2010-01-21 14:12:33','4b5860d198729',1,3,'2010-01-21 14:12:33','2010-02-08 15:25:44'),(4,17,2,1,3,0,'2010-01-21 14:12:33','4b5860d19b7e6',1,3,'2010-01-21 14:12:33','2010-01-21 14:12:33'),(5,11,1,1,3,999999,'2010-01-21 14:12:47','4b5860df83012',1,3,'2010-01-21 14:12:47','2010-01-21 14:12:47'),(6,18,2,1,3,0,'2010-01-21 14:12:47','4b5860df86e03',1,3,'2010-01-21 14:12:47','2010-01-21 14:12:47'),(7,11,1,1,3,999999,'2010-01-21 14:13:16','4b5860fc08fe4',1,3,'2010-01-21 14:13:16','2010-02-25 13:44:38'),(8,19,2,1,3,0,'2010-01-21 14:13:16','4b5860fc1014c',1,3,'2010-01-21 14:13:16','2010-01-21 14:13:16'),(9,11,1,1,3,999999,'2010-01-21 14:14:02','4b58612ac0a20',1,3,'2010-01-21 14:14:02','2010-02-09 08:22:52'),(10,20,2,1,3,0,'2010-01-21 14:14:02','4b58612ac2a1f',1,3,'2010-01-21 14:14:02','2010-01-21 14:14:02'),(11,11,1,0,3,999999,'2010-01-21 14:14:20','4b58613c3c9b0',1,3,'2010-01-21 14:14:20','2010-02-08 15:57:45'),(12,20,2,0,3,6,'2010-02-08 09:05:25','4b58613c42670',1,3,'2010-01-21 14:14:20','2010-02-08 09:05:25'),(13,11,1,0,3,999999,'2010-01-21 14:14:39','4b58614f47b56',1,3,'2010-01-21 14:14:39','2010-02-11 18:31:53'),(14,20,2,0,3,3,'2010-02-08 09:05:19','4b58614f4a383',1,3,'2010-01-21 14:14:39','2010-02-08 09:05:19'),(15,11,1,0,3,999999,'2010-01-21 14:15:01','4b586165d67a2',1,3,'2010-01-21 14:15:01','2010-02-08 15:57:11'),(16,20,2,0,3,4,'2010-02-08 09:05:22','4b586165dcf1b',1,3,'2010-01-21 14:15:01','2010-02-08 09:05:22'),(17,11,1,0,3,999999,'2010-01-21 14:15:21','4b586179c1713',1,3,'2010-01-21 14:15:21','2010-02-04 08:35:58'),(18,20,2,0,3,5,'2010-02-08 09:05:23','4b586179c46b1',1,3,'2010-01-21 14:15:21','2010-02-08 09:05:23'),(19,11,1,0,3,999999,'2010-01-21 14:15:42','4b58618e770f0',1,3,'2010-01-21 14:15:42','2010-02-08 15:57:39'),(20,20,2,0,3,2,'2010-02-08 09:05:13','4b58618e79dd2',1,3,'2010-01-21 14:15:42','2010-02-08 09:05:13'),(21,11,1,1,3,999999,'2010-01-21 14:15:59','4b58619f4de8f',1,3,'2010-01-21 14:15:59','2010-02-08 15:56:05'),(22,21,2,1,3,0,'2010-01-21 14:15:59','4b58619f4fcb2',1,3,'2010-01-21 14:15:59','2010-01-21 14:15:59'),(23,11,1,1,3,999999,'2010-01-21 14:16:10','4b5861aa05ec3',1,3,'2010-01-21 14:16:10','2010-01-21 14:16:10'),(24,22,2,1,3,0,'2010-01-21 14:16:10','4b5861aa08015',1,3,'2010-01-21 14:16:10','2010-01-21 14:16:10'),(25,11,1,1,3,999999,'2010-01-21 14:16:25','4b5861b987a25',1,3,'2010-01-21 14:16:25','2010-01-21 14:16:25'),(26,23,2,1,3,0,'2010-01-21 14:16:25','4b5861b98b94e',1,3,'2010-01-21 14:16:25','2010-01-21 14:16:25'),(27,11,1,1,3,999999,'2010-01-21 14:16:39','4b5861c7dc368',1,3,'2010-01-21 14:16:39','2010-01-21 14:16:39'),(28,24,2,1,3,0,'2010-01-21 14:16:39','4b5861c7e0b3f',1,3,'2010-01-21 14:16:39','2010-01-21 14:16:39'),(29,11,1,0,3,999999,'2010-01-21 14:16:57','4b5861d9d4b67',1,3,'2010-01-21 14:16:57','2010-01-21 14:17:26'),(30,24,2,0,3,1,'2010-01-21 14:16:57','4b5861d9d6fe2',1,3,'2010-01-21 14:16:57','2010-01-21 14:16:57'),(31,11,1,0,3,999999,'2010-01-21 14:17:49','4b58620d299c8',1,3,'2010-01-21 14:17:49','2010-01-21 14:17:49'),(32,24,2,0,3,2,'2010-01-21 14:17:49','4b58620d2c296',1,3,'2010-01-21 14:17:49','2010-01-21 14:17:49'),(33,11,1,0,3,999999,'2010-01-21 14:18:12','4b586224046a2',1,3,'2010-01-21 14:18:12','2010-01-21 14:18:12'),(34,24,2,0,3,3,'2010-01-21 14:18:12','4b58622406b7c',1,3,'2010-01-21 14:18:12','2010-01-21 14:18:12'),(35,11,1,0,3,999999,'2010-01-21 14:18:32','4b586238622fa',1,3,'2010-01-21 14:18:32','2010-01-21 14:18:32'),(36,22,2,0,3,1,'2010-01-21 14:18:32','4b58623864aca',1,3,'2010-01-21 14:18:32','2010-01-21 14:18:32'),(37,11,1,0,3,999999,'2010-01-21 14:18:45','4b5862458f289',1,3,'2010-01-21 14:18:45','2010-01-21 14:18:45'),(38,22,2,0,3,2,'2010-01-21 14:18:45','4b586245918e2',1,3,'2010-01-21 14:18:45','2010-01-21 14:18:45'),(39,11,1,0,3,999999,'2010-01-21 14:18:59','4b586253af457',1,3,'2010-01-21 14:18:59','2010-01-21 14:18:59'),(40,22,2,0,3,3,'2010-01-21 14:18:59','4b586253b2f3f',1,3,'2010-01-21 14:18:59','2010-01-21 14:18:59'),(41,11,1,0,3,999999,'2010-01-21 14:19:12','4b58626062fd8',1,3,'2010-01-21 14:19:12','2010-01-21 14:19:12'),(42,22,2,0,3,4,'2010-01-21 14:19:12','4b586260653d3',1,3,'2010-01-21 14:19:12','2010-01-21 14:19:12'),(43,21,2,0,3,4,'2010-02-02 13:15:12','4b682560af736',1,3,'2010-02-02 13:15:12','2010-02-02 13:15:12'),(44,11,1,0,3,999999,'2010-02-04 10:36:46','4b6aa33ede16d',1,3,'2010-02-04 10:36:46','2010-02-26 22:11:28'),(45,19,2,0,3,1,'2010-02-08 09:04:29','4b6aa33ee46b0',1,3,'2010-02-04 10:36:46','2010-02-08 09:04:29'),(46,11,1,0,3,999999,'2010-02-04 10:37:06','4b6aa3520f7de',1,3,'2010-02-04 10:37:06','2010-02-04 10:37:06'),(47,19,2,0,3,2,'2010-02-08 09:04:31','4b6aa35212a88',1,3,'2010-02-04 10:37:06','2010-02-08 09:04:31'),(48,11,1,1,3,999999,'2010-02-08 08:21:53','4b6fc9a131dd8',1,3,'2010-02-08 08:21:53','2010-02-08 15:57:58'),(49,28,2,1,3,0,'2010-02-08 08:21:53','4b6fc9a136867',1,3,'2010-02-08 08:21:53','2010-02-08 08:21:53');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,'Url');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regionFields`
--

DROP TABLE IF EXISTS `regionFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regionFields` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idRegions` bigint(20) NOT NULL,
  `idFields` bigint(20) NOT NULL,
  `order` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idRegions` (`idRegions`),
  KEY `idFields` (`idFields`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regionFields`
--

LOCK TABLES `regionFields` WRITE;
/*!40000 ALTER TABLE `regionFields` DISABLE KEYS */;
INSERT INTO `regionFields` VALUES (1,1,1,1),(2,1,1,1),(3,1,2,2),(4,2,3,1),(5,2,4,2),(6,3,5,1),(7,4,6,1),(8,5,7,2),(9,6,8,2),(10,8,10,2),(11,9,11,1),(12,10,17,1),(13,11,18,2),(14,11,19,3),(15,11,20,1),(16,9,21,5),(17,9,22,3),(18,12,23,1),(19,12,24,3),(20,5,25,1),(21,6,26,1),(22,2,27,3),(23,13,28,1),(24,14,29,3),(25,14,30,1),(26,15,31,5),(27,15,34,3),(28,15,37,1),(29,2,40,1),(30,16,41,4),(31,16,42,2),(32,16,43,1),(33,17,44,5),(34,17,45,2),(35,17,46,1),(36,15,47,6),(37,15,48,7),(38,16,49,5),(39,16,50,6),(40,17,51,6),(41,17,52,7),(42,17,53,3),(43,12,54,2),(44,8,55,1),(45,9,56,4),(46,15,59,2),(47,15,60,4),(48,16,61,3),(49,17,62,4),(50,99999999,64,2),(51,18,65,3),(52,18,66,4),(53,19,67,1),(54,19,68,2),(55,20,69,2),(56,20,70,3),(57,20,71,4),(58,20,72,5),(59,20,73,1),(60,19,74,3),(61,19,75,4),(62,18,76,1),(63,18,77,2),(64,18,78,5),(65,21,79,1),(66,21,80,2),(67,21,81,3),(68,21,82,4),(69,21,83,5),(70,21,84,6),(71,22,85,1),(72,9,86,2),(73,19,87,5),(74,23,88,2),(75,23,89,3),(76,23,90,1),(77,24,91,1),(78,24,92,2),(79,25,93,2),(80,25000,94,1),(81,15,95,8),(82,25,96,1),(83,26,1,1),(84,27,97,1),(85,27,98,2),(86,26,99,2),(87,26,100,3),(88,26,101,4),(89,26,102,5),(90,26,103,6),(91,28,108,1),(92,26,27,7),(93,29,104,1),(94,29,105,2),(95,30,106,1),(96,29,107,3),(97,31,109,1),(98,32,110,1),(99,32,113,2),(101,35,115,1),(102,33,111,1),(103,33,112,1),(104,36,116,1),(105,37,117,1),(106,38,118,1),(107,39,119,1),(108,39,120,2),(109,40,121,1),(110,40,122,2),(111,41,86,1),(113,41,22,2),(115,41,56,3),(116,41,21,4),(117,42,6,1),(119,43,5,1),(120,44,7,1),(121,45,20,1),(122,45,18,2),(123,45,19,3),(125,46,23,1),(126,46,54,2),(127,46,24,3),(128,47,26,1),(129,47,129,2),(130,48,119,1),(131,48,120,2),(132,49,55,1),(133,49,10,2),(134,50,124,1),(135,50,125,2),(136,51,126,1),(137,51,127,2),(138,14,128,2),(139,52,46,1),(140,52,130,2),(141,52,131,3),(142,52,132,4),(143,10,133,2);
/*!40000 ALTER TABLE `regionFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regionTitles`
--

DROP TABLE IF EXISTS `regionTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regionTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idRegions` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idRegions` (`idRegions`),
  CONSTRAINT `regionTitles_ibfk_1` FOREIGN KEY (`idRegions`) REFERENCES `regions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regionTitles`
--

LOCK TABLES `regionTitles` WRITE;
/*!40000 ALTER TABLE `regionTitles` DISABLE KEYS */;
INSERT INTO `regionTitles` VALUES (1,1,1,'Allgemeine Informationen'),(2,2,1,'Allgemeine Informationen'),(3,3,1,'Titelbild'),(4,4,1,'Artikel'),(5,5,1,'Bildergalerie'),(6,6,1,'Dokumente'),(8,8,1,'Auszug'),(9,9,1,'Layout, Kategorien & Tags'),(10,10,1,'Allgemeine Informationen'),(11,11,1,'Textblock'),(12,12,1,'Video'),(13,13,1,'Link auf Seite im Portal'),(14,14,1,'Sidebar'),(15,15,1,'Definitionen'),(16,16,1,'Portal Top'),(17,17,1,'Artikel'),(18,18,1,'Allgemeine Kontaktinformationen'),(19,19,1,'Veranstaltungsinformationen'),(20,20,1,'Veranstaltungsort'),(21,21,1,'Kontaktdetails'),(22,22,1,'Vortragende'),(23,23,1,'Banner klein'),(24,24,1,'Headerbereich'),(25,25,1,'Externer Link'),(26,1,2,'General Informations'),(27,2,2,'General Informations'),(28,26,1,'Allgemeine Informationen'),(29,27,1,'Prozessanweisung'),(30,28,1,'Prozessgrafik'),(31,29,1,'Prozessschritt'),(32,30,1,'Kurzbeschreibung'),(33,31,1,'Prozessinputs / Informationen / Ressourcen'),(34,32,1,'Prozessrisiken'),(35,33,1,'Vorschriften'),(36,34,1,'Prozessoutputs / Ergebnisse / Kunden'),(37,35,1,'Messgößen'),(38,36,1,'Vorschriften / Richtlinien / Sicherheit'),(39,37,1,'Methoden / Verfahren / IT Tools'),(40,38,1,'Google Maps'),(41,39,1,'Interne Links'),(42,40,1,'Kollektion'),(43,41,1,'Kategorien, Etiketten und Tags'),(44,41,2,'Categories, labels and tags'),(45,42,1,'Artikel'),(46,42,2,'Short description'),(47,43,1,'Titelbild'),(48,43,2,'Title picture'),(49,44,1,'Bildergalerie'),(50,44,2,'Pictures'),(51,45,1,'Textblock'),(52,45,2,'Description'),(53,46,1,'Video'),(54,46,2,'Video'),(55,47,1,'Dokumente'),(56,47,2,'Documents'),(57,48,1,'Interne Links'),(58,48,2,'Internal links'),(59,49,1,'Auszug'),(60,49,2,'Abstract'),(62,50,1,'Externe Links'),(63,50,2,'External links'),(64,51,1,'Titelbild & Slogan'),(65,52,1,'Produktbaum');
/*!40000 ALTER TABLE `regionTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regionTypes`
--

DROP TABLE IF EXISTS `regionTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regionTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regionTypes`
--

LOCK TABLES `regionTypes` WRITE;
/*!40000 ALTER TABLE `regionTypes` DISABLE KEYS */;
INSERT INTO `regionTypes` VALUES (1,'content'),(2,'config');
/*!40000 ALTER TABLE `regionTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idRegionTypes` bigint(20) unsigned NOT NULL,
  `columns` int(10) NOT NULL COMMENT 'size of region',
  `isTemplate` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'indicates, whether this region should be multiusable - needed later on for tempalte editor',
  `collapsable` tinyint(1) NOT NULL DEFAULT '1',
  `isCollapsed` tinyint(1) NOT NULL DEFAULT '1',
  `position` varchar(255) DEFAULT NULL,
  `isMultiply` tinyint(1) NOT NULL DEFAULT '0',
  `multiplyRegion` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES (1,1,9,0,0,1,NULL,0,0),(2,1,9,0,0,1,NULL,0,0),(3,1,9,0,1,1,NULL,0,0),(4,1,9,0,1,1,NULL,0,0),(5,1,9,0,1,0,NULL,0,0),(6,1,9,0,1,0,NULL,0,0),(8,1,9,0,1,0,NULL,0,0),(9,1,3,0,1,1,'right',0,0),(10,1,12,0,0,1,NULL,0,0),(11,1,9,0,1,0,NULL,1,1),(12,1,9,0,1,0,NULL,0,0),(13,1,12,0,0,1,NULL,0,0),(14,1,9,0,1,0,NULL,1,1),(15,2,9,0,1,0,NULL,1,1),(16,2,9,0,1,1,NULL,0,0),(17,2,9,0,1,0,NULL,1,1),(18,1,12,0,0,1,NULL,0,0),(19,1,9,0,1,1,NULL,0,0),(20,1,9,0,1,1,NULL,0,0),(21,1,12,0,1,1,NULL,0,0),(22,1,9,0,1,1,NULL,0,0),(23,1,9,0,1,0,NULL,0,0),(24,1,9,0,1,0,NULL,0,0),(25,1,12,0,0,1,NULL,0,0),(26,1,9,0,0,1,NULL,0,0),(27,1,9,0,1,1,NULL,1,0),(28,1,9,0,1,1,NULL,0,0),(29,1,9,0,1,0,NULL,1,0),(30,1,9,0,1,0,NULL,0,0),(31,1,9,0,1,0,NULL,0,0),(32,1,9,0,1,0,NULL,1,1),(33,1,9,0,1,1,NULL,1,0),(34,1,9,0,1,0,NULL,0,0),(35,1,9,0,1,0,NULL,0,0),(36,1,9,0,1,0,NULL,0,0),(37,1,9,0,1,0,NULL,0,0),(38,1,9,0,1,0,NULL,0,0),(39,1,9,0,1,0,NULL,0,0),(40,1,9,0,1,0,NULL,0,0),(41,1,3,0,1,1,'right',0,0),(42,1,9,0,1,1,NULL,0,0),(43,1,9,0,1,1,NULL,0,0),(44,1,9,0,1,0,NULL,0,0),(45,1,9,0,1,0,NULL,1,1),(46,1,9,0,1,0,NULL,0,0),(47,1,9,0,1,0,NULL,1,1),(48,1,9,0,1,0,NULL,0,0),(49,1,9,0,1,0,NULL,0,0),(50,1,9,0,1,0,NULL,1,1),(51,1,9,0,1,0,NULL,1,1),(52,2,9,0,1,0,NULL,0,0);
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `renderedFiles`
--

DROP TABLE IF EXISTS `renderedFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `renderedFiles` (
  `id` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `folder` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `renderedFiles`
--

LOCK TABLES `renderedFiles` WRITE;
/*!40000 ALTER TABLE `renderedFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `renderedFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourceGroups`
--

DROP TABLE IF EXISTS `resourceGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourceGroups` (
  `idResources` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`idResources`,`idGroups`),
  KEY `idGroups` (`idGroups`),
  CONSTRAINT `resourceGroups_ibfk_1` FOREIGN KEY (`idResources`) REFERENCES `resources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `resourceGroups_ibfk_2` FOREIGN KEY (`idGroups`) REFERENCES `groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourceGroups`
--

LOCK TABLES `resourceGroups` WRITE;
/*!40000 ALTER TABLE `resourceGroups` DISABLE KEYS */;
INSERT INTO `resourceGroups` VALUES (1,1),(2,1),(3,1),(5,1),(6,1),(1,2),(5,2),(2,3),(1,5);
/*!40000 ALTER TABLE `resourceGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `key` varchar(64) NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES (1,'Portals','portals',3,3,'2009-10-08 10:15:10','2009-10-19 10:24:06'),(2,'Media','media',3,3,'2009-10-08 10:15:10','2009-10-19 10:24:03'),(3,'User administration','user_administration',3,3,'2009-10-19 09:32:23','2009-10-19 09:57:15'),(5,'Settings','settings',3,3,'2009-10-19 09:55:40','2009-10-19 09:59:35'),(6,'Settings - System Internal','settings-system_internal',3,3,'2009-10-19 09:58:54','2009-10-19 12:50:43');
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rootLevelPermissions`
--

DROP TABLE IF EXISTS `rootLevelPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rootLevelPermissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idRootLevels` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned DEFAULT NULL,
  `idPermissions` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevelPermissions`
--

LOCK TABLES `rootLevelPermissions` WRITE;
/*!40000 ALTER TABLE `rootLevelPermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `rootLevelPermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rootLevelTitles`
--

DROP TABLE IF EXISTS `rootLevelTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rootLevelTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idRootLevels` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rootLevelTitles_ibfk_1` (`idRootLevels`),
  CONSTRAINT `rootLevelTitles_ibfk_1` FOREIGN KEY (`idRootLevels`) REFERENCES `rootLevels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevelTitles`
--

LOCK TABLES `rootLevelTitles` WRITE;
/*!40000 ALTER TABLE `rootLevelTitles` DISABLE KEYS */;
INSERT INTO `rootLevelTitles` VALUES (1,1,1,'.COM Schaan'),(2,2,1,'Bilder'),(3,3,1,'Dokumente'),(4,5,1,'Kontakte'),(5,4,1,'Kategorien'),(6,6,1,'Eigene Etiketten'),(7,7,1,'System Interne'),(8,8,1,'Benutzer'),(9,9,1,'Gruppen / Rollen'),(10,10,1,'Ressourcen'),(11,1,2,'.COM Schaan'),(12,11,1,'Alle Produkte'),(13,12,1,'Produktbaum'),(14,13,1,'.DE Deutschland'),(15,13,2,'.DE Germany'),(16,14,1,'.FR Frankreich'),(17,14,2,'.FR France'),(18,11,2,'All Products'),(19,12,2,'Product Tree'),(20,2,2,'Images'),(21,3,2,'Documents'),(22,5,2,'Contacts'),(23,4,2,'Categories'),(24,6,2,'Custom flags'),(25,7,2,'System internals'),(26,8,2,'Users'),(27,9,2,'Groups'),(28,10,2,'Resources');
/*!40000 ALTER TABLE `rootLevelTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rootLevelTypes`
--

DROP TABLE IF EXISTS `rootLevelTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rootLevelTypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevelTypes`
--

LOCK TABLES `rootLevelTypes` WRITE;
/*!40000 ALTER TABLE `rootLevelTypes` DISABLE KEYS */;
INSERT INTO `rootLevelTypes` VALUES (1,'portals'),(2,'images'),(3,'documents'),(4,'categories'),(5,'contacts'),(6,'labels'),(7,'systeminternals'),(8,'users'),(9,'groups'),(10,'resources'),(11,'products');
/*!40000 ALTER TABLE `rootLevelTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rootLevelUrls`
--

DROP TABLE IF EXISTS `rootLevelUrls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rootLevelUrls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idRootLevels` bigint(20) unsigned NOT NULL,
  `url` varchar(255) NOT NULL COMMENT 'without "www" in front',
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idRootLevels` (`idRootLevels`),
  CONSTRAINT `rootLevelUrls_ibfk_1` FOREIGN KEY (`idRootLevels`) REFERENCES `rootLevels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevelUrls`
--

LOCK TABLES `rootLevelUrls` WRITE;
/*!40000 ALTER TABLE `rootLevelUrls` DISABLE KEYS */;
INSERT INTO `rootLevelUrls` VALUES (6,1,'dev.zoolu.area51.at',2,2,'2009-08-05 09:38:38','2009-05-07 06:49:07'),(7,1,'ivoclarvivadent.zoolu.area51.at',3,3,'2009-10-15 13:09:31','2009-10-15 13:09:23');
/*!40000 ALTER TABLE `rootLevelUrls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rootLevels`
--

DROP TABLE IF EXISTS `rootLevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rootLevels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idRootLevelTypes` int(10) unsigned NOT NULL,
  `idModules` bigint(20) unsigned NOT NULL,
  `href` varchar(64) DEFAULT NULL,
  `idThemes` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevels`
--

LOCK TABLES `rootLevels` WRITE;
/*!40000 ALTER TABLE `rootLevels` DISABLE KEYS */;
INSERT INTO `rootLevels` VALUES (1,1,1,NULL,2),(2,2,2,NULL,NULL),(3,3,2,NULL,NULL),(4,4,3,NULL,NULL),(5,5,3,NULL,NULL),(6,6,3,NULL,NULL),(7,7,3,NULL,NULL),(8,8,4,NULL,NULL),(9,9,4,NULL,NULL),(10,10,4,NULL,NULL),(11,11,5,'/zoolu/products/index/list',NULL),(12,11,5,'/zoolu/products/index/tree',NULL),(13,1,1,NULL,1),(14,1,1,NULL,1);
/*!40000 ALTER TABLE `rootLevels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchFieldTypes`
--

DROP TABLE IF EXISTS `searchFieldTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchFieldTypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchFieldTypes`
--

LOCK TABLES `searchFieldTypes` WRITE;
/*!40000 ALTER TABLE `searchFieldTypes` DISABLE KEYS */;
INSERT INTO `searchFieldTypes` VALUES (1,'None',NULL),(2,'Keyword','Keyword fields are stored and indexed, meaning that they can be searched as well as displayed in search results. They are not split up into separate words by tokenization. Enumerated database fields usually translate well to Keyword fields in Zend_Search_Lucene.'),(3,'UnIndexed','UnIndexed fields are not searchable, but they are returned with search hits. Database timestamps, primary keys, file system paths, and other external identifiers are good candidates for UnIndexed fields.'),(4,'Binary','Binary fields are not tokenized or indexed, but are stored for retrieval with search hits. They can be used to store any data encoded as a binary string, such as an image icon.'),(5,'Text','Text fields are stored, indexed, and tokenized. Text fields are appropriate for storing information like subjects and titles that need to be searchable as well as returned with search results.'),(6,'UnStored','UnStored fields are tokenized and indexed, but not stored in the index. Large amounts of text are best indexed using this type of field. Storing data creates a larger index on disk, so if you need to search but not redisplay the data, use an UnStored field. UnStored fields are practical when using a Zend_Search_Lucene index in combination with a relational database. You can index large data fields with UnStored fields for searching, and retrieve them from your relational database by using a separate field as an identifier.');
/*!40000 ALTER TABLE `searchFieldTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sortTypes`
--

DROP TABLE IF EXISTS `sortTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sortTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sortTypes`
--

LOCK TABLES `sortTypes` WRITE;
/*!40000 ALTER TABLE `sortTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sortTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'test'),(2,'live');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusTitles`
--

DROP TABLE IF EXISTS `statusTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statusTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idStatus` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idStatus` (`idStatus`),
  CONSTRAINT `statusTitles_ibfk_1` FOREIGN KEY (`idStatus`) REFERENCES `status` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusTitles`
--

LOCK TABLES `statusTitles` WRITE;
/*!40000 ALTER TABLE `statusTitles` DISABLE KEYS */;
INSERT INTO `statusTitles` VALUES (1,1,1,'Test'),(2,2,1,'Veröffentlicht');
/*!40000 ALTER TABLE `statusTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabRegions`
--

DROP TABLE IF EXISTS `tabRegions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabRegions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idTabs` bigint(20) NOT NULL,
  `idRegions` bigint(20) NOT NULL,
  `order` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabRegions`
--

LOCK TABLES `tabRegions` WRITE;
/*!40000 ALTER TABLE `tabRegions` DISABLE KEYS */;
INSERT INTO `tabRegions` VALUES (1,1,1,1),(2,2,2,1),(3,2,3,4),(4,2,4,6),(5,2,5,9),(6,2,6,10),(7,2,7,0),(8,2,8,12),(9,2,9,0),(10,5,10,1),(15,2,11,7),(16,2,12,8),(17,6,13,1),(18,7,2,1),(19,7,9,0),(20,7,14,6),(21,7,15,4),(22,8,2,1),(23,8,9,0),(24,8,11,7),(25,8,16,3),(26,8,17,8),(47,7,8,11),(48,7,3,4),(49,7,4,7),(50,9,10,1),(51,11,2,1),(52,11,3,4),(53,11,4,6),(54,11,5,9),(55,11,6,10),(56,11,7,0),(57,11,8,11),(58,11,9,0),(60,11,12,8),(61,10,18,1),(62,11,19,4),(63,11,20,5),(64,10,21,2),(65,11,22,6),(66,12,2,1),(67,12,3,4),(68,12,4,6),(69,12,8,11),(70,12,9,0),(71,8,23,5),(72,8,3,4),(73,8,4,6),(74,2,24,2),(75,8,24,2),(76,11,24,2),(77,12,24,2),(78,13,25,1),(79,14,26,1),(80,15,27,2),(81,16,28,1),(82,17,29,4),(83,14,30,2),(84,14,31,3),(85,18,32,1),(86,19,33,6),(87,14,34,4),(88,14,35,5),(89,14,36,6),(90,14,37,7),(91,2,38,3),(92,2,39,11),(93,7,40,5),(94,20,41,2),(95,20,42,6),(96,20,43,4),(97,20,44,9),(98,20,45,7),(99,20,46,8),(100,20,47,10),(101,20,48,10),(102,20,49,3),(103,20,50,11),(104,20,2,1),(105,21,41,0),(106,21,2,1),(107,21,43,2),(108,21,15,4),(109,21,14,5),(110,21,4,3),(111,21,8,6),(112,20,51,5),(113,22,9,0),(114,22,2,1),(115,22,3,4),(116,22,14,6),(117,22,4,7),(118,22,8,11),(119,22,52,5);
/*!40000 ALTER TABLE `tabRegions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabTitles`
--

DROP TABLE IF EXISTS `tabTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTitles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idTabs` bigint(20) NOT NULL,
  `idLanguages` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabTitles`
--

LOCK TABLES `tabTitles` WRITE;
/*!40000 ALTER TABLE `tabTitles` DISABLE KEYS */;
INSERT INTO `tabTitles` VALUES (1,14,1,'Übersicht'),(2,15,1,'Anweisung'),(3,16,1,'Ablauf'),(4,17,1,'Schritte'),(5,18,1,'Risiken'),(6,19,1,'Vorschriften / Richtlinien / Sicherheit');
/*!40000 ALTER TABLE `tabTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabs`
--

DROP TABLE IF EXISTS `tabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `color` char(7) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabs`
--

LOCK TABLES `tabs` WRITE;
/*!40000 ALTER TABLE `tabs` DISABLE KEYS */;
INSERT INTO `tabs` VALUES (1,NULL),(2,NULL),(3,NULL),(4,NULL),(5,NULL),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,NULL),(11,NULL),(12,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(17,NULL),(18,NULL),(19,NULL),(20,NULL),(21,NULL),(22,NULL);
/*!40000 ALTER TABLE `tabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagFiles`
--

DROP TABLE IF EXISTS `tagFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagFiles` (
  `idTags` bigint(20) unsigned NOT NULL,
  `fileId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`idTags`,`fileId`,`version`,`idLanguages`),
  KEY `idTags` (`idTags`),
  KEY `idFiles` (`fileId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagFiles`
--

LOCK TABLES `tagFiles` WRITE;
/*!40000 ALTER TABLE `tagFiles` DISABLE KEYS */;
INSERT INTO `tagFiles` VALUES (1,'1',1,1),(1,'1',1,2),(1,'2',1,1),(1,'2',1,2),(1,'27',1,1),(1,'28',1,1),(1,'3',1,1),(1,'31',1,1),(1,'32',1,1),(1,'33',1,1),(1,'39',1,1),(1,'39',1,2),(1,'4',1,1),(1,'40',1,1),(1,'55',1,1),(1,'55',1,2),(1,'6',1,1),(1,'66',1,1),(1,'67',1,1),(1,'67',1,2),(2,'1',1,1),(2,'29',1,1),(2,'32',1,1),(2,'33',1,1),(2,'40',1,1),(3,'30',1,1),(4,'15',1,1),(4,'15',1,2),(4,'56',1,1),(6,'56',1,1),(8,'56',1,1),(14,'15',1,2),(14,'39',1,2),(15,'15',1,1),(15,'39',1,1),(16,'58',1,1),(17,'63',1,1);
/*!40000 ALTER TABLE `tagFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagFolders`
--

DROP TABLE IF EXISTS `tagFolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagFolders` (
  `idTags` bigint(20) unsigned NOT NULL,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`idTags`,`folderId`,`version`,`idLanguages`),
  KEY `idTags` (`idTags`),
  KEY `idFolders` (`folderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagFolders`
--

LOCK TABLES `tagFolders` WRITE;
/*!40000 ALTER TABLE `tagFolders` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagFolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagPages`
--

DROP TABLE IF EXISTS `tagPages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagPages` (
  `idTags` bigint(20) unsigned NOT NULL,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`idTags`,`pageId`,`version`,`idLanguages`),
  KEY `idTags` (`idTags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagPages`
--

LOCK TABLES `tagPages` WRITE;
/*!40000 ALTER TABLE `tagPages` DISABLE KEYS */;
INSERT INTO `tagPages` VALUES (1,'4a115ca65d8bb',1,1),(2,'4a681b0f66d2a',1,1),(2,'4afade313b767',1,1),(3,'4a115ca65d8bb',1,1),(3,'4a681b0f66d2a',1,1),(3,'4afade313b767',1,1),(4,'4a112157d69eb',1,1),(4,'4a115ca65d8bb',1,1),(4,'4a115ca65d8bb',1,2),(5,'4a112157d69eb',1,1),(6,'4a115ca65d8bb',1,1),(10,'4a681b0f66d2a',1,1);
/*!40000 ALTER TABLE `tagPages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagProducts`
--

DROP TABLE IF EXISTS `tagProducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagProducts` (
  `idTags` bigint(20) unsigned NOT NULL,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`idTags`,`productId`,`version`,`idLanguages`),
  KEY `idTags` (`idTags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagProducts`
--

LOCK TABLES `tagProducts` WRITE;
/*!40000 ALTER TABLE `tagProducts` DISABLE KEYS */;
INSERT INTO `tagProducts` VALUES (1,'4afa92c061f69',1,1),(1,'4afa935fd7c1c',1,1),(1,'4b5860fc08fe4',1,1),(2,'4afa92c061f69',1,1),(2,'4afa935fd7c1c',1,1),(2,'4b5860fc08fe4',1,1),(3,'4b5860fc08fe4',1,1),(13,'4afa935fd7c1c',1,1);
/*!40000 ALTER TABLE `tagProducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Tag1'),(2,'Tag2'),(3,'Tag3'),(4,'Test1'),(5,'Test2'),(6,'Test3'),(8,'blub'),(10,'Das ist ein langer Tag'),(11,'dieter'),(12,'conny'),(13,'neuer Tag'),(14,'EN'),(15,'DE'),(16,'Xen'),(17,'t');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templateExcludedFields`
--

DROP TABLE IF EXISTS `templateExcludedFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templateExcludedFields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templateExcludedFields_ibfk_1` (`idTemplates`),
  CONSTRAINT `templateExcludedFields_ibfk_1` FOREIGN KEY (`idTemplates`) REFERENCES `templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateExcludedFields`
--

LOCK TABLES `templateExcludedFields` WRITE;
/*!40000 ALTER TABLE `templateExcludedFields` DISABLE KEYS */;
INSERT INTO `templateExcludedFields` VALUES (1,1,40),(2,2,3),(3,2,4000),(4,4,3),(5,4,4000),(6,3,3),(8,5,40),(9,6,40),(10,7,40),(11,3,86),(12,4,86),(13,6,86),(14,8,3),(15,8,4),(16,8,86),(17,10,3),(18,11,40),(19,12,3),(20,13,3);
/*!40000 ALTER TABLE `templateExcludedFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templateExcludedRegions`
--

DROP TABLE IF EXISTS `templateExcludedRegions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templateExcludedRegions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idRegions` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templateExcludedRegions_ibfk_1` (`idTemplates`),
  CONSTRAINT `templateExcludedRegions_ibfk_1` FOREIGN KEY (`idTemplates`) REFERENCES `templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateExcludedRegions`
--

LOCK TABLES `templateExcludedRegions` WRITE;
/*!40000 ALTER TABLE `templateExcludedRegions` DISABLE KEYS */;
INSERT INTO `templateExcludedRegions` VALUES (1,3,16),(2,3,23),(3,3,11),(4,1,24),(5,2,24),(6,3,24),(7,10,15),(8,4,40);
/*!40000 ALTER TABLE `templateExcludedRegions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templateRegionProperties`
--

DROP TABLE IF EXISTS `templateRegionProperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templateRegionProperties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idRegions` bigint(20) unsigned NOT NULL,
  `order` int(10) DEFAULT NULL,
  `collapsable` tinyint(1) DEFAULT NULL,
  `isCollapsed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `templateRegionProperties_ibfk_1` (`idTemplates`),
  CONSTRAINT `templateRegionProperties_ibfk_1` FOREIGN KEY (`idTemplates`) REFERENCES `templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateRegionProperties`
--

LOCK TABLES `templateRegionProperties` WRITE;
/*!40000 ALTER TABLE `templateRegionProperties` DISABLE KEYS */;
/*!40000 ALTER TABLE `templateRegionProperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templateTitles`
--

DROP TABLE IF EXISTS `templateTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templateTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `templateTitles_ibfk_1` (`idTemplates`),
  CONSTRAINT `templateTitles_ibfk_1` FOREIGN KEY (`idTemplates`) REFERENCES `templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateTitles`
--

LOCK TABLES `templateTitles` WRITE;
/*!40000 ALTER TABLE `templateTitles` DISABLE KEYS */;
INSERT INTO `templateTitles` VALUES (1,1,1,'Template News'),(2,2,1,'Startseite'),(3,3,1,'Portal Startseite'),(4,4,1,'Übersicht'),(5,5,1,'Template Video'),(6,6,1,'Template Text'),(7,7,1,'Veranstaltung'),(8,8,1,'Übersicht Veranstaltung'),(9,9,1,'Prozess'),(10,10,1,'Kollektion'),(11,13,1,'Produktbaum');
/*!40000 ALTER TABLE `templateTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templateTypes`
--

DROP TABLE IF EXISTS `templateTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templateTypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idTypes` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateTypes`
--

LOCK TABLES `templateTypes` WRITE;
/*!40000 ALTER TABLE `templateTypes` DISABLE KEYS */;
INSERT INTO `templateTypes` VALUES (2,1,2),(3,2,1),(5,4,3),(6,3,4),(7,5,2),(8,6,2),(9,7,2),(10,8,3),(11,10,5),(12,11,6),(13,12,6),(14,13,7);
/*!40000 ALTER TABLE `templateTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `genericFormId` varchar(32) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` VALUES (1,'DEFAULT_PAGE_1','template_1.php','template_01.jpg',1),(2,'DEFAULT_PAGE_1','template_1.php','template_01.jpg',1),(3,'DEFAULT_STARTPAGE','template_startpage.php','template_startpage.jpg',1),(4,'DEFAULT_OVERVIEW','template_overview.php','template_overview.jpg',1),(5,'DEFAULT_PAGE_1','template_video.php','template_video.jpg',0),(6,'DEFAULT_PAGE_1','template_text.php','template_text.jpg',0),(7,'DEFAULT_EVENT','template_event.php','template_event-detail.jpg',0),(8,'DEFAULT_EVENT_OVERVIEW','template_event_overview.php','template_event-overview.jpg',0),(9,'DEFAULT_PROCESS','template_process.php','template_process.jpg',1),(10,'DEFAULT_COLLECTION','template_collection.php','template_collection.jpg',1),(11,'DEFAULT_PRODUCT','template_product.php','template_product.jpg',1),(12,'DEFAULT_PRODUCT_OVERVIEW','template_product_overview.php','template_product_overview.jpg',1),(13,'DEFAULT_PRODUCT_TREE','template_product_tree.php','template_product_tree.jpg',1);
/*!40000 ALTER TABLE `templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `themes`
--

DROP TABLE IF EXISTS `themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `themes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `themes`
--

LOCK TABLES `themes` WRITE;
/*!40000 ALTER TABLE `themes` DISABLE KEYS */;
INSERT INTO `themes` VALUES (1,'Default','default',2,2,'2009-05-07 07:18:38','2009-05-07 06:48:35'),(2,'Ivoclarvivadent','ivoclarvivadent',2,2,'2009-12-08 14:19:02','2009-12-08 14:19:02');
/*!40000 ALTER TABLE `themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'startpage'),(2,'page'),(3,'overview'),(4,'portal_startpage'),(5,'collection'),(6,'product'),(7,'product_tree');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitTitles`
--

DROP TABLE IF EXISTS `unitTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitTitles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idUnits` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idUnits` (`idUnits`),
  CONSTRAINT `unitTitles_ibfk_1` FOREIGN KEY (`idUnits`) REFERENCES `units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitTitles`
--

LOCK TABLES `unitTitles` WRITE;
/*!40000 ALTER TABLE `unitTitles` DISABLE KEYS */;
INSERT INTO `unitTitles` VALUES (1,1,1,'Massive Art'),(2,2,1,'Ivoclar Vivadent Schaan'),(3,3,1,'Ivoclar Vivadent Italien'),(4,4,1,'Course Trainers'),(5,5,1,'Sales'),(6,6,1,'Distributors');
/*!40000 ALTER TABLE `unitTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idParentUnit` bigint(20) unsigned NOT NULL DEFAULT '0',
  `idRootUnit` bigint(20) unsigned DEFAULT NULL,
  `lft` int(10) unsigned DEFAULT NULL,
  `rgt` int(10) unsigned DEFAULT NULL,
  `depth` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`),
  KEY `idRootCategory` (`idRootUnit`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,9,0,1,1,2,0),(2,9,0,2,1,2,0),(3,9,0,3,1,2,0),(4,9,0,4,1,2,0),(5,9,0,5,1,2,0),(6,9,0,6,1,2,0);
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urlTypes`
--

DROP TABLE IF EXISTS `urlTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urlTypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urlTypes`
--

LOCK TABLES `urlTypes` WRITE;
/*!40000 ALTER TABLE `urlTypes` DISABLE KEYS */;
INSERT INTO `urlTypes` VALUES (1,'pages'),(2,'products');
/*!40000 ALTER TABLE `urlTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urls`
--

DROP TABLE IF EXISTS `urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `relationId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idUrlTypes` int(10) unsigned NOT NULL DEFAULT '1',
  `isMain` tinyint(1) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `idParent` bigint(20) unsigned DEFAULT NULL,
  `idParentTypes` int(10) unsigned DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `relationId` (`relationId`,`version`,`idUrlTypes`,`idLanguages`),
  KEY `relationId_2` (`relationId`),
  KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urls`
--

LOCK TABLES `urls` WRITE;
/*!40000 ALTER TABLE `urls` DISABLE KEYS */;
INSERT INTO `urls` VALUES (1,'4b4d8dc9a138f',1,1,1,1,NULL,NULL,'',3,3,'2010-01-18 12:57:06','2010-01-18 12:57:06'),(2,'4b4da15087430',1,1,0,1,NULL,NULL,'dental-professional/',3,3,'2010-01-18 12:57:10','2010-01-21 14:21:23'),(3,'4b4da26279384',1,1,0,1,NULL,NULL,'laboratory-professional/',3,3,'2010-01-18 12:57:13','2010-01-21 14:21:11'),(4,'4b4da2f3f290d',1,1,0,1,NULL,NULL,'alle-produkte/',3,3,'2010-01-18 12:57:16','2010-01-21 14:21:33'),(7,'4b4da3e1c4291',1,1,1,1,NULL,NULL,'unternehmen/',3,3,'2010-01-18 12:57:43','2010-01-18 12:57:43'),(8,'4b4da6aa1ac18',1,1,1,1,NULL,NULL,'unternehmen/passion-x-vision-x-innovation/',3,3,'2010-01-18 12:57:43','2010-01-18 12:57:43'),(9,'4b4da6bdeafc1',1,1,1,1,NULL,NULL,'unternehmen/geschichte/',3,3,'2010-01-18 12:57:58','2010-01-18 12:57:58'),(10,'4b4da6c8b5347',1,1,1,1,NULL,NULL,'unternehmen/zahlen-und-fakten/',3,3,'2010-01-18 12:58:02','2010-01-18 12:58:02'),(11,'4b4da6d5688cb',1,1,1,1,NULL,NULL,'unternehmen/management/',3,3,'2010-01-18 12:58:07','2010-01-18 12:58:07'),(12,'4b4dc2ac5fba0',1,1,1,1,NULL,NULL,'unternehmen/einkaufsbedingungen',3,3,'2010-01-18 13:01:47','2010-01-18 13:01:47'),(13,'4b4dc2ccb3e8d',1,1,1,1,NULL,NULL,'unternehmen/jobs/',3,3,'2010-01-18 13:01:50','2010-01-18 13:01:50'),(14,'4b4dc303af218',1,1,1,1,NULL,NULL,'unternehmen/jobs/hr-spezialist-mit-it-flair-_50--60__-m_w_---4_208',3,3,'2010-01-18 13:01:54','2010-01-18 13:01:54'),(15,'4b4dc31a83c14',1,1,1,1,NULL,NULL,'unternehmen/jobs/it-software-developer-_m_w_-100__---1_048',3,3,'2010-01-18 13:01:57','2010-01-18 13:01:57'),(16,'4b4dc70098b2a',1,1,1,1,NULL,NULL,'unternehmen/jobs/marketing-assistenz-cbe-_100__-m_w_-4_206',3,3,'2010-01-18 13:02:00','2010-01-18 13:02:00'),(17,'4b4da3ee0b54d',1,1,1,1,NULL,NULL,'presse/',3,3,'2010-01-18 13:02:04','2010-01-18 13:02:04'),(18,'4b4f351e0300e',1,1,1,1,NULL,NULL,'presse/test-thomas',3,3,'2010-01-18 13:02:09','2010-01-18 13:02:09'),(19,'4b4da40da918b',1,1,1,1,NULL,NULL,'karriere/',3,3,'2010-01-18 13:02:14','2010-01-18 13:02:14'),(20,'4b4da41b05a85',1,1,1,1,NULL,NULL,'support/',3,3,'2010-01-18 13:02:18','2010-01-18 13:02:18'),(21,'4b4da430b62f8',1,1,1,1,NULL,NULL,'kontakt/',3,3,'2010-01-18 13:02:21','2010-01-18 13:02:21'),(22,'4b4d8dc9a138f',1,1,1,2,NULL,NULL,'',3,3,'2010-01-18 13:02:29','2010-01-18 13:02:29'),(23,'4b4d8dc9a138f',1,1,1,3,NULL,NULL,'',3,3,'2010-01-18 13:02:33','2010-01-18 13:02:33'),(24,'4b4d8dc9a138f',1,1,1,4,NULL,NULL,'',3,3,'2010-01-18 13:02:36','2010-01-18 13:02:36'),(25,'4b4d8dc9a138f',1,1,1,5,NULL,NULL,'',3,3,'2010-01-18 13:02:43','2010-01-18 13:02:43'),(26,'4b55844696ca3',1,1,1,1,NULL,NULL,'kontakt',3,3,'2010-01-19 10:07:02','2010-01-19 10:07:02'),(27,'4b55857146c18',1,1,1,1,NULL,NULL,'kontakt/',3,3,'2010-01-19 10:12:01','2010-01-19 10:12:01'),(28,'4b558b4271b8e',1,1,1,1,NULL,NULL,'impressum',3,3,'2010-01-19 10:36:50','2010-01-19 10:36:50'),(29,'4b558b613f159',1,1,1,1,NULL,NULL,'sitemap',3,3,'2010-01-19 10:37:21','2010-01-19 10:37:21'),(33,'4b585c59516f4',1,2,1,1,NULL,NULL,'',3,3,'2010-01-21 14:12:00','2010-01-21 14:12:00'),(34,'4b5860d19b7e6',1,2,0,1,NULL,NULL,'produkte/',3,3,'2010-01-21 14:12:33','2010-01-21 14:13:40'),(35,'4b5860df86e03',1,2,1,1,NULL,NULL,'kompetenzen/',3,3,'2010-01-21 14:12:47','2010-01-21 14:12:47'),(36,'4b5860fc1014c',1,2,0,1,NULL,NULL,'produkte/zaehne/',3,3,'2010-01-21 14:13:16','2010-01-21 14:13:40'),(37,'4b5860d19b7e6',1,2,1,1,NULL,NULL,'p/',3,3,'2010-01-21 14:13:40','2010-01-21 14:13:40'),(38,'4b5860fc1014c',1,2,0,1,NULL,NULL,'p/zaehne/',3,3,'2010-01-21 14:13:40','2010-02-08 16:11:58'),(39,'4b58612ac2a1f',1,2,0,1,NULL,NULL,'p/zaehne/zahnzubehoer/',3,3,'2010-01-21 14:14:02','2010-02-08 16:11:58'),(40,'4b58613c42670',1,2,0,1,NULL,NULL,'p/zaehne/zahnzubehoer/sr-phonares-formselector',3,3,'2010-01-21 14:14:20','2010-02-08 16:11:58'),(41,'4b58614f4a383',1,2,0,1,NULL,NULL,'p/zaehne/zahnzubehoer/zahnschrank-z4',3,3,'2010-01-21 14:14:39','2010-02-08 16:11:58'),(42,'4b586165dcf1b',1,2,0,1,NULL,NULL,'p/zaehne/zahnzubehoer/zahnschrank-z6',3,3,'2010-01-21 14:15:01','2010-02-08 16:11:58'),(43,'4b586179c46b1',1,2,0,1,NULL,NULL,'p/zaehne/zahnzubehoer/zahnschrank-z12',3,3,'2010-01-21 14:15:21','2010-02-08 16:11:58'),(44,'4b58618e79dd2',1,2,0,1,NULL,NULL,'p/zaehne/zahnzubehoer/sr-phonares-zahnschrank',3,3,'2010-01-21 14:15:42','2010-02-08 16:11:58'),(45,'4b58619f4fcb2',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/',3,3,'2010-01-21 14:15:59','2010-01-21 14:15:59'),(46,'4b5861aa08015',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/composites/',3,3,'2010-01-21 14:16:10','2010-01-21 14:16:10'),(47,'4b5861b98b94e',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/compomere/',3,3,'2010-01-21 14:16:25','2010-01-21 14:16:25'),(48,'4b5861c7e0b3f',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/amalgame/',3,3,'2010-01-21 14:16:39','2010-01-21 14:16:39'),(50,'4b5861d9d6fe2',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/amalgame/amalcap-plus',3,3,'2010-01-21 14:17:27','2010-01-21 14:17:27'),(51,'4b58620d2c296',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/amalgame/vivacap',3,3,'2010-01-21 14:17:49','2010-01-21 14:17:49'),(52,'4b58622406b7c',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/amalgame/world-cap',3,3,'2010-01-21 14:18:12','2010-01-21 14:18:12'),(53,'4b58623864aca',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/composites/ips-empress-direct',3,3,'2010-01-21 14:18:32','2010-01-21 14:18:32'),(54,'4b586245918e2',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/composites/tetric-evoceram',3,3,'2010-01-21 14:18:45','2010-01-21 14:18:45'),(55,'4b586253b2f3f',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/composites/tetric-evoflow',3,3,'2010-01-21 14:18:59','2010-01-21 14:18:59'),(56,'4b586260653d3',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/composites/tetric',3,3,'2010-01-21 14:19:12','2010-01-21 14:19:12'),(57,'4b4da26279384',1,1,1,1,NULL,NULL,'lp/',3,3,'2010-01-21 14:21:11','2010-01-21 14:21:11'),(59,'4b4da2f3f290d',1,1,1,1,NULL,NULL,'all/',3,3,'2010-01-21 14:21:33','2010-01-21 14:21:33'),(60,'4b5db8df53e32',1,1,1,1,NULL,NULL,'dp/test-seite-thomas',3,3,'2010-01-25 15:29:35','2010-01-25 15:29:35'),(62,'4b4da15087430',1,1,1,1,NULL,NULL,'dp/',3,3,'2010-02-01 13:43:27','2010-02-01 13:43:27'),(63,'4b4da40da918b',1,1,1,2,NULL,NULL,'career/',3,3,'2010-02-01 13:58:50','2010-02-01 13:58:50'),(64,'4b4da3ee0b54d',1,1,1,2,NULL,NULL,'press/',3,3,'2010-02-01 13:58:59','2010-02-01 13:58:59'),(65,'4b4da3e1c4291',1,1,1,2,NULL,NULL,'company/',3,3,'2010-02-01 13:59:05','2010-02-01 13:59:05'),(66,'4b4da2f3f290d',1,1,0,2,NULL,NULL,'all-products/',3,3,'2010-02-01 13:59:12','2010-02-02 15:40:12'),(67,'4b4da26279384',1,1,0,2,NULL,NULL,'laboratory-professional/',3,3,'2010-02-01 13:59:24','2010-02-02 15:39:55'),(68,'4b4da15087430',1,1,0,2,NULL,NULL,'dental-professional/',3,3,'2010-02-01 13:59:32','2010-02-02 15:39:20'),(69,'4b558b613f159',1,1,1,2,NULL,NULL,'sitemap',3,3,'2010-02-01 13:59:59','2010-02-01 13:59:59'),(70,'4b558b4271b8e',1,1,1,2,NULL,NULL,'imprint',3,3,'2010-02-01 14:00:28','2010-02-01 14:00:28'),(71,'4b4da41b05a85',1,1,1,2,NULL,NULL,'support/',3,3,'2010-02-01 14:01:13','2010-02-01 14:01:13'),(72,'4b55857146c18',1,1,1,2,NULL,NULL,'contact/',3,3,'2010-02-01 14:01:21','2010-02-01 14:01:21'),(73,'4b682560af736',1,2,1,1,NULL,NULL,'p/fuellungsmaterialie/zahnschrank-z4',3,3,'2010-02-02 13:15:17','2010-02-02 13:15:17'),(74,'4b5860d19b7e6',1,2,0,2,NULL,NULL,'products/',3,3,'2010-02-02 15:29:27','2010-02-02 15:29:33'),(75,'4b5860d19b7e6',1,2,1,2,NULL,NULL,'p/',3,3,'2010-02-02 15:29:33','2010-02-02 15:29:33'),(77,'4b5860fc1014c',1,2,1,2,NULL,NULL,'p/teeths/',3,3,'2010-02-02 15:33:11','2010-02-02 15:33:11'),(78,'4b4da15087430',1,1,1,2,NULL,NULL,'dp/',3,3,'2010-02-02 15:39:20','2010-02-02 15:39:20'),(79,'4b4da26279384',1,1,1,2,NULL,NULL,'lp/',3,3,'2010-02-02 15:39:55','2010-02-02 15:39:55'),(80,'4b4da2f3f290d',1,1,1,2,NULL,NULL,'all/',3,3,'2010-02-02 15:40:12','2010-02-02 15:40:12'),(81,'4b6987a31e8e0',1,1,1,1,NULL,NULL,'test/',3,3,'2010-02-03 14:26:43','2010-02-03 14:26:43'),(82,'4b58612ac2a1f',1,2,1,2,NULL,NULL,'p/teeths/teeth-accessory/',3,3,'2010-02-03 15:27:56','2010-02-03 15:27:56'),(83,'4b6aa33ee46b0',1,2,0,1,NULL,NULL,'p/zaehne/vivoperl-pe---frontzaehne',3,3,'2010-02-04 10:36:47','2010-02-08 16:11:58'),(84,'4b6aa35212a88',1,2,0,1,NULL,NULL,'p/zaehne/vivoperl-pe---orthotyp',3,3,'2010-02-04 10:37:06','2010-02-08 16:11:58'),(85,'4b6fc9a136867',1,2,0,1,NULL,NULL,'p/zaehne/zahnzubehoer/zahnschrank/',3,3,'2010-02-08 08:21:53','2010-02-08 16:11:58'),(86,'4b5860fc1014c',1,2,1,1,NULL,NULL,'p/z/',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(87,'4b58612ac2a1f',1,2,1,1,NULL,NULL,'p/z/zahnzubehoer/',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(88,'4b58613c42670',1,2,1,1,NULL,NULL,'p/z/zahnzubehoer/sr-phonares-formselector',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(89,'4b58614f4a383',1,2,1,1,NULL,NULL,'p/z/zahnzubehoer/zahnschrank-z4',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(90,'4b586165dcf1b',1,2,1,1,NULL,NULL,'p/z/zahnzubehoer/zahnschrank-z6',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(91,'4b586179c46b1',1,2,1,1,NULL,NULL,'p/z/zahnzubehoer/zahnschrank-z12',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(92,'4b58618e79dd2',1,2,1,1,NULL,NULL,'p/z/zahnzubehoer/sr-phonares-zahnschrank',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(93,'4b6aa33ee46b0',1,2,1,1,NULL,NULL,'p/z/vivoperl-pe---frontzaehne',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(94,'4b6aa35212a88',1,2,1,1,NULL,NULL,'p/z/vivoperl-pe---orthotyp',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(95,'4b6fc9a136867',1,2,1,1,NULL,NULL,'p/z/zahnzubehoer/zahnschrank/',3,3,'2010-02-08 16:11:58','2010-02-08 16:11:58'),(97,'4b5860fc1014c',1,2,1,4,NULL,NULL,'zaehne/',3,3,'2010-02-09 08:22:15','2010-02-09 08:22:15'),(98,'4b58612ac2a1f',1,2,1,4,NULL,NULL,'zaehne/zahnzubehoer/',3,3,'2010-02-09 08:22:52','2010-02-09 08:22:52'),(99,'4b6aa33ee46b0',1,2,1,2,NULL,NULL,'p/teeths/vivoperl-pe',3,3,'2010-02-19 11:26:57','2010-02-19 11:26:57'),(100,'4b4f351e0300e',1,1,1,2,NULL,NULL,'press/test-thomas',3,3,'2010-02-22 08:19:41','2010-02-22 08:19:41');
/*!40000 ALTER TABLE `urls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userGroups`
--

DROP TABLE IF EXISTS `userGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userGroups` (
  `idUsers` bigint(20) NOT NULL,
  `idGroups` bigint(20) NOT NULL,
  PRIMARY KEY (`idUsers`,`idGroups`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userGroups`
--

LOCK TABLES `userGroups` WRITE;
/*!40000 ALTER TABLE `userGroups` DISABLE KEYS */;
INSERT INTO `userGroups` VALUES (0,1),(1,1),(1,2),(1,3),(2,1),(2,2),(2,5),(3,1),(3,2),(3,5),(5,1),(5,3),(6,1),(11,1),(12,2),(12,3),(13,3),(13,5),(14,2),(14,5),(15,3),(16,3),(17,3),(18,5),(19,2),(19,3),(20,1),(20,2),(20,3),(20,4),(20,5),(20,6),(20,7);
/*!40000 ALTER TABLE `userGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userProfiles`
--

DROP TABLE IF EXISTS `userProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userProfiles` (
  `id` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userProfiles`
--

LOCK TABLES `userProfiles` WRITE;
/*!40000 ALTER TABLE `userProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `userProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idLanguages` int(10) unsigned NOT NULL DEFAULT '1',
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `sname` varchar(255) NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `created` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'rainer','163732f752aeeccdbb9630c04fe08e14','Rainer','Schönherr',3,3,'2009-10-07 09:41:35','2009-10-21 09:32:25'),(2,1,'conny','3af31637b5328eb0e6a050e23a064681','Cornelius','Hansjakob',1,2,NULL,'2009-11-06 14:43:58'),(3,1,'thomas','090c25cfa555e7685a14d33b1d0f52a1','Thomas','Schedler',2,3,NULL,'2009-10-23 06:35:27'),(4,1,'berndhep','01c2310a3cc00933589d3e2f694343d8','Bernd','Hepberger',3,3,NULL,'2009-12-16 08:12:10'),(5,1,'kate','29ddc288099264c17b07baf44d3f0adc','Kate','Dobler',3,3,NULL,'2009-12-16 08:16:22'),(19,1,'max.mustermann','548eee09b1d8f1bd292433f911abe23a','Max','Mustermann',3,3,'2009-11-09 15:46:24','2009-11-09 15:46:24'),(20,1,'mtr','c8e12b9eac80da5a7c0d282276908ff5','Michael','Trawetzky',3,3,'2009-11-18 14:51:47','2009-12-08 14:39:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validators`
--

DROP TABLE IF EXISTS `validators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validators`
--

LOCK TABLES `validators` WRITE;
/*!40000 ALTER TABLE `validators` DISABLE KEYS */;
INSERT INTO `validators` VALUES (1,'Alnum'),(2,'Alpha'),(3,'Barcode'),(4,'Between'),(5,'Ccnum'),(6,'Date'),(7,'Digits'),(8,'EmailAddress'),(9,'Float'),(10,'GreaterThan'),(11,'Hex'),(12,'Hostname'),(13,'InArray'),(14,'Int'),(15,'Ip'),(16,'LessThan'),(17,'NotEmpty'),(18,'Regex'),(19,'StringLength');
/*!40000 ALTER TABLE `validators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videoTypes`
--

DROP TABLE IF EXISTS `videoTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `videoTypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videoTypes`
--

LOCK TABLES `videoTypes` WRITE;
/*!40000 ALTER TABLE `videoTypes` DISABLE KEYS */;
INSERT INTO `videoTypes` VALUES (1,'Vimeo'),(2,'Youtube');
/*!40000 ALTER TABLE `videoTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualFolderTypes`
--

DROP TABLE IF EXISTS `virtualFolderTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualFolderTypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualFolderTypes`
--

LOCK TABLES `virtualFolderTypes` WRITE;
/*!40000 ALTER TABLE `virtualFolderTypes` DISABLE KEYS */;
INSERT INTO `virtualFolderTypes` VALUES (1,'shallow'),(2,'deep');
/*!40000 ALTER TABLE `virtualFolderTypes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-02-28  9:36:46
