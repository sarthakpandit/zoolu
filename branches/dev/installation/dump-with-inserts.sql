-- MySQL dump 10.11
--
-- Host: localhost    Database: zoolu
-- ------------------------------------------------------
-- Server version	5.0.88

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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idParentCategory` bigint(20) unsigned NOT NULL default '0',
  `idRootCategory` bigint(20) unsigned default NULL,
  `idCategoryTypes` bigint(20) unsigned NOT NULL,
  `matchCode` varchar(255) default NULL,
  `lft` int(10) unsigned default NULL,
  `rgt` int(10) unsigned default NULL,
  `depth` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`),
  KEY `idRootCategory` (`idRootCategory`),
  KEY `idParentCategory` (`idParentCategory`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,0,1,1,NULL,1,14,0),(11,0,11,2,NULL,1,20,0),(12,11,11,2,NULL,2,13,1),(13,11,11,2,NULL,14,19,1),(14,13,11,2,'DESC',15,16,2),(15,13,11,2,'ASC',17,18,2),(16,12,11,2,'alpha',3,4,2),(17,12,11,2,'sort',5,6,2),(18,12,11,2,'created',7,8,2),(19,12,11,2,'changed',9,10,2),(21,0,21,3,NULL,1,8,0),(27,0,27,2,NULL,1,14,0),(28,27,27,2,'col-1',2,3,1),(29,27,27,2,'col-1-img',4,5,1),(30,27,27,2,'col-2',6,7,1),(31,27,27,2,'col-2-img',8,9,1),(35,27,27,2,'list',10,11,1),(36,27,27,2,'list-img',12,13,1),(40,12,11,2,'published',11,12,2),(42,0,42,2,NULL,1,4,0),(43,42,42,2,'similar_pages',2,3,1),(48,0,48,2,NULL,1,10,0),(49,48,48,2,NULL,2,9,1),(50,49,48,2,NULL,3,4,2),(51,49,48,2,NULL,5,6,2),(52,49,48,2,NULL,7,8,2),(53,1,1,1,NULL,6,7,1),(54,1,1,1,NULL,8,9,1),(55,1,1,1,NULL,10,11,1),(56,21,21,3,NULL,2,3,1),(60,21,21,3,NULL,4,5,1),(63,21,21,3,NULL,6,7,1),(64,0,64,2,NULL,1,6,0),(65,64,64,2,NULL,2,3,1),(66,64,64,2,NULL,4,5,1),(67,1,1,1,NULL,12,13,1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoryTitles`
--

DROP TABLE IF EXISTS `categoryTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoryTitles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idCategories` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(500) default NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `idCategories` (`idCategories`),
  CONSTRAINT `categoryTitles_ibfk_1` FOREIGN KEY (`idCategories`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoryTitles`
--

LOCK TABLES `categoryTitles` WRITE;
/*!40000 ALTER TABLE `categoryTitles` DISABLE KEYS */;
INSERT INTO `categoryTitles` VALUES (1,1,1,'Seiten Kategorien',0,'0000-00-00 00:00:00'),(11,11,1,'Sortierung',0,'0000-00-00 00:00:00'),(12,12,1,'Sortierarten',0,'0000-00-00 00:00:00'),(13,13,1,'Reihenfolge',0,'0000-00-00 00:00:00'),(14,14,1,'absteigend',0,'0000-00-00 00:00:00'),(15,15,1,'aufsteigend',0,'0000-00-00 00:00:00'),(16,16,1,'Alphabet',0,'0000-00-00 00:00:00'),(17,17,1,'Sortierung',0,'0000-00-00 00:00:00'),(18,18,1,'Erstelldatum',0,'0000-00-00 00:00:00'),(19,19,1,'Änderungsdatum',0,'0000-00-00 00:00:00'),(21,21,1,'Seiten Etiketten',0,'0000-00-00 00:00:00'),(27,27,1,'Darstellungsformen',0,'0000-00-00 00:00:00'),(28,28,1,'1-spaltig ohne Bilder',0,'0000-00-00 00:00:00'),(29,29,1,'1-spaltig mit Bilder',0,'0000-00-00 00:00:00'),(30,30,1,'2-spaltig ohne Bilder',0,'0000-00-00 00:00:00'),(31,31,1,'2-spaltig mit Bilder',0,'0000-00-00 00:00:00'),(35,35,1,'Liste ohne Bilder',0,'0000-00-00 00:00:00'),(36,36,1,'Liste mit Bilder',0,'0000-00-00 00:00:00'),(40,40,1,'Veröffentlichungsdatum',0,'0000-00-00 00:00:00'),(42,42,1,'Darstellungsoptionen',0,'0000-00-00 00:00:00'),(43,43,1,'Ähnliche Seiten anzeigen',0,'0000-00-00 00:00:00'),(48,48,1,'Status',0,'0000-00-00 00:00:00'),(49,49,1,'Veranstaltung',0,'0000-00-00 00:00:00'),(50,50,1,'Anmeldung offen',0,'0000-00-00 00:00:00'),(51,51,1,'Wenige Restplätze',0,'0000-00-00 00:00:00'),(52,52,1,'Ausgebucht',0,'0000-00-00 00:00:00'),(53,53,1,'Top Product',1,'2009-11-11 11:04:18'),(54,54,1,'Current Video',1,'2009-11-11 11:04:56'),(55,55,1,'Jobs',1,'2009-11-11 11:05:16'),(56,56,1,'Startseite',1,'2009-11-11 11:17:29'),(59,54,2,'Test EN 2',0,'0000-00-00 00:00:00'),(60,55,2,'Test EN 3',0,'0000-00-00 00:00:00'),(61,53,2,'Test EN 1',3,'2009-06-09 17:07:59'),(62,53,2,'Test EN 1',3,'2009-06-09 17:07:59'),(63,56,2,'Test 1 EN',0,'0000-00-00 00:00:00'),(73,60,1,'Priority 1',1,'2009-11-11 11:17:43'),(76,63,1,'Priority 2',1,'2009-11-11 11:17:50'),(77,63,2,'Test 3 EN',3,'2009-06-09 09:07:52'),(78,60,2,'Test 2 EN',3,'2009-06-09 09:08:59'),(79,64,1,'Sub-Navigations-Seiten',3,'2009-06-23 08:27:54'),(80,65,1,'nicht miteinbeziehen',3,'2009-06-23 08:28:09'),(81,66,1,'miteinbeziehen',3,'2009-06-23 08:28:34'),(82,67,1,'Press',1,'2009-11-11 11:05:42');
/*!40000 ALTER TABLE `categoryTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoryTypes`
--

DROP TABLE IF EXISTS `categoryTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoryTypes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idContacts` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idContacts` bigint(20) unsigned NOT NULL,
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idContacts` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `creator` bigint(20) unsigned NOT NULL,
  `idUnits` bigint(20) unsigned NOT NULL,
  `salutation` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `fname` varchar(255) NOT NULL,
  `sname` varchar(255) NOT NULL,
  `position` varchar(255) default NULL,
  `phone` varchar(128) default NULL,
  `mobile` varchar(128) default NULL,
  `fax` varchar(128) default NULL,
  `email` varchar(128) default NULL,
  `website` varchar(128) default NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFields` bigint(20) unsigned NOT NULL,
  `idPermissions` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFields` bigint(20) unsigned NOT NULL,
  `idProperties` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFields` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(500) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `idFields` (`idFields`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldTitles`
--

LOCK TABLES `fieldTitles` WRITE;
/*!40000 ALTER TABLE `fieldTitles` DISABLE KEYS */;
INSERT INTO `fieldTitles` VALUES (1,1,1,'Titel',NULL),(2,2,1,'Beschreibung',NULL),(3,3,1,'Titel',NULL),(4,4,1,'Überschrift für den Artikel',NULL),(5,11,1,'Aktuelles Template',NULL),(6,5,1,NULL,NULL),(7,7,1,NULL,''),(8,8,1,NULL,NULL),(9,12,1,'Multiselect Test',NULL),(11,15,1,'Radiobuttons',NULL),(12,16,1,'Checkboxes',NULL),(13,17,1,'Titel',NULL),(14,20,1,'Titel',NULL),(15,21,1,'Tags',NULL),(16,22,1,'Kategorien',NULL),(17,24,1,'Embed Code',NULL),(18,23,1,'Titel',NULL),(19,25,1,'Titel',NULL),(20,26,1,'Titel',NULL),(21,28,1,'Verlinkte Seite',NULL),(22,30,1,'Titel',NULL),(23,31,1,'Anzahl',NULL),(26,37,1,'Titel',NULL),(29,34,1,'Nur Seiten mit Kategorie',NULL),(30,41,1,'Anzahl',NULL),(31,42,1,'Nur Seiten mit Kategorie',NULL),(32,43,1,'Titel',NULL),(33,47,1,'Sortierung nach',NULL),(34,48,1,'Reihenfolge',NULL),(35,49,1,'Sortierung nach',NULL),(36,50,1,'Reihenfolge',NULL),(37,51,1,'Sortierung nach',NULL),(38,52,1,'Reihenfolge',NULL),(39,44,1,'Anzahl',NULL),(40,45,1,'Navigationspunkt',NULL),(41,46,1,'Titel',NULL),(42,53,1,'Nur Seiten mit Kategorie',NULL),(43,54,1,'Video Service',NULL),(44,10,1,'Kurzbeschreibung des Artikels',NULL),(45,56,1,'Eigene Etiketten',NULL),(47,59,1,'Darstellungsform',NULL),(49,60,1,'Nur Seiten mit Etikett',NULL),(50,61,1,'Nur Seiten mit Etikett',NULL),(51,62,1,'Nur Seiten mit Etikett',NULL),(53,64,1,'Darstellungsoptionen',NULL),(54,65,1,'Vorname',NULL),(55,66,1,'Nachname',NULL),(56,67,1,'Datum, Zeit (Format: dd.mm.yyyy hh:mm)',NULL),(57,68,1,'Dauer (z.B.: 90 Minuten)',NULL),(58,69,1,'Strasse',NULL),(59,70,1,'Hausnummer',NULL),(60,71,1,'Postleitzahl',NULL),(61,72,1,'Ort',NULL),(62,73,1,'Schauplatz',NULL),(63,74,1,'Max. Teilnehmeranzahl',NULL),(64,75,1,'Kosten (in EUR)',NULL),(65,76,1,'Anrede',NULL),(66,77,1,'Titel',NULL),(67,78,1,'Funktion / Position',NULL),(68,79,1,'Telefon',NULL),(69,80,1,'Mobil',NULL),(70,81,1,'Fax ',NULL),(71,82,1,'E-Mail',NULL),(72,83,1,'Internet URL',NULL),(73,84,1,'Kontaktbilder',NULL),(74,85,1,'Vortragende',NULL),(75,86,1,'Kontakt',NULL),(76,87,1,'Veranstaltungsstatus',NULL),(77,90,1,'Titel',NULL),(78,91,1,'Headerbild',NULL),(79,92,1,'Embed Code',NULL),(80,93,1,'Url (z.B. http://www.getzoolu.com)',NULL),(81,94,1,'Titel',NULL),(82,95,1,'Sub-Navigations-Seiten',NULL),(83,97,1,'Titel',NULL),(84,98,1,'Beschreibung',NULL),(85,99,1,'Beschreibung',NULL),(86,100,1,'Abteilung',NULL),(87,101,1,'Stelle',NULL),(88,102,1,'Inhaltiche Verantwortung',NULL),(89,103,1,'Organisatorische Verantwortung',NULL),(90,104,1,'Aktivität',NULL),(91,105,1,'Beschreibung',NULL),(92,107,1,'Wer?',NULL),(93,110,1,'Beschreibung / Ursache',NULL),(94,111,1,'Titel',NULL),(95,113,1,'Präventive und korrektive Maßnahme',NULL),(96,112,1,'Beschreibung',NULL),(97,119,1,'Titel',NULL),(98,121,1,'Titel',NULL),(99,124,1,'Titel',NULL),(100,125,1,'Url (z.B. http://www.getzoolu.org)',NULL),(101,130,1,'Produktbaum',NULL),(102,131,1,'Nur Produkte mit Kategorie',NULL),(103,132,1,'Nur Produkte mit Etikett',NULL);
/*!40000 ALTER TABLE `fieldTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldTypeGroups`
--

DROP TABLE IF EXISTS `fieldTypeGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldTypeGroups` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) character set latin1 NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idDecorator` bigint(20) unsigned NOT NULL,
  `sqlType` varchar(30) NOT NULL,
  `size` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `defaultValue` varchar(255) NOT NULL,
  `idFieldTypeGroup` int(10) unsigned NOT NULL default '5',
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFields` bigint(20) unsigned NOT NULL,
  `idValidators` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFieldTypes` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `idSearchFieldTypes` int(10) NOT NULL default '1',
  `idRelationPage` bigint(20) unsigned default NULL,
  `idCategory` bigint(20) unsigned default NULL,
  `sqlSelect` varchar(2000) default NULL,
  `columns` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL default '0',
  `isCoreField` tinyint(1) NOT NULL default '0',
  `isKeyField` tinyint(1) NOT NULL default '0',
  `isSaveField` tinyint(1) NOT NULL default '1',
  `isRegionTitle` tinyint(1) NOT NULL default '0',
  `isDependentOn` bigint(20) unsigned default NULL COMMENT 'must be an ID',
  `copyValue` tinyint(1) NOT NULL default '0' COMMENT 'decision if we addittionally write the value into the table (result: id and e.g. title in table)',
  PRIMARY KEY  (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0),(2,10,'description',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(3,1,'title',5,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0),(4,1,'articletitle',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(5,12,'mainpics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(6,10,'description',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(7,12,'pics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(8,13,'docs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(10,2,'shortdescription',5,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(11,11,'template',1,NULL,NULL,NULL,12,0,0,0,0,0,NULL,0),(17,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0),(18,12,'block_pics',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(19,10,'block_description',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(20,1,'block_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(21,16,'page_tags',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(22,17,'category',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, tbl.depth AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,1,0,1,0,NULL,0),(23,1,'video_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(24,2,'video_embed_code',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(25,1,'pics_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(26,1,'docs_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(27,18,'url',3,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(28,19,'internal_link',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(29,10,'sidebar_description',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(30,1,'sidebar_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(31,1,'entry_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0),(34,20,'entry_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(37,1,'entry_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(40,21,'title',5,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0),(41,1,'top_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0),(42,20,'top_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(43,1,'top_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(44,1,'entry_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0),(45,20,'entry_nav_point',1,NULL,NULL,'SELECT folders.id, folderTitles.title, folders.depth FROM folders INNER JOIN folderTitles ON folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = %LANGUAGE_ID% INNER JOIN rootLevels ON rootLevels.id = folders.idRootLevels INNER JOIN rootLevelTitles ON rootLevelTitles.idRootLevels = rootLevels.id WHERE folders.idRootLevels = %ROOTLEVEL_ID% ORDER BY folders.lft, folders.sortPosition ASC, folders.sortTimestamp DESC',4,0,0,0,1,0,NULL,0),(46,1,'entry_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(47,9,'entry_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(48,4,'entry_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(49,9,'top_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(50,4,'top_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(51,9,'entry_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(52,4,'entry_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(53,20,'entry_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(54,22,'video',1,NULL,NULL,'SELECT tbl.id AS id, tbl.title AS title FROM videoTypes AS tbl',12,0,0,0,1,0,NULL,0),(55,12,'pic_shortdescription',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(56,17,'label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, tbl.depth AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,1,0,1,0,NULL,0),(59,9,'entry_viewtype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 27 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(60,20,'entry_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(61,20,'top_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(62,20,'entry_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(64,3,'option',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 42 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,0,0,1,0,NULL,0),(65,1,'fname',1,NULL,NULL,NULL,6,0,1,1,1,0,NULL,0),(66,1,'sname',1,NULL,NULL,NULL,6,0,1,1,1,0,NULL,0),(67,1,'datetime',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(68,1,'event_duration',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(69,1,'event_street',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(70,1,'event_streetnr',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(71,1,'event_plz',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(72,1,'event_city',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(73,1,'event_location',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(74,1,'event_max_members',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(75,1,'event_costs',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(76,1,'salutation',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(77,1,'title',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(78,1,'position',1,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0),(79,1,'phone',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0),(80,1,'mobile',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0),(81,1,'fax',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0),(82,1,'email',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(83,1,'website',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(84,12,'pics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(85,24,'speakers',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(86,9,'contact',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',12,0,0,0,1,0,NULL,0),(87,9,'event_status',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 49 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',6,0,0,0,1,0,NULL,0),(88,12,'banner_pics',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(89,10,'banner_description',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(90,1,'banner_title',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(91,12,'headerpics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(92,2,'header_embed_code',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(93,1,'external',1,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0),(94,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0),(95,4,'entry_depth',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 64 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft %WHERE_ADDON% BETWEEN (rootCat.lft+1) AND rootCat.rgt ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(96,21,'title',5,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0),(97,1,'instruction_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(98,10,'instruction_description',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(99,1,'description',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(100,1,'department',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(101,1,'position',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(102,1,'content_responsible',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',6,0,0,0,1,0,NULL,0),(103,1,'organizational_responsible',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',6,0,0,0,1,0,NULL,0),(104,1,'steps_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(105,10,'steps_text',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(106,10,'shortdescription',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(107,1,'steps_who',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(108,12,'process_pic',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(109,10,'process_inputs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(110,10,'risk_description',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(111,1,'rule_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(112,10,'rule_text',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(113,10,'risk_measure',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(114,10,'process_output',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(115,10,'process_indicator',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(116,10,'process_instructions',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(117,10,'process_techniques',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(118,25,'gmaps',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(119,1,'internal_links_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(120,26,'internal_links',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(121,1,'collection_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(122,27,'collection',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(123,13,'block_docs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(124,1,'link_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(125,1,'link_url',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(126,12,'header_pics',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(127,10,'header_description',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(128,12,'sidebar_pics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(129,28,'docs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(130,20,'entry_product_point',1,NULL,NULL,'SELECT folders.id, folderTitles.title, folders.depth FROM folders INNER JOIN folderTitles ON folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = %LANGUAGE_ID% INNER JOIN rootLevels ON rootLevels.id = folders.idRootLevels INNER JOIN rootLevelTitles ON rootLevelTitles.idRootLevels = rootLevels.id WHERE folders.idRootLevels = 12 ORDER BY folders.lft, folders.sortPosition ASC, folders.sortTimestamp DESC',4,0,0,0,1,0,NULL,0),(131,20,'entry_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(132,20,'entry_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0);
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileAttributes`
--

DROP TABLE IF EXISTS `fileAttributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileAttributes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFiles` bigint(20) unsigned NOT NULL,
  `xDim` int(10) default NULL,
  `yDim` int(10) default NULL,
  PRIMARY KEY  (`id`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `fileAttributes_ibfk_1` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileAttributes`
--

LOCK TABLES `fileAttributes` WRITE;
/*!40000 ALTER TABLE `fileAttributes` DISABLE KEYS */;
INSERT INTO `fileAttributes` VALUES (32,20,400,300),(33,21,400,300),(34,22,400,300),(35,23,400,300),(36,24,400,300),(37,25,400,300),(38,26,400,300),(39,27,400,300),(40,28,250,200),(41,29,400,300),(42,30,250,200),(43,31,400,300),(44,32,400,300),(45,33,400,300),(46,34,400,300),(47,35,400,300),(48,36,400,300),(49,37,696,288),(51,39,1574,813),(54,42,677,280),(55,43,1024,768),(56,44,1024,768),(57,45,1024,768),(58,46,1920,1200),(59,47,NULL,NULL),(60,48,1024,768),(61,49,480,800),(62,50,1680,1050),(69,57,1024,768),(70,58,1280,1024);
/*!40000 ALTER TABLE `fileAttributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filePermissions`
--

DROP TABLE IF EXISTS `filePermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filePermissions` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idPermissions` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(500) default NULL,
  `description` text,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `fileTitles_ibfk_1` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileTitles`
--

LOCK TABLES `fileTitles` WRITE;
/*!40000 ALTER TABLE `fileTitles` DISABLE KEYS */;
INSERT INTO `fileTitles` VALUES (50,17,1,'vvo_luftspruenge','','2009-12-16 22:03:51'),(51,18,1,'Vorbereitung Herbst 2009','','2009-12-03 17:53:44'),(52,19,1,'Vorbereitung Herbst 2009','','2009-12-03 17:54:55'),(53,20,1,'ApexCal','','2009-12-09 10:35:16'),(54,21,1,'bluephase','','2009-12-09 10:35:16'),(55,22,1,'bluephase_20i','','2009-12-16 08:07:47'),(56,23,1,'bluephase_c8','','2009-12-09 10:35:16'),(57,24,1,'bluephase_meter','','2009-12-09 10:35:16'),(58,25,1,'e.max','','2009-12-09 10:35:16'),(59,26,1,'IPS AcrylCAD','','2009-12-09 10:35:16'),(60,27,1,'OptraGate','','2009-12-09 10:35:16'),(61,28,1,'Programat CS','','2009-12-09 10:35:16'),(62,29,1,'Proxyt','','2009-12-09 10:35:16'),(63,30,1,'Silamat S6','','2009-12-09 10:35:16'),(64,31,1,'speedCEM','','2009-12-15 18:40:47'),(65,32,1,'SR Ivocap High Impact','','2009-12-15 18:40:47'),(66,33,1,'systemp.cem','','2009-12-15 18:40:47'),(67,34,1,'tetric_evoceram','','2009-12-09 10:35:16'),(68,35,1,'Virtual380','','2009-12-09 10:35:16'),(69,36,1,'vivastyle','','2009-12-09 10:35:16'),(70,37,1,'header1','','2009-12-09 12:43:49'),(74,42,1,'header2','','2009-12-10 09:35:32'),(75,43,1,'84_45','','2009-12-14 15:37:58'),(76,44,1,'nature','','2009-12-14 16:02:05'),(77,45,1,'nature23','','2009-12-14 16:02:05'),(78,46,1,'Spirit_of_Vistas_by_Leviatan3','','2009-12-15 15:43:27'),(79,47,1,'The Lonely Path äö$ü§ß#*','','2009-12-15 15:43:55'),(80,48,1,'widewallpapers_eu_1206953132','','2009-12-15 15:52:33'),(81,49,1,'spider','','2009-12-15 15:54:51'),(82,50,1,'theoldfarmv41680x1050kq9','','2009-12-15 15:57:51'),(89,57,1,'84_45','','2009-12-15 18:31:23'),(90,58,1,'hd-wallpaper-vista-windows-art','','2009-12-16 08:45:36'),(91,59,1,'caching-sharding','','2009-12-16 22:27:30');
/*!40000 ALTER TABLE `fileTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileTypes`
--

DROP TABLE IF EXISTS `fileTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileTypes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `isImage` tinyint(1) default NULL COMMENT 'If filetyp ecan be rendered to image',
  PRIMARY KEY  (`id`)
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
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `fileId` varchar(64) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `path` varchar(500) NOT NULL,
  `idParent` bigint(20) unsigned NOT NULL,
  `idParentTypes` int(10) unsigned NOT NULL,
  `isS3Stored` tinyint(4) NOT NULL default '0',
  `isImage` tinyint(4) NOT NULL default '0',
  `filename` varchar(500) default NULL,
  `idFileTypes` bigint(20) unsigned default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `size` bigint(20) unsigned NOT NULL COMMENT 'Filesize in KB',
  `extension` varchar(10) NOT NULL,
  `mimeType` varchar(255) NOT NULL,
  `version` int(10) NOT NULL,
  `archived` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (17,'vvo_luftspruenge',2,'',4,2,0,0,'vvo_luftspruenge.rtf',NULL,2,'2009-12-03 17:53:18',1088,'rtf','text/rtf',1,0),(18,'vorbereitung-herbst-2009',2,'',4,2,0,0,'vorbereitung-herbst-2009.pdf',NULL,2,'2009-12-03 17:53:42',50032,'pdf','application/pdf',1,0),(19,'vorbereitung-herbst-2009-1',2,'',4,2,0,0,'vorbereitung-herbst-2009-1.pdf',NULL,2,'2009-12-03 17:54:54',50032,'pdf','application/pdf',1,0),(20,'apexcal',3,'',5,2,0,1,'apexcal.jpg',NULL,3,'2009-12-09 10:34:03',14289,'jpg','image/jpeg',1,0),(21,'bluephase',3,'',5,2,0,1,'bluephase.jpg',NULL,3,'2009-12-09 10:34:04',18542,'jpg','image/jpeg',1,0),(22,'bluephase_20i',3,'',5,2,0,1,'bluephase_20i.jpg',NULL,3,'2009-12-09 10:34:05',23231,'jpg','image/jpeg',1,0),(23,'bluephase_c8',3,'',5,2,0,1,'bluephase_c8.jpg',NULL,3,'2009-12-09 10:34:06',20907,'jpg','image/jpeg',1,0),(24,'bluephase_meter',3,'',5,2,0,1,'bluephase_meter.jpg',NULL,3,'2009-12-09 10:34:07',22497,'jpg','image/jpeg',1,0),(25,'e-max',3,'',5,2,0,1,'e-max.jpg',NULL,3,'2009-12-09 10:34:08',20158,'jpg','image/jpeg',1,0),(26,'ips-acrylcad',3,'',5,2,0,1,'ips-acrylcad.jpg',NULL,3,'2009-12-09 10:34:09',16337,'jpg','image/jpeg',1,0),(27,'optragate',3,'',5,2,0,1,'optragate.jpg',NULL,3,'2009-12-09 10:34:10',14155,'jpg','image/jpeg',1,0),(28,'programat-cs',3,'',5,2,0,1,'programat-cs.jpg',NULL,3,'2009-12-09 10:34:11',17752,'jpg','image/jpeg',1,0),(29,'proxyt',3,'',5,2,0,1,'proxyt.jpg',NULL,3,'2009-12-09 10:34:12',27467,'jpg','image/jpeg',1,0),(30,'silamat-s6',3,'',5,2,0,1,'silamat-s6.jpg',NULL,3,'2009-12-09 10:34:13',16086,'jpg','image/jpeg',1,0),(31,'speedcem',3,'',5,2,0,1,'speedcem.jpg',NULL,3,'2009-12-09 10:34:14',17139,'jpg','image/jpeg',1,0),(32,'sr-ivocap-high-impact',3,'',5,2,0,1,'sr-ivocap-high-impact.jpg',NULL,3,'2009-12-09 10:34:15',26669,'jpg','image/jpeg',1,0),(33,'systemp-cem',3,'',5,2,0,1,'systemp-cem.jpg',NULL,3,'2009-12-09 10:34:16',16933,'jpg','image/jpeg',1,0),(34,'tetric_evoceram',3,'',5,2,0,1,'tetric_evoceram.jpg',NULL,3,'2009-12-09 10:34:18',26564,'jpg','image/jpeg',1,0),(35,'virtual380',3,'',5,2,0,1,'virtual380.jpg',NULL,3,'2009-12-09 10:34:19',26571,'jpg','image/jpeg',1,0),(36,'vivastyle',3,'',5,2,0,1,'vivastyle.jpg',NULL,3,'2009-12-09 10:34:20',35519,'jpg','image/jpeg',1,0),(37,'header1',3,'',5,2,0,1,'header1.jpg',NULL,3,'2009-12-09 12:43:46',107926,'jpg','image/jpeg',1,0),(39,'lachen',20,'',5,2,0,1,'lachen.jpg',NULL,20,'2009-12-09 15:51:06',111030,'jpg','image/jpeg',1,0),(42,'header2',3,'',5,2,0,1,'header2.jpg',NULL,3,'2009-12-10 09:35:30',74231,'jpg','image/jpeg',1,0),(43,'84_45',2,'',100,2,0,1,'84_45.jpg',NULL,2,'2009-12-14 15:37:30',98117,'jpg','image/jpeg',1,0),(44,'nature',2,'',100,2,0,1,'nature.jpg',NULL,2,'2009-12-14 16:02:00',139099,'jpg','image/jpeg',1,0),(45,'nature23',2,'',100,2,0,1,'nature23.jpg',NULL,2,'2009-12-14 16:02:02',101932,'jpg','image/jpeg',1,0),(46,'spirit_of_vistas_by_leviatan3',2,'',100,2,0,1,'spirit_of_vistas_by_leviatan3.jpg',NULL,2,'2009-12-15 15:33:19',514778,'jpg','image/jpeg',1,0),(47,'the-lonely-path-aeoe-ue--ss--',2,'',100,2,0,1,'the-lonely-path-aeoe-ue--ss--.jpg',NULL,2,'2009-12-15 15:43:37',1749794,'jpg','image/jpeg',1,0),(48,'widewallpapers_eu_1206953132',2,'',100,2,0,1,'widewallpapers_eu_1206953132.jpg',NULL,2,'2009-12-15 15:49:21',481331,'jpg','image/jpeg',1,0),(49,'spider',2,'',100,2,0,1,'spider.jpg',NULL,2,'2009-12-15 15:52:51',182268,'jpg','image/jpeg',1,0),(50,'theoldfarmv41680x1050kq9',2,'',100,2,0,1,'theoldfarmv41680x1050kq9.jpg',NULL,2,'2009-12-15 15:57:33',1221771,'jpg','image/jpeg',1,0),(57,'84_45-1',2,'',100,2,0,1,'84_45-1.jpg',NULL,2,'2009-12-15 17:31:30',98117,'jpg','image/jpeg',1,0),(58,'hd-wallpaper-vista-windows-art',2,'',100,2,0,1,'hd-wallpaper-vista-windows-art.jpg',NULL,2,'2009-12-15 18:02:49',347041,'jpg','image/jpeg',1,0),(59,'caching-sharding',3,'',111,2,0,0,'caching-sharding.pdf',NULL,3,'2009-12-16 22:27:20',360266,'pdf','application/pdf',1,0);
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folder-DEFAULT_FOLDER-1-Instances`
--

DROP TABLE IF EXISTS `folder-DEFAULT_FOLDER-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folder-DEFAULT_FOLDER-1-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `description` text,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `folderId` (`folderId`),
  CONSTRAINT `folder-DEFAULT_FOLDER-1-Instances_ibfk_1` FOREIGN KEY (`folderId`) REFERENCES `folders` (`folderId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folder-DEFAULT_FOLDER-1-Instances`
--

LOCK TABLES `folder-DEFAULT_FOLDER-1-Instances` WRITE;
/*!40000 ALTER TABLE `folder-DEFAULT_FOLDER-1-Instances` DISABLE KEYS */;
INSERT INTO `folder-DEFAULT_FOLDER-1-Instances` VALUES (1,'4a112157c45e5',1,1,'',3,2,'2009-05-18 08:50:31','2009-12-15 13:35:50'),(3,'4a1133f4257b5',1,1,'',20,2,'2009-05-18 10:09:56','2009-12-08 15:18:43'),(4,'4a2910cf9583d',1,1,'',3,3,'2009-06-05 12:34:23','2009-12-16 15:08:57'),(5,'4a2a3c746b0ba',1,1,'',3,3,'2009-06-06 09:52:52','2009-06-08 16:17:26'),(6,'4a112157c45e5',1,2,'',3,3,'2009-06-08 16:02:52','2009-06-09 15:13:03'),(12,'4af3cb4341687',1,1,'',1,6,'2009-11-06 07:07:47','2009-11-11 10:58:25'),(16,'4af44cdad0fad',1,1,'',1,3,'2009-11-06 16:20:42','2009-11-11 11:13:09'),(29,'4afa8f3947978',1,1,'',20,1,'2009-11-11 10:17:29','2009-12-08 15:18:34'),(30,'4afa8f6f2c823',1,1,'',20,1,'2009-11-11 10:18:23','2009-12-08 15:26:38'),(31,'4afa8f7940363',1,1,'',3,1,'2009-11-11 10:18:33','2009-12-09 15:30:07'),(32,'4afa8f841687f',1,1,'',20,1,'2009-11-11 10:18:44','2009-12-08 15:27:11'),(33,'4afa8ff593df7',1,1,'',3,1,'2009-11-11 10:20:37','2009-12-09 07:51:45'),(34,'4afa900524eaa',1,1,'',3,1,'2009-11-11 10:20:53','2009-12-09 07:51:54'),(35,'4afa8ff593df7',1,2,'',1,1,'2009-11-11 10:21:01','2009-11-11 10:21:01'),(36,'4afa900524eaa',1,2,'',1,1,'2009-11-11 10:21:17','2009-11-11 10:21:17'),(37,'4afa902aa9830',1,1,'',3,1,'2009-11-11 10:21:30','2009-12-15 17:46:33'),(38,'4afa902aa9830',1,2,'',3,1,'2009-11-11 10:23:47','2009-12-17 12:10:26'),(39,'4afa914e89ed3',1,1,'',3,1,'2009-11-11 10:26:22','2009-12-10 07:55:18'),(40,'4afa9195d03c4',1,1,'',3,1,'2009-11-11 10:27:33','2009-12-10 07:55:25'),(41,'4afa914e89ed3',1,2,'',1,1,'2009-11-11 10:28:51','2009-11-11 10:28:51'),(42,'4afa9195d03c4',1,2,'',1,1,'2009-11-11 10:29:11','2009-11-11 10:29:11'),(43,'4afa921339c18',1,1,'',3,1,'2009-11-11 10:29:39','2009-12-15 17:55:26'),(45,'4afa92357da69',1,1,'',1,1,'2009-11-11 10:30:13','2009-11-11 10:30:13'),(46,'4afa924751823',1,1,'',1,1,'2009-11-11 10:30:31','2009-11-11 10:30:31'),(47,'4afa92531787c',1,1,'',1,1,'2009-11-11 10:30:43','2009-11-11 10:30:43'),(49,'4afa925e42845',1,1,'',1,1,'2009-11-11 10:30:54','2009-11-11 10:30:54'),(51,'4afa9276e0777',1,1,'',20,1,'2009-11-11 10:31:18','2009-12-08 15:27:37'),(53,'4afa942723de6',1,1,'',1,1,'2009-11-11 10:38:31','2009-11-11 10:38:31'),(54,'4afa943011107',1,1,'',1,1,'2009-11-11 10:38:40','2009-11-11 10:38:40'),(55,'4afa9440eaba6',1,1,'',1,1,'2009-11-11 10:38:56','2009-11-11 10:38:56'),(56,'4afa94593736e',1,1,'',1,1,'2009-11-11 10:39:21','2009-11-11 10:39:21'),(57,'4afa9472af029',1,1,'',1,1,'2009-11-11 10:39:46','2009-11-11 10:39:46'),(58,'4afa947f48d5a',1,1,'',1,1,'2009-11-11 10:39:59','2009-11-11 10:39:59'),(59,'4afa948bad2f9',1,1,'',1,1,'2009-11-11 10:40:11','2009-11-11 10:40:11'),(61,'4afa949ae9fc2',1,1,'',1,1,'2009-11-11 10:40:26','2009-11-11 10:40:26'),(62,'4afa94a7aa578',1,1,'',1,1,'2009-11-11 10:40:39','2009-11-11 10:40:39'),(63,'4afa94b30a27d',1,1,'',1,1,'2009-11-11 10:40:51','2009-11-11 10:40:51'),(65,'4afa94bd5c704',1,1,'',1,1,'2009-11-11 10:41:01','2009-11-11 10:41:01'),(66,'4afa94c3b3413',1,1,'',1,1,'2009-11-11 10:41:07','2009-11-11 10:41:07'),(71,'4afa95ce3da4f',1,1,'',1,1,'2009-11-11 10:45:34','2009-11-11 10:45:34'),(72,'4afa95dd2e088',1,1,'',1,1,'2009-11-11 10:45:49','2009-11-11 10:45:49'),(73,'4afa95f059537',1,1,'',1,1,'2009-11-11 10:46:08','2009-11-11 10:46:08'),(74,'4afa971dd0785',1,1,'',3,1,'2009-11-11 10:51:09','2009-12-15 17:55:43'),(75,'4afa9767e8c02',1,1,'',3,1,'2009-11-11 10:52:23','2009-12-09 08:45:03'),(77,'4afa978829f7d',1,1,'',1,1,'2009-11-11 10:52:56','2009-11-11 10:52:56'),(78,'4afa97935ab86',1,1,'',1,1,'2009-11-11 10:53:07','2009-11-11 10:53:07'),(80,'4afa995f63419',1,1,'',1,1,'2009-11-11 11:00:47','2009-11-11 11:00:47'),(81,'4afa998181cb8',1,1,'',1,1,'2009-11-11 11:01:21','2009-11-11 11:01:21'),(82,'4afa9991f3e8c',1,1,'',1,1,'2009-11-11 11:01:38','2009-11-11 11:01:38'),(83,'4afa99a7c0957',1,1,'',1,1,'2009-11-11 11:01:59','2009-11-11 11:01:59'),(84,'4afa99b943abb',1,1,'',1,1,'2009-11-11 11:02:17','2009-11-11 11:02:17'),(88,'4afa9c5d520c2',1,1,'',20,1,'2009-11-11 11:13:33','2009-12-08 15:27:49'),(89,'4afa9c9376085',1,1,'',20,1,'2009-11-11 11:14:27','2009-12-10 09:38:28'),(102,'4afae25320d2b',1,1,'',3,3,'2009-11-11 16:12:03','2009-11-11 16:12:03'),(107,'4b26541027b93',1,1,'',2,2,'2009-12-14 15:04:48','2009-12-14 15:04:48'),(108,'4b2654610abac',1,1,'',2,2,'2009-12-14 15:06:09','2009-12-15 13:32:33'),(109,'4b265590204e7',1,1,'',2,2,'2009-12-14 15:11:12','2009-12-14 15:11:12'),(110,'4b2655cc1cc1e',1,1,'',2,2,'2009-12-14 15:12:12','2009-12-14 15:12:12'),(111,'4b2657930a275',1,1,'',2,2,'2009-12-14 15:19:47','2009-12-14 15:19:47'),(115,'4b2671f0a7ea3',1,1,'',3,3,'2009-12-14 17:12:16','2009-12-14 17:16:40'),(116,'4b2676145c850',1,1,'',3,3,'2009-12-14 17:29:56','2009-12-14 17:29:56'),(117,'4afa921339c18',1,2,'',3,3,'2009-12-15 18:29:51','2009-12-15 18:29:51'),(118,'4b28f7cebd4e1',1,1,'',3,3,'2009-12-16 15:07:58','2009-12-16 15:07:58'),(119,'4b28f7da7f37f',1,1,'',3,3,'2009-12-16 15:08:10','2009-12-16 15:08:10'),(120,'4b28f7e3a89dc',1,1,'',3,3,'2009-12-16 15:08:19','2009-12-16 15:08:19'),(121,'4b28f7ef79acb',1,1,'',3,3,'2009-12-16 15:08:31','2009-12-16 15:08:31'),(122,'4b28f7fa06acd',1,1,'',3,3,'2009-12-16 15:08:42','2009-12-16 15:08:42'),(123,'4b28f80301c21',1,1,'',3,3,'2009-12-16 15:08:51','2009-12-16 15:08:51');
/*!40000 ALTER TABLE `folder-DEFAULT_FOLDER-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderCategories`
--

DROP TABLE IF EXISTS `folderCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderCategories` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `category` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  PRIMARY KEY  (`idFolders`,`environment`,`idGroups`),
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
INSERT INTO `folderPermissions` VALUES (1,1,1),(1,1,5);
/*!40000 ALTER TABLE `folderPermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderTitles`
--

DROP TABLE IF EXISTS `folderTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderTitles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `folderId` (`folderId`),
  CONSTRAINT `folderTitles_ibfk_1` FOREIGN KEY (`folderId`) REFERENCES `folders` (`folderId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folderTitles`
--

LOCK TABLES `folderTitles` WRITE;
/*!40000 ALTER TABLE `folderTitles` DISABLE KEYS */;
INSERT INTO `folderTitles` VALUES (1,'4a112157c45e5',1,1,'Products',3,2,'2009-05-18 08:50:31','2009-12-15 13:35:50'),(3,'4a1133f4257b5',1,1,'Company',20,2,'2009-05-18 10:09:56','2009-12-08 15:18:43'),(4,'4a2910cf9583d',1,1,'Test',3,3,'2009-06-05 12:34:23','2009-12-16 15:08:57'),(5,'4a2a3c746b0ba',1,1,'TEST',3,3,'2009-06-06 09:52:52','2009-06-08 16:17:26'),(6,'4a112157c45e5',1,2,'Main Navigation 1',3,3,'2009-06-08 16:02:52','2009-06-09 15:13:03'),(12,'4af3cb4341687',1,1,'Laboratory Professional',1,6,'2009-11-06 07:07:47','2009-11-11 10:58:25'),(16,'4af44cdad0fad',1,1,'History',1,3,'2009-11-06 16:20:42','2009-11-11 11:13:09'),(29,'4afa8f3947978',1,1,'Press',20,1,'2009-11-11 10:17:29','2009-12-08 15:18:34'),(30,'4afa8f6f2c823',1,1,'Career',20,1,'2009-11-11 10:18:23','2009-12-08 15:26:38'),(31,'4afa8f7940363',1,1,'Support',3,1,'2009-11-11 10:18:33','2009-12-09 15:30:07'),(32,'4afa8f841687f',1,1,'Contact',20,1,'2009-11-11 10:18:44','2009-12-08 15:27:11'),(33,'4afa8ff593df7',1,1,'Produkte',3,1,'2009-11-11 10:20:37','2009-12-09 07:51:45'),(34,'4afa900524eaa',1,1,'Kompetenzen',3,1,'2009-11-11 10:20:53','2009-12-09 07:51:54'),(35,'4afa8ff593df7',1,2,'Products',1,1,'2009-11-11 10:21:01','2009-11-11 10:21:01'),(36,'4afa900524eaa',1,2,'Competences',1,1,'2009-11-11 10:21:17','2009-11-11 10:21:17'),(37,'4afa902aa9830',1,1,'Füllungstherapie',3,1,'2009-11-11 10:21:30','2009-12-15 17:46:33'),(38,'4afa902aa9830',1,2,'Restorative Therapy',3,1,'2009-11-11 10:23:47','2009-12-17 12:10:26'),(39,'4afa914e89ed3',1,1,'Geräte',3,1,'2009-11-11 10:26:22','2009-12-10 07:55:18'),(40,'4afa9195d03c4',1,1,'Legierungen',3,1,'2009-11-11 10:27:33','2009-12-10 07:55:25'),(41,'4afa914e89ed3',1,2,'Equipment ',1,1,'2009-11-11 10:28:51','2009-11-11 10:28:51'),(42,'4afa9195d03c4',1,2,'Alloys',1,1,'2009-11-11 10:29:11','2009-11-11 10:29:11'),(43,'4afa921339c18',1,1,'Composites',3,1,'2009-11-11 10:29:39','2009-12-15 17:55:26'),(45,'4afa92357da69',1,1,'Compomeres',1,1,'2009-11-11 10:30:13','2009-11-11 10:30:13'),(46,'4afa924751823',1,1,'Adhesives/Etchants',1,1,'2009-11-11 10:30:31','2009-11-11 10:30:31'),(47,'4afa92531787c',1,1,'Amalgams',1,1,'2009-11-11 10:30:43','2009-11-11 10:30:43'),(49,'4afa925e42845',1,1,'Lining material',1,1,'2009-11-11 10:30:54','2009-11-11 10:30:54'),(51,'4afa9276e0777',1,1,'Schaan',20,1,'2009-11-11 10:31:18','2009-12-08 15:27:37'),(53,'4afa942723de6',1,1,'Composites',1,1,'2009-11-11 10:38:31','2009-11-11 10:38:31'),(54,'4afa943011107',1,1,'All-Ceramics',1,1,'2009-11-11 10:38:40','2009-11-11 10:38:40'),(55,'4afa9440eaba6',1,1,'Implant Esthetics',1,1,'2009-11-11 10:38:56','2009-11-11 10:38:56'),(56,'4afa94593736e',1,1,'Planning',1,1,'2009-11-11 10:39:21','2009-11-11 10:39:21'),(57,'4afa9472af029',1,1,'Retraction Isolation',1,1,'2009-11-11 10:39:46','2009-11-11 10:39:46'),(58,'4afa947f48d5a',1,1,'Matrix',1,1,'2009-11-11 10:39:59','2009-11-11 10:39:59'),(59,'4afa948bad2f9',1,1,'Adhesives',1,1,'2009-11-11 10:40:11','2009-11-11 10:40:11'),(61,'4afa949ae9fc2',1,1,'Flowable composites',1,1,'2009-11-11 10:40:26','2009-11-11 10:40:26'),(62,'4afa94a7aa578',1,1,'Sculptable composites',1,1,'2009-11-11 10:40:39','2009-11-11 10:40:39'),(63,'4afa94b30a27d',1,1,'LED curing lights',1,1,'2009-11-11 10:40:51','2009-11-11 10:40:51'),(65,'4afa94bd5c704',1,1,'Polishing',1,1,'2009-11-11 10:41:01','2009-11-11 10:41:01'),(66,'4afa94c3b3413',1,1,'Recall',1,1,'2009-11-11 10:41:07','2009-11-11 10:41:07'),(71,'4afa95ce3da4f',1,1,'IPS e.max dental technician',1,1,'2009-11-11 10:45:34','2009-11-11 10:45:34'),(72,'4afa95dd2e088',1,1,'IPS e.max dentist',1,1,'2009-11-11 10:45:49','2009-11-11 10:45:49'),(73,'4afa95f059537',1,1,'IPS Empress dental technician',1,1,'2009-11-11 10:46:08','2009-11-11 10:46:08'),(74,'4afa971dd0785',1,1,'Dental Professional',3,1,'2009-11-11 10:51:09','2009-12-15 17:55:43'),(75,'4afa9767e8c02',1,1,'All Products',3,1,'2009-11-11 10:52:23','2009-12-09 08:45:03'),(77,'4afa978829f7d',1,1,'Service',1,1,'2009-11-11 10:52:56','2009-11-11 10:52:56'),(78,'4afa97935ab86',1,1,'Education Courses',1,1,'2009-11-11 10:53:07','2009-11-11 10:53:07'),(80,'4afa995f63419',1,1,'MSDS Documents',1,1,'2009-11-11 11:00:47','2009-11-11 11:00:47'),(81,'4afa998181cb8',1,1,'Instructions for Use for dental technicians',1,1,'2009-11-11 11:01:21','2009-11-11 11:01:21'),(82,'4afa9991f3e8c',1,1,'Instructions for use for dentists',1,1,'2009-11-11 11:01:38','2009-11-11 11:01:38'),(83,'4afa99a7c0957',1,1,'Brochures',1,1,'2009-11-11 11:01:59','2009-11-11 11:01:59'),(84,'4afa99b943abb',1,1,'Scientific Documentation',1,1,'2009-11-11 11:02:17','2009-11-11 11:02:17'),(88,'4afa9c5d520c2',1,1,'Facts & Figures',20,1,'2009-11-11 11:13:33','2009-12-08 15:27:49'),(89,'4afa9c9376085',1,1,'Press Pictures',20,1,'2009-11-11 11:14:27','2009-12-10 09:38:28'),(102,'4afae25320d2b',1,1,'Test Thomas',3,3,'2009-11-11 16:12:03','2009-11-11 16:12:03'),(107,'4b26541027b93',1,1,'Test1.1',2,2,'2009-12-14 15:04:48','2009-12-14 15:04:48'),(108,'4b2654610abac',1,1,'Test1.2',2,2,'2009-12-14 15:06:09','2009-12-15 13:32:33'),(109,'4b265590204e7',1,1,'Test1.1.1',2,2,'2009-12-14 15:11:12','2009-12-14 15:11:12'),(110,'4b2655cc1cc1e',1,1,'Test1.2.1',2,2,'2009-12-14 15:12:12','2009-12-14 15:12:12'),(111,'4b2657930a275',1,1,'Test1.2.2',2,2,'2009-12-14 15:19:47','2009-12-14 15:19:47'),(115,'4b2671f0a7ea3',1,1,'All Products',3,3,'2009-12-14 17:12:16','2009-12-14 17:16:40'),(116,'4b2676145c850',1,1,'Products',3,3,'2009-12-14 17:29:56','2009-12-14 17:29:56'),(117,'4afa921339c18',1,2,'Composites',3,3,'2009-12-15 18:29:51','2009-12-15 18:29:51'),(118,'4b28f7cebd4e1',1,1,'Test 1',3,3,'2009-12-16 15:07:58','2009-12-16 15:07:58'),(119,'4b28f7da7f37f',1,1,'Test 1.1',3,3,'2009-12-16 15:08:10','2009-12-16 15:08:10'),(120,'4b28f7e3a89dc',1,1,'Test 1.1.1',3,3,'2009-12-16 15:08:19','2009-12-16 15:08:19'),(121,'4b28f7ef79acb',1,1,'Test 1.2',3,3,'2009-12-16 15:08:31','2009-12-16 15:08:31'),(122,'4b28f7fa06acd',1,1,'Test 1.3',3,3,'2009-12-16 15:08:42','2009-12-16 15:08:42'),(123,'4b28f80301c21',1,1,'Test 2',3,3,'2009-12-16 15:08:51','2009-12-16 15:08:51');
/*!40000 ALTER TABLE `folderTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderTypes`
--

DROP TABLE IF EXISTS `folderTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderTypes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idFolderTypes` bigint(20) unsigned NOT NULL,
  `idParentFolder` bigint(20) unsigned default NULL,
  `idRootLevels` bigint(20) unsigned default NULL,
  `lft` int(10) unsigned default NULL,
  `rgt` int(10) unsigned default NULL,
  `depth` int(10) unsigned default NULL,
  `idSortTypes` bigint(20) unsigned NOT NULL,
  `sortOrder` varchar(255) default NULL,
  `sortPosition` bigint(20) unsigned NOT NULL,
  `sortTimestamp` timestamp NULL default NULL,
  `folderId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `publisher` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `published` timestamp NULL default NULL,
  `idStatus` bigint(20) unsigned NOT NULL default '0',
  `isUrlFolder` tinyint(1) NOT NULL default '0',
  `showInNavigation` tinyint(1) NOT NULL default '0',
  `isVirtualFolder` tinyint(1) NOT NULL default '0',
  `virtualFolderType` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `folderId` (`folderId`),
  KEY `idParentFolder` (`idParentFolder`),
  KEY `idRootLevels` (`idRootLevels`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders`
--

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
INSERT INTO `folders` VALUES (1,1,1,67,1,24,25,1,0,NULL,1,'2009-11-11 10:58:03','4a112157c45e5',1,3,2,0,'2009-05-18 08:50:31','2009-12-15 16:30:45',NULL,2,1,1,0,NULL),(3,1,1,0,1,1,8,0,0,NULL,4,'2009-12-09 15:31:47','4a1133f4257b5',1,20,2,0,'2009-05-18 10:09:56','2009-12-09 15:33:45',NULL,2,0,1,0,NULL),(4,1,1,0,3,1,14,0,0,NULL,0,'2009-06-05 12:34:23','4a2910cf9583d',1,3,3,0,'2009-06-05 12:34:23','2009-12-16 15:08:57',NULL,1,1,0,0,NULL),(5,1,1,0,2,1,12,0,0,NULL,0,'2009-06-06 09:52:52','4a2a3c746b0ba',1,3,3,0,'2009-06-06 09:52:52','2009-12-15 13:29:48',NULL,1,1,0,0,NULL),(10,1,1,0,1,33,34,0,0,NULL,2,'2009-12-09 15:31:47','4af3cb4341687',1,1,6,0,'2009-11-06 07:07:47','2009-12-15 16:30:45',NULL,2,1,0,0,NULL),(14,1,1,3,1,2,3,1,0,NULL,2,'2009-11-11 11:13:37','4af44cdad0fad',1,1,3,0,'2009-11-06 16:20:42','2009-12-09 15:33:45',NULL,2,1,1,0,NULL),(27,1,1,0,1,9,12,0,0,NULL,5,'2009-12-09 15:31:47','4afa8f3947978',1,20,1,0,'2009-11-11 10:17:29','2009-12-09 15:33:45',NULL,2,1,1,0,NULL),(28,1,1,0,1,13,14,0,0,NULL,6,'2009-12-09 15:31:47','4afa8f6f2c823',1,20,1,0,'2009-11-11 10:18:23','2009-12-09 15:33:45',NULL,2,1,1,0,NULL),(29,1,1,0,1,15,16,0,0,NULL,7,'2009-12-09 15:31:47','4afa8f7940363',1,3,1,0,'2009-11-11 10:18:33','2009-12-09 15:33:45',NULL,2,1,1,0,NULL),(30,1,1,0,1,17,18,0,0,NULL,8,'2009-12-09 15:31:47','4afa8f841687f',1,20,1,0,'2009-11-11 10:18:44','2009-12-09 15:33:45',NULL,2,1,1,0,NULL),(31,1,1,0,12,1,18,0,0,NULL,0,'2009-11-11 10:20:37','4afa8ff593df7',1,3,1,0,'2009-11-11 10:20:37','2009-12-22 13:06:34',NULL,2,1,0,0,NULL),(32,1,1,0,12,19,50,0,0,NULL,1,'2009-11-11 10:20:53','4afa900524eaa',1,3,1,0,'2009-11-11 10:20:53','2009-12-22 13:06:34',NULL,2,1,0,0,NULL),(33,1,1,31,12,2,13,1,0,NULL,0,'2009-11-11 10:21:30','4afa902aa9830',1,3,1,0,'2009-11-11 10:21:30','2009-12-22 13:06:34',NULL,2,1,0,0,NULL),(34,1,1,31,12,14,15,1,0,NULL,1,'2009-11-11 10:26:22','4afa914e89ed3',1,3,1,0,'2009-11-11 10:26:22','2009-12-22 13:06:34',NULL,2,1,0,0,NULL),(35,1,1,31,12,16,17,1,0,NULL,2,'2009-11-11 10:27:33','4afa9195d03c4',1,3,1,0,'2009-11-11 10:27:33','2009-12-22 13:06:34',NULL,2,1,0,0,NULL),(36,1,1,33,12,11,12,2,0,NULL,0,'2009-11-11 10:29:39','4afa921339c18',1,3,1,0,'2009-11-11 10:29:39','2009-12-22 13:06:34',NULL,2,1,0,0,NULL),(38,1,1,33,12,3,4,2,0,NULL,1,'2009-11-11 10:30:13','4afa92357da69',1,1,1,0,'2009-11-11 10:30:13','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(39,1,1,33,12,5,6,2,0,NULL,2,'2009-11-11 10:30:31','4afa924751823',1,1,1,0,'2009-11-11 10:30:31','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(40,1,1,33,12,7,8,2,0,NULL,3,'2009-11-11 10:30:43','4afa92531787c',1,1,1,0,'2009-11-11 10:30:43','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(42,1,1,33,12,9,10,2,0,NULL,4,'2009-11-11 10:30:54','4afa925e42845',1,1,1,0,'2009-11-11 10:30:54','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(44,1,1,3,1,4,5,1,0,NULL,1,'2009-11-11 11:13:37','4afa9276e0777',1,20,1,0,'2009-11-11 10:31:18','2009-12-09 15:33:45',NULL,2,1,1,0,NULL),(46,1,1,32,12,20,39,1,0,NULL,0,'2009-11-11 10:38:31','4afa942723de6',1,1,1,0,'2009-11-11 10:38:31','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(47,1,1,32,12,40,47,1,0,NULL,1,'2009-11-11 10:38:40','4afa943011107',1,1,1,0,'2009-11-11 10:38:40','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(48,1,1,32,12,48,49,1,0,NULL,2,'2009-11-11 10:38:56','4afa9440eaba6',1,1,1,0,'2009-11-11 10:38:56','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(49,1,1,46,12,21,22,2,0,NULL,3,'2009-11-11 10:39:21','4afa94593736e',1,1,1,0,'2009-11-11 10:39:21','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(50,1,1,46,12,23,24,2,0,NULL,1,'2009-11-11 10:39:46','4afa9472af029',1,1,1,0,'2009-11-11 10:39:46','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(51,1,1,46,12,25,26,2,0,NULL,2,'2009-11-11 10:39:59','4afa947f48d5a',1,1,1,0,'2009-11-11 10:39:59','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(52,1,1,46,12,27,28,2,0,NULL,3,'2009-11-11 10:40:11','4afa948bad2f9',1,1,1,0,'2009-11-11 10:40:11','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(54,1,1,46,12,29,30,2,0,NULL,4,'2009-11-11 10:40:26','4afa949ae9fc2',1,1,1,0,'2009-11-11 10:40:26','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(55,1,1,46,12,31,32,2,0,NULL,5,'2009-11-11 10:40:39','4afa94a7aa578',1,1,1,0,'2009-11-11 10:40:39','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(56,1,1,46,12,33,34,2,0,NULL,6,'2009-11-11 10:40:51','4afa94b30a27d',1,1,1,0,'2009-11-11 10:40:51','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(58,1,1,46,12,35,36,2,0,NULL,7,'2009-11-11 10:41:01','4afa94bd5c704',1,1,1,0,'2009-11-11 10:41:01','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(59,1,1,46,12,37,38,2,0,NULL,8,'2009-11-11 10:41:07','4afa94c3b3413',1,1,1,0,'2009-11-11 10:41:07','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(64,1,1,47,12,41,42,2,0,NULL,0,'2009-11-11 10:45:34','4afa95ce3da4f',1,1,1,0,'2009-11-11 10:45:34','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(65,1,1,47,12,43,44,2,0,NULL,1,'2009-11-11 10:45:49','4afa95dd2e088',1,1,1,0,'2009-11-11 10:45:49','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(66,1,1,47,12,45,46,2,0,NULL,2,'2009-11-11 10:46:08','4afa95f059537',1,1,1,0,'2009-11-11 10:46:08','2009-12-22 13:06:34',NULL,1,1,0,0,NULL),(67,1,1,0,1,19,32,0,0,NULL,1,'2009-12-09 15:31:47','4afa971dd0785',1,3,1,0,'2009-11-11 10:51:09','2009-12-15 17:55:43',NULL,2,1,0,0,NULL),(68,1,1,0,1,35,36,0,0,NULL,3,'2009-12-09 15:31:47','4afa9767e8c02',1,3,1,0,'2009-11-11 10:52:23','2009-12-15 16:30:45',NULL,2,1,0,0,NULL),(70,1,1,67,1,20,21,1,0,NULL,2,'2009-11-11 10:58:03','4afa978829f7d',1,1,1,0,'2009-11-11 10:52:56','2009-12-09 15:33:45',NULL,1,1,0,0,NULL),(71,1,1,67,1,22,23,1,0,NULL,3,'2009-11-11 10:58:03','4afa97935ab86',1,1,1,0,'2009-11-11 10:53:07','2009-12-09 15:33:45',NULL,1,1,0,0,NULL),(73,1,1,0,3,15,16,0,0,NULL,1,'2009-11-11 11:00:47','4afa995f63419',1,1,1,0,'2009-11-11 11:00:47','2009-12-16 15:08:51',NULL,1,1,0,0,NULL),(74,1,1,0,3,17,18,0,0,NULL,2,'2009-11-11 11:01:21','4afa998181cb8',1,1,1,0,'2009-11-11 11:01:21','2009-12-16 15:08:51',NULL,1,1,0,0,NULL),(75,1,1,0,3,19,20,0,0,NULL,3,'2009-11-11 11:01:38','4afa9991f3e8c',1,1,1,0,'2009-11-11 11:01:38','2009-12-16 15:08:51',NULL,1,1,0,0,NULL),(76,1,1,0,3,21,22,0,0,NULL,4,'2009-11-11 11:01:59','4afa99a7c0957',1,1,1,0,'2009-11-11 11:01:59','2009-12-16 15:08:51',NULL,1,1,0,0,NULL),(77,1,1,0,3,23,24,0,0,NULL,5,'2009-11-11 11:02:17','4afa99b943abb',1,1,1,0,'2009-11-11 11:02:17','2009-12-16 15:08:51',NULL,1,1,0,0,NULL),(81,1,1,3,1,6,7,1,0,NULL,3,'2009-11-11 11:13:37','4afa9c5d520c2',1,20,1,0,'2009-11-11 11:13:33','2009-12-09 15:33:45',NULL,2,1,1,0,NULL),(82,1,1,27,1,10,11,1,0,NULL,1,'2009-11-11 11:14:27','4afa9c9376085',1,20,1,0,'2009-11-11 11:14:27','2009-12-10 09:38:28',NULL,2,1,1,0,NULL),(95,1,1,67,1,26,27,1,0,NULL,4,'2009-11-11 16:12:03','4afae25320d2b',1,3,3,0,'2009-11-11 16:12:03','2009-12-15 16:30:45',NULL,1,1,0,0,NULL),(100,1,1,5,2,2,5,1,0,NULL,0,'2009-12-14 15:04:48','4b26541027b93',1,2,2,0,'2009-12-14 15:04:48','2009-12-15 13:29:48',NULL,1,1,0,0,NULL),(101,1,1,5,2,6,11,1,0,NULL,1,'2009-12-14 15:06:09','4b2654610abac',1,2,2,0,'2009-12-14 15:06:09','2009-12-15 13:32:33',NULL,1,1,0,0,NULL),(102,1,1,100,2,3,4,2,0,NULL,0,'2009-12-14 15:11:12','4b265590204e7',1,2,2,0,'2009-12-14 15:11:12','2009-12-15 13:29:48',NULL,1,1,0,0,NULL),(103,1,1,101,2,7,8,2,0,NULL,0,'2009-12-14 15:12:12','4b2655cc1cc1e',1,2,2,0,'2009-12-14 15:12:12','2009-12-15 13:29:48',NULL,1,1,0,0,NULL),(104,1,1,101,2,9,10,2,0,NULL,1,'2009-12-14 15:19:47','4b2657930a275',1,2,2,0,'2009-12-14 15:19:47','2009-12-15 13:29:48',NULL,1,1,0,0,NULL),(108,1,1,67,1,28,29,1,0,NULL,5,'2009-12-14 17:12:16','4b2671f0a7ea3',1,3,3,0,'2009-12-14 17:12:16','2009-12-15 16:30:45',NULL,1,1,0,0,NULL),(109,1,1,67,1,30,31,1,0,NULL,6,'2009-12-14 17:29:56','4b2676145c850',1,3,3,0,'2009-12-14 17:29:56','2009-12-15 16:30:45',NULL,1,1,0,0,NULL),(110,1,1,4,3,2,11,1,0,NULL,0,'2009-12-16 15:07:58','4b28f7cebd4e1',1,3,3,0,'2009-12-16 15:07:58','2009-12-16 15:08:42',NULL,1,1,0,0,NULL),(111,1,1,110,3,3,6,2,0,NULL,0,'2009-12-16 15:08:10','4b28f7da7f37f',1,3,3,0,'2009-12-16 15:08:10','2009-12-16 15:08:19',NULL,1,1,0,0,NULL),(112,1,1,111,3,4,5,3,0,NULL,0,'2009-12-16 15:08:19','4b28f7e3a89dc',1,3,3,0,'2009-12-16 15:08:19','2009-12-16 15:08:19',NULL,1,1,0,0,NULL),(113,1,1,110,3,7,8,2,0,NULL,1,'2009-12-16 15:08:31','4b28f7ef79acb',1,3,3,0,'2009-12-16 15:08:31','2009-12-16 15:08:31',NULL,1,1,0,0,NULL),(114,1,1,110,3,9,10,2,0,NULL,2,'2009-12-16 15:08:42','4b28f7fa06acd',1,3,3,0,'2009-12-16 15:08:42','2009-12-16 15:08:42',NULL,1,1,0,0,NULL),(115,1,1,4,3,12,13,1,0,NULL,1,'2009-12-16 15:08:51','4b28f80301c21',1,3,3,0,'2009-12-16 15:08:51','2009-12-16 15:08:51',NULL,1,1,0,0,NULL);
/*!40000 ALTER TABLE `folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genericFormTabs`
--

DROP TABLE IF EXISTS `genericFormTabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genericFormTabs` (
  `id` bigint(20) NOT NULL auto_increment,
  `idGenericForms` bigint(20) NOT NULL,
  `idTabs` bigint(20) NOT NULL,
  `order` int(10) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(255) default NULL,
  `idAction` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idUsers` bigint(20) unsigned NOT NULL,
  `genericFormId` varchar(32) NOT NULL,
  `version` int(10) NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `idGenericFormTypes` int(10) unsigned NOT NULL,
  `mandatoryUpgrade` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
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
  PRIMARY KEY  (`idGroups`,`idLanguages`,`idPermissions`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `key` varchar(64) NOT NULL,
  `description` text,
  `idGroupTypes` bigint(20) unsigned default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idLanguanges` int(10) unsigned NOT NULL default '1',
  `guiId` varchar(32) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `languageCode` varchar(5) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'DE','COM-Deutsch'),(2,'EN','COM-English'),(3,'ES','COM-Spanisch'),(4,'DE-DE','Deutschland'),(5,'IT','Italien'),(6,'FR','Frankreich'),(7,'PL','Polen'),(8,'RU','Russland'),(9,'SV','Schweden'),(10,'EN-US','USA / Kanada'),(11,'EN-NZ','Neuseeland'),(12,'EN-AU','Australien'),(13,'JP','Japan'),(14,'ES-CO','Kolumbien'),(15,'ES-MX','Mexiko'),(16,'EN-AS','Asien'),(17,'EN-ME','mitlerer Osten'),(18,'PT-BR','Brasilien'),(19,'CN','China'),(20,'KO','Korea'),(21,'EN-IN','Indien'),(22,'SL','Slowenien'),(23,'EL','Griechenland'),(24,'TR','Türkei'),(25,'EN-UK','UK'),(26,'HR','Kroatien, Bosnien & Herzegowina, Serbien&Montenegro');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `resourceKey` varchar(64) default NULL,
  `cssClass` varchar(64) default NULL,
  `order` int(11) default NULL,
  `active` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
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
-- Table structure for table `page-DEFAULT_COLLECTION-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_COLLECTION-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_COLLECTION-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) default NULL,
  `collection_title` varchar(255) default NULL,
  `shortdescription` text,
  `description` text NOT NULL,
  `header_embed_code` text,
  `contact` varchar(255) default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_COLLECTION-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-Instances`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_COLLECTION-1-Instances` VALUES (1,'4a40944a8ee78',1,1,3,'','Hier kommt meine Kollektion','','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.<br /><br />Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a.</p>',NULL,'',3,'2009-08-28 12:11:52','2009-12-15 13:23:35'),(2,'4a112157d69eb',1,1,3,'','','','',NULL,'',6,'2009-10-30 10:28:16','2009-12-15 14:08:08'),(3,'4af3cb435ebcf',1,1,2,'','','','',NULL,'',2,'2009-12-10 09:40:10','2009-12-10 09:40:10');
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` VALUES (1,'4af3cb435ebcf',1,1,78,21,128);
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_COLLECTION-1-Region14-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_COLLECTION-1-Region14-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_COLLECTION-1-Region14-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) default NULL,
  `sidebar_description` text,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_COLLECTION-1-Region14-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_COLLECTION-1-Region14-Instances` VALUES (78,'4af3cb435ebcf',1,1,1,'test','<p>test</p>'),(90,'4a40944a8ee78',1,1,1,'Sidebar','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.<br /><br />Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a.</p>'),(91,'4a112157d69eb',1,1,1,'','');
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_EVENT-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_EVENT-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_EVENT-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` text NOT NULL,
  `description` text,
  `pics_title` varchar(255) default NULL,
  `docs_title` varchar(255) default '',
  `video_title` varchar(255) default NULL,
  `video_embed_code` text,
  `shortdescription` text NOT NULL,
  `event_duration` varchar(255) default NULL,
  `event_street` varchar(255) default NULL,
  `event_streetnr` varchar(255) default NULL,
  `event_plz` varchar(255) default NULL,
  `event_city` varchar(255) default NULL,
  `event_location` varchar(255) default NULL,
  `event_max_members` varchar(255) default NULL,
  `event_costs` varchar(255) default NULL,
  `event_status` varchar(255) default NULL,
  `contact` varchar(255) default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `shortdescription` text NOT NULL,
  `description` text NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-InstanceFiles` VALUES (4,'4afa8f39584a2',1,1,1,39,5);
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) default NULL,
  `shortdescription` text,
  `description` text NOT NULL,
  `header_embed_code` text,
  `contact` varchar(255) default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Instances` VALUES (1,'4a112157d69eb',1,1,3,'','','','',NULL,3,'2009-06-09 09:35:23','2009-09-01 08:44:56'),(2,'4a112157d69eb',1,2,3,NULL,'','','',NULL,3,'2009-06-09 09:36:01','2009-06-09 17:07:38'),(3,'4a113342dffe5',1,1,3,'','','','',NULL,3,'2009-06-09 16:51:25','2009-09-01 14:07:52'),(4,'4a113342dffe5',1,2,3,NULL,'','','',NULL,3,'2009-06-09 16:52:17','2009-06-09 16:52:25'),(5,'4afa8f39584a2',1,1,3,'Distinguished by innovation','','<p>Healthy teeth produce a radiant smile. We strive to achieve this goal on a daily basis. It inspires us to search for innovative, economic and esthetic solutions for direct filling procedures and the fabrication of indirect, fixed or removable restorations, so that you have quality products at your disposal to help people regain a beautiful smile.</p>\n<div class=\"col02 mBottom20R\"></div>\n<!-- /.colContainer2 -->',NULL,NULL,20,'2009-12-09 14:45:18','2009-12-15 16:01:01'),(6,'4af3cb435ebcf',1,1,3,'','','',NULL,NULL,2,'2009-12-10 09:34:34','2009-12-23 13:54:28'),(7,'4afa971de31f6',1,1,3,'','','',NULL,NULL,3,'2009-12-23 09:25:14','2009-12-23 13:38:50');
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` VALUES (1,'4af3cb435ebcf',1,1,35,21,128),(2,'4afa8f39584a2',1,1,36,24,128),(3,'4afa8f39584a2',1,1,37,24,128),(4,'4afa8f39584a2',1,1,38,24,128),(5,'4afa8f39584a2',1,1,39,24,128),(6,'4afa8f39584a2',1,1,40,24,128),(7,'4afa8f39584a2',1,1,41,24,128),(8,'4af3cb435ebcf',1,1,44,21,128);
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-Region14-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-Region14-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-Region14-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) default NULL,
  `sidebar_description` text,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Region14-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Region14-Instances` VALUES (7,'4a113342dffe5',1,2,1,'',''),(11,'4a112157d69eb',1,2,1,'',''),(21,'4a112157d69eb',1,1,1,'',''),(24,'4a113342dffe5',1,1,1,'',''),(41,'4afa8f39584a2',1,1,1,'bluephase family','<p>With it\'s specially developed polywave&reg; LED, the 2nd  				generation of the bluephase family sets new standards in the dental practice.</p>'),(43,'4afa971de31f6',1,1,1,'',''),(44,'4af3cb435ebcf',1,1,1,'TEST','<p>test</p>');
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_OVERVIEW-1-Region15-Instances`
--

DROP TABLE IF EXISTS `page-DEFAULT_OVERVIEW-1-Region15-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_OVERVIEW-1-Region15-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `entry_title` varchar(255) default NULL,
  `entry_category` bigint(20) unsigned default NULL,
  `entry_label` bigint(20) unsigned default NULL,
  `entry_viewtype` bigint(20) unsigned default NULL,
  `entry_number` bigint(20) unsigned default NULL,
  `entry_sorttype` bigint(20) unsigned default NULL,
  `entry_sortorder` bigint(20) unsigned default NULL,
  `entry_depth` bigint(20) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Region15-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Region15-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Region15-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region15-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Region15-Instances` VALUES (7,'4a113342dffe5',1,2,1,'',0,0,0,0,0,0,NULL),(11,'4a112157d69eb',1,2,1,'',0,0,0,0,0,0,NULL),(21,'4a112157d69eb',1,1,1,'Übersicht',0,0,29,99,18,14,66),(24,'4a113342dffe5',1,1,1,'',0,0,29,100,0,0,0),(41,'4afa8f39584a2',1,1,1,'',67,0,31,6,0,15,0),(43,'4afa971de31f6',1,1,1,'',0,0,0,0,0,0,0),(44,'4af3cb435ebcf',1,1,1,'',0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region15-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PAGE_1-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PAGE_1-1-InstanceFiles` VALUES (92,'4afa9c9f50419',1,1,1,28,5),(103,'4a1133f43284a',1,1,1,39,5),(104,'4a1133f43284a',1,1,1,20,7),(105,'4a1133f43284a',1,1,2,21,7),(106,'4a1133f43284a',1,1,3,22,7),(107,'4a1133f43284a',1,1,4,23,7),(108,'4a1133f43284a',1,1,5,24,7),(109,'4a1133f43284a',1,1,6,25,7),(110,'4a1133f43284a',1,1,7,26,7),(111,'4a1133f43284a',1,1,1,18,8),(112,'4a1133f43284a',1,1,2,17,8);
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` text NOT NULL,
  `description` text,
  `header_embed_code` text,
  `pics_title` varchar(255) default NULL,
  `docs_title` varchar(255) default '',
  `internal_links_title` varchar(255) default NULL,
  `video_title` varchar(255) default NULL,
  `video_embed_code` text,
  `shortdescription` text NOT NULL,
  `contact` varchar(255) default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Instances`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PAGE_1-1-Instances` VALUES (1,'4a112157d69eb',1,1,3,'','','','','','','','','','',2,'2009-05-18 08:50:31','2009-12-22 13:22:50'),(2,'4a113342dffe5',1,1,3,'','','','','',NULL,'','','','',2,'2009-05-18 10:06:58','2009-06-09 16:52:41'),(3,'4a1133f43284a',1,1,3,'','<p>The battery-operated bluephase 20i combines the highest light in- tensity of 2.000 mW/cm2 in the Turbo program with extremely short curing times of no more than 5 seconds for light and dark composi- tes while being gentle to the pulp and the soft tissue. The full capacity of bluephase 20i is particularly useful when consis- tent and maximum performance is required, for instance when all- ceramic restorations are placed or orthodontic brackets are bonded.</p>','','','Test Dokumente','','ZCOPE - gegen das Chaos','','','',2,'2009-05-18 10:09:56','2009-12-15 16:10:40'),(15,'4a112157d69eb',1,2,3,'','','','','','','','','','',3,'2009-06-09 09:34:21','2009-12-16 08:09:48'),(18,'4a2fa65ac1781',1,1,3,'','',NULL,'','',NULL,'','','','',3,'2009-06-10 12:26:02','2009-06-10 12:26:02'),(19,'4a40944a8ee78',1,1,3,'','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum.</p>',NULL,'','',NULL,'','','','',3,'2009-06-23 08:37:30','2009-06-23 08:46:34'),(28,'4a9d42e6cbb25',1,1,3,'','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.</p>\n<p>Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.</p>\n<p>Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.</p>\n<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt.</p>',NULL,'','','','','','','',3,'2009-09-01 15:51:02','2009-09-01 15:53:48'),(34,'4af3cb435ebcf',1,1,3,'','',NULL,'','','','','','','',6,'2009-11-06 07:07:47','2009-12-09 15:30:33'),(35,'4af3cb586f5fa',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-06 07:08:08','2009-11-11 08:54:52'),(39,'4af44cdae2991',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-06 16:20:42','2009-12-15 16:10:09'),(41,'4af831aa753c8',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-09 15:13:46','2009-11-09 15:13:46'),(42,'4af831b710f7b',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-09 15:13:59','2009-11-09 15:13:59'),(58,'4afa8f39584a2',1,1,6,'','',NULL,'','','','','','','',1,'2009-11-11 10:17:29','2009-11-11 15:15:51'),(59,'4afa8f6f3d454',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 10:18:23','2009-12-09 15:31:06'),(60,'4afa8f795055c',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 10:18:33','2009-12-09 15:31:36'),(61,'4afa8f842670c',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 10:18:44','2009-12-09 15:31:11'),(62,'4afa927112636',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 10:31:13','2009-11-11 10:31:13'),(63,'4afa9276f1d58',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 10:31:18','2009-12-15 16:11:18'),(64,'4afa93e2d98c1',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 10:37:22','2009-11-11 10:37:22'),(65,'4afa949103dbe',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 10:40:17','2009-11-11 10:40:17'),(66,'4afa94b78dcd4',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 10:40:55','2009-11-11 10:40:55'),(67,'4afa94c71391b',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 10:41:11','2009-11-11 10:41:11'),(68,'4afa94e26ef70',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 10:41:38','2009-11-11 10:41:38'),(70,'4afa959b266f6',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 10:44:43','2009-11-11 10:44:43'),(71,'4afa95b50c9ef',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 10:45:09','2009-11-11 10:45:09'),(72,'4afa971de31f6',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 10:51:09','2009-12-17 13:19:38'),(73,'4afa976806a14',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 10:52:24','2009-12-09 15:30:46'),(74,'4afa977e8f26f',1,1,1,'','',NULL,'','','','','','','',1,'2009-11-11 10:52:46','2009-11-11 10:52:46'),(75,'4afa97883bd6d',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 10:52:56','2009-12-14 17:18:45'),(76,'4afa97936a799',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 10:53:07','2009-12-14 17:17:57'),(77,'4afa98e578e75',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 10:58:45','2009-11-11 10:58:45'),(79,'4afa99f38c327',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 11:03:15','2009-11-11 11:03:15'),(80,'4afa9a9c05a33',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 11:06:04','2009-11-11 11:06:04'),(81,'4afa9af122cd3',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 11:07:29','2009-11-11 11:07:29'),(82,'4afa9c5d634f6',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 11:13:33','2009-12-15 16:10:14'),(83,'4afa9c9388b0e',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 11:14:27','2009-12-15 16:01:09'),(84,'4afa9c9f50419',1,1,3,'Implant restorations: protected all around','',NULL,'','','','','','','',1,'2009-11-11 11:14:39','2009-12-15 16:01:13'),(85,'4afa9cbaf0044',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 11:15:06','2009-12-15 16:01:17'),(86,'4afa9cc6e7d4f',1,1,3,'','',NULL,'','','','','','','',1,'2009-11-11 11:15:18','2009-12-15 16:01:20'),(87,'4afa9fb2568e1',1,1,2,'','',NULL,'','','','','','','',2,'2009-11-11 11:27:46','2009-11-11 11:27:46'),(88,'4afa9fbf2e718',1,1,2,'','',NULL,'','','','','','','',2,'2009-11-11 11:27:59','2009-11-11 11:27:59'),(89,'4afaab39b1d0a',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 12:16:57','2009-11-11 12:16:57'),(90,'4afaab6431d90',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 12:17:40','2009-11-11 12:17:40'),(91,'4afaacd73c493',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 12:23:51','2009-11-11 12:23:51'),(96,'4afab1fa70f82',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 12:45:46','2009-11-11 12:45:46'),(97,'4afab2058dd99',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 12:45:57','2009-11-11 12:45:57'),(98,'4afab21fe73fa',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 12:46:23','2009-11-11 12:46:23'),(99,'4afab26598a95',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 12:47:33','2009-11-11 12:47:33'),(100,'4afab287a4564',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 12:48:07','2009-11-11 12:48:33'),(102,'4afab4ee48926',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 12:58:22','2009-11-11 12:58:22'),(103,'4afabca603992',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 13:31:18','2009-11-11 13:31:18'),(104,'4afabcb11177c',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 13:31:29','2009-11-11 13:31:29'),(105,'4afabcba797c5',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 13:31:38','2009-11-11 13:31:38'),(106,'4afabccd725fb',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 13:31:57','2009-11-11 13:31:57'),(107,'4afabd4f20841',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 13:34:07','2009-11-11 13:34:07'),(108,'4afabd6eaacec',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 13:34:38','2009-11-11 13:34:38'),(112,'4afacf4f8c775',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 14:50:55','2009-11-11 15:03:31'),(113,'4afad29d86868',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 15:05:01','2009-11-11 15:05:01'),(114,'4afad63cb6099',1,1,3,'','',NULL,'','','','','','','',6,'2009-11-11 15:20:28','2009-12-15 16:01:31'),(115,'4afad7b0dffc0',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 15:26:40','2009-12-15 16:01:35'),(116,'4afad7c8cc1b1',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 15:27:04','2009-12-15 16:01:38'),(119,'4afaddea0d1be',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 15:53:14','2009-11-11 15:53:14'),(120,'4afaddf514681',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-11 15:53:25','2009-11-11 15:53:25'),(124,'4afae253318b0',1,1,3,'','',NULL,'','','','','','','',3,'2009-11-11 16:12:03','2009-12-14 17:19:13'),(125,'4afbe5f14beb2',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-12 10:39:45','2009-11-12 10:39:45'),(126,'4afbe60bdd281',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-12 10:40:11','2009-11-12 10:40:11'),(127,'4afbe64c66f56',1,1,6,'','',NULL,'','','','','','','',6,'2009-11-12 10:41:16','2009-11-12 10:41:16'),(128,'4b1e6e26d1feb',1,1,20,'','',NULL,'','','','','','','',20,'2009-12-08 15:17:58','2009-12-08 15:17:58'),(129,'4b266d69e26b3',1,1,3,'','',NULL,'','','','','','','',3,'2009-12-14 16:52:57','2009-12-14 17:02:48'),(130,'4b266fced3fc0',1,1,3,'','',NULL,'','','','','','','',3,'2009-12-14 17:03:10','2009-12-14 17:03:10'),(131,'4b267193e02c2',1,1,3,'','',NULL,'','','','','','','',3,'2009-12-14 17:10:43','2009-12-14 17:11:51'),(132,'4b2671f0c94cb',1,1,3,'','',NULL,'','','','','','','',3,'2009-12-14 17:12:16','2009-12-14 17:19:22'),(133,'4b26761486caa',1,1,3,'','',NULL,'','','','','','','',3,'2009-12-14 17:29:56','2009-12-14 17:30:10'),(134,'4b27658c8ff9a',1,1,3,'','',NULL,'','','','','','','',3,'2009-12-15 10:31:40','2009-12-15 10:38:43'),(138,'4b30c814deb7b',1,1,3,'','',NULL,'','','','','','','',3,'2009-12-22 13:22:28','2009-12-22 13:25:06');
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `block_title` varchar(255) default NULL,
  `block_description` text,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1235 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Region11-Instances`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Region11-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PAGE_1-1-Region11-Instances` VALUES (113,'4a113342dffe5',1,1,1,'',''),(127,'4a40944a8ee78',1,1,1,'',''),(281,'4a9d42e6cbb25',1,1,1,'',''),(876,'4af3cb586f5fa',1,1,1,'',''),(918,'4afa9fb2568e1',1,1,1,'',''),(919,'4afa9fbf2e718',1,1,1,'',''),(920,'4afaab6431d90',1,1,1,'',''),(939,'4afab1fa70f82',1,1,1,'',''),(942,'4afab287a4564',1,1,1,'',''),(945,'4afabcb11177c',1,1,1,'',''),(946,'4afabccd725fb',1,1,1,'',''),(947,'4afabd6eaacec',1,1,1,'',''),(974,'4afacf4f8c775',1,1,1,'',''),(976,'4afad29d86868',1,1,1,'',''),(978,'4afa8f39584a2',1,1,1,'',''),(1023,'4afbe64c66f56',1,1,1,'',''),(1039,'4af3cb435ebcf',1,1,1,'',''),(1041,'4afa976806a14',1,1,1,'',''),(1043,'4afa8f6f3d454',1,1,1,'',''),(1044,'4afa8f842670c',1,1,1,'',''),(1047,'4afa8f795055c',1,1,1,'',''),(1072,'4b266d69e26b3',1,1,1,'',''),(1079,'4b267193e02c2',1,1,1,'',''),(1081,'4afa97936a799',1,1,1,'',''),(1084,'4afa97883bd6d',1,1,1,'',''),(1086,'4afae253318b0',1,1,1,'',''),(1087,'4b2671f0c94cb',1,1,1,'',''),(1089,'4b26761486caa',1,1,1,'',''),(1098,'4b27658c8ff9a',1,1,1,'',''),(1196,'4afa9c9388b0e',1,1,1,'',''),(1197,'4afa9c9f50419',1,1,1,'',''),(1198,'4afa9cbaf0044',1,1,1,'',''),(1199,'4afa9cc6e7d4f',1,1,1,'',''),(1201,'4afad63cb6099',1,1,1,'',''),(1202,'4afad7b0dffc0',1,1,1,'',''),(1203,'4afad7c8cc1b1',1,1,1,'',''),(1206,'4af44cdae2991',1,1,1,'',''),(1207,'4afa9c5d634f6',1,1,1,'',''),(1208,'4a1133f43284a',1,1,1,'',''),(1209,'4afa9276f1d58',1,1,1,'',''),(1216,'4a112157d69eb',1,2,1,'',''),(1219,'4afa971de31f6',1,1,1,'',''),(1230,'4a112157d69eb',1,1,1,'',''),(1234,'4b30c814deb7b',1,1,1,'','');
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PROCESS-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PROCESS-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PROCESS-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `description` text,
  `shortdescription` text,
  `department` varchar(255) default NULL,
  `position` varchar(255) default NULL,
  `content_responsible` varchar(255) default NULL,
  `organizational_responsible` varchar(255) default NULL,
  `process_inputs` text,
  `process_output` text,
  `process_indicator` text,
  `process_instructions` text,
  `process_techniques` text,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `instruction_title` varchar(255) default NULL,
  `instruction_description` text,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `steps_title` varchar(255) default NULL,
  `steps_text` text,
  `steps_who` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `risk_description` text NOT NULL,
  `risk_measure` text NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `rule_title` varchar(255) default NULL,
  `rule_text` text,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles` VALUES (3,'4afa971de31f6',1,1,1,37,5);
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PRODUCT_TREE-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) default NULL,
  `entry_title` varchar(255) default NULL,
  `entry_product_point` bigint(20) unsigned default NULL,
  `entry_category` bigint(20) unsigned default NULL,
  `entry_label` bigint(20) unsigned default NULL,
  `shortdescription` text,
  `description` text,
  `contact` varchar(255) default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PRODUCT_TREE-1-Instances`
--

LOCK TABLES `page-DEFAULT_PRODUCT_TREE-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PRODUCT_TREE-1-Instances` VALUES (1,'4afa971de31f6',1,1,3,'','Dental Professional',31,0,0,'','','',3,'2009-12-23 14:24:06','2009-12-23 14:48:21');
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) default NULL,
  `sidebar_description` text,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` VALUES (3,'4afa971de31f6',1,1,1,'','');
/*!40000 ALTER TABLE `page-DEFAULT_PRODUCT_TREE-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_STARTPAGE-1-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_STARTPAGE-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_STARTPAGE-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) default NULL,
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
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-Instances`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_STARTPAGE-1-Instances` VALUES (1,'49f17460a4f9f',1,2,3,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2009-06-10 07:47:53','2009-07-08 17:05:38'),(2,'49f17460a4f9f',1,1,3,'','<p>asdf</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2009-07-21 16:54:37','2009-12-15 16:00:32');
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles`
--

DROP TABLE IF EXISTS `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `block_title` varchar(255) default NULL,
  `block_description` text,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `entry_title` varchar(255) default NULL,
  `entry_nav_point` bigint(20) unsigned default NULL,
  `entry_category` bigint(20) unsigned default NULL,
  `entry_label` bigint(20) unsigned default NULL,
  `entry_number` bigint(20) unsigned default NULL,
  `entry_sorttype` bigint(20) unsigned default NULL,
  `entry_sortorder` bigint(20) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region17-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-Region17-Instances`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-Region17-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region17-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_STARTPAGE-1-Region17-Instances` VALUES (2,'49f17460a4f9f',1,2,1,'',0,0,0,0,0,0),(28,'49f17460a4f9f',1,1,1,'',0,0,0,0,0,0);
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region17-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageCategories`
--

DROP TABLE IF EXISTS `pageCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageCategories` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `category` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageCategories_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageCategories`
--

LOCK TABLES `pageCategories` WRITE;
/*!40000 ALTER TABLE `pageCategories` DISABLE KEYS */;
INSERT INTO `pageCategories` VALUES (113,'4a113342dffe5',1,1,54,3,3,'2009-09-01 14:07:52','2009-09-01 14:07:52'),(156,'4afa9c9388b0e',1,1,67,3,3,'2009-12-15 16:01:09','2009-12-15 16:01:09'),(157,'4afa9c9f50419',1,1,67,3,3,'2009-12-15 16:01:13','2009-12-15 16:01:13'),(158,'4afa9cbaf0044',1,1,67,3,3,'2009-12-15 16:01:17','2009-12-15 16:01:17'),(161,'4a112157d69eb',1,2,54,3,3,'2009-12-16 08:09:48','2009-12-16 08:09:48'),(162,'4a112157d69eb',1,1,53,3,3,'2009-12-22 13:22:50','2009-12-22 13:22:50');
/*!40000 ALTER TABLE `pageCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageCollections`
--

DROP TABLE IF EXISTS `pageCollections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageCollections` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) NOT NULL,
  `collectedPageId` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageCollections_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageCollections`
--

LOCK TABLES `pageCollections` WRITE;
/*!40000 ALTER TABLE `pageCollections` DISABLE KEYS */;
INSERT INTO `pageCollections` VALUES (337,'4af3cb435ebcf',1,1,1,'',2,2,'2009-12-10 09:40:10','2009-12-10 09:40:10'),(388,'4a40944a8ee78',1,1,1,'4a115ca65d8bb',3,3,'2009-12-15 13:23:35','2009-12-15 13:23:35'),(389,'4a40944a8ee78',1,1,2,'4a676ebfe3a7a',3,3,'2009-12-15 13:23:35','2009-12-15 13:23:35'),(390,'4a40944a8ee78',1,1,3,'4a113342dffe5',3,3,'2009-12-15 13:23:35','2009-12-15 13:23:35'),(391,'4a40944a8ee78',1,1,4,'4a40946ce9d01',3,3,'2009-12-15 13:23:35','2009-12-15 13:23:35'),(392,'4a40944a8ee78',1,1,5,'4a978dcd034e2',3,3,'2009-12-15 13:23:35','2009-12-15 13:23:35'),(393,'4a40944a8ee78',1,1,6,'4a9d42e6cbb25',3,3,'2009-12-15 13:23:35','2009-12-15 13:23:35'),(394,'4a112157d69eb',1,1,1,'4a40944a8ee78',3,3,'2009-12-15 14:08:09','2009-12-15 14:08:09'),(395,'4a112157d69eb',1,1,2,'4a115ca65d8bb',3,3,'2009-12-15 14:08:09','2009-12-15 14:08:09'),(396,'4a112157d69eb',1,1,3,'4a676ebfe3a7a',3,3,'2009-12-15 14:08:09','2009-12-15 14:08:09'),(397,'4a112157d69eb',1,1,4,'4a681b0f66d2a',3,3,'2009-12-15 14:08:09','2009-12-15 14:08:09');
/*!40000 ALTER TABLE `pageCollections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageContacts`
--

DROP TABLE IF EXISTS `pageContacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageContacts` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idContacts` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `datetime` varchar(255) default NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `external` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `pageExternals_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageExternals`
--

LOCK TABLES `pageExternals` WRITE;
/*!40000 ALTER TABLE `pageExternals` DISABLE KEYS */;
INSERT INTO `pageExternals` VALUES (2,'4a113342dffe5',1,1,'http://www.getzcope.com',3,2,'2009-06-23 09:51:29','2009-07-08 17:14:19');
/*!40000 ALTER TABLE `pageExternals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageGmaps`
--

DROP TABLE IF EXISTS `pageGmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageGmaps` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageGmaps_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=713 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageGmaps`
--

LOCK TABLES `pageGmaps` WRITE;
/*!40000 ALTER TABLE `pageGmaps` DISABLE KEYS */;
INSERT INTO `pageGmaps` VALUES (77,'4a9d42e6cbb25',1,1,'47.503042','9.747067',3,NULL,'2009-09-01 15:53:48'),(400,'4af3cb586f5fa',1,1,'47.503042','9.747067',6,NULL,'2009-11-11 08:54:52'),(423,'4afa9fb2568e1',1,1,'47.503042','9.747067',2,NULL,'2009-11-11 11:27:46'),(424,'4afa9fbf2e718',1,1,'47.503042','9.747067',2,NULL,'2009-11-11 11:27:59'),(425,'4afaab6431d90',1,1,'47.503042','9.747067',3,NULL,'2009-11-11 12:17:40'),(441,'4afab287a4564',1,1,'47.503042','9.747067',6,NULL,'2009-11-11 12:48:33'),(444,'4afabcb11177c',1,1,'47.503042','9.747067',6,NULL,'2009-11-11 13:31:29'),(445,'4afabccd725fb',1,1,'47.503042','9.747067',6,NULL,'2009-11-11 13:31:57'),(446,'4afabd6eaacec',1,1,'47.503042','9.747067',6,NULL,'2009-11-11 13:34:38'),(464,'4afacf4f8c775',1,1,'47.503042','9.747067',3,NULL,'2009-11-11 15:03:31'),(466,'4afad29d86868',1,1,'47.503042','9.747067',3,NULL,'2009-11-11 15:05:01'),(468,'4afa8f39584a2',1,1,'47.503042','9.747067',6,NULL,'2009-11-11 15:15:51'),(504,'4afbe64c66f56',1,1,'47.503042','9.747067',6,NULL,'2009-11-12 10:41:16'),(520,'4af3cb435ebcf',1,1,'47.503042','9.747067',3,NULL,'2009-12-09 15:30:33'),(522,'4afa976806a14',1,1,'47.503042','9.747067',3,NULL,'2009-12-09 15:30:46'),(524,'4afa8f6f3d454',1,1,'47.503042','9.747067',3,NULL,'2009-12-09 15:31:06'),(525,'4afa8f842670c',1,1,'47.503042','9.747067',3,NULL,'2009-12-09 15:31:11'),(528,'4afa8f795055c',1,1,'47.503042','9.747067',3,NULL,'2009-12-09 15:31:36'),(553,'4b266d69e26b3',1,1,'47.503042','9.747067',3,NULL,'2009-12-14 17:02:48'),(560,'4b267193e02c2',1,1,'47.503042','9.747067',3,NULL,'2009-12-14 17:11:51'),(562,'4afa97936a799',1,1,'47.503042','9.747067',3,NULL,'2009-12-14 17:17:57'),(565,'4afa97883bd6d',1,1,'47.503042','9.747067',3,NULL,'2009-12-14 17:18:45'),(567,'4afae253318b0',1,1,'47.503042','9.747067',3,NULL,'2009-12-14 17:19:13'),(568,'4b2671f0c94cb',1,1,'47.503042','9.747067',3,NULL,'2009-12-14 17:19:22'),(570,'4b26761486caa',1,1,'47.503042','9.747067',3,NULL,'2009-12-14 17:30:10'),(579,'4b27658c8ff9a',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 10:38:43'),(674,'4afa9c9388b0e',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:01:09'),(675,'4afa9c9f50419',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:01:13'),(676,'4afa9cbaf0044',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:01:17'),(677,'4afa9cc6e7d4f',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:01:20'),(679,'4afad63cb6099',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:01:31'),(680,'4afad7b0dffc0',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:01:35'),(681,'4afad7c8cc1b1',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:01:38'),(684,'4af44cdae2991',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:10:09'),(685,'4afa9c5d634f6',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:10:14'),(686,'4a1133f43284a',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:10:40'),(687,'4afa9276f1d58',1,1,'47.503042','9.747067',3,NULL,'2009-12-15 16:11:18'),(697,'4afa971de31f6',1,1,'47.503042','9.747067',3,NULL,'2009-12-17 13:19:38'),(708,'4a112157d69eb',1,1,'47.503042','9.747067',3,NULL,'2009-12-22 13:22:50'),(712,'4b30c814deb7b',1,1,'47.503042','9.747067',3,NULL,'2009-12-22 13:25:06');
/*!40000 ALTER TABLE `pageGmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageInternalLinks`
--

DROP TABLE IF EXISTS `pageInternalLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageInternalLinks` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) NOT NULL,
  `linkedPageId` varchar(32) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  KEY `linkedPageId` (`linkedPageId`),
  CONSTRAINT `pageInternalLinks_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `pageInternalLinks_ibfk_2` FOREIGN KEY (`linkedPageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageInternalLinks`
--

LOCK TABLES `pageInternalLinks` WRITE;
/*!40000 ALTER TABLE `pageInternalLinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageInternalLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageLabels`
--

DROP TABLE IF EXISTS `pageLabels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageLabels` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `label` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idPages` bigint(20) unsigned NOT NULL,
  `pageId` varchar(32) NOT NULL COMMENT 'linked page',
  PRIMARY KEY  (`id`),
  KEY `idPages` (`idPages`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `pageLinks_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `pageLinks_ibfk_2` FOREIGN KEY (`idPages`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageLinks`
--

LOCK TABLES `pageLinks` WRITE;
/*!40000 ALTER TABLE `pageLinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagePermissions`
--

DROP TABLE IF EXISTS `pagePermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagePermissions` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idPages` bigint(20) unsigned NOT NULL,
  `idPermissions` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
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
-- Table structure for table `pageRegistrations`
--

DROP TABLE IF EXISTS `pageRegistrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageRegistrations` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idPage` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `sname` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `address` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `plz` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `club` varchar(255) default NULL,
  `infos` text,
  `created` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `pageTitles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTitles`
--

LOCK TABLES `pageTitles` WRITE;
/*!40000 ALTER TABLE `pageTitles` DISABLE KEYS */;
INSERT INTO `pageTitles` VALUES (1,'49f17460a4f9f',1,1,'Home',3,3,'2009-04-24 08:12:16','2009-12-15 16:00:32'),(2,'4a112157d69eb',1,1,'Products',3,2,'2009-05-18 08:50:31','2009-12-22 13:22:50'),(3,'4a113342dffe5',1,1,'Hauptpunkt 2',3,2,'2009-05-18 10:06:58','2009-09-01 14:07:52'),(4,'4a1133f43284a',1,1,'Company',3,2,'2009-05-18 10:09:56','2009-12-15 16:10:40'),(9,'4a112157d69eb',1,2,'Main Navigation 1',3,2,NULL,'2009-12-16 08:09:48'),(11,'4a113342dffe5',1,2,'Main Navigation 2',3,2,NULL,'2009-06-09 16:52:25'),(12,'49f17460a4f9f',1,2,'Home',3,3,'2009-06-10 07:48:53','2009-07-08 17:05:38'),(13,'4a2fa65ac1781',1,1,'asdf',3,3,'2009-06-10 12:26:02','2009-06-10 12:26:02'),(14,'4a40944a8ee78',1,1,'Kollektion 1',3,3,'2009-06-23 08:37:30','2009-12-15 13:23:35'),(24,'4a9d42e6cbb25',1,1,'Test Seite 2.1',3,3,'2009-09-01 15:51:02','2009-09-01 15:53:48'),(30,'4af3cb435ebcf',1,1,'Laboratory Professional',3,6,'2009-11-06 07:07:47','2009-12-23 13:54:28'),(31,'4af3cb586f5fa',1,1,'die seite',6,6,'2009-11-06 07:08:08','2009-11-11 08:54:52'),(35,'4af44cdae2991',1,1,'History',3,3,'2009-11-06 16:20:42','2009-12-15 16:10:09'),(37,'4af831aa753c8',1,1,'folderblub',20,6,'2009-11-09 15:13:46','2009-12-09 14:21:09'),(38,'4af831b710f7b',1,1,'folderblublub',6,6,'2009-11-09 15:13:59','2009-11-09 15:13:59'),(54,'4afa8f39584a2',1,1,'Press',3,1,'2009-11-11 10:17:29','2009-12-15 16:01:01'),(55,'4afa8f6f3d454',1,1,'Career',3,1,'2009-11-11 10:18:23','2009-12-09 15:31:06'),(56,'4afa8f795055c',1,1,'Support',3,1,'2009-11-11 10:18:33','2009-12-09 15:31:36'),(57,'4afa8f842670c',1,1,'Contact',3,1,'2009-11-11 10:18:44','2009-12-09 15:31:11'),(58,'4afa927112636',1,1,'asdf',3,3,'2009-11-11 10:31:13','2009-11-11 10:31:13'),(59,'4afa9276f1d58',1,1,'Schaan',3,1,'2009-11-11 10:31:18','2009-12-15 16:11:18'),(60,'4afa93e2d98c1',1,1,'Test Folder 2',3,3,'2009-11-11 10:37:22','2009-11-11 10:38:12'),(61,'4afa949103dbe',1,1,'Test Thomas',3,3,'2009-11-11 10:40:17','2009-11-11 10:40:17'),(62,'4afa94b78dcd4',1,1,'Test Thomas',3,3,'2009-11-11 10:40:55','2009-11-11 10:40:55'),(63,'4afa94c71391b',1,1,'asdf',3,3,'2009-11-11 10:41:11','2009-11-11 10:41:11'),(64,'4afa94e26ef70',1,1,'asdf',3,3,'2009-11-11 10:41:38','2009-11-11 10:41:38'),(66,'4afa959b266f6',1,1,'asdf',3,3,'2009-11-11 10:44:43','2009-11-11 10:44:43'),(67,'4afa95b50c9ef',1,1,'asdf',20,3,'2009-11-11 10:45:09','2009-12-09 14:21:16'),(68,'4afa971de31f6',1,1,'Dental Professional',3,1,'2009-11-11 10:51:09','2009-12-23 14:48:21'),(69,'4afa976806a14',1,1,'All Products',3,1,'2009-11-11 10:52:24','2009-12-09 15:30:46'),(70,'4afa977e8f26f',1,1,'Products',1,1,'2009-11-11 10:52:46','2009-11-11 10:52:46'),(71,'4afa97883bd6d',1,1,'Service',3,1,'2009-11-11 10:52:56','2009-12-14 17:18:45'),(72,'4afa97936a799',1,1,'Education Courses',3,1,'2009-11-11 10:53:07','2009-12-14 17:17:57'),(73,'4afa98e578e75',1,1,'domis ordner',6,6,'2009-11-11 10:58:45','2009-11-11 10:58:45'),(75,'4afa99f38c327',1,1,'test ordner domi',6,6,'2009-11-11 11:03:15','2009-11-11 11:03:15'),(76,'4afa9a9c05a33',1,1,'test',6,6,'2009-11-11 11:06:04','2009-11-11 11:06:04'),(77,'4afa9af122cd3',1,1,'ettetaset',6,6,'2009-11-11 11:07:29','2009-11-11 11:07:29'),(78,'4afa9c5d634f6',1,1,'Facts & Figures',3,1,'2009-11-11 11:13:33','2009-12-15 16:10:14'),(79,'4afa9c9388b0e',1,1,'Press Pictures',3,1,'2009-11-11 11:14:27','2009-12-15 16:01:09'),(80,'4afa9c9f50419',1,1,'Implant restorations',3,1,'2009-11-11 11:14:39','2009-12-15 16:01:13'),(81,'4afa9cbaf0044',1,1,'Definitely quicker',3,1,'2009-11-11 11:15:06','2009-12-15 16:01:17'),(82,'4afa9cc6e7d4f',1,1,'The better way of tooth isolation',3,1,'2009-11-11 11:15:18','2009-12-15 16:01:20'),(83,'4afa9fb2568e1',1,1,'Home',2,2,'2009-11-11 11:27:46','2009-11-11 11:27:46'),(84,'4afa9fbf2e718',1,1,'Home',2,2,'2009-11-11 11:27:59','2009-11-11 11:27:59'),(85,'4afaab39b1d0a',1,1,'asdf',3,3,'2009-11-11 12:16:57','2009-11-11 12:16:57'),(86,'4afaab6431d90',1,1,'Test Seite',3,3,'2009-11-11 12:17:40','2009-11-11 12:17:40'),(87,'4afaacd73c493',1,1,'testtest',6,6,'2009-11-11 12:23:51','2009-11-11 12:23:51'),(92,'4afab1fa70f82',1,1,'gsdfgfg',6,6,'2009-11-11 12:45:46','2009-11-11 12:45:46'),(93,'4afab2058dd99',1,1,'fgdfg',6,6,'2009-11-11 12:45:57','2009-11-11 12:47:02'),(94,'4afab21fe73fa',1,1,'domi test',6,6,'2009-11-11 12:46:23','2009-11-11 12:46:23'),(95,'4afab26598a95',1,1,'dupi',6,6,'2009-11-11 12:47:33','2009-11-11 12:47:33'),(96,'4afab287a4564',1,1,'test',6,6,'2009-11-11 12:48:07','2009-11-11 12:48:33'),(98,'4afab4ee48926',1,1,'afaef',6,6,'2009-11-11 12:58:22','2009-11-11 12:58:22'),(99,'4afabca603992',1,1,'fasdfasdf',6,6,'2009-11-11 13:31:18','2009-11-11 13:31:18'),(100,'4afabcb11177c',1,1,'asdfasdfasdf',6,6,'2009-11-11 13:31:29','2009-11-11 13:31:29'),(101,'4afabcba797c5',1,1,'43f34f3f4',6,6,'2009-11-11 13:31:38','2009-11-11 13:31:38'),(102,'4afabccd725fb',1,1,'sdafsadfdsf',6,6,'2009-11-11 13:31:57','2009-11-11 13:31:57'),(103,'4afabd4f20841',1,1,'asdf',6,6,'2009-11-11 13:34:07','2009-11-11 13:34:07'),(104,'4afabd6eaacec',1,1,'rfafaf',6,6,'2009-11-11 13:34:38','2009-11-11 13:34:38'),(108,'4afacf4f8c775',1,1,'Support 1',3,3,'2009-11-11 14:50:55','2009-11-11 15:03:31'),(109,'4afad29d86868',1,1,'Support 2',3,3,'2009-11-11 15:05:01','2009-11-11 15:05:01'),(110,'4afad63cb6099',1,1,'test',3,6,'2009-11-11 15:20:28','2009-12-15 16:01:31'),(111,'4afad7b0dffc0',1,1,'Test',3,3,'2009-11-11 15:26:40','2009-12-15 16:01:35'),(112,'4afad7c8cc1b1',1,1,'Test2',3,3,'2009-11-11 15:27:04','2009-12-15 16:01:38'),(115,'4afaddea0d1be',1,1,'testordner',6,6,'2009-11-11 15:53:14','2009-11-11 15:53:14'),(116,'4afaddf514681',1,1,'testordner2',6,6,'2009-11-11 15:53:25','2009-11-11 15:53:25'),(120,'4afae253318b0',1,1,'Test Thomas',3,3,'2009-11-11 16:12:03','2009-12-14 17:19:13'),(121,'4afbe5f14beb2',1,1,'DEFAULT_PRODUCT_FOLDER',6,6,'2009-11-12 10:39:45','2009-11-12 10:39:45'),(122,'4afbe60bdd281',1,1,'DEFAULT_PRODUCT',6,6,'2009-11-12 10:40:11','2009-11-12 10:40:11'),(123,'4afbe64c66f56',1,1,'default_prod_test',6,6,'2009-11-12 10:41:16','2009-11-12 10:41:16'),(124,'4b1e6e26d1feb',1,1,'Company',20,20,'2009-12-08 15:17:58','2009-12-08 15:17:58'),(125,'4b266d69e26b3',1,1,'All-Products',3,3,'2009-12-14 16:52:57','2009-12-14 17:02:48'),(126,'4b266fced3fc0',1,1,'asdf',3,3,'2009-12-14 17:03:10','2009-12-14 17:03:10'),(127,'4b267193e02c2',1,1,'asdf',3,3,'2009-12-14 17:10:43','2009-12-14 17:11:51'),(128,'4b2671f0c94cb',1,1,'All Products',3,3,'2009-12-14 17:12:16','2009-12-14 17:19:22'),(129,'4b26761486caa',1,1,'Products',3,3,'2009-12-14 17:29:56','2009-12-14 17:30:10'),(130,'4b27658c8ff9a',1,1,'Neue Testseite',3,3,'2009-12-15 10:31:40','2009-12-15 10:38:43'),(134,'4b30c814deb7b',1,1,'Test',3,3,'2009-12-22 13:22:28','2009-12-22 13:25:06');
/*!40000 ALTER TABLE `pageTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageTypeTitles`
--

DROP TABLE IF EXISTS `pageTypeTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageTypeTitles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idPageTypes` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `page` tinyint(1) NOT NULL default '0',
  `startpage` tinyint(1) NOT NULL default '0',
  `active` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `userId` varchar(32) NOT NULL,
  `videoId` varchar(64) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `idVideoTypes` int(10) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageVideos_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageVideos`
--

LOCK TABLES `pageVideos` WRITE;
/*!40000 ALTER TABLE `pageVideos` DISABLE KEYS */;
INSERT INTO `pageVideos` VALUES (177,'4a1133f43284a',1,1,'zcope','4643094','http://ts.vimeo.com.s3.amazonaws.com/121/778/12177888_100.jpg',1,3,'2009-12-15 16:10:40');
/*!40000 ALTER TABLE `pageVideos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idPageTypes` bigint(20) unsigned NOT NULL,
  `isStartPage` tinyint(1) NOT NULL default '0',
  `showInNavigation` tinyint(1) NOT NULL default '0',
  `idParent` bigint(20) unsigned NOT NULL,
  `idParentTypes` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `sortPosition` bigint(20) unsigned NOT NULL,
  `sortTimestamp` timestamp NULL default NULL,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `publisher` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `published` timestamp NULL default NULL,
  `idStatus` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,8,3,1,1,1,1,1,3,0,'2009-04-24 08:12:50','49f17460a4f9f',1,3,0,'2009-04-24 08:12:50','2009-12-15 16:00:32','2009-04-24 08:12:50',2),(2,2,2,1,1,1,1,2,3,0,'2009-05-18 08:50:31','4a112157d69eb',1,2,0,'2009-05-18 08:50:31','2009-12-22 13:22:50','2009-06-09 09:34:19',2),(3,7,4,3,1,1,2,2,3,0,'2009-05-18 10:06:58','4a113342dffe5',1,2,0,'2009-05-18 10:06:58','2009-09-01 14:07:52','2009-06-09 16:51:23',2),(4,2,2,1,1,1,3,2,3,0,'2009-05-18 10:09:56','4a1133f43284a',1,2,0,'2009-05-18 10:09:56','2009-12-15 16:10:40','2009-09-01 08:45:11',2),(8,2,2,1,1,0,12,2,3,0,'2009-06-10 12:26:02','4a2fa65ac1781',1,3,0,'2009-06-10 12:26:02','2009-06-10 12:26:02',NULL,1),(9,15,10,6,1,1,6,2,3,0,'2009-06-23 08:37:30','4a40944a8ee78',1,3,0,'2009-06-23 08:37:30','2009-12-15 13:23:35','2009-06-23 08:46:21',2),(16,2,1,1,0,1,2,2,3,2,'2009-09-01 15:51:02','4a9d42e6cbb25',1,3,0,'2009-09-01 15:51:02','2009-09-01 15:53:48','2009-09-01 15:50:39',2),(22,7,4,3,1,0,10,2,3,0,'2009-11-06 07:07:47','4af3cb435ebcf',1,6,0,'2009-11-06 07:07:47','2009-12-23 13:54:28','2009-11-09 13:58:17',2),(23,2,1,1,0,0,10,2,6,1,'2009-11-06 07:08:08','4af3cb586f5fa',1,6,0,'2009-11-06 07:08:08','2009-11-11 08:54:52','2009-11-11 08:54:39',1),(27,2,2,1,1,1,14,2,3,0,'2009-11-06 16:20:42','4af44cdae2991',1,3,0,'2009-11-06 16:20:42','2009-12-15 16:10:08','2009-11-12 08:57:06',2),(29,2,2,1,1,1,17,2,20,0,'2009-11-09 15:13:46','4af831aa753c8',1,6,0,'2009-11-09 15:13:46','2009-12-09 14:21:09',NULL,2),(30,2,2,1,1,0,18,2,6,0,'2009-11-09 15:13:59','4af831b710f7b',1,6,0,'2009-11-09 15:13:59','2009-11-09 15:13:59',NULL,1),(45,7,4,3,1,1,27,2,3,0,'2009-11-11 10:17:29','4afa8f39584a2',1,1,0,'2009-11-11 10:17:29','2009-12-15 16:01:01','2009-11-11 12:24:34',2),(46,2,2,1,1,1,28,2,3,0,'2009-11-11 10:18:23','4afa8f6f3d454',1,1,0,'2009-11-11 10:18:23','2009-12-09 15:31:06','2009-11-11 12:24:49',2),(47,2,2,1,1,1,29,2,3,0,'2009-11-11 10:18:33','4afa8f795055c',1,1,0,'2009-11-11 10:18:33','2009-12-09 15:31:36','2009-11-11 12:25:21',2),(48,2,2,1,1,1,30,2,3,0,'2009-11-11 10:18:44','4afa8f842670c',1,1,0,'2009-11-11 10:18:44','2009-12-09 15:31:11','2009-11-11 12:25:01',2),(49,2,2,1,1,0,43,2,3,0,'2009-11-11 10:31:13','4afa927112636',1,3,0,'2009-11-11 10:31:13','2009-11-11 10:31:13',NULL,1),(50,2,2,1,1,1,44,2,3,0,'2009-11-11 10:31:18','4afa9276f1d58',1,1,0,'2009-11-11 10:31:18','2009-12-15 16:11:18','2009-11-11 15:20:17',2),(51,2,2,1,1,0,45,2,3,0,'2009-11-11 10:37:22','4afa93e2d98c1',1,3,0,'2009-11-11 10:37:22','2009-11-11 10:38:12',NULL,1),(52,2,2,1,1,0,53,2,3,0,'2009-11-11 10:40:17','4afa949103dbe',1,3,0,'2009-11-11 10:40:17','2009-11-11 10:40:17',NULL,1),(53,2,2,1,1,0,57,2,3,0,'2009-11-11 10:40:55','4afa94b78dcd4',1,3,0,'2009-11-11 10:40:55','2009-11-11 10:40:55',NULL,1),(54,2,2,1,1,0,60,2,3,0,'2009-11-11 10:41:11','4afa94c71391b',1,3,0,'2009-11-11 10:41:11','2009-11-11 10:41:11',NULL,1),(55,2,2,1,1,0,61,2,3,0,'2009-11-11 10:41:38','4afa94e26ef70',1,3,0,'2009-11-11 10:41:38','2009-11-11 10:41:38',NULL,1),(57,2,2,1,1,0,62,2,3,0,'2009-11-11 10:44:43','4afa959b266f6',1,3,0,'2009-11-11 10:44:43','2009-11-11 10:44:43',NULL,1),(58,2,2,1,1,1,63,2,20,0,'2009-11-11 10:45:09','4afa95b50c9ef',1,3,0,'2009-11-11 10:45:09','2009-12-09 14:21:16',NULL,2),(59,18,13,7,1,0,67,2,3,0,'2009-11-11 10:51:09','4afa971de31f6',1,1,0,'2009-11-11 10:51:09','2009-12-23 14:48:21','2009-11-11 12:18:53',2),(60,2,2,1,1,0,68,2,3,0,'2009-11-11 10:52:24','4afa976806a14',1,1,0,'2009-11-11 10:52:24','2009-12-09 15:30:46','2009-11-11 12:24:19',2),(61,2,2,1,1,0,69,2,1,0,'2009-11-11 10:52:46','4afa977e8f26f',1,1,0,'2009-11-11 10:52:46','2009-11-11 10:52:46',NULL,1),(62,2,2,1,1,0,70,2,3,0,'2009-11-11 10:52:56','4afa97883bd6d',1,1,0,'2009-11-11 10:52:56','2009-12-14 17:18:45','2009-11-11 12:26:48',1),(63,2,2,1,1,0,71,2,3,0,'2009-11-11 10:53:07','4afa97936a799',1,1,0,'2009-11-11 10:53:07','2009-12-14 17:17:57','2009-11-11 12:49:46',1),(64,2,2,1,1,0,72,2,6,0,'2009-11-11 10:58:45','4afa98e578e75',1,6,0,'2009-11-11 10:58:45','2009-11-11 10:58:45',NULL,1),(66,2,2,1,1,0,78,2,6,0,'2009-11-11 11:03:15','4afa99f38c327',1,6,0,'2009-11-11 11:03:15','2009-11-11 11:03:15',NULL,1),(67,2,2,1,1,0,79,2,6,0,'2009-11-11 11:06:04','4afa9a9c05a33',1,6,0,'2009-11-11 11:06:04','2009-11-11 11:06:04',NULL,1),(68,2,2,1,1,0,80,2,6,0,'2009-11-11 11:07:29','4afa9af122cd3',1,6,0,'2009-11-11 11:07:29','2009-11-11 11:07:29',NULL,1),(69,2,2,1,1,1,81,2,3,0,'2009-11-11 11:13:33','4afa9c5d634f6',1,1,0,'2009-11-11 11:13:33','2009-12-15 16:10:14','2009-12-09 15:32:42',2),(70,2,2,1,1,1,82,2,3,0,'2009-11-11 11:14:27','4afa9c9388b0e',1,1,0,'2009-11-11 11:14:27','2009-12-15 16:01:09','2009-12-10 09:38:30',2),(71,2,1,1,0,1,27,2,3,2,'2009-11-11 11:14:39','4afa9c9f50419',1,1,0,'2009-11-11 11:14:39','2009-12-15 16:01:13','2009-11-11 11:14:35',2),(72,2,1,1,0,1,27,2,3,3,'2009-11-11 11:15:06','4afa9cbaf0044',1,1,0,'2009-11-11 11:15:06','2009-12-15 16:01:17','2009-12-10 09:38:08',2),(73,2,1,1,0,1,27,2,3,4,'2009-11-11 11:15:18','4afa9cc6e7d4f',1,1,0,'2009-11-11 11:15:18','2009-12-15 16:01:20','2009-12-10 09:38:15',2),(74,8,3,1,1,1,13,1,2,0,'2009-11-11 11:28:55','4afa9fb2568e1',1,2,0,'2009-11-11 11:28:55','2009-11-11 11:28:55',NULL,2),(75,8,3,1,1,1,14,1,2,0,'2009-11-11 11:28:55','4afa9fbf2e718',1,2,0,'2009-11-11 11:28:55','2009-11-11 11:28:55',NULL,2),(76,2,2,1,1,0,83,2,3,0,'2009-11-11 12:16:57','4afaab39b1d0a',1,3,0,'2009-11-11 12:16:57','2009-11-11 12:16:57',NULL,1),(77,2,1,1,0,0,10,2,3,2,'2009-11-11 12:17:40','4afaab6431d90',1,3,0,'2009-11-11 12:17:40','2009-11-11 12:17:40',NULL,1),(78,2,2,1,1,0,84,2,6,0,'2009-11-11 12:23:51','4afaacd73c493',1,6,0,'2009-11-11 12:23:51','2009-11-11 12:23:51',NULL,1),(83,2,1,1,0,0,84,2,6,1,'2009-11-11 12:45:46','4afab1fa70f82',1,6,0,'2009-11-11 12:45:46','2009-11-11 12:45:46',NULL,1),(84,2,2,1,1,0,85,2,6,0,'2009-11-11 12:45:57','4afab2058dd99',1,6,0,'2009-11-11 12:45:57','2009-11-11 12:47:02',NULL,1),(85,2,2,1,1,0,86,2,6,0,'2009-11-11 12:46:23','4afab21fe73fa',1,6,0,'2009-11-11 12:46:23','2009-11-11 12:46:23',NULL,1),(86,2,2,1,1,0,87,2,6,0,'2009-11-11 12:47:33','4afab26598a95',1,6,0,'2009-11-11 12:47:33','2009-11-11 12:47:33',NULL,1),(87,2,2,1,1,0,88,2,6,0,'2009-11-11 12:48:07','4afab287a4564',1,6,0,'2009-11-11 12:48:07','2009-11-11 12:48:33','2009-11-11 12:48:28',1),(89,2,2,1,1,0,89,2,6,0,'2009-11-11 12:58:22','4afab4ee48926',1,6,0,'2009-11-11 12:58:22','2009-11-11 12:58:22',NULL,1),(90,2,2,1,1,0,90,2,6,0,'2009-11-11 13:31:18','4afabca603992',1,6,0,'2009-11-11 13:31:18','2009-11-11 13:31:18',NULL,1),(91,2,1,1,0,0,90,2,6,1,'2009-11-11 13:31:29','4afabcb11177c',1,6,0,'2009-11-11 13:31:29','2009-11-11 13:31:29',NULL,1),(92,2,2,1,1,0,91,2,6,0,'2009-11-11 13:31:38','4afabcba797c5',1,6,0,'2009-11-11 13:31:38','2009-11-11 13:31:38',NULL,1),(93,2,1,1,0,0,91,2,6,1,'2009-11-11 13:31:57','4afabccd725fb',1,6,0,'2009-11-11 13:31:57','2009-11-11 13:31:57',NULL,1),(94,2,2,1,1,0,92,2,6,0,'2009-11-11 13:34:07','4afabd4f20841',1,6,0,'2009-11-11 13:34:07','2009-11-11 13:34:07',NULL,1),(95,2,1,1,0,0,92,2,6,1,'2009-11-11 13:34:38','4afabd6eaacec',1,6,0,'2009-11-11 13:34:38','2009-11-11 13:34:38',NULL,1),(99,2,1,1,0,0,29,2,3,1,'2009-11-11 14:50:55','4afacf4f8c775',1,3,0,'2009-11-11 14:50:55','2009-11-11 15:03:31','2009-11-11 14:50:43',1),(100,2,1,1,0,0,29,2,3,2,'2009-11-11 15:05:01','4afad29d86868',1,3,0,'2009-11-11 15:05:01','2009-11-11 15:05:01',NULL,1),(101,2,1,1,0,1,44,2,3,1,'2009-11-11 15:20:28','4afad63cb6099',1,6,0,'2009-11-11 15:20:28','2009-12-15 16:01:31','2009-11-11 15:20:26',2),(102,2,1,1,0,1,44,2,3,2,'2009-11-11 15:26:40','4afad7b0dffc0',1,3,0,'2009-11-11 15:26:40','2009-12-15 16:01:35','2009-12-09 14:20:35',2),(103,2,1,1,0,1,44,2,3,3,'2009-11-11 15:27:04','4afad7c8cc1b1',1,3,0,'2009-11-11 15:27:04','2009-12-15 16:01:38','2009-12-09 14:20:42',2),(106,2,2,1,1,0,93,2,6,0,'2009-11-11 15:53:14','4afaddea0d1be',1,6,0,'2009-11-11 15:53:14','2009-11-11 15:53:14',NULL,1),(107,2,2,1,1,0,94,2,6,0,'2009-11-11 15:53:25','4afaddf514681',1,6,0,'2009-11-11 15:53:25','2009-11-11 15:53:25',NULL,1),(111,2,2,1,1,0,95,2,3,0,'2009-11-11 16:12:03','4afae253318b0',1,3,0,'2009-11-11 16:12:03','2009-12-14 17:19:13','2009-11-11 16:12:14',1),(112,2,2,1,1,0,96,2,6,0,'2009-11-12 10:39:45','4afbe5f14beb2',1,6,0,'2009-11-12 10:39:45','2009-11-12 10:39:45',NULL,1),(113,2,2,1,1,0,97,2,6,0,'2009-11-12 10:40:11','4afbe60bdd281',1,6,0,'2009-11-12 10:40:11','2009-11-12 10:40:11',NULL,1),(114,8,1,1,0,0,97,2,6,1,'2009-11-12 10:42:09','4afbe64c66f56',1,6,0,'2009-11-12 10:42:09','2009-11-12 10:42:09',NULL,1),(115,2,2,1,1,1,96,2,20,1,'2009-12-08 15:17:58','4b1e6e26d1feb',1,20,0,'2009-12-08 15:17:58','2009-12-08 15:17:58',NULL,2),(116,2,2,1,1,0,105,2,3,0,'2009-12-14 16:52:57','4b266d69e26b3',1,3,0,'2009-12-14 16:52:57','2009-12-14 17:02:48','2009-12-14 16:53:06',1),(117,2,2,1,1,0,106,2,3,0,'2009-12-14 17:03:10','4b266fced3fc0',1,3,0,'2009-12-14 17:03:10','2009-12-14 17:03:10',NULL,1),(118,2,2,1,1,0,107,2,3,0,'2009-12-14 17:10:43','4b267193e02c2',1,3,0,'2009-12-14 17:10:43','2009-12-14 17:11:51','2009-12-14 17:10:59',1),(119,2,2,1,1,0,108,2,3,0,'2009-12-14 17:12:16','4b2671f0c94cb',1,3,0,'2009-12-14 17:12:16','2009-12-14 17:19:22','2009-12-14 17:19:18',1),(120,2,2,1,1,0,109,2,3,0,'2009-12-14 17:29:56','4b26761486caa',1,3,0,'2009-12-14 17:29:56','2009-12-14 17:30:10','2009-12-14 17:30:02',1),(121,2,1,1,0,0,67,2,3,7,'2009-12-15 10:31:40','4b27658c8ff9a',1,3,0,'2009-12-15 10:31:40','2009-12-15 10:38:43','2009-12-15 10:32:12',1),(125,2,1,1,0,0,1,2,3,1,'2009-12-22 13:22:28','4b30c814deb7b',1,3,0,'2009-12-22 13:22:28','2009-12-22 13:25:06','2009-12-22 13:22:53',2);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parentTypes`
--

DROP TABLE IF EXISTS `parentTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parentTypes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `from` varchar(255) NOT NULL,
  `to` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathReplacers`
--

LOCK TABLES `pathReplacers` WRITE;
/*!40000 ALTER TABLE `pathReplacers` DISABLE KEYS */;
INSERT INTO `pathReplacers` VALUES (1,1,'ä','ae'),(2,1,'ö','oe'),(3,1,'ü','ue'),(4,1,'ß','ss'),(5,1,'Ä','Ae'),(6,1,'Ö','Oe'),(7,1,'Ü','Ue'),(8,1,'&','und'),(9,2,'&','and');
/*!40000 ALTER TABLE `pathReplacers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=637 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-InstanceFiles` VALUES (575,'4afa92c061f69',1,1,1,37,5),(576,'4afa92c061f69',1,1,2,42,5),(632,'4afa935fd7c1c',1,1,1,34,7),(633,'4afa935fd7c1c',1,1,2,33,7),(634,'4afa935fd7c1c',1,1,3,31,7),(635,'4afa935fd7c1c',1,1,4,20,7),(636,'4afa935fd7c1c',1,1,1,20,55);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` text NOT NULL,
  `description` text,
  `header_embed_code` text,
  `pics_title` varchar(255) default NULL,
  `internal_links_title` varchar(255) default NULL,
  `video_title` varchar(255) default NULL,
  `video_embed_code` text,
  `shortdescription` text NOT NULL,
  `contact` varchar(255) default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Instances` VALUES (1,'4afa92c061f69',1,1,3,'IPS Empress Direct','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.</p>\n<p>Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.</p>\n<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh.</p>\n<p>Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc, quis gravida magna mi a libero. Fusce vulputate eleifend sapien. Vestibulum purus quam, scelerisque ut, mollis sed, nonummy id, metus. Nullam accumsan lorem in dui. Cras ultricies mi eu turpis hendrerit fringilla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In ac dui quis mi consectetuer lacinia. Nam pretium turpis et arcu. Duis arcu tortor, suscipit eget, imperdiet nec, imperdiet iaculis, ipsum. Sed aliquam ultrices mauris. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris. Praesent adipiscing. Phasellus ullamcorper ipsum rutrum nunc. Nunc nonummy metus. Vestibulum volutpat pretium libero. Cras id dui.</p>',NULL,NULL,'Produkt-Links','','','Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\n\nDonec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.\n','1',3,'2009-12-03 18:42:14','2009-12-17 14:41:11'),(2,'4af978b4375a3',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-09 07:51:04','2009-12-09 07:51:04'),(3,'4afa8ff5a12d4',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-09 07:51:10','2009-12-09 07:51:10'),(4,'4afa92d302e98',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-09 07:55:39','2009-12-09 07:55:39'),(5,'4afa935fd7c1c',1,1,3,'','',NULL,NULL,'Ähnliche Produkte','','','Tetric Color: 7 Charakterisierfarben in der Spritze mit ultrafeiner Kanüle für die individuelle Farbcharakterisierung von direkten und indirekten Kunststofffüllungen und zur Abdeckung von Verfärbungen der Zahnhartsubstanz.','3',3,'2009-12-09 07:56:00','2009-12-17 17:07:46'),(6,'4afa92134bf12',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-09 07:57:02','2009-12-09 07:57:02'),(7,'4afa92e4331b5',1,1,3,'','<p><b>Tetric EvoCeram</b> is the new universal composite for anterior and posterior restorations from Ivoclar Vivadent. <br />Tetric EvoCeram is a light-curing, radiopaque nanohybrid composite that is based on the latest technology for direct restorative therapy.</p>\n<p><b>Tetric EvoCeram</b> is supplied in syringes and in Cavifils.</p>\n<p><b>Tetric EvoCeram</b>&nbsp;- the successor product of Tetric Ceram <br />Our leading product Tetric Ceram has been further developed to become Tetric EvoCeram. Tetric EvoCeram is the result of many years of experience and expertise gathered in the field of composites and is based on the time-honoured tradition and long-term clinical success of the products from Ivoclar Vivadent.</p>\n<p><b>Tetric EvoCeram</b>&nbsp;- innovative nano-optimized technology <br />For the first time ever, three types of nanoparticles are utilized in a single composite:<br />fillers, pigments and a modifier.</p>\n<p><b>Tetric EvoCeram</b>&nbsp;- clearly arranged colour coding <br />The colour of both the labels (syringes) and the caps (Cavifils) for the A-D shades reflect the shades of the classical Vita system. As a result, the correct shade can be spotted immediately from the labels or caps.</p>',NULL,NULL,'','','','','',3,'2009-12-09 08:32:15','2009-12-17 17:24:22'),(8,'4afa935fd7c1c',1,2,3,'','',NULL,NULL,'','','','','',3,'2009-12-10 11:21:01','2009-12-22 13:09:16'),(9,'4afa92c061f69',1,2,3,'','',NULL,NULL,'','','','','',3,'2009-12-17 14:41:09','2009-12-17 14:41:09'),(10,'4afa93248b5a7',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-17 17:16:24','2009-12-17 17:16:24'),(11,'4afa933671f48',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-17 17:16:31','2009-12-17 17:16:31'),(12,'4b30c2896ef8d',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 12:58:49','2009-12-22 12:58:54'),(13,'4b30c2b1b2cca',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 12:59:29','2009-12-22 12:59:29'),(14,'4b30c4cf66a83',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 13:08:31','2009-12-22 13:08:39'),(15,'4b30c50e9830e',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 13:09:34','2009-12-22 13:09:41'),(16,'4b30c52bc8fdf',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 13:10:03','2009-12-22 13:10:21'),(17,'4b30c6cccd18f',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 13:17:00','2009-12-22 13:17:04'),(18,'4b30c6e7b7025',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 13:17:27','2009-12-22 13:17:27'),(19,'4b30c7847b8d2',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 13:20:04','2009-12-22 13:20:04'),(20,'4b30c79628b7d',1,1,3,'','',NULL,NULL,'','','','','',3,'2009-12-22 13:20:22','2009-12-22 13:20:22');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT-1-Region45-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=594 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` VALUES (532,'4afa92c061f69',1,1,316,17,123),(533,'4afa92c061f69',1,1,316,18,123),(589,'4afa935fd7c1c',1,1,350,35,18),(590,'4afa935fd7c1c',1,1,350,18,123),(591,'4afa935fd7c1c',1,1,350,17,123),(592,'4afa935fd7c1c',1,1,351,32,18),(593,'4afa935fd7c1c',1,1,351,19,123);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region45-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region45-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region45-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region45-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `block_title` varchar(255) NOT NULL,
  `block_description` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region45-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region45-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region45-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region45-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region45-Instances` VALUES (17,'4af978b4375a3',1,1,1,'',''),(18,'4afa8ff5a12d4',1,1,1,'',''),(20,'4afa92d302e98',1,1,1,'',''),(22,'4afa92134bf12',1,1,1,'',''),(315,'4afa92c061f69',1,2,1,'',''),(316,'4afa92c061f69',1,1,1,'Lorem ipsum dolor sit amet!','<div class=\"jqDnR\" id=\"idTextPanel\">\n<p style=\"font-family: Verdana,Geneva,sans-serif; font-style: normal; font-weight: normal; font-size: 10px; letter-spacing: normal; line-height: normal; text-transform: none; text-decoration: none; text-align: left;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit.  Aenean commodo ligula eget dolor.</p>\n<p style=\"font-family: Verdana,Geneva,sans-serif; font-style: normal; font-weight: normal; font-size: 10px; letter-spacing: normal; line-height: normal; text-transform: none; text-decoration: none; text-align: left;\">Aenean massa.  Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n<p style=\"font-family: Verdana,Geneva,sans-serif; font-style: normal; font-weight: normal; font-size: 10px; letter-spacing: normal; line-height: normal; text-transform: none; text-decoration: none; text-align: left;\">Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.</p>\n</div>'),(350,'4afa935fd7c1c',1,1,1,'Handling','<p>Die ultrafeine Kan&uuml;le (Durchmesser nur 0.4 mm) erlaubt die direkte Applikation ohne Umweg &uuml;ber den Mischblock.</p>'),(351,'4afa935fd7c1c',1,1,2,'Klinisch','<p>Tetric Color ist mit allen lichth&auml;rtenden Restaurationsmaterialien von Ivoclar Vivadent einsetzbar (Artemis, Tetric EvoCeram, Tetric EvoFlow, Tetric Ceram HB, Heliomolar, Heliomolar Flow, Heliomolar HB, Helio Progress, Compoglass F, Compoglass Flow)</p>'),(352,'4afa935fd7c1c',1,1,3,'Farben','<ul>\n<li>Weiss</li>\n<li>Hellgelb</li>\n<li>Blaugrau</li>\n<li>Ocker</li>\n<li>Mittelbraun</li>\n<li>Dunkelbraun</li>\n<li>Schwarz</li>\n</ul>'),(353,'4afa93248b5a7',1,1,1,'',''),(355,'4afa933671f48',1,1,1,'',''),(356,'4afa92e4331b5',1,1,1,'',''),(358,'4b30c2896ef8d',1,1,1,'',''),(359,'4b30c2b1b2cca',1,1,1,'',''),(362,'4b30c4cf66a83',1,1,1,'',''),(363,'4afa935fd7c1c',1,2,1,'',''),(365,'4b30c50e9830e',1,1,1,'',''),(369,'4b30c52bc8fdf',1,1,1,'',''),(371,'4b30c6cccd18f',1,1,1,'',''),(372,'4b30c6e7b7025',1,1,1,'',''),(373,'4b30c7847b8d2',1,1,1,'',''),(374,'4b30c79628b7d',1,1,1,'','');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region45-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFilterTypes` int(10) unsigned NOT NULL,
  `referenceId` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT-1-Region47-Instances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` VALUES (447,'4afa935fd7c1c',1,1,271,1,1,129),(448,'4afa935fd7c1c',1,1,271,2,4,129),(449,'4afa935fd7c1c',1,1,271,3,0,129),(450,'4afa935fd7c1c',1,1,272,1,1,129),(451,'4afa935fd7c1c',1,1,272,1,2,129),(452,'4afa935fd7c1c',1,1,272,2,4,129),(453,'4afa935fd7c1c',1,1,272,2,73,129),(454,'4afa935fd7c1c',1,1,272,2,74,129),(455,'4afa935fd7c1c',1,1,272,3,3,129);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFileFilters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region47-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `docs_title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region47-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region47-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region47-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region47-Instances` VALUES (29,'4af978b4375a3',1,1,1,''),(30,'4afa8ff5a12d4',1,1,1,''),(34,'4afa92d302e98',1,1,1,''),(36,'4afa92134bf12',1,1,1,''),(246,'4afa92c061f69',1,2,1,''),(247,'4afa92c061f69',1,1,1,'Doc Title'),(248,'4afa92c061f69',1,1,2,'Test 2'),(271,'4afa935fd7c1c',1,1,1,'Instructions for use'),(272,'4afa935fd7c1c',1,1,2,'BROCHURES'),(273,'4afa93248b5a7',1,1,1,''),(275,'4afa933671f48',1,1,1,''),(276,'4afa92e4331b5',1,1,1,''),(278,'4b30c2896ef8d',1,1,1,''),(279,'4b30c2b1b2cca',1,1,1,''),(282,'4b30c4cf66a83',1,1,1,''),(283,'4afa935fd7c1c',1,2,1,''),(285,'4b30c50e9830e',1,1,1,''),(289,'4b30c52bc8fdf',1,1,1,''),(291,'4b30c6cccd18f',1,1,1,''),(292,'4b30c6e7b7025',1,1,1,''),(293,'4b30c7847b8d2',1,1,1,''),(294,'4b30c79628b7d',1,1,1,'');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region47-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region50-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region50-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region50-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `link_title` varchar(255) NOT NULL,
  `link_url` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region50-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region50-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region50-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region50-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region50-Instances` VALUES (17,'4af978b4375a3',1,1,1,'',''),(18,'4afa8ff5a12d4',1,1,1,'',''),(20,'4afa92d302e98',1,1,1,'',''),(22,'4afa92134bf12',1,1,1,'',''),(129,'4afa92c061f69',1,2,1,'',''),(130,'4afa92c061f69',1,1,1,'ZOOLU','http://www.getzoolu.org'),(142,'4afa935fd7c1c',1,1,1,'ZOOLU','http://www.getzoolu.org'),(143,'4afa93248b5a7',1,1,1,'',''),(145,'4afa933671f48',1,1,1,'',''),(146,'4afa92e4331b5',1,1,1,'',''),(148,'4b30c2896ef8d',1,1,1,'',''),(149,'4b30c2b1b2cca',1,1,1,'',''),(152,'4b30c4cf66a83',1,1,1,'',''),(153,'4afa935fd7c1c',1,2,1,'',''),(155,'4b30c50e9830e',1,1,1,'',''),(159,'4b30c52bc8fdf',1,1,1,'',''),(161,'4b30c6cccd18f',1,1,1,'',''),(162,'4b30c6e7b7025',1,1,1,'',''),(163,'4b30c7847b8d2',1,1,1,'',''),(164,'4b30c79628b7d',1,1,1,'','');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region50-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT-1-Region51-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` VALUES (215,'4afa935fd7c1c',1,1,227,34,126),(216,'4afa935fd7c1c',1,1,228,33,126);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region51-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT-1-Region51-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT-1-Region51-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT-1-Region51-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `header_title` varchar(255) NOT NULL,
  `header_description` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT-1-Region51-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT-1-Region51-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT-1-Region51-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region51-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT-1-Region51-Instances` VALUES (203,'4afa92c061f69',1,2,1,'',''),(204,'4afa92c061f69',1,1,1,'',''),(227,'4afa935fd7c1c',1,1,1,'','<p><b>Lichth&auml;rtende Charakterisierfarben f&uuml;r Composite-F&uuml;llungsmaterialien.</b><br /><br />Tetric Color: 7 Charakterisierfarben in der Spritze mit ultrafeiner Kan&uuml;le f&uuml;r die individuelle Farbcharakterisierung von direkten und indirekten Kunststofff&uuml;llungen und zur Abdeckung von Verf&auml;rbungen der Zahnhartsubstanz.</p>'),(228,'4afa935fd7c1c',1,1,2,'','<p>Cum sociis natoque penatibus et <b>magnis dis parturient</b> montes, nascetur ridiculus mus. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. <b>Aenean commodo</b> ligula eget dolor. Aenean massa.</p>'),(229,'4afa93248b5a7',1,1,1,'',''),(231,'4afa933671f48',1,1,1,'',''),(232,'4afa92e4331b5',1,1,1,'',''),(234,'4b30c2896ef8d',1,1,1,'',''),(235,'4b30c2b1b2cca',1,1,1,'',''),(238,'4b30c4cf66a83',1,1,1,'',''),(239,'4afa935fd7c1c',1,2,1,'',''),(241,'4b30c50e9830e',1,1,1,'',''),(245,'4b30c52bc8fdf',1,1,1,'',''),(247,'4b30c6cccd18f',1,1,1,'',''),(248,'4b30c6e7b7025',1,1,1,'',''),(249,'4b30c7847b8d2',1,1,1,'',''),(250,'4b30c79628b7d',1,1,1,'','');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT-1-Region51-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idFiles` (`idFiles`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-InstanceMultiFields` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(255) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRelation` bigint(20) unsigned NOT NULL,
  `value` varchar(255) default NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idUsers` bigint(20) unsigned NOT NULL,
  `articletitle` varchar(255) default NULL,
  `shortdescription` text,
  `description` text NOT NULL,
  `header_embed_code` text,
  `contact` varchar(255) default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` VALUES (1,'4af978b4375a3',1,1,3,'','','',NULL,'',3,'2009-12-15 16:49:03','2009-12-15 18:33:01'),(2,'4afa8ff5a12d4',1,1,3,'','','',NULL,'',3,'2009-12-15 16:49:43','2009-12-15 18:33:20'),(3,'4afa902ab7124',1,1,3,'','','',NULL,'',3,'2009-12-15 16:54:44','2009-12-16 08:07:04'),(4,'4afa902ab7124',1,2,3,'','','',NULL,'',3,'2009-12-15 16:54:54','2009-12-15 18:33:45'),(5,'4afa92134bf12',1,1,3,'','','',NULL,'',3,'2009-12-15 16:55:28','2009-12-15 18:33:50'),(6,'4afa9195e40f3',1,1,3,'','','',NULL,'',3,'2009-12-15 17:45:34','2009-12-15 17:45:34'),(7,'4afa914ea4965',1,1,3,'','','',NULL,'',3,'2009-12-15 17:45:44','2009-12-15 17:45:44'),(8,'4afa8ff5a12d4',1,2,3,'','','',NULL,'',3,'2009-12-15 17:58:23','2009-12-15 18:33:32'),(9,'4afa92134bf12',1,2,3,'','','',NULL,'',3,'2009-12-15 18:29:42','2009-12-15 18:33:54'),(10,'4af978b4375a3',1,2,3,'','','',NULL,'',3,'2009-12-15 18:33:04','2009-12-15 18:33:04');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idRegionInstances` bigint(20) unsigned NOT NULL,
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idRegionInstances` (`idRegionInstances`),
  KEY `idFiles` (`idFiles`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles_ibfk_2` FOREIGN KEY (`idRegionInstances`) REFERENCES `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles_ibfk_3` FOREIGN KEY (`idFiles`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-InstanceFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `sidebar_title` varchar(255) default NULL,
  `sidebar_description` text,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` VALUES (18,'4afa9195e40f3',1,1,1,'',''),(19,'4afa914ea4965',1,1,1,'',''),(33,'4af978b4375a3',1,1,1,'',''),(34,'4af978b4375a3',1,2,1,'',''),(36,'4afa8ff5a12d4',1,1,1,'',''),(38,'4afa8ff5a12d4',1,2,1,'',''),(40,'4afa902ab7124',1,2,1,'',''),(41,'4afa92134bf12',1,1,1,'',''),(42,'4afa92134bf12',1,2,1,'',''),(44,'4afa902ab7124',1,1,1,'','');
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region14-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances`
--

DROP TABLE IF EXISTS `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) unsigned NOT NULL,
  `entry_title` varchar(255) default NULL,
  `entry_category` bigint(20) unsigned default NULL,
  `entry_label` bigint(20) unsigned default NULL,
  `entry_viewtype` bigint(20) unsigned default NULL,
  `entry_number` bigint(20) unsigned default NULL,
  `entry_sorttype` bigint(20) unsigned default NULL,
  `entry_sortorder` bigint(20) unsigned default NULL,
  `entry_depth` bigint(20) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances`
--

LOCK TABLES `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` WRITE;
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` DISABLE KEYS */;
INSERT INTO `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` VALUES (18,'4afa9195e40f3',1,1,1,'',0,0,0,0,0,0,0),(19,'4afa914ea4965',1,1,1,'',0,0,0,0,0,0,0),(33,'4af978b4375a3',1,1,1,'',0,0,0,0,0,0,0),(34,'4af978b4375a3',1,2,1,'',0,0,0,0,0,0,0),(36,'4afa8ff5a12d4',1,1,1,'',0,0,0,0,0,0,0),(38,'4afa8ff5a12d4',1,2,1,'',0,0,0,0,0,0,0),(40,'4afa902ab7124',1,2,1,'',0,0,0,0,0,0,0),(41,'4afa92134bf12',1,1,1,'',0,0,0,0,0,0,0),(42,'4afa92134bf12',1,2,1,'',0,0,0,0,0,0,0),(44,'4afa902ab7124',1,1,1,'',0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `product-DEFAULT_PRODUCT_OVERVIEW-1-Region15-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productCategories`
--

DROP TABLE IF EXISTS `productCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productCategories` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `category` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  CONSTRAINT `productCategories_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productCategories`
--

LOCK TABLES `productCategories` WRITE;
/*!40000 ALTER TABLE `productCategories` DISABLE KEYS */;
INSERT INTO `productCategories` VALUES (14,'4afa92c061f69',1,1,53,3,3,'2009-12-17 14:41:11','2009-12-17 14:41:11'),(26,'4afa935fd7c1c',1,1,54,3,3,'2009-12-17 17:07:46','2009-12-17 17:07:46');
/*!40000 ALTER TABLE `productCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productInternalLinks`
--

DROP TABLE IF EXISTS `productInternalLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productInternalLinks` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `sortPosition` int(10) NOT NULL,
  `linkedProductId` varchar(32) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  KEY `linkedProductId` (`linkedProductId`),
  CONSTRAINT `productInternalLinks_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `productInternalLinks_ibfk_2` FOREIGN KEY (`linkedProductId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productInternalLinks`
--

LOCK TABLES `productInternalLinks` WRITE;
/*!40000 ALTER TABLE `productInternalLinks` DISABLE KEYS */;
INSERT INTO `productInternalLinks` VALUES (4,'4afa935fd7c1c',1,1,1,'4afa93248dbb8',3,3,'2009-12-17 17:07:46','2009-12-17 17:07:46'),(5,'4afa935fd7c1c',1,1,2,'4afa92e436b41',3,3,'2009-12-17 17:07:46','2009-12-17 17:07:46'),(6,'4afa935fd7c1c',1,1,3,'4afa933675ff8',3,3,'2009-12-17 17:07:46','2009-12-17 17:07:46');
/*!40000 ALTER TABLE `productInternalLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productLabels`
--

DROP TABLE IF EXISTS `productLabels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productLabels` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `label` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  KEY `productId_2` (`productId`,`version`),
  CONSTRAINT `productLabels_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productLabels`
--

LOCK TABLES `productLabels` WRITE;
/*!40000 ALTER TABLE `productLabels` DISABLE KEYS */;
INSERT INTO `productLabels` VALUES (23,'4afa92c061f69',1,1,56,3,3,'2009-12-17 14:41:11','2009-12-17 14:41:11'),(24,'4afa92c061f69',1,1,60,3,3,'2009-12-17 14:41:11','2009-12-17 14:41:11'),(36,'4afa935fd7c1c',1,1,63,3,3,'2009-12-17 17:07:46','2009-12-17 17:07:46');
/*!40000 ALTER TABLE `productLabels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productLinks`
--

DROP TABLE IF EXISTS `productLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productLinks` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idProducts` bigint(20) unsigned NOT NULL,
  `productId` varchar(32) NOT NULL COMMENT 'linked product',
  PRIMARY KEY  (`id`),
  KEY `idProducts` (`idProducts`),
  KEY `productId` (`productId`),
  CONSTRAINT `productLinks_ibfk_1` FOREIGN KEY (`idProducts`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `productLinks_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productLinks`
--

LOCK TABLES `productLinks` WRITE;
/*!40000 ALTER TABLE `productLinks` DISABLE KEYS */;
INSERT INTO `productLinks` VALUES (17,2,'4af978b4375a3'),(18,4,'4afa8ff5a12d4'),(19,6,'4afa900532ecc'),(20,8,'4afa902ab7124'),(21,10,'4afa914ea4965'),(22,12,'4afa9195e40f3'),(23,14,'4afa92134bf12'),(24,16,'4afa921415a66'),(25,18,'4afa923594b03'),(26,20,'4afa924760ab5'),(27,22,'4afa92532550a'),(28,24,'4afa9257a782e'),(29,26,'4afa925e55ea0'),(30,28,'4afa92c061f69'),(32,32,'4afa92e4331b5'),(33,34,'4afa93248b5a7'),(34,36,'4afa933671f48'),(35,38,'4afa935fd7c1c'),(36,40,'4afa937778b73'),(37,42,'4afa938f1a139'),(38,44,'4afa93a8bf80f'),(39,46,'4afa93bc8c385'),(40,48,'4afa93d16c4d9'),(41,50,'4afa93e13200d'),(42,52,'4afa93f6a9f09'),(43,54,'4afa940d16093'),(44,56,'4afa94273134c'),(45,58,'4afa94301f88e'),(46,60,'4afa944106b30'),(47,62,'4afa945951770'),(48,64,'4afa9472bd339'),(49,66,'4afa947f54c1c'),(50,68,'4afa948bbcabc'),(51,70,'4afa949b05ba6'),(52,72,'4afa94a7ba11f'),(53,74,'4afa94b31835e'),(54,76,'4afa94bd6841f'),(55,78,'4afa94c3c1b8a'),(56,80,'4afa94f11aa1a'),(57,82,'4afa9501512b4'),(58,84,'4afa955ceee12'),(59,86,'4afa9591a5287'),(60,88,'4afa95a47a136'),(61,90,'4afa95ce4c1e1'),(62,92,'4afa95dd3b88c'),(63,94,'4afa95f066823'),(64,96,'4afa962a1465c'),(65,98,'4afa9638c5159'),(66,100,'4afa9648645d5'),(67,102,'4afa96582bb16'),(68,103,'4afa940d16093'),(69,104,'4afa935fd7c1c'),(71,108,'4b30c2b1b2cca'),(78,122,'4b30c79628b7d');
/*!40000 ALTER TABLE `productLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productProperties`
--

DROP TABLE IF EXISTS `productProperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productProperties` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idProductTypes` bigint(20) unsigned NOT NULL,
  `showInNavigation` tinyint(1) NOT NULL default '0',
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `publisher` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `published` timestamp NULL default NULL,
  `idStatus` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `productId_2` (`productId`,`version`,`idLanguages`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  KEY `idLanguages` (`idLanguages`),
  KEY `publisher` (`publisher`),
  KEY `creator` (`creator`),
  KEY `idUsers` (`idUsers`),
  CONSTRAINT `productProperties_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productProperties`
--

LOCK TABLES `productProperties` WRITE;
/*!40000 ALTER TABLE `productProperties` DISABLE KEYS */;
INSERT INTO `productProperties` VALUES (21,'4af978b4375a3',1,1,17,12,3,0,3,3,3,'2009-11-10 14:29:08','2009-12-15 18:33:01','2009-11-10 14:29:04',2),(22,'4afa8ff5a12d4',1,1,17,12,3,0,3,1,1,'2009-11-11 10:20:37','2009-12-15 18:33:20','2009-12-09 07:51:08',2),(23,'4afa900532ecc',1,1,17,12,3,0,3,1,1,'2009-11-11 10:20:53','2009-12-09 14:53:36',NULL,2),(24,'4afa902ab7124',1,1,17,12,3,0,3,1,1,'2009-11-11 10:21:30','2009-12-16 08:07:04','2009-12-15 16:54:42',2),(25,'4afa914ea4965',1,1,17,12,3,0,3,1,1,'2009-11-11 10:26:22','2009-12-15 17:45:44','2009-12-15 17:45:42',2),(26,'4afa9195e40f3',1,1,17,12,3,0,3,1,1,'2009-11-11 10:27:33','2009-12-15 17:45:34','2009-12-15 17:45:30',2),(27,'4afa92134bf12',1,1,17,12,3,0,3,1,1,'2009-11-11 10:29:39','2009-12-15 18:33:50','2009-12-09 07:57:01',2),(28,'4afa921415a66',1,1,17,12,3,0,3,3,3,'2009-11-11 10:29:40','2009-12-09 14:53:36',NULL,1),(29,'4afa923594b03',1,1,17,12,3,0,1,1,1,'2009-11-11 10:30:13','2009-12-09 14:53:36',NULL,1),(30,'4afa924760ab5',1,1,17,12,3,0,1,1,1,'2009-11-11 10:30:31','2009-12-09 14:53:36',NULL,1),(31,'4afa92532550a',1,1,17,12,3,0,1,1,1,'2009-11-11 10:30:43','2009-12-09 14:53:36',NULL,1),(32,'4afa9257a782e',1,1,17,12,3,0,3,3,3,'2009-11-11 10:30:47','2009-12-09 14:53:36',NULL,1),(33,'4afa925e55ea0',1,1,17,12,3,0,1,1,1,'2009-11-11 10:30:54','2009-12-09 14:53:36',NULL,1),(34,'4afa92c061f69',1,1,16,11,1,1,3,3,1,'2009-11-11 10:32:32','2009-12-17 14:41:11','2009-11-11 10:32:28',2),(35,'4afa92c061f69',1,2,16,11,1,0,3,1,1,'2009-11-11 10:32:37','2009-12-17 14:41:09','2009-11-11 10:32:34',1),(36,'4afa92d302e98',1,1,16,11,1,0,3,1,1,'2009-11-11 10:32:51','2009-12-09 07:55:39','2009-11-11 10:32:48',1),(37,'4afa92d302e98',1,2,16,11,1,0,1,1,1,'2009-11-11 10:32:54','2009-11-11 10:32:54','2009-11-11 10:32:52',1),(38,'4afa92e4331b5',1,1,16,11,1,0,3,1,1,'2009-11-11 10:33:08','2009-12-17 17:24:22','2009-11-11 10:32:58',1),(39,'4afa92e4331b5',1,2,16,11,1,0,1,1,1,'2009-11-11 10:33:12','2009-11-11 10:33:47','2009-11-11 10:33:09',1),(40,'4afa93248b5a7',1,1,16,11,1,0,3,1,1,'2009-11-11 10:34:12','2009-12-17 17:16:24','2009-11-11 10:34:05',1),(41,'4afa93248b5a7',1,2,16,11,1,0,1,1,1,'2009-11-11 10:34:16','2009-11-11 10:34:16','2009-11-11 10:34:14',1),(42,'4afa933671f48',1,1,16,11,1,0,3,1,1,'2009-11-11 10:34:30','2009-12-17 17:16:31','2009-11-11 10:34:27',1),(43,'4afa933671f48',1,2,16,11,1,0,1,1,1,'2009-11-11 10:34:34','2009-11-11 10:34:34','2009-11-11 10:34:32',1),(44,'4afa935fd7c1c',1,1,16,11,1,0,3,1,1,'2009-11-11 10:35:11','2009-12-17 17:07:46','2009-11-11 10:35:07',2),(45,'4afa935fd7c1c',1,2,16,11,1,0,3,1,1,'2009-11-11 10:35:16','2009-12-22 13:09:15','2009-11-11 10:35:13',1),(46,'4afa937778b73',1,1,16,11,1,0,1,1,1,'2009-11-11 10:35:35','2009-11-11 10:35:35','2009-11-11 10:35:32',1),(47,'4afa937778b73',1,2,16,11,1,0,1,1,1,'2009-11-11 10:35:38','2009-11-11 10:35:38','2009-11-11 10:35:37',1),(48,'4afa938f1a139',1,1,16,11,1,0,1,1,1,'2009-11-11 10:35:59','2009-11-11 10:35:59','2009-11-11 10:35:55',1),(49,'4afa938f1a139',1,2,16,11,1,0,1,1,1,'2009-11-11 10:36:02','2009-11-11 10:36:02','2009-11-11 10:36:00',1),(50,'4afa93a8bf80f',1,1,16,11,1,0,1,1,1,'2009-11-11 10:36:24','2009-11-11 10:36:24','2009-11-11 10:36:21',1),(51,'4afa93a8bf80f',1,2,16,11,1,0,1,1,1,'2009-11-11 10:36:30','2009-11-11 10:36:30','2009-11-11 10:36:27',1),(52,'4afa93bc8c385',1,1,16,11,1,0,1,1,1,'2009-11-11 10:36:44','2009-11-11 10:36:44','2009-11-11 10:36:41',1),(53,'4afa93bc8c385',1,2,16,11,1,0,1,1,1,'2009-11-11 10:36:47','2009-11-11 10:36:47','2009-11-11 10:36:46',1),(54,'4afa93d16c4d9',1,1,16,11,1,0,1,1,1,'2009-11-11 10:37:05','2009-11-11 10:37:05','2009-11-11 10:36:51',1),(55,'4afa93d16c4d9',1,2,16,11,1,0,1,1,1,'2009-11-11 10:37:09','2009-11-11 10:37:09','2009-11-11 10:37:07',1),(56,'4afa93e13200d',1,1,16,11,1,0,1,1,1,'2009-11-11 10:37:21','2009-11-11 10:37:21','2009-11-11 10:37:12',1),(57,'4afa93e13200d',1,2,16,11,1,0,1,1,1,'2009-11-11 10:37:25','2009-11-11 10:37:25','2009-11-11 10:37:23',1),(58,'4afa93f6a9f09',1,1,16,11,1,0,1,1,1,'2009-11-11 10:37:42','2009-11-11 10:37:42','2009-11-11 10:37:28',1),(59,'4afa93f6a9f09',1,2,16,11,1,0,1,1,1,'2009-11-11 10:37:46','2009-11-11 10:37:46','2009-11-11 10:37:44',1),(60,'4afa940d16093',1,1,16,11,1,0,1,1,1,'2009-11-11 10:38:05','2009-11-11 10:38:05','2009-11-11 10:38:02',1),(61,'4afa940d16093',1,2,16,11,1,0,1,1,1,'2009-11-11 10:38:08','2009-11-11 10:38:08','2009-11-11 10:38:06',1),(62,'4afa94273134c',1,1,17,12,3,0,1,1,1,'2009-11-11 10:38:31','2009-12-09 14:53:36',NULL,1),(63,'4afa94301f88e',1,1,17,12,3,0,1,1,1,'2009-11-11 10:38:40','2009-12-09 14:53:36',NULL,1),(64,'4afa944106b30',1,1,17,12,3,0,1,1,1,'2009-11-11 10:38:57','2009-12-09 14:53:36',NULL,1),(65,'4afa945951770',1,1,17,12,3,0,1,1,1,'2009-11-11 10:39:21','2009-12-09 14:53:36',NULL,1),(66,'4afa9472bd339',1,1,17,12,3,0,1,1,1,'2009-11-11 10:39:46','2009-12-09 14:53:36',NULL,1),(67,'4afa947f54c1c',1,1,17,12,3,0,1,1,1,'2009-11-11 10:39:59','2009-12-09 14:53:36',NULL,1),(68,'4afa948bbcabc',1,1,17,12,3,0,1,1,1,'2009-11-11 10:40:11','2009-12-09 14:53:36',NULL,1),(69,'4afa949b05ba6',1,1,17,12,3,0,1,1,1,'2009-11-11 10:40:27','2009-12-09 14:53:36',NULL,1),(70,'4afa94a7ba11f',1,1,17,12,3,0,1,1,1,'2009-11-11 10:40:39','2009-12-09 14:53:36',NULL,1),(71,'4afa94b31835e',1,1,17,12,3,0,1,1,1,'2009-11-11 10:40:51','2009-12-09 14:53:36',NULL,1),(72,'4afa94bd6841f',1,1,17,12,3,0,1,1,1,'2009-11-11 10:41:01','2009-12-09 14:53:36',NULL,1),(73,'4afa94c3c1b8a',1,1,17,12,3,0,1,1,1,'2009-11-11 10:41:07','2009-12-09 14:53:36',NULL,1),(74,'4afa94f11aa1a',1,1,16,11,1,0,1,1,1,'2009-11-11 10:41:53','2009-11-11 10:41:53','2009-11-11 10:41:49',1),(75,'4afa94f11aa1a',1,2,16,11,1,0,1,1,1,'2009-11-11 10:41:57','2009-11-11 10:41:57','2009-11-11 10:41:54',1),(76,'4afa9501512b4',1,1,16,11,1,0,1,1,1,'2009-11-11 10:42:09','2009-11-11 10:42:09','2009-11-11 10:42:06',1),(77,'4afa9501512b4',1,2,16,11,1,0,1,1,1,'2009-11-11 10:42:14','2009-11-11 10:42:14','2009-11-11 10:42:10',1),(78,'4afa955ceee12',1,1,16,11,1,0,1,1,1,'2009-11-11 10:43:40','2009-11-11 10:43:40','2009-11-11 10:43:38',1),(79,'4afa955ceee12',1,2,16,11,1,0,1,1,1,'2009-11-11 10:43:45','2009-11-11 10:43:50','2009-11-11 10:43:43',1),(80,'4afa9591a5287',1,1,16,11,1,0,1,1,1,'2009-11-11 10:44:33','2009-11-11 10:44:33','2009-11-11 10:44:18',1),(81,'4afa9591a5287',1,2,16,11,1,0,1,1,1,'2009-11-11 10:44:40','2009-11-11 10:44:40','2009-11-11 10:44:35',1),(82,'4afa95a47a136',1,1,16,11,1,0,1,1,1,'2009-11-11 10:44:52','2009-11-11 10:44:52','2009-11-11 10:44:45',1),(83,'4afa95a47a136',1,2,16,11,1,0,1,1,1,'2009-11-11 10:44:57','2009-11-11 10:44:57','2009-11-11 10:44:55',1),(84,'4afa95ce4c1e1',1,1,17,12,3,0,1,1,1,'2009-11-11 10:45:34','2009-12-09 14:53:36',NULL,1),(85,'4afa95dd3b88c',1,1,17,12,3,0,1,1,1,'2009-11-11 10:45:49','2009-12-09 14:53:36',NULL,1),(86,'4afa95f066823',1,1,17,12,3,0,1,1,1,'2009-11-11 10:46:08','2009-12-09 14:53:36',NULL,1),(87,'4afa962a1465c',1,1,16,11,1,0,1,1,1,'2009-11-11 10:47:06','2009-11-11 10:47:06','2009-11-11 10:47:03',1),(88,'4afa962a1465c',1,2,16,11,1,0,1,1,1,'2009-11-11 10:47:10','2009-11-11 10:47:10','2009-11-11 10:47:08',1),(89,'4afa9638c5159',1,1,16,11,1,0,1,1,1,'2009-11-11 10:47:20','2009-11-11 10:47:20','2009-11-11 10:47:13',1),(90,'4afa9638c5159',1,2,16,11,1,0,1,1,1,'2009-11-11 10:47:25','2009-11-11 10:47:25','2009-11-11 10:47:22',1),(91,'4afa9648645d5',1,1,16,11,1,0,1,1,1,'2009-11-11 10:47:36','2009-11-11 10:47:36','2009-11-11 10:47:33',1),(92,'4afa9648645d5',1,2,16,11,1,0,1,1,1,'2009-11-11 10:47:40','2009-11-11 10:47:40','2009-11-11 10:47:38',1),(93,'4afa96582bb16',1,1,16,11,1,0,1,1,1,'2009-11-11 10:47:52','2009-11-11 10:47:52','2009-11-11 10:47:43',1),(94,'4afa96582bb16',1,2,16,11,1,0,1,1,1,'2009-11-11 10:47:56','2009-11-11 10:47:56','2009-11-11 10:47:54',1),(95,'4afa902ab7124',1,2,17,12,1,0,3,1,3,'2009-12-15 16:54:54','2009-12-17 12:10:26','2009-12-15 16:54:52',2),(96,'4afa8ff5a12d4',1,2,17,12,1,0,3,3,3,'2009-12-15 17:58:23','2009-12-15 18:33:32','2009-12-15 17:58:16',1),(97,'4afa92134bf12',1,2,17,12,1,0,3,1,3,'2009-12-15 18:29:42','2009-12-15 18:33:54','2009-12-15 18:29:39',2),(98,'4af978b4375a3',1,2,17,12,1,0,3,3,3,'2009-12-15 18:33:04','2009-12-15 18:33:04','2009-12-15 18:33:03',1),(99,'4b30c2896ef8d',1,1,16,11,1,0,3,3,3,'2009-12-22 12:58:49','2009-12-22 12:58:54','2009-12-22 12:58:45',1),(100,'4b30c2b1b2cca',1,1,16,11,1,0,3,3,3,'2009-12-22 12:59:29','2009-12-22 12:59:29','2009-12-22 12:59:24',1),(101,'4b30c4cf66a83',1,1,16,11,1,0,3,3,3,'2009-12-22 13:08:31','2009-12-22 13:08:39','2009-12-22 13:08:27',1),(102,'4b30c50e9830e',1,1,16,11,1,0,3,3,3,'2009-12-22 13:09:34','2009-12-22 13:09:41','2009-12-22 13:09:27',1),(103,'4b30c52bc8fdf',1,1,16,11,1,0,3,3,3,'2009-12-22 13:10:03','2009-12-22 13:10:21','2009-12-22 13:09:58',1),(104,'4b30c6cccd18f',1,1,16,11,1,0,3,3,3,'2009-12-22 13:17:00','2009-12-22 13:17:04','2009-12-22 13:16:56',1),(105,'4b30c6e7b7025',1,1,16,11,1,0,3,3,3,'2009-12-22 13:17:27','2009-12-22 13:17:27','2009-12-22 13:17:24',1),(106,'4b30c7847b8d2',1,1,16,11,1,0,3,3,3,'2009-12-22 13:20:04','2009-12-22 13:20:04','2009-12-22 13:20:00',1),(107,'4b30c79628b7d',1,1,16,11,1,1,3,3,3,'2009-12-22 13:20:22','2009-12-22 13:20:22','2009-12-22 13:20:15',2);
/*!40000 ALTER TABLE `productProperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productTitles`
--

DROP TABLE IF EXISTS `productTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productTitles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `productId_2` (`productId`,`version`,`idLanguages`),
  KEY `productId` (`productId`),
  CONSTRAINT `productTitles_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productTitles`
--

LOCK TABLES `productTitles` WRITE;
/*!40000 ALTER TABLE `productTitles` DISABLE KEYS */;
INSERT INTO `productTitles` VALUES (20,'4af978b4375a3',1,1,'Produktbaum',3,3,'2009-11-10 14:29:08','2009-12-15 18:33:01'),(21,'4afa8ff5a12d4',1,1,'Produkte',3,1,'2009-11-11 10:20:37','2009-12-15 18:33:20'),(22,'4afa900532ecc',1,1,'Kompetenzen',3,1,'2009-11-11 10:20:53','2009-12-09 07:51:54'),(23,'4afa8ff5a12d4',1,2,'Products',3,1,NULL,'2009-12-15 18:33:32'),(24,'4afa900532ecc',1,2,'Competences',1,1,NULL,'2009-11-11 10:21:17'),(25,'4afa902ab7124',1,1,'Füllungstherapie',3,1,'2009-11-11 10:21:30','2009-12-16 08:07:04'),(26,'4afa902ab7124',1,2,'Restorative Therapy',3,1,NULL,'2009-12-17 12:10:26'),(27,'4afa914ea4965',1,1,'Geräte',3,1,'2009-11-11 10:26:22','2009-12-15 17:45:44'),(28,'4afa9195e40f3',1,1,'Legierungen',3,1,'2009-11-11 10:27:33','2009-12-15 17:45:34'),(29,'4afa914ea4965',1,2,'Equipment ',1,1,NULL,'2009-11-11 10:28:51'),(30,'4afa9195e40f3',1,2,'Alloys',1,1,NULL,'2009-11-11 10:29:11'),(31,'4afa92134bf12',1,1,'Composites',3,1,'2009-11-11 10:29:39','2009-12-15 18:33:50'),(32,'4afa921415a66',1,1,'Test',3,3,'2009-11-11 10:29:40','2009-11-11 10:29:40'),(33,'4afa923594b03',1,1,'Compomeres',1,1,'2009-11-11 10:30:13','2009-11-11 10:30:13'),(34,'4afa924760ab5',1,1,'Adhesives/Etchants',1,1,'2009-11-11 10:30:31','2009-11-11 10:30:31'),(35,'4afa92532550a',1,1,'Amalgams',1,1,'2009-11-11 10:30:43','2009-11-11 10:30:43'),(36,'4afa9257a782e',1,1,'Projekt 01',3,3,'2009-11-11 10:30:47','2009-11-11 10:30:47'),(37,'4afa925e55ea0',1,1,'Lining material',1,1,'2009-11-11 10:30:54','2009-11-11 10:30:54'),(38,'4afa92c061f69',1,1,'IPS Empress Direct',3,1,'2009-11-11 10:32:32','2009-12-17 14:41:11'),(39,'4afa92c061f69',1,2,'IPS Empress Direct',3,1,'2009-11-11 10:32:37','2009-12-17 14:41:09'),(40,'4afa92d302e98',1,1,'IPS Empress Direct',3,1,'2009-11-11 10:32:51','2009-12-09 07:55:39'),(41,'4afa92d302e98',1,2,'IPS Empress Direct',1,1,'2009-11-11 10:32:54','2009-11-11 10:32:54'),(42,'4afa92e4331b5',1,1,'Tetric EvoFlow',3,1,'2009-11-11 10:33:08','2009-12-17 17:24:22'),(43,'4afa92e4331b5',1,2,'Tetric EvoFlow',1,1,'2009-11-11 10:33:12','2009-11-11 10:33:47'),(44,'4afa93248b5a7',1,1,'Tetric',3,1,'2009-11-11 10:34:12','2009-12-17 17:16:24'),(45,'4afa93248b5a7',1,2,'Tetric',1,1,'2009-11-11 10:34:16','2009-11-11 10:34:16'),(46,'4afa933671f48',1,1,'Tetric Ceram HB',3,1,'2009-11-11 10:34:30','2009-12-17 17:16:31'),(47,'4afa933671f48',1,2,'Tetric Ceram HB',1,1,'2009-11-11 10:34:34','2009-11-11 10:34:34'),(48,'4afa935fd7c1c',1,1,'Tetric Color',3,1,'2009-11-11 10:35:11','2009-12-17 17:07:46'),(49,'4afa935fd7c1c',1,2,'Tetric Color',3,1,'2009-11-11 10:35:16','2009-12-22 13:09:16'),(50,'4afa937778b73',1,1,'Compoglass F',1,1,'2009-11-11 10:35:35','2009-11-11 10:35:35'),(51,'4afa937778b73',1,2,'Compoglass F',1,1,'2009-11-11 10:35:38','2009-11-11 10:35:38'),(52,'4afa938f1a139',1,1,'Compoglass Flow',1,1,'2009-11-11 10:35:59','2009-11-11 10:35:59'),(53,'4afa938f1a139',1,2,'Compoglass Flow',1,1,'2009-11-11 10:36:02','2009-11-11 10:36:02'),(54,'4afa93a8bf80f',1,1,'AdheSE One F',1,1,'2009-11-11 10:36:24','2009-11-11 10:36:24'),(55,'4afa93a8bf80f',1,2,'AdheSE One F',1,1,'2009-11-11 10:36:30','2009-11-11 10:36:30'),(56,'4afa93bc8c385',1,1,'Total Etch',1,1,'2009-11-11 10:36:44','2009-11-11 10:36:44'),(57,'4afa93bc8c385',1,2,'Total Etch',1,1,'2009-11-11 10:36:47','2009-11-11 10:36:47'),(58,'4afa93d16c4d9',1,1,'Syntac',1,1,'2009-11-11 10:37:05','2009-11-11 10:37:05'),(59,'4afa93d16c4d9',1,2,'Syntac',1,1,'2009-11-11 10:37:09','2009-11-11 10:37:09'),(60,'4afa93e13200d',1,1,'ExciTE',1,1,'2009-11-11 10:37:21','2009-11-11 10:37:21'),(61,'4afa93e13200d',1,2,'ExciTE',1,1,'2009-11-11 10:37:25','2009-11-11 10:37:25'),(62,'4afa93f6a9f09',1,1,'ExciTE DSC',1,1,'2009-11-11 10:37:42','2009-11-11 10:37:42'),(63,'4afa93f6a9f09',1,2,'ExciTE DSC',1,1,'2009-11-11 10:37:46','2009-11-11 10:37:46'),(64,'4afa940d16093',1,1,'AdheSE',1,1,'2009-11-11 10:38:05','2009-11-11 10:38:05'),(65,'4afa940d16093',1,2,'AdheSE',1,1,'2009-11-11 10:38:08','2009-11-11 10:38:08'),(66,'4afa94273134c',1,1,'Composites',1,1,'2009-11-11 10:38:31','2009-11-11 10:38:31'),(67,'4afa94301f88e',1,1,'All-Ceramics',1,1,'2009-11-11 10:38:40','2009-11-11 10:38:40'),(68,'4afa944106b30',1,1,'Implant Esthetics',1,1,'2009-11-11 10:38:57','2009-11-11 10:38:57'),(69,'4afa945951770',1,1,'Planning',1,1,'2009-11-11 10:39:21','2009-11-11 10:39:21'),(70,'4afa9472bd339',1,1,'Retraction Isolation',1,1,'2009-11-11 10:39:46','2009-11-11 10:39:46'),(71,'4afa947f54c1c',1,1,'Matrix',1,1,'2009-11-11 10:39:59','2009-11-11 10:39:59'),(72,'4afa948bbcabc',1,1,'Adhesives',1,1,'2009-11-11 10:40:11','2009-11-11 10:40:11'),(73,'4afa949b05ba6',1,1,'Flowable composites',1,1,'2009-11-11 10:40:27','2009-11-11 10:40:27'),(74,'4afa94a7ba11f',1,1,'Sculptable composites',1,1,'2009-11-11 10:40:39','2009-11-11 10:40:39'),(75,'4afa94b31835e',1,1,'LED curing lights',1,1,'2009-11-11 10:40:51','2009-11-11 10:40:51'),(76,'4afa94bd6841f',1,1,'Polishing',1,1,'2009-11-11 10:41:01','2009-11-11 10:41:01'),(77,'4afa94c3c1b8a',1,1,'Recall',1,1,'2009-11-11 10:41:07','2009-11-11 10:41:07'),(78,'4afa94f11aa1a',1,1,'OptraGate',1,1,'2009-11-11 10:41:53','2009-11-11 10:41:53'),(79,'4afa94f11aa1a',1,2,'OptraGate',1,1,'2009-11-11 10:41:57','2009-11-11 10:41:57'),(80,'4afa9501512b4',1,1,'OptraDam',1,1,'2009-11-11 10:42:09','2009-11-11 10:42:09'),(81,'4afa9501512b4',1,2,'OptraDam',1,1,'2009-11-11 10:42:14','2009-11-11 10:42:14'),(82,'4afa955ceee12',1,1,'OptraMatrix',1,1,'2009-11-11 10:43:40','2009-11-11 10:43:40'),(83,'4afa955ceee12',1,2,'OptraMatrix',1,1,'2009-11-11 10:43:45','2009-11-11 10:43:50'),(84,'4afa9591a5287',1,1,'Optra Contact',1,1,'2009-11-11 10:44:33','2009-11-11 10:44:33'),(85,'4afa9591a5287',1,2,'Optra Contact',1,1,'2009-11-11 10:44:40','2009-11-11 10:44:40'),(86,'4afa95a47a136',1,1,'Contour-Strip',1,1,'2009-11-11 10:44:52','2009-11-11 10:44:52'),(87,'4afa95a47a136',1,2,'Contour-Strip',1,1,'2009-11-11 10:44:57','2009-11-11 10:44:57'),(88,'4afa95ce4c1e1',1,1,'IPS e.max dental technician',1,1,'2009-11-11 10:45:34','2009-11-11 10:45:34'),(89,'4afa95dd3b88c',1,1,'IPS e.max dentist',1,1,'2009-11-11 10:45:49','2009-11-11 10:45:49'),(90,'4afa95f066823',1,1,'IPS Empress dental technician',1,1,'2009-11-11 10:46:08','2009-11-11 10:46:08'),(91,'4afa962a1465c',1,1,'IPS e.max ZirCAD',1,1,'2009-11-11 10:47:06','2009-11-11 10:47:06'),(92,'4afa962a1465c',1,2,'IPS e.max ZirCAD',1,1,'2009-11-11 10:47:10','2009-11-11 10:47:10'),(93,'4afa9638c5159',1,1,'IPS e.max CAD',1,1,'2009-11-11 10:47:20','2009-11-11 10:47:20'),(94,'4afa9638c5159',1,2,'IPS e.max CAD',1,1,'2009-11-11 10:47:25','2009-11-11 10:47:25'),(95,'4afa9648645d5',1,1,'IPS e.max Ceram',1,1,'2009-11-11 10:47:36','2009-11-11 10:47:36'),(96,'4afa9648645d5',1,2,'IPS e.max Ceram',1,1,'2009-11-11 10:47:40','2009-11-11 10:47:40'),(97,'4afa96582bb16',1,1,'Cementation',1,1,'2009-11-11 10:47:52','2009-11-11 10:47:52'),(98,'4afa96582bb16',1,2,'Cementation',1,1,'2009-11-11 10:47:56','2009-11-11 10:47:56'),(99,'4afa92134bf12',1,2,'Composites',3,1,NULL,'2009-12-15 18:33:54'),(100,'4b30c2896ef8d',1,1,'Test',3,3,'2009-12-22 12:58:49','2009-12-22 12:58:54'),(101,'4b30c2b1b2cca',1,1,'test',3,3,'2009-12-22 12:59:29','2009-12-22 12:59:29'),(102,'4b30c4cf66a83',1,1,'Test',3,3,'2009-12-22 13:08:31','2009-12-22 13:08:39'),(103,'4b30c50e9830e',1,1,'Test Produkt',3,3,'2009-12-22 13:09:34','2009-12-22 13:09:41'),(104,'4b30c52bc8fdf',1,1,'Test',3,3,'2009-12-22 13:10:03','2009-12-22 13:10:21'),(105,'4b30c6cccd18f',1,1,'test',3,3,'2009-12-22 13:17:00','2009-12-22 13:17:04'),(106,'4b30c6e7b7025',1,1,'test',3,3,'2009-12-22 13:17:27','2009-12-22 13:17:27'),(107,'4b30c7847b8d2',1,1,'test',3,3,'2009-12-22 13:20:04','2009-12-22 13:20:04'),(108,'4b30c79628b7d',1,1,'Test',3,3,'2009-12-22 13:20:22','2009-12-22 13:20:22');
/*!40000 ALTER TABLE `productTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productTypeTitles`
--

DROP TABLE IF EXISTS `productTypeTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productTypeTitles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idProductTypes` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `product` tinyint(1) NOT NULL default '0',
  `startproduct` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `product` (`product`),
  KEY `startproduct` (`startproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productTypes`
--

LOCK TABLES `productTypes` WRITE;
/*!40000 ALTER TABLE `productTypes` DISABLE KEYS */;
INSERT INTO `productTypes` VALUES (1,'product',1,1),(2,'link',1,1),(3,'overview',0,1);
/*!40000 ALTER TABLE `productTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productVideos`
--

DROP TABLE IF EXISTS `productVideos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productVideos` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `userId` varchar(32) NOT NULL,
  `videoId` varchar(64) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `idVideoTypes` int(10) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `productId` (`productId`),
  KEY `version` (`version`),
  CONSTRAINT `productVideos_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productVideos`
--

LOCK TABLES `productVideos` WRITE;
/*!40000 ALTER TABLE `productVideos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productVideos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idParent` bigint(20) unsigned NOT NULL,
  `idParentTypes` bigint(20) unsigned NOT NULL,
  `isStartProduct` tinyint(1) NOT NULL default '0',
  `idUsers` bigint(20) unsigned NOT NULL,
  `sortPosition` bigint(20) unsigned NOT NULL,
  `sortTimestamp` timestamp NULL default NULL,
  `productId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`productId`),
  KEY `version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,11,1,1,3,999999,'2009-11-10 14:29:44','4af978b4375a3',1,3,'2009-11-10 14:29:44','2009-12-15 18:33:04'),(2,12,1,1,3,0,'2009-11-10 14:29:44','4af978b4395fb',1,3,'2009-11-10 14:29:44','2009-11-10 14:29:44'),(3,11,1,1,3,999999,'2009-11-11 10:20:37','4afa8ff5a12d4',1,1,'2009-11-11 10:20:37','2009-12-15 18:33:32'),(4,31,2,1,1,0,'2009-11-11 10:20:37','4afa8ff5a584a',1,1,'2009-11-11 10:20:37','2009-11-11 10:20:37'),(5,11,1,1,1,999999,'2009-11-11 10:20:53','4afa900532ecc',1,1,'2009-11-11 10:20:53','2009-11-11 10:20:53'),(6,32,2,1,1,0,'2009-11-11 10:20:53','4afa9005348c7',1,1,'2009-11-11 10:20:53','2009-11-11 10:20:53'),(7,11,1,1,3,999999,'2009-11-11 10:21:30','4afa902ab7124',1,1,'2009-11-11 10:21:30','2009-12-16 08:07:04'),(8,33,2,1,1,0,'2009-11-11 10:21:30','4afa902ab8b6e',1,1,'2009-11-11 10:21:30','2009-11-11 10:21:30'),(9,11,1,1,3,999999,'2009-11-11 10:26:22','4afa914ea4965',1,1,'2009-11-11 10:26:22','2009-12-15 17:45:44'),(10,34,2,1,1,0,'2009-11-11 10:26:22','4afa914ea8a2c',1,1,'2009-11-11 10:26:22','2009-11-11 10:26:22'),(11,11,1,1,3,999999,'2009-11-11 10:27:33','4afa9195e40f3',1,1,'2009-11-11 10:27:33','2009-12-15 17:45:34'),(12,35,2,1,1,0,'2009-11-11 10:27:33','4afa9195e60ec',1,1,'2009-11-11 10:27:33','2009-11-11 10:27:33'),(13,11,1,1,3,999999,'2009-11-11 10:29:39','4afa92134bf12',1,1,'2009-11-11 10:29:39','2009-12-15 18:33:54'),(14,36,2,1,1,0,'2009-11-11 10:29:39','4afa92134e5ee',1,1,'2009-11-11 10:29:39','2009-11-11 10:29:39'),(15,11,1,1,3,999999,'2009-11-11 10:29:40','4afa921415a66',1,3,'2009-11-11 10:29:40','2009-11-11 10:29:40'),(16,37,2,1,3,0,'2009-11-11 10:29:40','4afa921416ea4',1,3,'2009-11-11 10:29:40','2009-11-11 10:29:40'),(17,11,1,1,1,999999,'2009-11-11 10:30:13','4afa923594b03',1,1,'2009-11-11 10:30:13','2009-11-11 10:30:13'),(18,38,2,1,1,0,'2009-11-11 10:30:13','4afa9235986d7',1,1,'2009-11-11 10:30:13','2009-11-11 10:30:13'),(19,11,1,1,1,999999,'2009-11-11 10:30:31','4afa924760ab5',1,1,'2009-11-11 10:30:31','2009-11-11 10:30:31'),(20,39,2,1,1,0,'2009-11-11 10:30:31','4afa924762428',1,1,'2009-11-11 10:30:31','2009-11-11 10:30:31'),(21,11,1,1,1,999999,'2009-11-11 10:30:43','4afa92532550a',1,1,'2009-11-11 10:30:43','2009-11-11 10:30:43'),(22,40,2,1,1,0,'2009-11-11 10:30:43','4afa925327033',1,1,'2009-11-11 10:30:43','2009-11-11 10:30:43'),(23,11,1,1,3,999999,'2009-11-11 10:30:47','4afa9257a782e',1,3,'2009-11-11 10:30:47','2009-11-11 10:30:47'),(24,41,2,1,3,0,'2009-11-11 10:30:47','4afa9257a9287',1,3,'2009-11-11 10:30:47','2009-11-11 10:30:47'),(25,11,1,1,1,999999,'2009-11-11 10:30:54','4afa925e55ea0',1,1,'2009-11-11 10:30:54','2009-11-11 10:30:54'),(26,42,2,1,1,0,'2009-11-11 10:30:54','4afa925e58455',1,1,'2009-11-11 10:30:54','2009-11-11 10:30:54'),(27,11,1,0,3,999999,'2009-11-11 10:32:32','4afa92c061f69',1,1,'2009-11-11 10:32:32','2009-12-17 14:41:11'),(28,36,2,0,1,1,'2009-12-10 07:55:47','4afa92c064543',1,1,'2009-11-11 10:32:32','2009-12-10 07:55:47'),(29,11,1,0,3,999999,'2009-11-11 10:32:51','4afa92d302e98',1,1,'2009-11-11 10:32:51','2009-12-09 07:55:39'),(31,11,1,0,3,999999,'2009-11-11 10:33:08','4afa92e4331b5',1,1,'2009-11-11 10:33:08','2009-12-17 17:24:22'),(32,36,2,0,1,3,'2009-11-11 10:33:08','4afa92e436b41',1,1,'2009-11-11 10:33:08','2009-11-11 10:33:08'),(33,11,1,0,3,999999,'2009-11-11 10:34:12','4afa93248b5a7',1,1,'2009-11-11 10:34:12','2009-12-17 17:16:24'),(34,36,2,0,1,4,'2009-11-11 10:34:12','4afa93248dbb8',1,1,'2009-11-11 10:34:12','2009-11-11 10:34:12'),(35,11,1,0,3,999999,'2009-11-11 10:34:30','4afa933671f48',1,1,'2009-11-11 10:34:30','2009-12-17 17:16:31'),(36,36,2,0,1,5,'2009-11-11 10:34:30','4afa933675ff8',1,1,'2009-11-11 10:34:30','2009-11-11 10:34:30'),(37,11,1,0,3,999999,'2009-11-11 10:35:11','4afa935fd7c1c',1,1,'2009-11-11 10:35:11','2009-12-22 13:09:15'),(38,36,2,0,1,1,'2009-12-10 07:56:04','4afa935fda39e',1,1,'2009-11-11 10:35:11','2009-12-10 07:56:04'),(39,11,1,0,1,999999,'2009-11-11 10:35:35','4afa937778b73',1,1,'2009-11-11 10:35:35','2009-11-11 10:35:38'),(40,38,2,0,1,1,'2009-11-11 10:35:35','4afa93777af58',1,1,'2009-11-11 10:35:35','2009-11-11 10:35:35'),(41,11,1,0,1,999999,'2009-11-11 10:35:59','4afa938f1a139',1,1,'2009-11-11 10:35:59','2009-11-11 10:36:02'),(42,38,2,0,1,2,'2009-11-11 10:35:59','4afa938f1c9f9',1,1,'2009-11-11 10:35:59','2009-11-11 10:35:59'),(43,11,1,0,1,999999,'2009-11-11 10:36:24','4afa93a8bf80f',1,1,'2009-11-11 10:36:24','2009-11-11 10:36:30'),(44,39,2,0,1,1,'2009-11-11 10:36:24','4afa93a8c1984',1,1,'2009-11-11 10:36:24','2009-11-11 10:36:24'),(45,11,1,0,1,999999,'2009-11-11 10:36:44','4afa93bc8c385',1,1,'2009-11-11 10:36:44','2009-11-11 10:36:47'),(46,39,2,0,1,2,'2009-11-11 10:36:44','4afa93bc8e7cd',1,1,'2009-11-11 10:36:44','2009-11-11 10:36:44'),(47,11,1,0,1,999999,'2009-11-11 10:37:05','4afa93d16c4d9',1,1,'2009-11-11 10:37:05','2009-11-11 10:37:09'),(48,39,2,0,1,3,'2009-11-11 10:37:05','4afa93d16f572',1,1,'2009-11-11 10:37:05','2009-11-11 10:37:05'),(49,11,1,0,1,999999,'2009-11-11 10:37:21','4afa93e13200d',1,1,'2009-11-11 10:37:21','2009-11-11 10:37:25'),(50,39,2,0,1,4,'2009-11-11 10:37:21','4afa93e136041',1,1,'2009-11-11 10:37:21','2009-11-11 10:37:21'),(51,11,1,0,1,999999,'2009-11-11 10:37:42','4afa93f6a9f09',1,1,'2009-11-11 10:37:42','2009-11-11 10:37:46'),(52,39,2,0,1,5,'2009-11-11 10:37:42','4afa93f6ac26a',1,1,'2009-11-11 10:37:42','2009-11-11 10:37:42'),(53,11,1,0,1,999999,'2009-11-11 10:38:05','4afa940d16093',1,1,'2009-11-11 10:38:05','2009-11-11 10:38:08'),(54,39,2,0,1,6,'2009-11-11 10:38:05','4afa940d18cf3',1,1,'2009-11-11 10:38:05','2009-11-11 10:38:05'),(55,11,1,1,1,999999,'2009-11-11 10:38:31','4afa94273134c',1,1,'2009-11-11 10:38:31','2009-11-11 10:38:31'),(56,46,2,1,1,0,'2009-11-11 10:38:31','4afa942732ce7',1,1,'2009-11-11 10:38:31','2009-11-11 10:38:31'),(57,11,1,1,1,999999,'2009-11-11 10:38:40','4afa94301f88e',1,1,'2009-11-11 10:38:40','2009-11-11 10:38:40'),(58,47,2,1,1,0,'2009-11-11 10:38:40','4afa943021238',1,1,'2009-11-11 10:38:40','2009-11-11 10:38:40'),(59,11,1,1,1,999999,'2009-11-11 10:38:57','4afa944106b30',1,1,'2009-11-11 10:38:57','2009-11-11 10:38:57'),(60,48,2,1,1,0,'2009-11-11 10:38:57','4afa944108968',1,1,'2009-11-11 10:38:57','2009-11-11 10:38:57'),(61,11,1,1,1,999999,'2009-11-11 10:39:21','4afa945951770',1,1,'2009-11-11 10:39:21','2009-11-11 10:39:21'),(62,49,2,1,1,0,'2009-11-11 10:39:21','4afa945952e53',1,1,'2009-11-11 10:39:21','2009-11-11 10:39:21'),(63,11,1,1,1,999999,'2009-11-11 10:39:46','4afa9472bd339',1,1,'2009-11-11 10:39:46','2009-11-11 10:39:46'),(64,50,2,1,1,0,'2009-11-11 10:39:46','4afa9472bec22',1,1,'2009-11-11 10:39:46','2009-11-11 10:39:46'),(65,11,1,1,1,999999,'2009-11-11 10:39:59','4afa947f54c1c',1,1,'2009-11-11 10:39:59','2009-11-11 10:39:59'),(66,51,2,1,1,0,'2009-11-11 10:39:59','4afa947f55fd7',1,1,'2009-11-11 10:39:59','2009-11-11 10:39:59'),(67,11,1,1,1,999999,'2009-11-11 10:40:11','4afa948bbcabc',1,1,'2009-11-11 10:40:11','2009-11-11 10:40:11'),(68,52,2,1,1,0,'2009-11-11 10:40:11','4afa948bbe380',1,1,'2009-11-11 10:40:11','2009-11-11 10:40:11'),(69,11,1,1,1,999999,'2009-11-11 10:40:27','4afa949b05ba6',1,1,'2009-11-11 10:40:27','2009-11-11 10:40:27'),(70,54,2,1,1,0,'2009-11-11 10:40:27','4afa949b079fd',1,1,'2009-11-11 10:40:27','2009-11-11 10:40:27'),(71,11,1,1,1,999999,'2009-11-11 10:40:39','4afa94a7ba11f',1,1,'2009-11-11 10:40:39','2009-11-11 10:40:39'),(72,55,2,1,1,0,'2009-11-11 10:40:39','4afa94a7bbac4',1,1,'2009-11-11 10:40:39','2009-11-11 10:40:39'),(73,11,1,1,1,999999,'2009-11-11 10:40:51','4afa94b31835e',1,1,'2009-11-11 10:40:51','2009-11-11 10:40:51'),(74,56,2,1,1,0,'2009-11-11 10:40:51','4afa94b319cad',1,1,'2009-11-11 10:40:51','2009-11-11 10:40:51'),(75,11,1,1,1,999999,'2009-11-11 10:41:01','4afa94bd6841f',1,1,'2009-11-11 10:41:01','2009-11-11 10:41:01'),(76,58,2,1,1,0,'2009-11-11 10:41:01','4afa94bd699a0',1,1,'2009-11-11 10:41:01','2009-11-11 10:41:01'),(77,11,1,1,1,999999,'2009-11-11 10:41:07','4afa94c3c1b8a',1,1,'2009-11-11 10:41:07','2009-11-11 10:41:07'),(78,59,2,1,1,0,'2009-11-11 10:41:07','4afa94c3c36cf',1,1,'2009-11-11 10:41:07','2009-11-11 10:41:07'),(79,11,1,0,1,999999,'2009-11-11 10:41:53','4afa94f11aa1a',1,1,'2009-11-11 10:41:53','2009-11-11 10:41:57'),(80,50,2,0,1,1,'2009-11-11 10:41:53','4afa94f11d0e7',1,1,'2009-11-11 10:41:53','2009-11-11 10:41:53'),(81,11,1,0,1,999999,'2009-11-11 10:42:09','4afa9501512b4',1,1,'2009-11-11 10:42:09','2009-11-11 10:42:14'),(82,50,2,0,1,2,'2009-11-11 10:42:09','4afa9501535e4',1,1,'2009-11-11 10:42:09','2009-11-11 10:42:09'),(83,11,1,0,1,999999,'2009-11-11 10:43:40','4afa955ceee12',1,1,'2009-11-11 10:43:40','2009-11-11 10:43:50'),(84,51,2,0,1,1,'2009-11-11 10:43:40','4afa955cf0bfd',1,1,'2009-11-11 10:43:40','2009-11-11 10:43:40'),(85,11,1,0,1,999999,'2009-11-11 10:44:33','4afa9591a5287',1,1,'2009-11-11 10:44:33','2009-11-11 10:44:40'),(86,51,2,0,1,2,'2009-11-11 10:44:33','4afa9591a94da',1,1,'2009-11-11 10:44:33','2009-11-11 10:44:33'),(87,11,1,0,1,999999,'2009-11-11 10:44:52','4afa95a47a136',1,1,'2009-11-11 10:44:52','2009-11-11 10:44:57'),(88,51,2,0,1,3,'2009-11-11 10:44:52','4afa95a47cddc',1,1,'2009-11-11 10:44:52','2009-11-11 10:44:52'),(89,11,1,1,1,999999,'2009-11-11 10:45:34','4afa95ce4c1e1',1,1,'2009-11-11 10:45:34','2009-11-11 10:45:34'),(90,64,2,1,1,0,'2009-11-11 10:45:34','4afa95ce4dc29',1,1,'2009-11-11 10:45:34','2009-11-11 10:45:34'),(91,11,1,1,1,999999,'2009-11-11 10:45:49','4afa95dd3b88c',1,1,'2009-11-11 10:45:49','2009-11-11 10:45:49'),(92,65,2,1,1,0,'2009-11-11 10:45:49','4afa95dd3d29c',1,1,'2009-11-11 10:45:49','2009-11-11 10:45:49'),(93,11,1,1,1,999999,'2009-11-11 10:46:08','4afa95f066823',1,1,'2009-11-11 10:46:08','2009-11-11 10:46:08'),(94,66,2,1,1,0,'2009-11-11 10:46:08','4afa95f06818e',1,1,'2009-11-11 10:46:08','2009-11-11 10:46:08'),(95,11,1,0,1,999999,'2009-11-11 10:47:06','4afa962a1465c',1,1,'2009-11-11 10:47:06','2009-11-11 10:47:10'),(96,64,2,0,1,1,'2009-11-11 10:47:06','4afa962a165c5',1,1,'2009-11-11 10:47:06','2009-11-11 10:47:06'),(97,11,1,0,1,999999,'2009-11-11 10:47:20','4afa9638c5159',1,1,'2009-11-11 10:47:20','2009-11-11 10:47:25'),(98,64,2,0,1,2,'2009-11-11 10:47:20','4afa9638c7441',1,1,'2009-11-11 10:47:20','2009-11-11 10:47:20'),(99,11,1,0,1,999999,'2009-11-11 10:47:36','4afa9648645d5',1,1,'2009-11-11 10:47:36','2009-11-11 10:47:40'),(100,64,2,0,1,3,'2009-11-11 10:47:36','4afa964867907',1,1,'2009-11-11 10:47:36','2009-11-11 10:47:36'),(101,11,1,0,1,999999,'2009-11-11 10:47:52','4afa96582bb16',1,1,'2009-11-11 10:47:52','2009-11-11 10:47:56'),(102,64,2,0,1,4,'2009-11-11 10:47:52','4afa96582e3cd',1,1,'2009-11-11 10:47:52','2009-11-11 10:47:52'),(103,38,2,0,3,3,'2009-12-04 14:21:49','4b191afdd9e89',1,3,'2009-12-04 14:21:49','2009-12-04 14:21:49'),(104,38,2,0,3,4,'2009-12-09 07:56:17','4b1f58212016a',1,3,'2009-12-09 07:56:17','2009-12-09 07:56:17'),(105,11,1,0,3,999999,'2009-12-22 12:58:49','4b30c2896ef8d',1,3,'2009-12-22 12:58:49','2009-12-22 12:58:54'),(107,11,1,0,3,999999,'2009-12-22 12:59:29','4b30c2b1b2cca',1,3,'2009-12-22 12:59:29','2009-12-22 12:59:29'),(108,36,2,0,3,6,'2009-12-22 12:59:29','4b30c2b1b73d1',1,3,'2009-12-22 12:59:29','2009-12-22 12:59:29'),(109,11,1,0,3,999999,'2009-12-22 13:08:31','4b30c4cf66a83',1,3,'2009-12-22 13:08:31','2009-12-22 13:08:39'),(111,11,1,0,3,999999,'2009-12-22 13:09:34','4b30c50e9830e',1,3,'2009-12-22 13:09:34','2009-12-22 13:09:41'),(113,11,1,0,3,999999,'2009-12-22 13:10:03','4b30c52bc8fdf',1,3,'2009-12-22 13:10:03','2009-12-22 13:10:21'),(115,11,1,0,3,999999,'2009-12-22 13:17:00','4b30c6cccd18f',1,3,'2009-12-22 13:17:00','2009-12-22 13:17:04'),(117,11,1,0,3,999999,'2009-12-22 13:17:27','4b30c6e7b7025',1,3,'2009-12-22 13:17:27','2009-12-22 13:17:27'),(119,11,1,0,3,999999,'2009-12-22 13:20:04','4b30c7847b8d2',1,3,'2009-12-22 13:20:04','2009-12-22 13:20:04'),(121,11,1,0,3,999999,'2009-12-22 13:20:22','4b30c79628b7d',1,3,'2009-12-22 13:20:22','2009-12-22 13:20:22'),(122,12,1,0,3,3,'2009-12-22 13:20:22','4b30c7962b6a1',1,3,'2009-12-22 13:20:22','2009-12-22 13:20:22');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `properties` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) NOT NULL auto_increment,
  `idRegions` bigint(20) NOT NULL,
  `idFields` bigint(20) NOT NULL,
  `order` int(10) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idRegions` (`idRegions`),
  KEY `idFields` (`idFields`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regionFields`
--

LOCK TABLES `regionFields` WRITE;
/*!40000 ALTER TABLE `regionFields` DISABLE KEYS */;
INSERT INTO `regionFields` VALUES (1,1,1,1),(2,1,1,1),(3,1,2,2),(4,2,3,1),(5,2,4,2),(6,3,5,1),(7,4,6,1),(8,5,7,2),(9,6,8,2),(10,8,10,2),(11,9,11,1),(12,10,17,1),(13,11,18,2),(14,11,19,3),(15,11,20,1),(16,9,21,5),(17,9,22,3),(18,12,23,1),(19,12,24,3),(20,5,25,1),(21,6,26,1),(22,2,27,3),(23,13,28,1),(24,14,29,3),(25,14,30,1),(26,15,31,5),(27,15,34,3),(28,15,37,1),(29,2,40,1),(30,16,41,4),(31,16,42,2),(32,16,43,1),(33,17,44,5),(34,17,45,2),(35,17,46,1),(36,15,47,6),(37,15,48,7),(38,16,49,5),(39,16,50,6),(40,17,51,6),(41,17,52,7),(42,17,53,3),(43,12,54,2),(44,8,55,1),(45,9,56,4),(46,15,59,2),(47,15,60,4),(48,16,61,3),(49,17,62,4),(50,99999999,64,2),(51,18,65,3),(52,18,66,4),(53,19,67,1),(54,19,68,2),(55,20,69,2),(56,20,70,3),(57,20,71,4),(58,20,72,5),(59,20,73,1),(60,19,74,3),(61,19,75,4),(62,18,76,1),(63,18,77,2),(64,18,78,5),(65,21,79,1),(66,21,80,2),(67,21,81,3),(68,21,82,4),(69,21,83,5),(70,21,84,6),(71,22,85,1),(72,9,86,2),(73,19,87,5),(74,23,88,2),(75,23,89,3),(76,23,90,1),(77,24,91,1),(78,24,92,2),(79,25,93,2),(80,25000,94,1),(81,15,95,8),(82,25,96,1),(83,26,1,1),(84,27,97,1),(85,27,98,2),(86,26,99,2),(87,26,100,3),(88,26,101,4),(89,26,102,5),(90,26,103,6),(91,28,108,1),(92,26,27,7),(93,29,104,1),(94,29,105,2),(95,30,106,1),(96,29,107,3),(97,31,109,1),(98,32,110,1),(99,32,113,2),(101,35,115,1),(102,33,111,1),(103,33,112,1),(104,36,116,1),(105,37,117,1),(106,38,118,1),(107,39,119,1),(108,39,120,2),(109,40,121,1),(110,40,122,2),(111,41,86,1),(113,41,22,2),(115,41,56,3),(116,41,21,4),(117,42,6,1),(119,43,5,1),(120,44,7,1),(121,45,20,1),(122,45,18,2),(123,45,19,3),(124,45,123,4),(125,46,23,1),(126,46,54,2),(127,46,24,3),(128,47,26,1),(129,47,129,2),(130,48,119,1),(131,48,120,2),(132,49,55,1),(133,49,10,2),(134,50,124,1),(135,50,125,2),(136,51,126,1),(137,51,127,2),(138,14,128,2),(139,52,46,1),(140,52,130,2),(141,52,131,3),(142,52,132,4);
/*!40000 ALTER TABLE `regionFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regionTitles`
--

DROP TABLE IF EXISTS `regionTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regionTitles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idRegions` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(500) default NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idRegionTypes` bigint(20) unsigned NOT NULL,
  `columns` int(10) NOT NULL COMMENT 'size of region',
  `isTemplate` tinyint(1) NOT NULL default '0' COMMENT 'indicates, whether this region should be multiusable - needed later on for tempalte editor',
  `collapsable` tinyint(1) NOT NULL default '1',
  `isCollapsed` tinyint(1) NOT NULL default '1',
  `position` varchar(255) default NULL,
  `isMultiply` tinyint(1) NOT NULL default '0',
  `multiplyRegion` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
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
  PRIMARY KEY  (`id`)
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
  PRIMARY KEY  (`idResources`,`idGroups`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `key` varchar(64) NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idRootLevels` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned default NULL,
  `idPermissions` bigint(20) unsigned default NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idRootLevels` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(500) default NULL,
  PRIMARY KEY  (`id`),
  KEY `rootLevelTitles_ibfk_1` (`idRootLevels`),
  CONSTRAINT `rootLevelTitles_ibfk_1` FOREIGN KEY (`idRootLevels`) REFERENCES `rootLevels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevelTitles`
--

LOCK TABLES `rootLevelTitles` WRITE;
/*!40000 ALTER TABLE `rootLevelTitles` DISABLE KEYS */;
INSERT INTO `rootLevelTitles` VALUES (1,1,1,'.COM Schaan'),(2,2,1,'Bilder'),(3,3,1,'Dokumente'),(4,5,1,'Kontakte'),(5,4,1,'Kategorien'),(6,6,1,'Eigene Etiketten'),(7,7,1,'System Interne'),(8,8,1,'Benutzer'),(9,9,1,'Gruppen / Rollen'),(10,10,1,'Ressourcen'),(11,1,2,'.COM Schaan'),(12,11,1,'Alle Produkte'),(13,12,1,'Produktbaum'),(14,13,1,'.DE Deutschland'),(15,13,2,'.DE Germany'),(16,14,1,'.FR Frankreich'),(17,14,2,'.FR France');
/*!40000 ALTER TABLE `rootLevelTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rootLevelTypes`
--

DROP TABLE IF EXISTS `rootLevelTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rootLevelTypes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idRootLevels` bigint(20) unsigned NOT NULL,
  `url` varchar(255) NOT NULL COMMENT 'without "www" in front',
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idRootLevelTypes` int(10) unsigned NOT NULL,
  `idModules` bigint(20) unsigned NOT NULL,
  `href` varchar(64) default NULL,
  `idThemes` bigint(20) unsigned default NULL,
  PRIMARY KEY  (`id`)
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'test'),(2,'live'),(3,'approval');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusTitles`
--

DROP TABLE IF EXISTS `statusTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statusTitles` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idStatus` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `idStatus` (`idStatus`),
  CONSTRAINT `statusTitles_ibfk_1` FOREIGN KEY (`idStatus`) REFERENCES `status` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusTitles`
--

LOCK TABLES `statusTitles` WRITE;
/*!40000 ALTER TABLE `statusTitles` DISABLE KEYS */;
INSERT INTO `statusTitles` VALUES (1,1,1,'Test'),(2,2,1,'Veröffentlicht'),(3,3,1,'Approval');
/*!40000 ALTER TABLE `statusTitles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabRegions`
--

DROP TABLE IF EXISTS `tabRegions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabRegions` (
  `id` bigint(20) NOT NULL auto_increment,
  `idTabs` bigint(20) NOT NULL,
  `idRegions` bigint(20) NOT NULL,
  `order` int(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabRegions`
--

LOCK TABLES `tabRegions` WRITE;
/*!40000 ALTER TABLE `tabRegions` DISABLE KEYS */;
INSERT INTO `tabRegions` VALUES (1,1,1,1),(2,2,2,1),(3,2,3,4),(4,2,4,6),(5,2,5,9),(6,2,6,10),(7,2,7,0),(8,2,8,12),(9,2,9,0),(10,5,10,1),(15,2,11,7),(16,2,12,8),(17,6,13,1),(18,7,2,1),(19,7,9,0),(20,7,14,6),(21,7,15,4),(22,8,2,1),(23,8,9,0),(24,8,11,7),(25,8,16,3),(26,8,17,8),(47,7,8,11),(48,7,3,4),(49,7,4,7),(50,9,10,1),(51,11,2,1),(52,11,3,4),(53,11,4,6),(54,11,5,9),(55,11,6,10),(56,11,7,0),(57,11,8,11),(58,11,9,0),(60,11,12,8),(61,10,18,1),(62,11,19,4),(63,11,20,5),(64,10,21,2),(65,11,22,6),(66,12,2,1),(67,12,3,4),(68,12,4,6),(69,12,8,11),(70,12,9,0),(71,8,23,5),(72,8,3,4),(73,8,4,6),(74,2,24,2),(75,8,24,2),(76,11,24,2),(77,12,24,2),(78,13,25,1),(79,14,26,1),(80,15,27,2),(81,16,28,1),(82,17,29,4),(83,14,30,2),(84,14,31,3),(85,18,32,1),(86,19,33,6),(87,14,34,4),(88,14,35,5),(89,14,36,6),(90,14,37,7),(91,2,38,3),(92,2,39,11),(93,7,40,5),(94,20,41,2),(95,20,42,5),(96,20,43,3),(97,20,44,8),(98,20,45,6),(99,20,46,7),(100,20,47,9),(101,20,48,10),(102,20,49,12),(103,20,50,11),(104,20,2,1),(105,21,41,0),(106,21,2,1),(107,21,43,2),(108,21,15,4),(109,21,14,5),(110,21,4,3),(111,21,8,6),(112,20,51,4),(113,22,9,0),(114,22,2,1),(115,22,3,4),(116,22,14,6),(117,22,4,7),(118,22,8,11),(119,22,52,5);
/*!40000 ALTER TABLE `tabRegions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabTitles`
--

DROP TABLE IF EXISTS `tabTitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTitles` (
  `id` bigint(20) NOT NULL auto_increment,
  `idTabs` bigint(20) NOT NULL,
  `idLanguages` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) NOT NULL auto_increment,
  `color` char(7) character set latin1 default NULL,
  PRIMARY KEY  (`id`)
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
  `idLanguages` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`idTags`,`fileId`,`version`,`idLanguages`),
  KEY `idTags` (`idTags`),
  KEY `idFiles` (`fileId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagFiles`
--

LOCK TABLES `tagFiles` WRITE;
/*!40000 ALTER TABLE `tagFiles` DISABLE KEYS */;
INSERT INTO `tagFiles` VALUES (1,'17',1,1),(1,'22',1,1),(1,'31',1,1),(1,'32',1,1),(1,'57',1,1),(1,'59',1,1),(2,'22',1,1),(2,'32',1,1),(2,'33',1,1),(2,'57',1,1),(2,'59',1,1),(3,'59',1,1),(4,'56',1,1),(4,'58',1,1),(6,'56',1,1),(8,'56',1,1),(10,'33',1,1),(11,'58',1,1);
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
  `idLanguages` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`idTags`,`folderId`,`version`,`idLanguages`),
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
  `idLanguages` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`idTags`,`pageId`,`version`,`idLanguages`),
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
  `idLanguages` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`idTags`,`productId`,`version`,`idLanguages`),
  KEY `idTags` (`idTags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagProducts`
--

LOCK TABLES `tagProducts` WRITE;
/*!40000 ALTER TABLE `tagProducts` DISABLE KEYS */;
INSERT INTO `tagProducts` VALUES (1,'4afa92c061f69',1,1),(1,'4afa935fd7c1c',1,1),(2,'4afa92c061f69',1,1),(2,'4afa935fd7c1c',1,1),(13,'4afa935fd7c1c',1,1);
/*!40000 ALTER TABLE `tagProducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Tag1'),(2,'Tag2'),(3,'Tag3'),(4,'Test1'),(5,'Test2'),(6,'Test3'),(8,'blub'),(10,'Das ist ein langer Tag'),(11,'dieter'),(12,'conny'),(13,'neuer Tag');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templateExcludedFields`
--

DROP TABLE IF EXISTS `templateExcludedFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templateExcludedFields` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `templateExcludedFields_ibfk_1` (`idTemplates`),
  CONSTRAINT `templateExcludedFields_ibfk_1` FOREIGN KEY (`idTemplates`) REFERENCES `templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateExcludedFields`
--

LOCK TABLES `templateExcludedFields` WRITE;
/*!40000 ALTER TABLE `templateExcludedFields` DISABLE KEYS */;
INSERT INTO `templateExcludedFields` VALUES (1,1,40),(2,2,3),(3,2,4000),(4,4,3),(5,4,4000),(6,3,3),(8,5,40),(9,6,40),(10,7,40),(11,3,86),(12,4,86),(13,6,86),(14,8,3),(15,8,4),(16,8,86),(17,10,3),(18,11,40),(19,12,3);
/*!40000 ALTER TABLE `templateExcludedFields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templateExcludedRegions`
--

DROP TABLE IF EXISTS `templateExcludedRegions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templateExcludedRegions` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idRegions` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idRegions` bigint(20) unsigned NOT NULL,
  `order` int(10) default NULL,
  `collapsable` tinyint(1) default NULL,
  `isCollapsed` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `idTemplates` bigint(20) unsigned NOT NULL,
  `idTypes` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `genericFormId` varchar(32) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idUnits` bigint(20) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `title` varchar(500) default NULL,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idGenericForms` bigint(20) unsigned NOT NULL,
  `idParentUnit` bigint(20) unsigned NOT NULL default '0',
  `idRootUnit` bigint(20) unsigned default NULL,
  `lft` int(10) unsigned default NULL,
  `rgt` int(10) unsigned default NULL,
  `depth` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `relationId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idUrlTypes` int(10) unsigned NOT NULL default '1',
  `isMain` tinyint(1) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idParent` bigint(20) unsigned default NULL,
  `idParentTypes` int(10) unsigned default NULL,
  `url` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `relationId` (`relationId`,`version`,`idUrlTypes`,`idLanguages`),
  KEY `relationId_2` (`relationId`),
  KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urls`
--

LOCK TABLES `urls` WRITE;
/*!40000 ALTER TABLE `urls` DISABLE KEYS */;
INSERT INTO `urls` VALUES (1,'49f17460a4f9f',1,1,1,1,NULL,NULL,'',3,3,'2009-12-15 16:00:39','2009-12-15 16:00:39'),(4,'4afa8f39584a2',1,1,1,1,NULL,NULL,'distinguished-by-innovation/',3,3,'2009-12-15 16:01:01','2009-12-15 16:01:01'),(5,'4afa9c9388b0e',1,1,1,1,NULL,NULL,'distinguished-by-innovation/press-pictures/',3,3,'2009-12-15 16:01:09','2009-12-15 16:01:09'),(6,'4afa9c9f50419',1,1,1,1,NULL,NULL,'distinguished-by-innovation/implant-restorations_-protected-all-around',3,3,'2009-12-15 16:01:13','2009-12-15 16:01:13'),(7,'4afa9cbaf0044',1,1,1,1,NULL,NULL,'distinguished-by-innovation/definitely-quicker',3,3,'2009-12-15 16:01:17','2009-12-15 16:01:17'),(8,'4afa9cc6e7d4f',1,1,1,1,NULL,NULL,'distinguished-by-innovation/the-better-way-of-tooth-isolation',3,3,'2009-12-15 16:01:20','2009-12-15 16:01:20'),(10,'4afad63cb6099',1,1,0,1,NULL,NULL,'company/schaan/test',3,3,'2009-12-15 16:01:31','2009-12-15 16:09:19'),(11,'4afad7b0dffc0',1,1,0,1,NULL,NULL,'company/schaan/test-1',3,3,'2009-12-15 16:01:35','2009-12-15 16:09:19'),(12,'4afad7c8cc1b1',1,1,0,1,NULL,NULL,'company/schaan/test2',3,3,'2009-12-15 16:01:38','2009-12-15 16:09:19'),(13,'4afa9276f1d58',1,1,0,1,NULL,NULL,'company/schaan-nnn/',3,3,'2009-12-15 16:09:19','2009-12-15 16:09:48'),(14,'4afad63cb6099',1,1,0,1,NULL,NULL,'company/schaan-nnn/test',3,3,'2009-12-15 16:09:19','2009-12-15 16:09:48'),(15,'4afad7b0dffc0',1,1,0,1,NULL,NULL,'company/schaan-nnn/test-1',3,3,'2009-12-15 16:09:19','2009-12-15 16:09:48'),(16,'4afad7c8cc1b1',1,1,0,1,NULL,NULL,'company/schaan-nnn/test2',3,3,'2009-12-15 16:09:19','2009-12-15 16:09:48'),(18,'4afa9276f1d58',1,1,0,1,NULL,NULL,'company-conny/schaan-nnn/',3,3,'2009-12-15 16:09:48','2009-12-15 16:10:40'),(19,'4afad63cb6099',1,1,0,1,NULL,NULL,'company-conny/schaan-nnn/test',3,3,'2009-12-15 16:09:48','2009-12-15 16:10:40'),(20,'4afad7b0dffc0',1,1,0,1,NULL,NULL,'company-conny/schaan-nnn/test-1',3,3,'2009-12-15 16:09:48','2009-12-15 16:10:40'),(21,'4afad7c8cc1b1',1,1,0,1,NULL,NULL,'company-conny/schaan-nnn/test2',3,3,'2009-12-15 16:09:48','2009-12-15 16:10:40'),(22,'4af44cdae2991',1,1,0,1,NULL,NULL,'company-conny/history/',3,3,'2009-12-15 16:10:09','2009-12-15 16:10:40'),(23,'4afa9c5d634f6',1,1,0,1,NULL,NULL,'company-conny/facts-und-figures/',3,3,'2009-12-15 16:10:14','2009-12-15 16:10:40'),(24,'4a1133f43284a',1,1,1,1,NULL,NULL,'company/',3,3,'2009-12-15 16:10:40','2009-12-15 16:10:40'),(25,'4afa9276f1d58',1,1,0,1,NULL,NULL,'company/schaan-nnn/',3,3,'2009-12-15 16:10:40','2009-12-15 16:11:18'),(26,'4afad63cb6099',1,1,0,1,NULL,NULL,'company/schaan-nnn/test',3,3,'2009-12-15 16:10:40','2009-12-15 16:11:18'),(27,'4afad7b0dffc0',1,1,0,1,NULL,NULL,'company/schaan-nnn/test-1',3,3,'2009-12-15 16:10:40','2009-12-15 16:11:18'),(28,'4afad7c8cc1b1',1,1,0,1,NULL,NULL,'company/schaan-nnn/test2',3,3,'2009-12-15 16:10:40','2009-12-15 16:11:18'),(29,'4af44cdae2991',1,1,1,1,NULL,NULL,'company/history/',3,3,'2009-12-15 16:10:40','2009-12-15 16:10:40'),(30,'4afa9c5d634f6',1,1,1,1,NULL,NULL,'company/facts-und-figures/',3,3,'2009-12-15 16:10:40','2009-12-15 16:10:40'),(31,'4afa9276f1d58',1,1,1,1,NULL,NULL,'company/schaan/',3,3,'2009-12-15 16:11:18','2009-12-15 16:11:18'),(32,'4afad63cb6099',1,1,1,1,NULL,NULL,'company/schaan/test',3,3,'2009-12-15 16:11:18','2009-12-15 16:11:18'),(33,'4afad7b0dffc0',1,1,1,1,NULL,NULL,'company/schaan/test-1',3,3,'2009-12-15 16:11:18','2009-12-15 16:11:18'),(34,'4afad7c8cc1b1',1,1,1,1,NULL,NULL,'company/schaan/test2',3,3,'2009-12-15 16:11:18','2009-12-15 16:11:18'),(36,'4afa971de31f6',1,1,0,1,NULL,NULL,'dp/',3,3,'2009-12-15 16:31:29','2009-12-15 16:47:28'),(37,'4a112157d69eb',1,1,0,1,NULL,NULL,'dp/products/',3,3,'2009-12-15 16:31:29','2009-12-15 16:47:28'),(38,'4a681b0f66d2a',1,1,0,1,NULL,NULL,'dp/products/test',3,3,'2009-12-15 16:31:37','2009-12-15 16:47:28'),(41,'4a681b0f66d2a',1,1,0,1,NULL,NULL,'dental-professional/products/test',3,3,'2009-12-15 16:47:28','2009-12-15 16:48:23'),(43,'4a681b0f66d2a',1,1,0,1,NULL,NULL,'dental-professional/products/test-1',3,3,'2009-12-15 16:48:23','2009-12-16 08:09:12'),(80,'4af978b4395fb',1,2,1,1,NULL,NULL,'',3,3,'2009-12-15 18:33:01','2009-12-15 18:33:01'),(81,'4af978b4395fb',1,2,1,2,NULL,NULL,'',3,3,'2009-12-15 18:33:04','2009-12-15 18:33:04'),(82,'4afa8ff5a584a',1,2,0,1,NULL,NULL,'produkte/',3,3,'2009-12-15 18:33:13','2009-12-15 18:33:20'),(83,'4afa8ff5a584a',1,2,1,1,NULL,NULL,'p/',3,3,'2009-12-15 18:33:20','2009-12-15 18:33:20'),(84,'4afa8ff5a584a',1,2,0,2,NULL,NULL,'products/',3,3,'2009-12-15 18:33:25','2009-12-15 18:33:32'),(85,'4afa8ff5a584a',1,2,1,2,NULL,NULL,'p/',3,3,'2009-12-15 18:33:32','2009-12-15 18:33:32'),(86,'4afa902ab8b6e',1,2,0,1,NULL,NULL,'p/fuellungstherapie/',3,3,'2009-12-15 18:33:41','2009-12-15 18:34:24'),(87,'4afa902ab8b6e',1,2,1,2,NULL,NULL,'p/restorative-therapy/',3,3,'2009-12-15 18:33:45','2009-12-15 18:33:45'),(88,'4afa92134e5ee',1,2,0,1,NULL,NULL,'p/fuellungstherapie/composites/',3,3,'2009-12-15 18:33:50','2009-12-15 18:34:24'),(89,'4afa92134e5ee',1,2,1,2,NULL,NULL,'p/restorative-therapy/composites/',3,3,'2009-12-15 18:33:54','2009-12-15 18:33:54'),(90,'4afa935fda39e',1,2,0,1,NULL,NULL,'p/fuellungstherapie/composites/tetric-color',3,3,'2009-12-15 18:34:00','2009-12-15 18:34:24'),(91,'4afa902ab8b6e',1,2,0,1,NULL,NULL,'p/fuellungen/',3,3,'2009-12-15 18:34:24','2009-12-16 08:07:04'),(92,'4afa92134e5ee',1,2,0,1,NULL,NULL,'p/fuellungen/composites/',3,3,'2009-12-15 18:34:24','2009-12-16 08:07:04'),(93,'4afa935fda39e',1,2,0,1,NULL,NULL,'p/fuellungen/composites/tetric-color',3,3,'2009-12-15 18:34:24','2009-12-16 08:07:04'),(94,'4afa902ab8b6e',1,2,1,1,NULL,NULL,'p/f/',3,3,'2009-12-16 08:07:04','2009-12-16 08:07:04'),(95,'4afa92134e5ee',1,2,1,1,NULL,NULL,'p/f/composites/',3,3,'2009-12-16 08:07:04','2009-12-16 08:07:04'),(97,'4afa971de31f6',1,1,0,1,NULL,NULL,'dental/',3,3,'2009-12-16 08:09:12','2009-12-17 13:18:11'),(98,'4a112157d69eb',1,1,0,1,NULL,NULL,'dental/products/',3,3,'2009-12-16 08:09:12','2009-12-17 13:18:11'),(99,'4a681b0f66d2a',1,1,0,1,NULL,NULL,'dental/products/test-1',3,3,'2009-12-16 08:09:12','2009-12-17 13:18:11'),(100,'4a112157d69eb',1,1,1,2,NULL,NULL,'main-navigation-1/',3,3,'2009-12-16 08:09:48','2009-12-16 08:09:48'),(101,'4afa935fda39e',1,2,1,1,NULL,NULL,'p/f/composites/tetric',3,3,'2009-12-17 12:53:33','2009-12-17 12:53:33'),(104,'4a681b0f66d2a',1,1,0,1,NULL,NULL,'dental-professional-1/products/test-1',3,3,'2009-12-17 13:18:11','2009-12-17 13:19:28'),(105,'4afa971de31f6',1,1,1,1,NULL,NULL,'dental-professional/',3,3,'2009-12-17 13:19:28','2009-12-17 13:19:28'),(106,'4a112157d69eb',1,1,0,1,NULL,NULL,'dental-professional/products-1/',3,3,'2009-12-17 13:19:28','2009-12-22 13:22:50'),(107,'4a681b0f66d2a',1,1,0,1,NULL,NULL,'dental-professional/products/test-1-1',3,3,'2009-12-17 13:19:28','2009-12-17 16:23:09'),(108,'4afa92c064543',1,2,1,2,NULL,NULL,'p/restorative-therapy/composites/ips-empress-direct',3,3,'2009-12-17 14:41:09','2009-12-17 14:41:09'),(109,'4afa92c064543',1,2,1,1,NULL,NULL,'p/f/composites/ips-empress-direct',3,3,'2009-12-17 14:41:12','2009-12-17 14:41:12'),(110,'4a681b0f66d2a',1,1,1,1,NULL,NULL,'dental-professional/products-1/test-1-1',3,3,'2009-12-17 16:23:09','2009-12-17 16:23:09'),(111,'4afa93248dbb8',1,2,1,1,NULL,NULL,'p/f/composites/tetric-1',3,3,'2009-12-17 17:16:24','2009-12-17 17:16:24'),(112,'4afa92e436b41',1,2,0,1,NULL,NULL,'p/f/composites/tetric--evoflow',3,3,'2009-12-17 17:16:28','2009-12-17 17:24:22'),(113,'4afa933675ff8',1,2,1,1,NULL,NULL,'p/f/composites/tetric-ceram-hb',3,3,'2009-12-17 17:16:31','2009-12-17 17:16:31'),(114,'4afa92e436b41',1,2,1,1,NULL,NULL,'p/f/composites/tetric-evoflow',3,3,'2009-12-17 17:24:22','2009-12-17 17:24:22'),(115,'4b30c28976b97',1,2,1,1,NULL,NULL,'p/f/composites/test',3,3,'2009-12-22 12:58:54','2009-12-22 12:58:54'),(116,'4b30c3f68cb77',1,1,1,1,NULL,NULL,'dental-professional/products-1/test',3,3,'2009-12-22 13:04:54','2009-12-22 13:04:54'),(117,'4b30c4cf69368',1,2,1,1,NULL,NULL,'-1',3,3,'2009-12-22 13:08:39','2009-12-22 13:08:39'),(118,'4afa935fda39e',1,2,1,2,NULL,NULL,'p/restorative-therapy/composites/tetric-color',3,3,'2009-12-22 13:09:16','2009-12-22 13:09:16'),(119,'4b30c50e9ad5d',1,2,1,1,NULL,NULL,'-1',3,3,'2009-12-22 13:09:41','2009-12-22 13:09:41'),(120,'4b30c52bcddfd',1,2,1,1,NULL,NULL,'p/test',3,3,'2009-12-22 13:10:21','2009-12-22 13:10:21'),(121,'4b30c6ccd0d82',1,2,1,1,NULL,NULL,'test',3,3,'2009-12-22 13:17:04','2009-12-22 13:17:04'),(122,'4b30c7847e0e7',1,2,1,1,NULL,NULL,'test',3,3,'2009-12-22 13:20:04','2009-12-22 13:20:04'),(123,'4b30c7962b6a1',1,2,1,1,NULL,NULL,'test',3,3,'2009-12-22 13:20:22','2009-12-22 13:20:22'),(124,'4b30c7caa2648',1,1,1,1,NULL,NULL,'dental-professional/products-1/test',3,3,'2009-12-22 13:21:14','2009-12-22 13:21:14'),(125,'4b30c7f3cb88e',1,1,1,1,NULL,NULL,'dental-professional/products-1/test',3,3,'2009-12-22 13:21:55','2009-12-22 13:21:55'),(127,'4a112157d69eb',1,1,1,1,NULL,NULL,'dental-professional/products/',3,3,'2009-12-22 13:22:50','2009-12-22 13:22:50'),(128,'4b30c814deb7b',1,1,1,1,NULL,NULL,'dental-professional/products/test',3,3,'2009-12-22 13:22:50','2009-12-22 13:22:50'),(129,'4af3cb435ebcf',1,1,1,1,NULL,NULL,'laboratory-professional/',3,3,'2009-12-23 13:54:28','2009-12-23 13:54:28');
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
  PRIMARY KEY  (`idUsers`,`idGroups`)
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
  PRIMARY KEY  (`id`)
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `sname` varchar(255) NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(20) NOT NULL,
  PRIMARY KEY  (`id`)
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

-- Dump completed on 2009-12-23 16:00:59
