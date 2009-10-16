-- MySQL dump 10.11
--
-- Host: localhost    Database: zoolu
-- ------------------------------------------------------
-- Server version	5.0.84

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
  KEY `idRootCategory` (`idRootCategory`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,0,1,1,NULL,1,12,0),(11,0,11,2,NULL,1,20,0),(12,11,11,2,NULL,2,13,1),(13,11,11,2,NULL,14,19,1),(14,13,11,2,'DESC',15,16,2),(15,13,11,2,'ASC',17,18,2),(16,12,11,2,'alpha',3,4,2),(17,12,11,2,'sort',5,6,2),(18,12,11,2,'created',7,8,2),(19,12,11,2,'changed',9,10,2),(21,0,21,3,NULL,1,8,0),(27,0,27,2,NULL,1,14,0),(28,27,27,2,'col-1',2,3,1),(29,27,27,2,'col-1-img',4,5,1),(30,27,27,2,'col-2',6,7,1),(31,27,27,2,'col-2-img',8,9,1),(35,27,27,2,'list',10,11,1),(36,27,27,2,'list-img',12,13,1),(40,12,11,2,'published',11,12,2),(42,0,42,2,NULL,1,4,0),(43,42,42,2,'similar_pages',2,3,1),(48,0,48,2,NULL,1,10,0),(49,48,48,2,NULL,2,9,1),(50,49,48,2,NULL,3,4,2),(51,49,48,2,NULL,5,6,2),(52,49,48,2,NULL,7,8,2),(53,1,1,1,NULL,6,7,1),(54,1,1,1,NULL,8,9,1),(55,1,1,1,NULL,10,11,1),(56,21,21,3,NULL,2,3,1),(60,21,21,3,NULL,4,5,1),(63,21,21,3,NULL,6,7,1),(64,0,64,2,NULL,1,6,0),(65,64,64,2,NULL,2,3,1),(66,64,64,2,NULL,4,5,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoryTitles`
--

LOCK TABLES `categoryTitles` WRITE;
/*!40000 ALTER TABLE `categoryTitles` DISABLE KEYS */;
INSERT INTO `categoryTitles` VALUES (1,1,1,'Seiten Kategorien',0,'0000-00-00 00:00:00'),(11,11,1,'Sortierung',0,'0000-00-00 00:00:00'),(12,12,1,'Sortierarten',0,'0000-00-00 00:00:00'),(13,13,1,'Reihenfolge',0,'0000-00-00 00:00:00'),(14,14,1,'absteigend',0,'0000-00-00 00:00:00'),(15,15,1,'aufsteigend',0,'0000-00-00 00:00:00'),(16,16,1,'Alphabet',0,'0000-00-00 00:00:00'),(17,17,1,'Sortierung',0,'0000-00-00 00:00:00'),(18,18,1,'Erstelldatum',0,'0000-00-00 00:00:00'),(19,19,1,'Änderungsdatum',0,'0000-00-00 00:00:00'),(21,21,1,'Seiten Etiketten',0,'0000-00-00 00:00:00'),(27,27,1,'Darstellungsformen',0,'0000-00-00 00:00:00'),(28,28,1,'1-spaltig ohne Bilder',0,'0000-00-00 00:00:00'),(29,29,1,'1-spaltig mit Bilder',0,'0000-00-00 00:00:00'),(30,30,1,'2-spaltig ohne Bilder',0,'0000-00-00 00:00:00'),(31,31,1,'2-spaltig mit Bilder',0,'0000-00-00 00:00:00'),(35,35,1,'Liste ohne Bilder',0,'0000-00-00 00:00:00'),(36,36,1,'Liste mit Bilder',0,'0000-00-00 00:00:00'),(40,40,1,'Veröffentlichungsdatum',0,'0000-00-00 00:00:00'),(42,42,1,'Darstellungsoptionen',0,'0000-00-00 00:00:00'),(43,43,1,'Ähnliche Seiten anzeigen',0,'0000-00-00 00:00:00'),(48,48,1,'Status',0,'0000-00-00 00:00:00'),(49,49,1,'Veranstaltung',0,'0000-00-00 00:00:00'),(50,50,1,'Anmeldung offen',0,'0000-00-00 00:00:00'),(51,51,1,'Wenige Restplätze',0,'0000-00-00 00:00:00'),(52,52,1,'Ausgebucht',0,'0000-00-00 00:00:00'),(53,53,1,'Test 1',0,'0000-00-00 00:00:00'),(54,54,1,'Test 2',0,'0000-00-00 00:00:00'),(55,55,1,'Test 3',0,'0000-00-00 00:00:00'),(56,56,1,'Test 1',0,'0000-00-00 00:00:00'),(59,54,2,'Test EN 2',0,'0000-00-00 00:00:00'),(60,55,2,'Test EN 3',0,'0000-00-00 00:00:00'),(61,53,2,'Test EN 1',3,'2009-06-09 17:07:59'),(62,53,2,'Test EN 1',3,'2009-06-09 17:07:59'),(63,56,2,'Test 1 EN',0,'0000-00-00 00:00:00'),(73,60,1,'Test 2',0,'0000-00-00 00:00:00'),(76,63,1,'Test 3',3,'2009-06-09 09:07:55'),(77,63,2,'Test 3 EN',3,'2009-06-09 09:07:52'),(78,60,2,'Test 2 EN',3,'2009-06-09 09:08:59'),(79,64,1,'Sub-Navigations-Seiten',3,'2009-06-23 08:27:54'),(80,65,1,'nicht miteinbeziehen',3,'2009-06-23 08:28:09'),(81,66,1,'miteinbeziehen',3,'2009-06-23 08:28:34');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,10,3,3,1,'','','Thomas','Schedler','','','','','','','2009-04-24 08:26:40','2009-04-24 08:26:40'),(2,10,3,3,1,'','','Bernd','Hepberger','','','','','','','2009-06-08 14:28:48','2009-06-08 14:28:48');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `decorators`
--

LOCK TABLES `decorators` WRITE;
/*!40000 ALTER TABLE `decorators` DISABLE KEYS */;
INSERT INTO `decorators` VALUES (1,'Input'),(2,'Template'),(3,'Tag'),(4,'Overflow'),(5,'Url'),(6,'VideoSelect'),(7,'Gmaps');
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
  PRIMARY KEY  (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldTitles`
--

LOCK TABLES `fieldTitles` WRITE;
/*!40000 ALTER TABLE `fieldTitles` DISABLE KEYS */;
INSERT INTO `fieldTitles` VALUES (1,1,1,'Titel',NULL),(2,2,1,'Beschreibung',NULL),(3,3,1,'Titel',NULL),(4,4,1,'Überschrift für den Artikel',NULL),(5,11,1,'Aktuelles Template',NULL),(6,5,1,NULL,NULL),(7,7,1,'',''),(8,8,1,NULL,NULL),(9,12,1,'Multiselect Test',NULL),(11,15,1,'Radiobuttons',NULL),(12,16,1,'Checkboxes',NULL),(13,17,1,'Titel',NULL),(14,20,1,'Titel',NULL),(15,21,1,'Tags',NULL),(16,22,1,'Kategorien',NULL),(17,24,1,'Embed Code',NULL),(18,23,1,'Titel',NULL),(19,25,1,'Titel',NULL),(20,26,1,'Titel',NULL),(21,28,1,'Verlinkte Seite',NULL),(22,30,1,'Titel',NULL),(23,31,1,'Anzahl',NULL),(26,37,1,'Titel',NULL),(29,34,1,'Nur Seiten mit Kategorie',NULL),(30,41,1,'Anzahl',NULL),(31,42,1,'Nur Seiten mit Kategorie',NULL),(32,43,1,'Titel',NULL),(33,47,1,'Sortierung nach',NULL),(34,48,1,'Reihenfolge',NULL),(35,49,1,'Sortierung nach',NULL),(36,50,1,'Reihenfolge',NULL),(37,51,1,'Sortierung nach',NULL),(38,52,1,'Reihenfolge',NULL),(39,44,1,'Anzahl',NULL),(40,45,1,'Navigationspunkt',NULL),(41,46,1,'Titel',NULL),(42,53,1,'Nur Seiten mit Kategorie',NULL),(43,54,1,'Video Service',NULL),(44,10,1,'Kurzbeschreibung des Artikels',NULL),(45,56,1,'Eigene Etiketten',NULL),(47,59,1,'Darstellungsform',NULL),(49,60,1,'Nur Seiten mit Etikett',NULL),(50,61,1,'Nur Seiten mit Etikett',NULL),(51,62,1,'Nur Seiten mit Etikett',NULL),(53,64,1,'Darstellungsoptionen',NULL),(54,65,1,'Vorname',NULL),(55,66,1,'Nachname',NULL),(56,67,1,'Datum, Zeit (Format: dd.mm.yyyy hh:mm)',NULL),(57,68,1,'Dauer (z.B.: 90 Minuten)',NULL),(58,69,1,'Strasse',NULL),(59,70,1,'Hausnummer',NULL),(60,71,1,'Postleitzahl',NULL),(61,72,1,'Ort',NULL),(62,73,1,'Schauplatz',NULL),(63,74,1,'Max. Teilnehmeranzahl',NULL),(64,75,1,'Kosten (in EUR)',NULL),(65,76,1,'Anrede',NULL),(66,77,1,'Titel',NULL),(67,78,1,'Funktion / Position',NULL),(68,79,1,'Telefon',NULL),(69,80,1,'Mobil',NULL),(70,81,1,'Fax ',NULL),(71,82,1,'E-Mail',NULL),(72,83,1,'Internet URL',NULL),(73,84,1,'Kontaktbilder',NULL),(74,85,1,'Vortragende',NULL),(75,86,1,'Kontakt',NULL),(76,87,1,'Veranstaltungsstatus',NULL),(77,90,1,'Titel',NULL),(78,91,1,'Headerbild',NULL),(79,92,1,'Embed Code',NULL),(80,93,1,'Url (z.B. http://www.getzoolu.com)',NULL),(81,94,1,'Titel',NULL),(82,95,1,'Sub-Navigations-Seiten',NULL),(83,97,1,'Titel',NULL),(84,98,1,'Beschreibung',NULL),(85,99,1,'Beschreibung',NULL),(86,100,1,'Abteilung',NULL),(87,101,1,'Stelle',NULL),(88,102,1,'Inhaltiche Verantwortung',NULL),(89,103,1,'Organisatorische Verantwortung',NULL),(90,104,1,'Aktivität',NULL),(91,105,1,'Beschreibung',NULL),(92,107,1,'Wer?',NULL),(93,110,1,'Beschreibung / Ursache',NULL),(94,111,1,'Titel',NULL),(95,113,1,'Präventive und korrektive Maßnahme',NULL),(96,112,1,'Beschreibung',NULL),(97,119,1,'Titel',NULL),(98,121,1,'Titel',NULL);
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
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldTypeGroups`
--

LOCK TABLES `fieldTypeGroups` WRITE;
/*!40000 ALTER TABLE `fieldTypeGroups` DISABLE KEYS */;
INSERT INTO `fieldTypeGroups` VALUES (1,'files'),(2,'selects'),(3,'multi_fields'),(4,'special_fields'),(5,'zend');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldTypes`
--

LOCK TABLES `fieldTypes` WRITE;
/*!40000 ALTER TABLE `fieldTypes` DISABLE KEYS */;
INSERT INTO `fieldTypes` VALUES (1,1,'',0,'text','',5),(2,1,'',0,'textarea','',5),(3,1,'',0,'multiCheckbox','',3),(4,1,'',0,'radio','',5),(5,1,'',0,'submit','',5),(6,1,'',0,'button','',5),(7,1,'',0,'reset','',5),(8,1,'',0,'hidden','',5),(9,1,'',0,'select','',2),(10,1,'',0,'texteditor','',5),(11,2,'',0,'template','',5),(12,1,'',0,'media','',1),(13,1,'',0,'document','',1),(14,1,'',0,'multiselect','',2),(15,1,'',0,'dselect','',5),(16,3,'',0,'tag','',4),(17,4,'',0,'multiCheckboxTree','',3),(18,5,'',0,'url','',4),(19,1,'',0,'internalLink','',4),(20,1,'',0,'selectTree','',2),(21,1,'',0,'textDisplay','',5),(22,6,'',0,'videoSelect','',4),(24,1,'',0,'contact','',4),(25,7,'',0,'gmaps','',4),(26,1,'',0,'internalLinks','',4),(27,1,'',0,'collection','',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0),(2,10,'description',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(3,1,'title',5,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0),(4,1,'articletitle',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(5,12,'mainpics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(6,10,'description',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(7,12,'pics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(8,13,'docs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(10,2,'shortdescription',5,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(11,11,'template',1,NULL,NULL,NULL,12,0,0,0,0,0,NULL,0),(17,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0),(18,12,'block_pics',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(19,10,'block_description',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(20,1,'block_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(21,16,'page_tags',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(22,17,'category',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, tbl.depth AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,1,0,1,0,NULL,0),(23,1,'video_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(24,2,'video_embed_code',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(25,1,'pics_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(26,1,'docs_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(27,18,'url',3,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(28,19,'internal_link',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(29,10,'block_description',6,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(30,1,'block_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(31,1,'entry_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0),(34,20,'entry_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(37,1,'entry_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(40,21,'title',5,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0),(41,1,'top_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0),(42,20,'top_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(43,1,'top_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(44,1,'entry_number',1,NULL,NULL,NULL,4,0,0,0,1,0,NULL,0),(45,20,'entry_nav_point',1,NULL,NULL,'SELECT folders.id, folderTitles.title, folders.depth FROM folders INNER JOIN folderTitles ON folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = %LANGUAGE_ID% INNER JOIN rootLevels ON rootLevels.id = folders.idRootLevels INNER JOIN rootLevelTitles ON rootLevelTitles.idRootLevels = rootLevels.id WHERE folders.idRootLevels = %ROOTLEVEL_ID% ORDER BY folders.lft, folders.sortPosition ASC, folders.sortTimestamp DESC',4,0,0,0,1,0,NULL,0),(46,1,'entry_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(47,9,'entry_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(48,4,'entry_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(49,9,'top_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(50,4,'top_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(51,9,'entry_sorttype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 12 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(52,4,'entry_sortorder',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 13 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(53,20,'entry_category',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 1 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(54,22,'video',1,NULL,NULL,'SELECT tbl.id AS id, tbl.title AS title FROM videoTypes AS tbl',12,0,0,0,1,0,NULL,0),(55,12,'pic_shortdescription',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(56,17,'label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, tbl.depth AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,1,0,1,0,NULL,0),(59,9,'entry_viewtype',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 27 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(60,20,'entry_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(61,20,'top_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(62,20,'entry_label',6,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title, (tbl.depth-1) AS depth FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 21 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN (rootCat.lft + 1) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(64,3,'option',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 42 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',12,0,0,0,1,0,NULL,0),(65,1,'fname',1,NULL,NULL,NULL,6,0,1,1,1,0,NULL,0),(66,1,'sname',1,NULL,NULL,NULL,6,0,1,1,1,0,NULL,0),(67,1,'datetime',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(68,1,'event_duration',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(69,1,'event_street',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(70,1,'event_streetnr',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(71,1,'event_plz',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(72,1,'event_city',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(73,1,'event_location',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(74,1,'event_max_members',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(75,1,'event_costs',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(76,1,'salutation',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(77,1,'title',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(78,1,'position',1,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0),(79,1,'phone',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0),(80,1,'mobile',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0),(81,1,'fax',1,NULL,NULL,NULL,4,0,1,0,1,0,NULL,0),(82,1,'email',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(83,1,'website',1,NULL,NULL,NULL,6,0,1,0,1,0,NULL,0),(84,12,'pics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(85,24,'speakers',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(86,9,'contact',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',12,0,0,0,1,0,NULL,0),(87,9,'event_status',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 49 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft BETWEEN ( rootCat.lft +1 ) AND rootCat.rgt %WHERE_ADDON% ORDER BY tbl.lft, categoryTitles.title',6,0,0,0,1,0,NULL,0),(88,12,'banner_pics',1,NULL,NULL,NULL,3,0,0,0,1,0,NULL,0),(89,10,'banner_description',1,NULL,NULL,NULL,9,0,0,0,1,0,NULL,0),(90,1,'banner_title',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(91,12,'headerpics',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(92,2,'header_embed_code',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(93,1,'external',1,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0),(94,1,'title',1,NULL,NULL,NULL,12,0,1,1,1,0,NULL,0),(95,4,'entry_depth',1,NULL,NULL,'SELECT tbl.id AS id, categoryTitles.title AS title FROM categories AS tbl INNER JOIN categoryTitles ON categoryTitles.idCategories = tbl.id AND categoryTitles.idLanguages = %LANGUAGE_ID%, categories AS rootCat WHERE rootCat.id = 64 AND tbl.idRootCategory = rootCat.idRootCategory AND tbl.lft %WHERE_ADDON% BETWEEN (rootCat.lft+1) AND rootCat.rgt ORDER BY tbl.lft, categoryTitles.title',4,0,0,0,1,0,NULL,0),(96,21,'title',5,NULL,NULL,NULL,12,0,1,0,1,0,NULL,0),(97,1,'instruction_title',5,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(98,10,'instruction_description',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(99,1,'description',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(100,1,'department',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(101,1,'position',1,NULL,NULL,NULL,6,0,0,0,1,0,NULL,0),(102,1,'content_responsible',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',6,0,0,0,1,0,NULL,0),(103,1,'organizational_responsible',1,NULL,NULL,'SELECT tbl.id AS id, CONCAT(tbl.fname,\' \',tbl.sname) AS title FROM contacts AS tbl WHERE tbl.idUnits = 1 ORDER BY tbl.fname ASC',6,0,0,0,1,0,NULL,0),(104,1,'steps_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(105,10,'steps_text',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(106,10,'shortdescription',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(107,1,'steps_who',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(108,12,'process_pic',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(109,10,'process_inputs',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(110,10,'risk_description',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(111,1,'rule_title',1,NULL,NULL,NULL,12,0,0,0,1,1,NULL,0),(112,10,'rule_text',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(113,10,'risk_measure',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(114,10,'process_output',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(115,10,'process_indicator',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(116,10,'process_instructions',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(117,10,'process_techniques',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(118,25,'gmaps',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(119,1,'internal_links_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(120,26,'internal_links',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(121,1,'collection_title',5,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0),(122,27,'collection',1,NULL,NULL,NULL,12,0,0,0,1,0,NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileAttributes`
--

LOCK TABLES `fileAttributes` WRITE;
/*!40000 ALTER TABLE `fileAttributes` DISABLE KEYS */;
INSERT INTO `fileAttributes` VALUES (1,31,3008,2000),(2,32,2560,1920),(3,33,1701,1273);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileTitles`
--

LOCK TABLES `fileTitles` WRITE;
/*!40000 ALTER TABLE `fileTitles` DISABLE KEYS */;
INSERT INTO `fileTitles` VALUES (7,30,1,'Stapel Dokumente','','0000-00-00 00:00:00'),(8,31,1,'Alter Fernrohr','','2009-08-28 12:32:56'),(9,32,1,'Schlüssel in Schloss','','2009-08-28 12:32:56'),(10,33,1,'Tellerrand Nahaufnahme','','2009-08-28 12:32:56');
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
  `fileId` varchar(32) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (30,'4a2a39af5b456',3,'',4,2,0,0,'4a2a39af5b456.pdf',NULL,3,'2009-06-06 09:41:03',559,'pdf','application/pdf',1,0),(31,'4a97ce6466e25',3,'',5,2,0,1,'4a97ce6466e25.jpg',NULL,3,'2009-08-28 12:32:45',2,'jpg','image/jpeg',1,0),(32,'4a97ce6e3e679',3,'',5,2,0,1,'4a97ce6e3e679.jpg',NULL,3,'2009-08-28 12:32:51',2,'jpg','image/jpeg',1,0),(33,'4a97ce74124cc',3,'',5,2,0,1,'4a97ce74124cc.jpg',NULL,3,'2009-08-28 12:32:54',2,'jpg','image/jpeg',1,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folder-DEFAULT_FOLDER-1-Instances`
--

LOCK TABLES `folder-DEFAULT_FOLDER-1-Instances` WRITE;
/*!40000 ALTER TABLE `folder-DEFAULT_FOLDER-1-Instances` DISABLE KEYS */;
INSERT INTO `folder-DEFAULT_FOLDER-1-Instances` VALUES (1,'4a112157c45e5',1,1,'',3,2,'2009-05-18 08:50:31','2009-09-01 08:44:51'),(2,'4a113342d22e2',1,1,'',3,2,'2009-05-18 10:06:58','2009-09-01 08:41:54'),(3,'4a1133f4257b5',1,1,'',3,2,'2009-05-18 10:09:56','2009-09-01 08:41:57'),(4,'4a2910cf9583d',1,1,'',3,3,'2009-06-05 12:34:23','2009-06-05 12:34:23'),(5,'4a2a3c746b0ba',1,1,'',3,3,'2009-06-06 09:52:52','2009-06-08 16:17:26'),(6,'4a112157c45e5',1,2,'',3,3,'2009-06-08 16:02:52','2009-06-09 15:13:03'),(7,'4a113342d22e2',1,2,'',3,3,'2009-06-09 16:52:10','2009-06-09 16:52:10'),(8,'4a40944a7fc0d',1,1,'',3,3,'2009-06-23 08:37:30','2009-08-28 12:19:35');
/*!40000 ALTER TABLE `folder-DEFAULT_FOLDER-1-Instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folderPermissions`
--

DROP TABLE IF EXISTS `folderPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folderPermissions` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idFolders` bigint(20) unsigned NOT NULL,
  `idPermissions` bigint(20) unsigned NOT NULL,
  `idGroups` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folderTitles`
--

LOCK TABLES `folderTitles` WRITE;
/*!40000 ALTER TABLE `folderTitles` DISABLE KEYS */;
INSERT INTO `folderTitles` VALUES (1,'4a112157c45e5',1,1,'Hauptpunkt 1',3,2,'2009-05-18 08:50:31','2009-09-01 08:44:51'),(2,'4a113342d22e2',1,1,'Hauptpunkt 2',3,2,'2009-05-18 10:06:58','2009-09-01 08:41:54'),(3,'4a1133f4257b5',1,1,'Hauptpunkt 3',3,2,'2009-05-18 10:09:56','2009-09-01 08:41:57'),(4,'4a2910cf9583d',1,1,'TEST',3,3,'2009-06-05 12:34:23','2009-06-05 12:34:23'),(5,'4a2a3c746b0ba',1,1,'TEST',3,3,'2009-06-06 09:52:52','2009-06-08 16:17:26'),(6,'4a112157c45e5',1,2,'Main Navigation 1',3,3,'2009-06-08 16:02:52','2009-06-09 15:13:03'),(7,'4a113342d22e2',1,2,'Main Navigation 2',3,3,'2009-06-09 16:52:10','2009-06-09 16:52:10'),(8,'4a40944a7fc0d',1,1,'Kollektion 1',3,3,'2009-06-23 08:37:30','2009-08-28 12:19:35');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders`
--

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
INSERT INTO `folders` VALUES (1,1,1,0,1,1,4,0,0,NULL,2,'2009-10-16 14:35:17','4a112157c45e5',1,3,2,0,'2009-05-18 08:50:31','2009-10-16 14:35:17',NULL,2,1,1,0,NULL),(2,1,1,0,1,5,6,0,0,NULL,3,'2009-10-16 14:35:17','4a113342d22e2',1,3,2,0,'2009-05-18 10:06:58','2009-10-16 14:35:17',NULL,2,1,1,0,NULL),(3,1,1,0,1,7,8,0,0,NULL,1,'2009-10-16 14:35:17','4a1133f4257b5',1,3,2,0,'2009-05-18 10:09:56','2009-10-16 14:35:17',NULL,2,1,1,0,NULL),(4,1,1,0,3,1,2,0,0,NULL,0,'2009-06-05 12:34:23','4a2910cf9583d',1,3,3,0,'2009-06-05 12:34:23','2009-06-05 12:34:23',NULL,1,1,0,0,NULL),(5,1,1,0,2,1,2,0,0,NULL,0,'2009-06-06 09:52:52','4a2a3c746b0ba',1,3,3,0,'2009-06-06 09:52:52','2009-06-08 16:17:26',NULL,1,1,0,0,NULL),(6,1,1,1,1,2,3,1,0,NULL,3,'2009-10-16 14:36:21','4a40944a7fc0d',1,3,3,0,'2009-06-23 08:37:30','2009-10-16 14:36:21',NULL,2,1,1,0,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genericFormTabs`
--

LOCK TABLES `genericFormTabs` WRITE;
/*!40000 ALTER TABLE `genericFormTabs` DISABLE KEYS */;
INSERT INTO `genericFormTabs` VALUES (1,1,1,1),(2,2,2,1),(3,3,3,1),(4,4,4,1),(5,5,5,1),(6,6,6,1),(7,7,7,1),(8,8,8,1),(9,9,9,1),(10,10,10,1),(11,11,11,1),(12,12,12,1),(13,13,13,1),(14,14,14,1),(15,14,15,2),(16,14,16,3),(17,14,17,4),(18,14,18,5),(19,14,19,6),(20,15,7,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genericFormTypes`
--

LOCK TABLES `genericFormTypes` WRITE;
/*!40000 ALTER TABLE `genericFormTypes` DISABLE KEYS */;
INSERT INTO `genericFormTypes` VALUES (1,'folder'),(2,'page'),(3,'category'),(4,'unit'),(5,'contact');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genericForms`
--

LOCK TABLES `genericForms` WRITE;
/*!40000 ALTER TABLE `genericForms` DISABLE KEYS */;
INSERT INTO `genericForms` VALUES (1,2,'DEFAULT_FOLDER',1,'2008-11-14 08:54:39','2008-11-14 08:54:39',1,0),(2,2,'DEFAULT_PAGE_1',1,'2009-01-29 07:27:34','2009-01-29 07:27:34',2,0),(5,2,'DEFAULT_CATEGORY',1,'2009-03-17 16:01:58','2009-03-17 16:01:58',3,0),(6,3,'DEFAULT_LINKING',1,'2009-02-11 15:37:37','2009-02-11 15:37:37',2,0),(7,2,'DEFAULT_OVERVIEW',1,'2009-02-17 13:30:42','2009-02-17 13:30:42',2,0),(8,2,'DEFAULT_STARTPAGE',1,'2009-02-27 09:51:14','2009-02-27 09:51:14',2,0),(9,3,'DEFAULT_UNIT',1,'2009-04-07 19:23:58','2009-04-07 19:23:58',4,0),(10,3,'DEFAULT_CONTACT',1,'2009-04-07 19:23:58','2009-04-07 19:23:58',5,0),(11,2,'DEFAULT_EVENT',1,'2009-04-09 15:04:57','2009-04-09 15:04:57',2,0),(12,2,'DEFAULT_EVENT_OVERVIEW',1,'2009-04-17 08:09:45','2009-04-17 08:09:45',2,0),(13,2,'DEFAULT_EXTERNAL',1,'2009-05-18 13:15:16','2009-02-11 15:37:37',2,0),(14,3,'DEFAULT_PROCESS',1,'2009-08-28 12:04:14','2009-08-28 12:04:14',2,0),(15,3,'DEFAULT_COLLECTION',1,'2009-08-28 12:04:01','2009-08-28 12:04:01',2,0);
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
  CONSTRAINT `groupPermissions_ibfk_1` FOREIGN KEY (`idGroups`) REFERENCES `groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupPermissions`
--

LOCK TABLES `groupPermissions` WRITE;
/*!40000 ALTER TABLE `groupPermissions` DISABLE KEYS */;
INSERT INTO `groupPermissions` VALUES (1,0,1),(1,0,2),(1,0,3),(1,0,4),(1,0,5),(1,0,6),(2,0,1),(2,0,2),(2,0,3),(2,0,4),(2,0,5),(2,0,6),(3,0,1),(3,0,2),(3,0,3),(3,0,4),(3,0,5),(3,0,6);
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
  `description` text,
  `idGroupTypes` bigint(20) unsigned default NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL COMMENT 'Person, letzte Änderung',
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Admin','',NULL,3,3,'2009-10-16 09:48:44','2009-10-16 14:07:55'),(2,'Content Manager','',NULL,3,3,'2009-10-16 09:58:37','2009-10-16 14:07:59'),(3,'Media Manager','',NULL,3,3,'2009-10-16 10:02:54','2009-10-16 10:02:54');
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
  `languageCode` varchar(3) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'DE','Deutsch'),(2,'EN','English');
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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'cms'),(2,'media'),(3,'properties'),(4,'users');
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
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_COLLECTION-1-InstanceFiles` VALUES (45,'4a40944a8ee78',1,1,31,5);
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
  KEY `pageId` (`pageId`)
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
  KEY `pageId` (`pageId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-Instances`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_COLLECTION-1-Instances` VALUES (1,'4a40944a8ee78',1,1,3,'','Hier kommt meine Kollektion','','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.<br /><br />Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a.</p>',NULL,'',3,'2009-08-28 12:11:52','2009-09-01 16:29:58');
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Instances` ENABLE KEYS */;
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
  `block_title` varchar(255) default NULL,
  `block_description` text,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_COLLECTION-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_COLLECTION-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_COLLECTION-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_COLLECTION-1-Region14-Instances` VALUES (48,'4a40944a8ee78',1,1,1,'Sidebar','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.<br /><br />Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a.</p>');
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
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Instances` VALUES (1,'4a112157d69eb',1,1,3,'','','','',NULL,3,'2009-06-09 09:35:23','2009-09-01 08:44:56'),(2,'4a112157d69eb',1,2,3,NULL,'','','',NULL,3,'2009-06-09 09:36:01','2009-06-09 17:07:38'),(3,'4a113342dffe5',1,1,3,'','','','',NULL,3,'2009-06-09 16:51:25','2009-09-01 14:07:52'),(4,'4a113342dffe5',1,2,3,NULL,'','','',NULL,3,'2009-06-09 16:52:17','2009-06-09 16:52:25');
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Instances` ENABLE KEYS */;
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
  `block_title` varchar(255) default NULL,
  `block_description` text,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `page-DEFAULT_OVERVIEW-1-Region14-Instances_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Region14-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Region14-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region14-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Region14-Instances` VALUES (7,'4a113342dffe5',1,2,1,'',''),(11,'4a112157d69eb',1,2,1,'',''),(21,'4a112157d69eb',1,1,1,'',''),(24,'4a113342dffe5',1,1,1,'','');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_OVERVIEW-1-Region15-Instances`
--

LOCK TABLES `page-DEFAULT_OVERVIEW-1-Region15-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_OVERVIEW-1-Region15-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_OVERVIEW-1-Region15-Instances` VALUES (7,'4a113342dffe5',1,2,1,'',0,0,0,0,0,0,NULL),(11,'4a112157d69eb',1,2,1,'',0,0,0,0,0,0,NULL),(21,'4a112157d69eb',1,1,1,'Übersicht',0,0,29,99,18,14,66),(24,'4a113342dffe5',1,1,1,'',0,0,29,100,0,0,0);
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
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`),
  CONSTRAINT `page-DEFAULT_PAGE_1-1-InstanceFiles_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE,
  CONSTRAINT `page-DEFAULT_PAGE_1-1-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PAGE_1-1-InstanceFiles` VALUES (32,'4a115ca65d8bb',1,0,30,8),(35,'4a9d42e6cbb25',1,1,32,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Instances`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PAGE_1-1-Instances` VALUES (1,'4a112157d69eb',1,1,3,'','','','','',NULL,'','','','',2,'2009-05-18 08:50:31','2009-07-23 09:05:12'),(2,'4a113342dffe5',1,1,3,'','','','','',NULL,'','','','',2,'2009-05-18 10:06:58','2009-06-09 16:52:41'),(3,'4a1133f43284a',1,1,3,'','','','','','','','','','',2,'2009-05-18 10:09:56','2009-09-01 08:45:13'),(4,'4a115ca65d8bb',1,1,3,'Testseite mit Überschrift für den Artikel','','','Bildergalerie',' Dokumente','Hier kommen die Internen Links','','','Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.asdf','1',2,'2009-05-18 13:03:34','2009-10-16 07:43:33'),(5,'4a1cf55c8b3e5',1,1,3,'','','','','','','','','','',2,'2009-05-27 08:10:04','2009-09-01 14:06:59'),(6,'4a115ca65d8bb',1,2,3,'','','','','',NULL,'','','','2',3,'2009-06-08 13:52:02','2009-06-10 07:41:49'),(15,'4a112157d69eb',1,2,3,'','','','','',NULL,'','','','',3,'2009-06-09 09:34:21','2009-06-09 16:50:35'),(16,'4a116d34752df',1,1,3,'','','','','',NULL,'','','','',3,'2009-06-09 16:43:55','2009-06-09 16:43:55'),(17,'4a116d34752df',1,2,3,'','','','','',NULL,'','','','',3,'2009-06-09 16:44:11','2009-06-09 16:44:11'),(18,'4a2fa65ac1781',1,1,3,'','',NULL,'','',NULL,'','','','',3,'2009-06-10 12:26:02','2009-06-10 12:26:02'),(19,'4a40944a8ee78',1,1,3,'','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum.</p>',NULL,'','',NULL,'','','','',3,'2009-06-23 08:37:30','2009-06-23 08:46:34'),(20,'4a40946ce9d01',1,1,3,'','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum.</p>',NULL,'','','Interne Links','','','','',3,'2009-06-23 08:38:04','2009-09-01 09:12:48'),(23,'4a676ebfe3a7a',1,1,3,'','',NULL,'','',NULL,'','','','',3,'2009-07-22 19:55:43','2009-08-05 09:41:19'),(24,'4a681b0f66d2a',1,1,3,'','',NULL,'','',NULL,'','','','',3,'2009-07-23 08:10:55','2009-07-23 08:47:14'),(25,'4a978dcd034e2',1,1,3,'','',NULL,'','','','','','','',3,'2009-08-28 07:57:01','2009-09-01 08:56:16'),(26,'4a978dcd034e2',1,2,3,'','',NULL,'','','','','','','',3,'2009-08-28 15:18:38','2009-08-28 15:18:44'),(27,'4a40946ce9d01',1,2,3,'','',NULL,'','','Internal Links','','','','',3,'2009-08-28 15:37:22','2009-08-28 15:37:33'),(28,'4a9d42e6cbb25',1,1,3,'','<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.</p>\n<p>Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.</p>\n<p>Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.</p>\n<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt.</p>',NULL,'','','','','','','',3,'2009-09-01 15:51:02','2009-09-01 15:53:48');
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
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
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
  CONSTRAINT `page-DEFAULT_PAGE_1-1-Region11-InstanceMultiFields_ibfk_1` FOREIGN KEY (`idRegionInstances`) REFERENCES `page-DEFAULT_PAGE_1-1-Region11-Instances` (`id`) ON DELETE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PAGE_1-1-Region11-Instances`
--

LOCK TABLES `page-DEFAULT_PAGE_1-1-Region11-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PAGE_1-1-Region11-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PAGE_1-1-Region11-Instances` VALUES (95,'4a112157d69eb',1,2,1,'',''),(109,'4a116d34752df',1,1,1,'',''),(110,'4a116d34752df',1,2,1,'',''),(113,'4a113342dffe5',1,1,1,'',''),(122,'4a115ca65d8bb',1,2,1,'TEST EN',''),(127,'4a40944a8ee78',1,1,1,'',''),(178,'4a681b0f66d2a',1,1,1,'',''),(182,'4a112157d69eb',1,1,1,'',''),(243,'4a676ebfe3a7a',1,1,1,'',''),(261,'4a978dcd034e2',1,2,1,'',''),(263,'4a40946ce9d01',1,2,1,'',''),(264,'4a1133f43284a',1,1,1,'',''),(269,'4a978dcd034e2',1,1,1,'',''),(276,'4a40946ce9d01',1,1,1,'',''),(277,'4a1cf55c8b3e5',1,1,1,'',''),(281,'4a9d42e6cbb25',1,1,1,'',''),(286,'4a115ca65d8bb',1,1,1,'Test Thomas','<p>asdfasdfsd</p>'),(287,'4a115ca65d8bb',1,1,2,'Test Thomas 2','<p>asfsdfasdf</p>');
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
  `idFiles` bigint(20) unsigned NOT NULL,
  `idFields` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `idFiles` (`idFiles`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-InstanceFiles`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-InstanceFiles` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-InstanceFiles` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PROCESS-1-InstanceFiles` VALUES (31,'4a676ebfe3a7a',1,1,88,108);
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
  KEY `pageId` (`pageId`)
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
  KEY `pageId` (`pageId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PROCESS-1-Instances` VALUES (1,'4a676ebfe3a7a',1,1,3,'','<p>Hier kommt eine kurze Beschreibung</p>','Abteilung','Stelle','2','1','<p><b>Prozessinputs / Informationen / Ressourcen</b></p>','<p><b>Prozessinputs / Informationen / Ressourcen</b></p>','<p><b>Messg&ouml;&szlig;en</b></p>\n<p>&nbsp;</p>','<p><b>Vorschriften / Richtlinien / Sicherheit</b></p>','<p><b>Methoden / Verfahren / IT Tools</b></p>',3,'2009-07-22 20:17:46','2009-09-01 14:05:31'),(2,'4a676ebfe3a7a',1,2,3,'','','','','0','0',NULL,NULL,NULL,NULL,NULL,3,'2009-07-22 20:50:44','2009-07-23 06:22:47'),(3,'4a681b0f66d2a',1,1,3,'','','','','','','','','','','',3,'2009-07-23 08:37:38','2009-09-01 08:56:10');
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
  KEY `pageId` (`pageId`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Region27-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Region27-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region27-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PROCESS-1-Region27-Instances` VALUES (32,'4a676ebfe3a7a',1,2,1,'',''),(111,'4a681b0f66d2a',1,1,1,'',''),(114,'4a676ebfe3a7a',1,1,1,'Test 1 Thomas','<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.&nbsp;</p>\n<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.&nbsp;</p>\n<table style=\"width: 100%;\" border=\"0\">\n<tbody>\n<tr>\n<td>TEST</td>\n<td>TEST</td>\n<td>TEST</td>\n<td>TEST</td>\n</tr>\n<tr>\n<td>TEST</td>\n<td>TEST</td>\n<td>TEST</td>\n<td>TEST</td>\n</tr>\n<tr>\n<td></td>\n<td></td>\n<td></td>\n<td></td>\n</tr>\n<tr>\n<td></td>\n<td></td>\n<td></td>\n<td></td>\n</tr>\n<tr>\n<td></td>\n<td></td>\n<td></td>\n<td></td>\n</tr>\n</tbody>\n</table>'),(115,'4a676ebfe3a7a',1,1,2,'Test 2 Thomas','<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.&nbsp;</p>');
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
  KEY `pageId` (`pageId`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Region29-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Region29-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region29-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PROCESS-1-Region29-Instances` VALUES (32,'4a676ebfe3a7a',1,2,1,'','',''),(97,'4a681b0f66d2a',1,1,1,'','',''),(100,'4a676ebfe3a7a',1,1,1,'Aktivität 001','','Ich'),(101,'4a676ebfe3a7a',1,1,2,'Aktivität 002','','');
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
  KEY `pageId` (`pageId`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Region32-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Region32-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region32-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PROCESS-1-Region32-Instances` VALUES (42,'4a681b0f66d2a',1,1,1,'',''),(44,'4a676ebfe3a7a',1,1,1,'<p><b>Beschreibung / Ursache</b></p>','<p><b>Pr&auml;ventive und korrektive Ma&szlig;nahme</b></p>');
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
  KEY `pageId` (`pageId`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_PROCESS-1-Region33-Instances`
--

LOCK TABLES `page-DEFAULT_PROCESS-1-Region33-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region33-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_PROCESS-1-Region33-Instances` VALUES (39,'4a681b0f66d2a',1,1,1,'',''),(41,'4a676ebfe3a7a',1,1,1,'asdfasdf','');
/*!40000 ALTER TABLE `page-DEFAULT_PROCESS-1-Region33-Instances` ENABLE KEYS */;
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
INSERT INTO `page-DEFAULT_STARTPAGE-1-Instances` VALUES (1,'49f17460a4f9f',1,2,3,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2009-06-10 07:47:53','2009-07-08 17:05:38'),(2,'49f17460a4f9f',1,1,3,'','<table style=\"width: 100%;\" align=\"left\" border=\"0\">\n<thead> \n<tr>\n<td><b>Test</b></td>\n<td><b>Test</b></td>\n<td><b>Test</b></td>\n<td><b>Test</b></td>\n</tr>\n</thead> \n<tbody>\n<tr>\n<td>Test <br /></td>\n<td>&nbsp;Test</td>\n<td>&nbsp;Test</td>\n<td>&nbsp;Test</td>\n</tr>\n<tr>\n<td>Test</td>\n<td>&nbsp;Test</td>\n<td>&nbsp;Test</td>\n<td>&nbsp;Test</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p><a href=\"http://www.getzoolu.org\">www.getzoolu.org</a></p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2009-07-21 16:54:37','2009-09-29 12:21:03');
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
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region11-InstanceFiles_ibfk_2` FOREIGN KEY (`idFiles`) REFERENCES `files` (`id`) ON DELETE CASCADE
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
  CONSTRAINT `page-DEFAULT_STARTPAGE-1-Region11-InstanceMultiFields_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page-DEFAULT_STARTPAGE-1-Region17-Instances`
--

LOCK TABLES `page-DEFAULT_STARTPAGE-1-Region17-Instances` WRITE;
/*!40000 ALTER TABLE `page-DEFAULT_STARTPAGE-1-Region17-Instances` DISABLE KEYS */;
INSERT INTO `page-DEFAULT_STARTPAGE-1-Region17-Instances` VALUES (2,'49f17460a4f9f',1,2,1,'',0,0,0,0,0,0),(9,'49f17460a4f9f',1,1,1,'',0,0,0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageCategories`
--

LOCK TABLES `pageCategories` WRITE;
/*!40000 ALTER TABLE `pageCategories` DISABLE KEYS */;
INSERT INTO `pageCategories` VALUES (55,'4a112157d69eb',1,2,54,3,3,'2009-06-09 17:07:38','2009-06-09 17:07:38'),(63,'4a115ca65d8bb',1,2,54,3,3,'2009-06-10 07:41:49','2009-06-10 07:41:49'),(110,'4a112157d69eb',1,1,53,3,3,'2009-09-01 08:44:56','2009-09-01 08:44:56'),(113,'4a113342dffe5',1,1,54,3,3,'2009-09-01 14:07:52','2009-09-01 14:07:52');
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
  `collectedPageId` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageCollections`
--

LOCK TABLES `pageCollections` WRITE;
/*!40000 ALTER TABLE `pageCollections` DISABLE KEYS */;
INSERT INTO `pageCollections` VALUES (227,'4a40944a8ee78',1,1,'4a115ca65d8bb',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(228,'4a40944a8ee78',1,1,'4a676ebfe3a7a',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(229,'4a40944a8ee78',1,1,'4a113342dffe5',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(230,'4a40944a8ee78',1,1,'4a40946ce9d01',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(231,'4a40944a8ee78',1,1,'4a978dcd034e2',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(232,'4a40944a8ee78',1,1,'4a9d42e6cbb25',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageExternals`
--

LOCK TABLES `pageExternals` WRITE;
/*!40000 ALTER TABLE `pageExternals` DISABLE KEYS */;
INSERT INTO `pageExternals` VALUES (1,'4a115ca65d8bb',1,1,'http://www.massiveart.at',2,2,'2009-05-27 08:09:11','2009-05-27 08:09:11'),(2,'4a113342dffe5',1,1,'http://www.getzcope.com',3,2,'2009-06-23 09:51:29','2009-07-08 17:14:19'),(3,'4a1cf55c8b3e5',1,1,'www.getzoolu.org',3,3,'2009-07-08 17:18:25','2009-09-01 14:07:04');
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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageGmaps`
--

LOCK TABLES `pageGmaps` WRITE;
/*!40000 ALTER TABLE `pageGmaps` DISABLE KEYS */;
INSERT INTO `pageGmaps` VALUES (48,'4a676ebfe3a7a',1,1,'47.503042','9.747067',3,NULL,'2009-08-05 09:41:20'),(64,'4a1133f43284a',1,1,'47.503042','9.747067',3,NULL,'2009-09-01 08:45:13'),(68,'4a978dcd034e2',1,1,'47.503042','9.747067',3,NULL,'2009-09-01 08:56:16'),(72,'4a40946ce9d01',1,1,'47.503042','9.747067',3,NULL,'2009-09-01 09:12:48'),(73,'4a1cf55c8b3e5',1,1,'47.503042','9.747067',3,NULL,'2009-09-01 14:06:59'),(77,'4a9d42e6cbb25',1,1,'47.503042','9.747067',3,NULL,'2009-09-01 15:53:48'),(80,'4a115ca65d8bb',1,1,'47.37603463349758','10.0030517578125',3,NULL,'2009-10-16 07:43:33');
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
  `linkedPageId` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  KEY `version` (`version`),
  CONSTRAINT `pageInternalLinks_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageInternalLinks`
--

LOCK TABLES `pageInternalLinks` WRITE;
/*!40000 ALTER TABLE `pageInternalLinks` DISABLE KEYS */;
INSERT INTO `pageInternalLinks` VALUES (2,'4a40946ce9d01',1,2,'4a978dcd034e2',3,3,'2009-08-28 15:37:33','2009-08-28 15:37:33'),(3,'4a1133f43284a',1,1,'',3,3,'2009-09-01 08:45:13','2009-09-01 08:45:13'),(7,'4a978dcd034e2',1,1,'',3,3,'2009-09-01 08:56:16','2009-09-01 08:56:16'),(11,'4a40946ce9d01',1,1,'',3,3,'2009-09-01 09:12:48','2009-09-01 09:12:48'),(12,'4a1cf55c8b3e5',1,1,'',3,3,'2009-09-01 14:06:59','2009-09-01 14:06:59'),(16,'4a9d42e6cbb25',1,1,'',3,3,'2009-09-01 15:53:48','2009-09-01 15:53:48'),(19,'4a115ca65d8bb',1,1,'',3,3,'2009-10-16 07:43:33','2009-10-16 07:43:33');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageLabels`
--

LOCK TABLES `pageLabels` WRITE;
/*!40000 ALTER TABLE `pageLabels` DISABLE KEYS */;
INSERT INTO `pageLabels` VALUES (28,'4a115ca65d8bb',1,2,56,3,3,'2009-06-10 07:41:49','2009-06-10 07:41:49'),(29,'4a115ca65d8bb',1,2,63,3,3,'2009-06-10 07:41:49','2009-06-10 07:41:49');
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
  CONSTRAINT `pageLinks_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageLinks`
--

LOCK TABLES `pageLinks` WRITE;
/*!40000 ALTER TABLE `pageLinks` DISABLE KEYS */;
INSERT INTO `pageLinks` VALUES (8,13,'4a676ebfe3a7a'),(9,6,'4a115ca65d8bb');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTitles`
--

LOCK TABLES `pageTitles` WRITE;
/*!40000 ALTER TABLE `pageTitles` DISABLE KEYS */;
INSERT INTO `pageTitles` VALUES (1,'49f17460a4f9f',1,1,'Home',3,3,'2009-04-24 08:12:16','2009-09-29 12:21:03'),(2,'4a112157d69eb',1,1,'Hauptpunkt 1',3,2,'2009-05-18 08:50:31','2009-09-01 08:44:56'),(3,'4a113342dffe5',1,1,'Hauptpunkt 2',3,2,'2009-05-18 10:06:58','2009-09-01 14:07:52'),(4,'4a1133f43284a',1,1,'Hauptpunkt 3',3,2,'2009-05-18 10:09:56','2009-09-01 08:45:13'),(5,'4a115ca65d8bb',1,1,'Testseite',3,2,'2009-05-18 13:03:34','2009-10-16 07:43:33'),(6,'4a116d34752df',1,1,'Testseite 2',3,2,'2009-05-18 14:14:12','2009-06-09 16:43:55'),(7,'4a1cf55c8b3e5',1,1,'Testseite 3',3,2,'2009-05-27 08:10:04','2009-09-01 14:07:04'),(8,'4a115ca65d8bb',1,2,'TEST EN',3,3,'2009-06-08 13:52:02','2009-06-10 07:41:49'),(9,'4a112157d69eb',1,2,'Main Navigation 1',3,2,NULL,'2009-06-09 17:07:38'),(10,'4a116d34752df',1,2,'Testseite 2 EN',3,3,'2009-06-09 16:44:11','2009-06-09 16:44:11'),(11,'4a113342dffe5',1,2,'Main Navigation 2',3,2,NULL,'2009-06-09 16:52:25'),(12,'49f17460a4f9f',1,2,'Home',3,3,'2009-06-10 07:48:53','2009-07-08 17:05:38'),(13,'4a2fa65ac1781',1,1,'asdf',3,3,'2009-06-10 12:26:02','2009-06-10 12:26:02'),(14,'4a40944a8ee78',1,1,'Kollektion 1',3,3,'2009-06-23 08:37:30','2009-09-01 16:29:58'),(15,'4a40946ce9d01',1,1,'Testseite 2',3,3,'2009-06-23 08:38:04','2009-09-01 09:12:48'),(18,'4a676ebfe3a7a',1,1,'Process',3,3,'2009-07-22 19:55:43','2009-09-01 14:05:31'),(19,'4a676ebfe3a7a',1,2,'Test',3,3,'2009-07-22 20:50:44','2009-07-23 06:22:47'),(20,'4a681b0f66d2a',1,1,'Test',3,3,'2009-07-23 08:10:55','2009-09-01 08:56:10'),(21,'4a978dcd034e2',1,1,'Test Thomas',3,3,'2009-08-28 07:57:01','2009-09-01 08:56:16'),(22,'4a978dcd034e2',1,2,'Test Thomas',3,3,'2009-08-28 15:18:38','2009-08-28 15:18:44'),(23,'4a40946ce9d01',1,2,'Testsite 2',3,3,'2009-08-28 15:37:22','2009-08-28 15:37:33'),(24,'4a9d42e6cbb25',1,1,'Test Seite 2.1',3,3,'2009-09-01 15:51:02','2009-09-01 15:53:48');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTypeTitles`
--

LOCK TABLES `pageTypeTitles` WRITE;
/*!40000 ALTER TABLE `pageTypeTitles` DISABLE KEYS */;
INSERT INTO `pageTypeTitles` VALUES (1,1,1,'Standardseite'),(2,2,1,'Interne Verlinkung'),(3,3,1,'Übersicht'),(4,4,1,'Externe Verlinkung'),(5,5,1,'Prozessablauf'),(6,6,1,'Kollektion');
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
  PRIMARY KEY  (`id`),
  KEY `page` (`page`),
  KEY `startpage` (`startpage`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTypes`
--

LOCK TABLES `pageTypes` WRITE;
/*!40000 ALTER TABLE `pageTypes` DISABLE KEYS */;
INSERT INTO `pageTypes` VALUES (1,'page',1,1),(2,'link',1,1),(3,'overview',0,1),(4,'external',1,1),(5,'process',1,1),(6,'collection',0,1);
/*!40000 ALTER TABLE `pageTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageUrls`
--

DROP TABLE IF EXISTS `pageUrls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageUrls` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `pageId` varchar(32) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `idParent` bigint(20) unsigned default NULL,
  `idParentTypes` int(10) unsigned default NULL,
  `url` varchar(255) NOT NULL,
  `idUsers` bigint(20) unsigned NOT NULL,
  `creator` bigint(20) unsigned NOT NULL,
  `created` timestamp NULL default NULL,
  `changed` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `pageId` (`pageId`),
  CONSTRAINT `pageUrls_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageUrls`
--

LOCK TABLES `pageUrls` WRITE;
/*!40000 ALTER TABLE `pageUrls` DISABLE KEYS */;
INSERT INTO `pageUrls` VALUES (1,'49f17460a4f9f',1,1,NULL,NULL,'',3,3,'2009-09-01 08:41:46','2009-09-01 08:41:46'),(2,'4a112157d69eb',1,1,NULL,NULL,'hauptpunkt-1/',3,3,'2009-09-01 08:44:56','2009-09-01 08:44:56'),(3,'4a113342dffe5',1,1,NULL,NULL,'hauptpunkt-2/',3,3,'2009-09-01 08:45:03','2009-09-01 08:45:03'),(4,'4a1133f43284a',1,1,NULL,NULL,'hauptpunkt-3/',3,3,'2009-09-01 08:45:13','2009-09-01 08:45:13'),(6,'4a978dcd034e2',1,1,NULL,NULL,'hauptpunkt-1/test-thomas',3,3,'2009-09-01 08:45:59','2009-09-01 08:45:59'),(7,'4a40944a8ee78',1,1,NULL,NULL,'hauptpunkt-1/kollektion-1/',3,3,'2009-09-01 08:46:05','2009-09-01 08:46:05'),(8,'4a40946ce9d01',1,1,NULL,NULL,'hauptpunkt-1/kollektion-1/testseite-2',3,3,'2009-09-01 08:46:12','2009-09-01 08:46:12'),(11,'4a681b0f66d2a',1,1,NULL,NULL,'hauptpunkt-1/test',3,3,'2009-09-01 08:56:10','2009-09-01 08:56:10'),(12,'4a676ebfe3a7a',1,1,NULL,NULL,'hauptpunkt-1/process',3,3,'2009-09-01 08:56:34','2009-09-01 08:56:34'),(51,'4a115ca65d8bb',1,1,NULL,NULL,'hauptpunkt-1/testseite-mit-ueberschrift-fuer-den-artikel',3,3,'2009-09-01 09:12:08','2009-09-01 09:12:08'),(87,'4a1cf55c8b3e5',1,1,NULL,NULL,'hauptpunkt-3/testseite-3',3,3,'2009-09-01 14:06:59','2009-09-01 14:06:59'),(99,'4a9d42e6cbb25',1,1,NULL,NULL,'hauptpunkt-2/test-seite-2_1',3,3,'2009-09-01 15:51:02','2009-09-01 15:51:02'),(106,'4a115ca65d8bb',1,1,6,2,'hauptpunkt-1/kollektion-1/testseite',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(107,'4a676ebfe3a7a',1,1,6,2,'hauptpunkt-1/kollektion-1/process',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(108,'4a113342dffe5',1,1,6,2,'hauptpunkt-1/kollektion-1/hauptpunkt-2',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(109,'4a40946ce9d01',1,1,6,2,'hauptpunkt-1/kollektion-1/testseite-2-1',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(110,'4a978dcd034e2',1,1,6,2,'hauptpunkt-1/kollektion-1/test-thomas',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58'),(111,'4a9d42e6cbb25',1,1,6,2,'hauptpunkt-1/kollektion-1/test-seite-2_1',3,3,'2009-09-01 16:29:58','2009-09-01 16:29:58');
/*!40000 ALTER TABLE `pageUrls` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageVideos`
--

LOCK TABLES `pageVideos` WRITE;
/*!40000 ALTER TABLE `pageVideos` DISABLE KEYS */;
INSERT INTO `pageVideos` VALUES (3,'4a115ca65d8bb',1,1,'','l4PZBpcGfY8','http://i.ytimg.com/vi/l4PZBpcGfY8/default.jpg',2,3,'2009-10-16 07:43:33');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,8,3,1,1,1,1,1,3,0,'2009-04-24 08:12:50','49f17460a4f9f',1,3,0,'2009-04-24 08:12:50','2009-09-29 12:21:03','2009-04-24 08:12:50',2),(2,7,4,3,1,1,1,2,3,0,'2009-05-18 08:50:31','4a112157d69eb',1,2,0,'2009-05-18 08:50:31','2009-09-01 08:44:56','2009-06-09 09:34:19',2),(3,7,4,3,1,1,2,2,3,0,'2009-05-18 10:06:58','4a113342dffe5',1,2,0,'2009-05-18 10:06:58','2009-09-01 14:07:52','2009-06-09 16:51:23',2),(4,2,2,1,1,1,3,2,3,0,'2009-05-18 10:09:56','4a1133f43284a',1,2,0,'2009-05-18 10:09:56','2009-09-01 08:45:13','2009-09-01 08:45:11',2),(5,2,1,1,0,1,1,2,3,2,'2009-10-16 14:36:21','4a115ca65d8bb',1,3,0,'2009-05-18 13:03:34','2009-10-16 14:36:21','2009-05-18 14:11:29',2),(6,6,1,2,0,1,2,2,3,1,'2009-05-18 14:14:12','4a116d34752df',1,2,0,'2009-05-18 14:14:12','2009-09-01 14:09:37','2009-05-18 14:16:34',2),(7,13,1,4,0,1,3,2,3,1,'2009-05-27 08:10:04','4a1cf55c8b3e5',1,2,0,'2009-05-27 08:10:04','2009-09-01 14:07:04','2009-07-08 17:18:16',2),(8,2,2,1,1,0,12,2,3,0,'2009-06-10 12:26:02','4a2fa65ac1781',1,3,0,'2009-06-10 12:26:02','2009-06-10 12:26:02',NULL,1),(9,15,10,6,1,1,6,2,3,0,'2009-06-23 08:37:30','4a40944a8ee78',1,3,0,'2009-06-23 08:37:30','2009-09-01 16:29:58','2009-06-23 08:46:21',2),(10,2,1,1,0,0,6,2,3,1,'2009-06-23 08:38:04','4a40946ce9d01',1,3,0,'2009-06-23 08:38:04','2009-09-01 09:12:48','2009-06-23 08:38:34',2),(13,14,9,5,0,1,1,2,3,4,'2009-10-16 14:36:21','4a676ebfe3a7a',1,3,0,'2009-07-22 19:55:43','2009-10-16 14:36:21','2009-07-22 19:55:33',2),(14,14,1,5,0,0,1,2,3,1,'2009-10-16 14:35:30','4a681b0f66d2a',1,3,0,'2009-07-23 08:10:55','2009-10-16 14:35:30','2009-07-23 08:16:30',1),(15,2,1,1,0,0,1,2,3,5,'2009-10-16 14:36:21','4a978dcd034e2',1,3,0,'2009-08-28 07:57:01','2009-10-16 14:36:21','2009-08-28 07:56:42',2),(16,2,1,1,0,1,2,2,3,2,'2009-09-01 15:51:02','4a9d42e6cbb25',1,3,0,'2009-09-01 15:51:02','2009-09-01 15:53:48','2009-09-01 15:50:39',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'view','Der Datensatz darf visualisiert werden'),(2,'add','Ein neuer Datensatz darf erzeugt werden'),(3,'update','Der Datensatz darf verändert werden'),(4,'delete','Der Datensatz darf gelöscht werden'),(5,'archive','Der Datensatz darf archiviert werden'),(6,'live','Live schalten');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regionFields`
--

LOCK TABLES `regionFields` WRITE;
/*!40000 ALTER TABLE `regionFields` DISABLE KEYS */;
INSERT INTO `regionFields` VALUES (1,1,1,1),(2,1,1,1),(3,1,2,2),(4,2,3,1),(5,2,4,2),(6,3,5,1),(7,4,6,1),(8,5,7,2),(9,6,8,2),(10,8,10,2),(11,9,11,1),(12,10,17,1),(13,11,18,2),(14,11,19,3),(15,11,20,1),(16,9,21,5),(17,9,22,3),(18,12,23,1),(19,12,24,3),(20,5,25,1),(21,6,26,1),(22,2,27,3),(23,13,28,1),(24,14,29,2),(25,14,30,1),(26,15,31,5),(27,15,34,3),(28,15,37,1),(29,2,40,1),(30,16,41,4),(31,16,42,2),(32,16,43,1),(33,17,44,5),(34,17,45,2),(35,17,46,1),(36,15,47,6),(37,15,48,7),(38,16,49,5),(39,16,50,6),(40,17,51,6),(41,17,52,7),(42,17,53,3),(43,12,54,2),(44,8,55,1),(45,9,56,4),(46,15,59,2),(47,15,60,4),(48,16,61,3),(49,17,62,4),(50,99999999,64,2),(51,18,65,3),(52,18,66,4),(53,19,67,1),(54,19,68,2),(55,20,69,2),(56,20,70,3),(57,20,71,4),(58,20,72,5),(59,20,73,1),(60,19,74,3),(61,19,75,4),(62,18,76,1),(63,18,77,2),(64,18,78,5),(65,21,79,1),(66,21,80,2),(67,21,81,3),(68,21,82,4),(69,21,83,5),(70,21,84,6),(71,22,85,1),(72,9,86,2),(73,19,87,5),(74,23,88,2),(75,23,89,3),(76,23,90,1),(77,24,91,1),(78,24,92,2),(79,25,93,2),(80,25000,94,1),(81,15,95,8),(82,25,96,1),(83,26,1,1),(84,27,97,1),(85,27,98,2),(86,26,99,2),(87,26,100,3),(88,26,101,4),(89,26,102,5),(90,26,103,6),(91,28,108,1),(92,26,27,7),(93,29,104,1),(94,29,105,2),(95,30,106,1),(96,29,107,3),(97,31,109,1),(98,32,110,1),(99,32,113,2),(100,34,114,1),(101,35,115,1),(102,33,111,1),(103,33,112,1),(104,36,116,1),(105,37,117,1),(106,38,118,1),(107,39,119,1),(108,39,120,2),(109,40,121,1),(110,40,122,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regionTitles`
--

LOCK TABLES `regionTitles` WRITE;
/*!40000 ALTER TABLE `regionTitles` DISABLE KEYS */;
INSERT INTO `regionTitles` VALUES (1,1,1,'Allgemeine Informationen'),(2,2,1,'Allgemeine Informationen'),(3,3,1,'Titelbild'),(4,4,1,'Artikel'),(5,5,1,'Bildergalerie'),(6,6,1,'Dokumente'),(8,8,1,'Auszug'),(9,9,1,'Layout, Kategorien & Tags'),(10,10,1,'Allgemeine Informationen'),(11,11,1,'Textblock'),(12,12,1,'Video'),(13,13,1,'Link auf Seite im Portal'),(14,14,1,'Sidebar'),(15,15,1,'Definitionen'),(16,16,1,'Portal Top'),(17,17,1,'Artikel'),(18,18,1,'Allgemeine Kontaktinformationen'),(19,19,1,'Veranstaltungsinformationen'),(20,20,1,'Veranstaltungsort'),(21,21,1,'Kontaktdetails'),(22,22,1,'Vortragende'),(23,23,1,'Banner klein'),(24,24,1,'Headerbereich'),(25,25,1,'Externer Link'),(26,1,2,'General Informations'),(27,2,2,'General Informations'),(28,26,1,'Allgemeine Informationen'),(29,27,1,'Prozessanweisung'),(30,28,1,'Prozessgrafik'),(31,29,1,'Prozessschritt'),(32,30,1,'Kurzbeschreibung'),(33,31,1,'Prozessinputs / Informationen / Ressourcen'),(34,32,1,'Prozessrisiken'),(35,33,1,'Vorschriften'),(36,34,1,'Prozessoutputs / Ergebnisse / Kunden'),(37,35,1,'Messgößen'),(38,36,1,'Vorschriften / Richtlinien / Sicherheit'),(39,37,1,'Methoden / Verfahren / IT Tools'),(40,38,1,'Google Maps'),(41,39,1,'Interne Links'),(42,40,1,'Kollektion');
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES (1,1,9,0,0,1,NULL,0,0),(2,1,9,0,0,1,NULL,0,0),(3,1,9,0,1,1,NULL,0,0),(4,1,9,0,1,1,NULL,0,0),(5,1,9,0,1,0,NULL,0,0),(6,1,9,0,1,0,NULL,0,0),(8,1,9,0,1,0,NULL,0,0),(9,1,3,0,1,1,'right',0,0),(10,1,12,0,0,1,NULL,0,0),(11,1,9,0,1,0,NULL,1,1),(12,1,9,0,1,0,NULL,0,0),(13,1,12,0,0,1,NULL,0,0),(14,1,9,0,1,0,NULL,1,1),(15,2,9,0,1,0,NULL,1,1),(16,2,9,0,1,1,NULL,0,0),(17,2,9,0,1,0,NULL,1,1),(18,1,12,0,0,1,NULL,0,0),(19,1,9,0,1,1,NULL,0,0),(20,1,9,0,1,1,NULL,0,0),(21,1,12,0,1,1,NULL,0,0),(22,1,9,0,1,1,NULL,0,0),(23,1,9,0,1,0,NULL,0,0),(24,1,9,0,1,0,NULL,0,0),(25,1,12,0,0,1,NULL,0,0),(26,1,9,0,0,1,NULL,0,0),(27,1,9,0,1,1,NULL,1,0),(28,1,9,0,1,1,NULL,0,0),(29,1,9,0,1,0,NULL,1,0),(30,1,9,0,1,0,NULL,0,0),(31,1,9,0,1,0,NULL,0,0),(32,1,9,0,1,0,NULL,1,1),(33,1,9,0,1,1,NULL,1,0),(34,1,9,0,1,0,NULL,0,0),(35,1,9,0,1,0,NULL,0,0),(36,1,9,0,1,0,NULL,0,0),(37,1,9,0,1,0,NULL,0,0),(38,1,9,0,1,0,NULL,0,0),(39,1,9,0,1,0,NULL,0,0),(40,1,9,0,1,0,NULL,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES (1,'Portals','portals',3,3,'2009-10-08 10:15:10','2009-10-08 10:15:10'),(2,'Media','media',3,3,'2009-10-08 10:15:10','2009-10-08 10:15:10');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevelTitles`
--

LOCK TABLES `rootLevelTitles` WRITE;
/*!40000 ALTER TABLE `rootLevelTitles` DISABLE KEYS */;
INSERT INTO `rootLevelTitles` VALUES (1,1,1,'Portal'),(2,2,1,'Bilder'),(3,3,1,'Dokumente'),(4,5,1,'Kontakte'),(5,4,1,'Kategorien'),(6,6,1,'Eigene Etiketten'),(7,7,1,'System Interne'),(8,8,1,'Benutzer'),(9,9,1,'Gruppen / Rollen'),(10,10,1,'Ressourcen'),(11,1,2,'Portal');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevelTypes`
--

LOCK TABLES `rootLevelTypes` WRITE;
/*!40000 ALTER TABLE `rootLevelTypes` DISABLE KEYS */;
INSERT INTO `rootLevelTypes` VALUES (1,'portals'),(2,'images'),(3,'documents'),(4,'categories'),(5,'contacts'),(6,'labels'),(7,'systeminternals'),(8,'users'),(9,'groups'),(10,'resources');
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
  `idThemes` bigint(20) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rootLevels`
--

LOCK TABLES `rootLevels` WRITE;
/*!40000 ALTER TABLE `rootLevels` DISABLE KEYS */;
INSERT INTO `rootLevels` VALUES (1,1,1,1),(2,2,2,NULL),(3,3,2,NULL),(4,4,3,NULL),(5,5,3,NULL),(6,6,3,NULL),(7,7,3,NULL),(8,8,4,NULL),(9,9,4,NULL),(10,10,4,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabRegions`
--

LOCK TABLES `tabRegions` WRITE;
/*!40000 ALTER TABLE `tabRegions` DISABLE KEYS */;
INSERT INTO `tabRegions` VALUES (1,1,1,1),(2,2,2,1),(3,2,3,4),(4,2,4,6),(5,2,5,9),(6,2,6,10),(7,2,7,0),(8,2,8,12),(9,2,9,0),(10,5,10,1),(15,2,11,7),(16,2,12,8),(17,6,13,1),(18,7,2,1),(19,7,9,0),(20,7,14,6),(21,7,15,4),(22,8,2,1),(23,8,9,0),(24,8,11,7),(25,8,16,3),(26,8,17,8),(47,7,8,11),(48,7,3,4),(49,7,4,7),(50,9,10,1),(51,11,2,1),(52,11,3,4),(53,11,4,6),(54,11,5,9),(55,11,6,10),(56,11,7,0),(57,11,8,11),(58,11,9,0),(60,11,12,8),(61,10,18,1),(62,11,19,4),(63,11,20,5),(64,10,21,2),(65,11,22,6),(66,12,2,1),(67,12,3,4),(68,12,4,6),(69,12,8,11),(70,12,9,0),(71,8,23,5),(72,8,3,4),(73,8,4,6),(74,2,24,2),(75,8,24,2),(76,11,24,2),(77,12,24,2),(78,13,25,1),(79,14,26,1),(80,15,27,2),(81,16,28,1),(82,17,29,4),(83,14,30,2),(84,14,31,3),(85,18,32,1),(86,19,33,6),(87,14,34,4),(88,14,35,5),(89,14,36,6),(90,14,37,7),(91,2,38,3),(92,2,39,11),(93,7,40,5);
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
  `color` char(7) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabs`
--

LOCK TABLES `tabs` WRITE;
/*!40000 ALTER TABLE `tabs` DISABLE KEYS */;
INSERT INTO `tabs` VALUES (1,NULL),(2,NULL),(3,NULL),(4,NULL),(5,NULL),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,NULL),(11,NULL),(12,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(17,NULL),(18,NULL),(19,NULL);
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
INSERT INTO `tagPages` VALUES (4,'4a112157d69eb',1,1),(4,'4a115ca65d8bb',1,1),(4,'4a115ca65d8bb',1,2),(5,'4a112157d69eb',1,1),(5,'4a115ca65d8bb',1,1);
/*!40000 ALTER TABLE `tagPages` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Tag1'),(2,'Tag2'),(3,'Tag3'),(4,'Test1'),(5,'Test2'),(6,'Test3');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateExcludedFields`
--

LOCK TABLES `templateExcludedFields` WRITE;
/*!40000 ALTER TABLE `templateExcludedFields` DISABLE KEYS */;
INSERT INTO `templateExcludedFields` VALUES (1,1,40),(2,2,3),(3,2,4000),(4,4,3),(5,4,4000),(6,3,3),(8,5,40),(9,6,40),(10,7,40),(11,3,86),(12,4,86),(13,6,86),(14,8,3),(15,8,4),(16,8,86),(17,10,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateTitles`
--

LOCK TABLES `templateTitles` WRITE;
/*!40000 ALTER TABLE `templateTitles` DISABLE KEYS */;
INSERT INTO `templateTitles` VALUES (1,1,1,'Template News'),(2,2,1,'Startseite'),(3,3,1,'Portal Startseite'),(4,4,1,'Übersicht'),(5,5,1,'Template Video'),(6,6,1,'Template Text'),(7,7,1,'Veranstaltung'),(8,8,1,'Übersicht Veranstaltung'),(9,9,1,'Prozess'),(10,10,1,'Kollektion');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templateTypes`
--

LOCK TABLES `templateTypes` WRITE;
/*!40000 ALTER TABLE `templateTypes` DISABLE KEYS */;
INSERT INTO `templateTypes` VALUES (2,1,2),(3,2,1),(5,4,3),(6,3,4),(7,5,2),(8,6,2),(9,7,2),(10,8,3),(11,10,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` VALUES (1,'DEFAULT_PAGE_1','template_1.php','template_01.jpg',1),(2,'DEFAULT_PAGE_1','template_1.php','template_01.jpg',1),(3,'DEFAULT_STARTPAGE','template_startpage.php','template_startpage.jpg',1),(4,'DEFAULT_OVERVIEW','template_overview.php','template_overview.jpg',1),(5,'DEFAULT_PAGE_1','template_video.php','template_video.jpg',0),(6,'DEFAULT_PAGE_1','template_text.php','template_text.jpg',0),(7,'DEFAULT_EVENT','template_event.php','template_event-detail.jpg',0),(8,'DEFAULT_EVENT_OVERVIEW','template_event_overview.php','template_event-overview.jpg',0),(9,'DEFAULT_PROCESS','template_process.php','template_process.jpg',1),(10,'DEFAULT_COLLECTION','template_collection.php','template_collection.jpg',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `themes`
--

LOCK TABLES `themes` WRITE;
/*!40000 ALTER TABLE `themes` DISABLE KEYS */;
INSERT INTO `themes` VALUES (1,'Default','default',2,2,'2009-05-07 07:18:38','2009-05-07 06:48:35');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'startpage'),(2,'page'),(3,'overview'),(4,'portal_startpage'),(5,'collection');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitTitles`
--

LOCK TABLES `unitTitles` WRITE;
/*!40000 ALTER TABLE `unitTitles` DISABLE KEYS */;
INSERT INTO `unitTitles` VALUES (1,1,1,'Massive Art');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,9,0,1,1,2,0);
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urlReplacers`
--

DROP TABLE IF EXISTS `urlReplacers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urlReplacers` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idLanguages` int(10) unsigned NOT NULL default '1',
  `from` varchar(255) NOT NULL,
  `to` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urlReplacers`
--

LOCK TABLES `urlReplacers` WRITE;
/*!40000 ALTER TABLE `urlReplacers` DISABLE KEYS */;
INSERT INTO `urlReplacers` VALUES (1,1,'ä','ae'),(2,1,'ö','oe'),(3,1,'ü','ue'),(4,1,'ß','ss'),(5,1,'Ä','Ae'),(6,1,'Ö','Oe'),(7,1,'Ü','Ue'),(8,1,'&','und');
/*!40000 ALTER TABLE `urlReplacers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userGroups`
--

DROP TABLE IF EXISTS `userGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userGroups` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `idUsers` bigint(20) NOT NULL,
  `idGroups` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userGroups`
--

LOCK TABLES `userGroups` WRITE;
/*!40000 ALTER TABLE `userGroups` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'rainer','163732f752aeeccdbb9630c04fe08e14','Rainer','Schönherr',3,3,'2009-10-07 09:41:35','2009-10-07 09:41:17'),(2,1,'conny','3af31637b5328eb0e6a050e23a064681','Cornelius','Hansjakob',1,1,NULL,'2009-10-07 09:41:17'),(3,1,'thomas','ef6e65efc188e7dffd7335b646a85a21','Thomas','Schedler',2,2,NULL,'2009-10-07 09:41:35'),(4,1,'berndhep','01c2310a3cc00933589d3e2f694343d8','Bernd','Hepberger',3,3,NULL,'2009-10-07 09:41:17'),(5,1,'kate','29ddc288099264c17b07baf44d3f0adc','Kate','Dobler',3,3,NULL,'2009-10-16 16:44:16'),(6,1,'dominik','4bd2b007716888ed6bf6c2399a6d7305','Dominik','Mößlang',3,3,'2009-10-16 07:50:48','2009-10-16 07:50:48'),(7,1,'thomas.schedler','090c25cfa555e7685a14d33b1d0f52a1','Thomas','Schedler',3,3,'2009-10-16 12:32:59','2009-10-16 12:32:59');
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

-- Dump completed on 2009-10-16 18:45:15
