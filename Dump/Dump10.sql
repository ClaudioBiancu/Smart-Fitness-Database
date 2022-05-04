CREATE DATABASE  IF NOT EXISTS `smartfitness` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `smartfitness`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: smartfitness
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `accessibile`
--

DROP TABLE IF EXISTS `accessibile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accessibile` (
  `CodiceModalita` int(11) NOT NULL,
  `CodiceCentro` int(11) NOT NULL,
  `MaxNumeroAccessiCentro` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceModalita`,`CodiceCentro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessibile`
--

LOCK TABLES `accessibile` WRITE;
/*!40000 ALTER TABLE `accessibile` DISABLE KEYS */;
INSERT INTO `accessibile` VALUES (0,0,10),(0,2,5),(0,3,5),(1,3,16),(2,4,12),(3,5,12),(4,6,20),(5,7,14),(6,3,8),(6,8,9),(7,4,8),(7,9,8),(8,6,13),(9,3,9),(9,5,11);
/*!40000 ALTER TABLE `accessibile` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger BR_Accessibile before insert on accessibile
for each row
begin

declare multisede bool default false;
declare quanteSedi integer default 0;

set multisede = (
				select
					m.Multisede
				from
					modalita m
				where
					m.CodiceModalita = new.CodiceModalita );

set quanteSedi = (
					select
						count(*)
                    from
						accessibile a
					where
						a.CodiceModalita = new.CodiceModalita );
                        
if multisede = true then
	if quanteSedi = 3 then
		signal sqlstate '45000'
        set message_text = 'Impossibile aggiungere un altro Centro';
	end if;
else
	if quanteSedi = 1 then
		signal sqlstate '45000'
        set message_text = 'Impossibile aggiungere un altro Centro';
	end if;
end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `accesso`
--

DROP TABLE IF EXISTS `accesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accesso` (
  `CodiceCliente` varchar(45) NOT NULL,
  `CodiceCentro` int(11) NOT NULL,
  `Data` date NOT NULL,
  `OrarioAccesso` int(11) DEFAULT NULL,
  `OrarioUscita` int(11) DEFAULT NULL,
  `CodiceSpogliatoio` int(11) DEFAULT NULL,
  `Numero` int(11) DEFAULT NULL,
  `Piscina` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`CodiceCliente`,`CodiceCentro`,`Data`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accesso`
--

LOCK TABLES `accesso` WRITE;
/*!40000 ALTER TABLE `accesso` DISABLE KEYS */;
INSERT INTO `accesso` VALUES ('0aaa',0,'2017-07-02',8,10,0,1,1),('0aaa',3,'2017-07-04',8,10,5,2,0),('0bbb',2,'2017-07-02',10,12,4,1,0),('0bbb',3,'2017-07-11',11,13,5,2,0),('0ccc',3,'2017-07-02',13,15,5,1,0),('0ccc',3,'2017-07-04',12,14,5,2,0),('0ddd',4,'2017-07-02',15,17,6,2,0),('0ddd',4,'2017-07-11',14,16,6,1,0),('0eee',5,'2017-07-04',16,18,7,1,0),('0eee',5,'2017-07-11',17,19,8,2,0),('0fff',6,'2017-07-02',18,20,9,1,0),('0fff',6,'2017-07-11',19,21,10,2,0);
/*!40000 ALTER TABLE `accesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amicizia`
--

DROP TABLE IF EXISTS `amicizia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amicizia` (
  `Richiedente` varchar(45) NOT NULL,
  `Destinatario` varchar(45) NOT NULL,
  `DataRichiesta` date NOT NULL,
  `Stato` tinyint(4) DEFAULT NULL,
  `DataAmicizia` date DEFAULT NULL,
  PRIMARY KEY (`Richiedente`,`Destinatario`,`DataRichiesta`),
  KEY `FK2_prof2_idx` (`Destinatario`),
  CONSTRAINT `FK1_prof1` FOREIGN KEY (`Richiedente`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_prof2` FOREIGN KEY (`Destinatario`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amicizia`
--

LOCK TABLES `amicizia` WRITE;
/*!40000 ALTER TABLE `amicizia` DISABLE KEYS */;
INSERT INTO `amicizia` VALUES ('0aaa','0bbb','2017-06-06',1,'2017-06-06'),('0aaa','0ddd','2017-06-04',1,'2017-06-04'),('0ccc','0bbb','2017-06-03',0,'2017-06-04'),('0eee','0bbb','2017-07-07',1,'2017-07-07'),('0eee','0fff','2017-07-09',1,'2017-07-11'),('0fff','0ggg','2017-07-08',0,'2017-07-08');
/*!40000 ALTER TABLE `amicizia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apparecchiatura`
--

DROP TABLE IF EXISTS `apparecchiatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apparecchiatura` (
  `CodiceIdentificativo` int(11) NOT NULL,
  `NomeSala` int(11) NOT NULL,
  `Tipologia` varchar(45) NOT NULL,
  `ConsumoEnergetico` int(100) DEFAULT '0',
  `LivelloUsura` int(11) DEFAULT '0',
  PRIMARY KEY (`CodiceIdentificativo`),
  KEY `NomeSala_idx` (`NomeSala`),
  CONSTRAINT `NomeSala` FOREIGN KEY (`NomeSala`) REFERENCES `sala` (`CodiceSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apparecchiatura`
--

LOCK TABLES `apparecchiatura` WRITE;
/*!40000 ALTER TABLE `apparecchiatura` DISABLE KEYS */;
INSERT INTO `apparecchiatura` VALUES (0,0,'TapisRoulant',102,51),(1,0,'LatMachine',204,48),(2,1,'Barra Trazioni',250,3),(3,1,'Pulley',303,70),(4,2,'Panca Piana',78,89),(5,3,'Chest Press',400,30),(6,4,'Panca Piana',326,56),(7,5,'Leg Extension',256,52),(8,6,'TapisRoulant',123,89),(9,7,'Pressa',421,70),(10,7,'Pressa',389,76),(11,8,'Calf Machine',126,44),(12,8,'Leg Curl',89,59),(14,9,'Cyclette',78,36),(15,9,'Manubri',189,58),(16,9,'Manubri',175,74),(17,1,'Cyclette',164,96),(18,6,'Ellittica',152,2),(19,7,'Ellittica',142,60),(20,4,'Cavi',138,62),(21,5,'Bilanciere',129,39);
/*!40000 ALTER TABLE `apparecchiatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armadietto`
--

DROP TABLE IF EXISTS `armadietto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armadietto` (
  `CodiceArmadietto` int(11) NOT NULL,
  `CodiceSpogliatoio` int(11) NOT NULL,
  `CombinazioneArmadietto` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceArmadietto`,`CodiceSpogliatoio`),
  KEY `FK_Spogliatoio_idx` (`CodiceSpogliatoio`),
  CONSTRAINT `FK_Spogliatoio` FOREIGN KEY (`CodiceSpogliatoio`) REFERENCES `spogliatoio` (`CodiceSpogliatoio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armadietto`
--

LOCK TABLES `armadietto` WRITE;
/*!40000 ALTER TABLE `armadietto` DISABLE KEYS */;
INSERT INTO `armadietto` VALUES (1,0,NULL),(1,1,NULL),(1,2,NULL),(1,3,NULL),(1,4,NULL),(1,5,NULL),(1,6,NULL),(1,7,NULL),(1,8,NULL),(1,9,NULL),(1,10,NULL),(1,11,NULL),(1,12,NULL),(1,13,NULL),(1,14,NULL),(1,15,NULL),(2,1,NULL),(2,2,NULL),(2,3,NULL),(2,4,NULL),(2,5,NULL),(2,6,NULL),(2,7,NULL),(2,8,NULL),(2,9,NULL),(2,10,NULL),(2,11,NULL),(2,12,NULL),(2,13,NULL),(2,14,NULL),(2,15,NULL);
/*!40000 ALTER TABLE `armadietto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendario`
--

DROP TABLE IF EXISTS `calendario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendario` (
  `Giorno` varchar(45) NOT NULL,
  `Corso` int(11) NOT NULL,
  `OrarioInizio` int(11) DEFAULT NULL,
  `OrarioFine` int(11) DEFAULT NULL,
  PRIMARY KEY (`Giorno`,`Corso`),
  KEY `FK2_cor2_idx` (`Corso`),
  CONSTRAINT `FK2_cor2` FOREIGN KEY (`Corso`) REFERENCES `corso` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendario`
--

LOCK TABLES `calendario` WRITE;
/*!40000 ALTER TABLE `calendario` DISABLE KEYS */;
INSERT INTO `calendario` VALUES ('Giovedì',0,13,15),('Lunedì',1,14,16),('Lunedì',4,20,22),('Lunedì',5,10,14),('Martedì',0,9,11),('Martedì',2,11,13),('Martedì',5,11,13),('Mercoledì',1,10,12),('Mercoledì',3,14,16),('Venerdì',2,12,14),('Venerdì',3,17,19),('Venerdì',4,9,11);
/*!40000 ALTER TABLE `calendario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger BR_Calendario before insert on Calendario
for each row
begin

declare hri int(11) default 0;
declare hrf int(11) default 0;
declare gg int(11) default 0;
declare tch char(255) default '';
declare corso char(255) default '';
declare centro char(255) default '';
declare trovato int(11) default 0;

set gg = new.Giorno;

set hri = new.OrarioInizio;

set hrf = new.OrarioFine;

set corso = new.Corso;

set centro = (
			select
				c.CodiceCentro
			from
				corso c
			where
				c.Codice = corso );

set tch = (
			select
				c.Istruttore
			from
				corso c
			where
				c.Codice = corso );

set trovato = (
				select
					count(*)
                from
					turnazione t
				where
					t.Dipendente = tch
                    and t.Giorno = gg
                    and hri between t.OrarioInizio and t.OrarioFine
                    and hrf between t.OrarioInizio and t.OrarioFine );
                    
if trovato = 0 then
	signal sqlstate '45000'
    set message_text = 'Impossibile inserire il calendario perchè turno del dipendente non presente';
end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `centro`
--

DROP TABLE IF EXISTS `centro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centro` (
  `CodiceCentro` int(11) NOT NULL,
  `Citta` varchar(45) DEFAULT NULL,
  `Indirizzo` varchar(45) DEFAULT NULL,
  `NumeroTel` int(15) DEFAULT NULL,
  `Dimensione` int(11) DEFAULT NULL,
  `NumeroMaxClienti` int(11) DEFAULT NULL,
  `OrarioApertura` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceCentro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro`
--

LOCK TABLES `centro` WRITE;
/*!40000 ALTER TABLE `centro` DISABLE KEYS */;
INSERT INTO `centro` VALUES (0,'Pisa','Via Diotisalvi 1',501234567,150,100,'8.00/20.00'),(1,'Milano','Via Lombardia 2',100000001,156,100,'8.00/12.00-14.00/20.00'),(2,'Roma','Via Lazio 3',200000002,130,90,'8.00/24.00'),(3,'Cagliari','Via Sardegna 4',300000003,180,100,'8.00/20.00'),(4,'Latina','Via Lazio 4',400000004,140,70,'8.00/21.00'),(5,'Padova','Via Veneto 3',500000005,160,65,'8.00/19.30'),(6,'Pisa','Via Toscana 6',600000006,200,100,'8.30/22.00'),(7,'Napoli','Via Campania 6',700000007,240,100,'8.00/20.00'),(8,'Torino','Via Piemonte 7',800000008,160,80,'9.00/23.00'),(9,'Bologna','Via Emilia 8',900000009,400,90,'8.00/24.00');
/*!40000 ALTER TABLE `centro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerchia`
--

DROP TABLE IF EXISTS `cerchia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerchia` (
  `Utente` varchar(45) NOT NULL,
  `Interesse` varchar(45) NOT NULL,
  `Amico` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Utente`,`Interesse`),
  KEY `FK5_inter5_idx` (`Interesse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerchia`
--

LOCK TABLES `cerchia` WRITE;
/*!40000 ALTER TABLE `cerchia` DISABLE KEYS */;
INSERT INTO `cerchia` VALUES ('0aaa','Macchinari','0bbb'),('0aaa','Nuoto','0ddd'),('0eee','Integratori','0bbb');
/*!40000 ALTER TABLE `cerchia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `CodiceFiscale` varchar(45) NOT NULL,
  `Nome` varchar(45) DEFAULT NULL,
  `Cognome` varchar(45) DEFAULT NULL,
  `DataNascita` date DEFAULT NULL,
  `Indirizzo` varchar(45) DEFAULT NULL,
  `Città` varchar(45) DEFAULT NULL,
  `DocumentoRiconoscimento` varchar(45) DEFAULT NULL,
  `PrefetturaDocumento` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('0aaa','Gabriele','D\'annunzio','1959-08-01','Via Cane 1','Milano','b000','Milano'),('0bbb','Eugenio','Montale','1959-09-25','Via Gatto 3','Pisa','b111','Pisa'),('0ccc','Giuseppe','Ungaretti','1989-08-06','Via Topo 4','Bari','b222','Bari'),('0ddd','Giovanni','Pascoli','1920-01-01','Via Giraffa 6','Torino','b333','Torino'),('0eee','Alda','Merini','1974-03-25','Via Elefante 9','Latina','b444','Latina'),('0fff','Vincenzo','Cardarelli','1996-03-06','Via Zebra 10','Latina','b555','Latina'),('0ggg','Dante','Alighieri','1963-09-05','Via Ippopotamo 78','Venezia','b666','Venezia'),('0hhh','Giosuè','Carducci','1954-06-02','Via Leone 12','Livorno','b777','Pisa'),('0iii','Salvatore','Quasimodo','1993-02-03','Via Tigre 46','Lucca','b888','Livorno'),('0lll','Pier Paolo ','Pasolini','1962-05-07','Via Scimmia 89','Catanzaro','b999','Nicotera'),('0mmm','Giacomo','Leopardi','1947-09-02','Via Iena 87','Palermo','c000','Trapani'),('0nnn','Francesco ','Petrarca','1978-10-03','Via Facocero 63','Perugia','c111','Perugia'),('0ooo','Umberto','Saba','1992-04-06','Via Armadillo 89','Cagliari','c222','Nuoro'),('0ppp','Alessandro','Manzoni','1988-05-30','Via Cammello 45','Napoli','c333','Amalfi'),('0qqq','Giovanni','Boccaccio','2000-03-06','Via Dromedario 96','Livorno','c444','Livorno');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consente1`
--

DROP TABLE IF EXISTS `consente1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consente1` (
  `CodiceModalita` int(11) NOT NULL,
  `CodicePiscina` int(11) NOT NULL,
  `MaxNumeroAccessi` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceModalita`,`CodicePiscina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consente1`
--

LOCK TABLES `consente1` WRITE;
/*!40000 ALTER TABLE `consente1` DISABLE KEYS */;
INSERT INTO `consente1` VALUES (0,0,4),(0,1,4),(1,1,4),(4,3,2),(4,8,6),(6,7,4),(7,7,4),(9,6,4),(9,9,4);
/*!40000 ALTER TABLE `consente1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consente2`
--

DROP TABLE IF EXISTS `consente2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consente2` (
  `CodiceModalita` int(11) NOT NULL,
  `CodiceSala` int(11) NOT NULL,
  PRIMARY KEY (`CodiceModalita`,`CodiceSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consente2`
--

LOCK TABLES `consente2` WRITE;
/*!40000 ALTER TABLE `consente2` DISABLE KEYS */;
INSERT INTO `consente2` VALUES (0,0),(0,1),(0,4),(0,14),(0,15),(0,16),(0,17),(0,18),(0,19),(1,17),(1,18),(1,19),(1,32),(1,33),(2,20),(2,21),(2,23),(3,24),(3,25),(3,26),(4,27),(4,28),(4,34),(4,35),(4,36),(4,37),(5,29),(5,38),(5,39),(6,17),(6,30),(6,31),(6,32),(6,33),(7,7),(7,20),(7,21),(7,22),(7,23),(7,39),(9,5),(9,17),(9,18),(9,19),(9,24),(9,25),(9,32),(9,33);
/*!40000 ALTER TABLE `consente2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratto`
--

DROP TABLE IF EXISTS `contratto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contratto` (
  `CodiceCliente` varchar(45) NOT NULL,
  `DataSottoscrizione` date DEFAULT NULL,
  `CodiceConsulente` varchar(45) DEFAULT NULL,
  `ModalitaPagamento` tinyint(4) DEFAULT NULL,
  `Durata` int(11) DEFAULT NULL,
  `CodiceModalita` int(11) DEFAULT NULL,
  `Scopo` varchar(45) NOT NULL,
  PRIMARY KEY (`CodiceCliente`),
  KEY `CodiceConsulente_idx` (`CodiceConsulente`),
  KEY `CodiceModalita_idx` (`CodiceModalita`),
  CONSTRAINT `CodiceCliente` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `CodiceConsulente` FOREIGN KEY (`CodiceConsulente`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `CodiceModalita` FOREIGN KEY (`CodiceModalita`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratto`
--

LOCK TABLES `contratto` WRITE;
/*!40000 ALTER TABLE `contratto` DISABLE KEYS */;
INSERT INTO `contratto` VALUES ('0aaa','2016-10-11','aaa',0,3,0,'Potenziamento'),('0bbb','2016-12-03','bbb',1,2,0,'Potenziamento'),('0ccc','2016-08-03','ccc',1,4,1,'Potenziamento'),('0ddd','2017-01-03','ccc',0,5,2,'Dimagrimento'),('0eee','2016-10-23','ddd',0,4,3,'Ricreativo'),('0fff','2016-07-12','eee',0,3,4,'Ricreativo'),('0ggg','2017-02-03','fff',1,2,5,'Ricreativo'),('0hhh','2017-05-29','bbb',0,1,6,'Ricreativo'),('0iii','2017-06-14','iii',0,4,7,'Dimagrimento'),('0lll','2016-11-06','hhh',0,5,9,'Dimagrimento'),('0mmm','2017-03-04','ggg',0,3,0,'Dimagrimento'),('0nnn','2016-08-05','ccc',0,2,3,'Ricreativo'),('0ooo','2016-09-25','fff',0,4,6,'Potenziamento'),('0ppp','2017-03-06','ddd',0,5,5,'Ricreativo'),('0qqq','2017-05-30','aaa',0,2,7,'Dimagrimento');
/*!40000 ALTER TABLE `contratto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corso`
--

DROP TABLE IF EXISTS `corso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corso` (
  `Codice` int(11) NOT NULL,
  `Disciplina` varchar(45) DEFAULT NULL,
  `Livello` int(11) DEFAULT NULL,
  `Istruttore` varchar(45) DEFAULT NULL,
  `DataInizio` date DEFAULT NULL,
  `DataFine` date DEFAULT NULL,
  `CodiceSala` int(11) DEFAULT NULL,
  `NumeroMaxPartecipanti` int(11) DEFAULT NULL,
  PRIMARY KEY (`Codice`),
  KEY `FK_sala1_idx` (`CodiceSala`),
  KEY `FK1_dip1_idx` (`Istruttore`),
  CONSTRAINT `FK1_dip1` FOREIGN KEY (`Istruttore`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_sala1` FOREIGN KEY (`CodiceSala`) REFERENCES `sala` (`CodiceSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corso`
--

LOCK TABLES `corso` WRITE;
/*!40000 ALTER TABLE `corso` DISABLE KEYS */;
INSERT INTO `corso` VALUES (0,'Box',1,'aaa','2017-01-01','2017-02-01',7,15),(1,'Box',2,'fff','2107-02-01','2107-04-01',34,10),(2,'Zumba',3,'ddd','2017-03-01','2017-06-01',4,15),(3,'KickBox',1,'bbb','2017-04-01','2017-06-01',3,20),(4,'Karate',2,'aaa','2017-01-01','2017-03-01',9,25),(5,'Yoga',3,'eee','2017-02-01','2017-04-01',5,30);
/*!40000 ALTER TABLE `corso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dieta`
--

DROP TABLE IF EXISTS `dieta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dieta` (
  `CodiceSchedaAlimentazione` int(11) NOT NULL,
  `Calorie` int(11) DEFAULT NULL,
  `NumeroPasti` int(11) DEFAULT NULL,
  `ComposizionePasti` text,
  PRIMARY KEY (`CodiceSchedaAlimentazione`),
  CONSTRAINT `FK1_schedaal1` FOREIGN KEY (`CodiceSchedaAlimentazione`) REFERENCES `schedaalimentazione` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dieta`
--

LOCK TABLES `dieta` WRITE;
/*!40000 ALTER TABLE `dieta` DISABLE KEYS */;
INSERT INTO `dieta` VALUES (0,2000,5,'pasta'),(1,2200,4,'cavoli'),(2,2300,5,'pesce'),(3,2400,6,'carne'),(4,2500,5,'frutta'),(5,2600,4,'frutta'),(6,2700,5,'pesce'),(7,2800,6,'carne'),(8,2900,5,'fagioli'),(9,3000,4,'legumi'),(10,2000,5,'legumi'),(11,2100,6,'pesce'),(12,2200,5,'fagioli'),(13,2300,4,'carne'),(14,2400,5,'cipolle');
/*!40000 ALTER TABLE `dieta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dipendente`
--

DROP TABLE IF EXISTS `dipendente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dipendente` (
  `CodiceFiscale` varchar(45) NOT NULL,
  `Nome` varchar(45) DEFAULT NULL,
  `Cognome` varchar(45) DEFAULT NULL,
  `DataNascita` date DEFAULT NULL,
  `Indirizzo` varchar(45) DEFAULT NULL,
  `Città` varchar(45) DEFAULT NULL,
  `DocumentoRiconoscimento` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dipendente`
--

LOCK TABLES `dipendente` WRITE;
/*!40000 ALTER TABLE `dipendente` DISABLE KEYS */;
INSERT INTO `dipendente` VALUES ('aaa','Poseidone','Mare','1980-09-13','Via Italia 3','Roma','a000'),('bbb','Atena','Olimpo','1965-03-16','Via Grecia 13','Pisa','a111'),('bnccld','Claudio','Biancu','1996-08-06','Via Danimarca 43','Pisa','a222'),('ccc','Marte','Guerra','1959-08-01','Via Germania 9','Pisa','a333'),('ddd','Eros','Amore','1940-12-26','Via Spagna 46','Latina','a444'),('eee','Mercurio','Veloce','1977-11-06','Via Francia 56','Cagliari','a555'),('fff','Ade','Inferi','1956-01-23','Via Portogallo 89','Torino','a666'),('ggg','Caronte','Barca','1954-03-30','Via Polonia 77','Padova','a777'),('hhh','Afrodite','Bellezza','1991-05-09','Via Inghilterra ','Milano','a888'),('iii','Apollo','Sole','1992-10-08','Via Irlanda 9','Roma','a999');
/*!40000 ALTER TABLE `dipendente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `esercizio`
--

DROP TABLE IF EXISTS `esercizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `esercizio` (
  `Nome` varchar(45) NOT NULL,
  `DEOM` int(11) DEFAULT NULL,
  `TipologiaEsercizio` varchar(45) DEFAULT NULL,
  `TipologiaMacchina` varchar(45) DEFAULT NULL,
  `RegolazioneMacchina` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Nome`),
  KEY `FK1_tip1_idx` (`TipologiaMacchina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `esercizio`
--

LOCK TABLES `esercizio` WRITE;
/*!40000 ALTER TABLE `esercizio` DISABLE KEYS */;
INSERT INTO `esercizio` VALUES ('AddPower',120,'Addominali','PancaPiana','0-(-1)-0'),('AddStandard',100,'Addominali','PancaPiana','0-0-0'),('CorsaCardio',130,'Corsa','TapisRoulant','1-0-30minuti'),('CycletteStandard',120,'Cardio','Cyclette','VelocitàVariabile-30minuti'),('DorsoStandard',130,'Dorso','LatMachine','60kg'),('EllitticaStandard',130,'Cardio','Ellittica','30minuti'),('Petto1',120,'Petto','Chest Press','70kg'),('PettoStandard',130,'Petto','Manubri','40 kg'),('PressaOk',150,'Gambe','Pressa','100kg'),('PressaPower',160,'Gambe','Pressa','150kg'),('Squat100',150,'Squat','Manubri','100kg');
/*!40000 ALTER TABLE `esercizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornitore`
--

DROP TABLE IF EXISTS `fornitore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornitore` (
  `Nome` varchar(45) NOT NULL,
  `FormaSocietaria` varchar(45) DEFAULT NULL,
  `PartitaIva` int(11) DEFAULT NULL,
  `Indirizzo` varchar(45) DEFAULT NULL,
  `Citta` varchar(45) DEFAULT NULL,
  `NumTelefono` int(11) DEFAULT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornitore`
--

LOCK TABLES `fornitore` WRITE;
/*!40000 ALTER TABLE `fornitore` DISABLE KEYS */;
INSERT INTO `fornitore` VALUES ('Dimagra','SRL',2,'Via Iguana 6','Roma',1400000000),('Integrators','S.P.A.',0,'Via Camaleonte 4','Milano',1200000000),('PowerUp','S.P.A.',3,'Via Biscia 7','Napoli',1500000000),('Vitamins','SRL',1,'Via Rana 5','Pisa',1300000000);
/*!40000 ALTER TABLE `fornitore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornitura`
--

DROP TABLE IF EXISTS `fornitura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornitura` (
  `NomeIntegratore` varchar(45) NOT NULL,
  `NomeFornitore` varchar(45) NOT NULL,
  `Quantita` int(11) DEFAULT NULL,
  PRIMARY KEY (`NomeIntegratore`,`NomeFornitore`),
  KEY `FK_fornitore3_idx` (`NomeFornitore`),
  CONSTRAINT `FK_fornitore3` FOREIGN KEY (`NomeFornitore`) REFERENCES `fornitore` (`Nome`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_integratore5` FOREIGN KEY (`NomeIntegratore`) REFERENCES `integratore` (`NomeCommerciale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornitura`
--

LOCK TABLES `fornitura` WRITE;
/*!40000 ALTER TABLE `fornitura` DISABLE KEYS */;
INSERT INTO `fornitura` VALUES ('Fyron Body','Dimagra',40),('Fyron Body','Integrators',50),('Fyron Body','PowerUp',60),('Fyron Body','Vitamins',70),('Polase','Dimagra',70),('Polase','Integrators',50),('Polase','PowerUp',60),('Polase','Vitamins',40),('Prozis ','Dimagra',50),('Prozis ','Integrators',40),('Prozis ','PowerUp',60),('Prozis ','Vitamins',50),('ScitecNutrition','Dimagra',70),('ScitecNutrition','Integrators',30),('ScitecNutrition','PowerUp',50),('ScitecNutrition','Vitamins',60),('Supradyn','Dimagra',40),('Supradyn','Integrators',60),('Supradyn','PowerUp',40),('Supradyn','Vitamins',60),('Sustenium','Dimagra',80),('Sustenium','Integrators',90),('Sustenium','PowerUp',50),('Sustenium','Vitamins',60);
/*!40000 ALTER TABLE `fornitura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impiego`
--

DROP TABLE IF EXISTS `impiego`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impiego` (
  `CodiceFiscale` varchar(45) NOT NULL,
  `CodiceCentro` int(11) NOT NULL,
  `Ruolo` varchar(45) DEFAULT NULL,
  `TipologiaAttivita` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceFiscale`,`CodiceCentro`),
  KEY `CodiceCentro_idx` (`CodiceCentro`),
  CONSTRAINT `FK_CodiceCentr` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Dipendente` FOREIGN KEY (`CodiceFiscale`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impiego`
--

LOCK TABLES `impiego` WRITE;
/*!40000 ALTER TABLE `impiego` DISABLE KEYS */;
INSERT INTO `impiego` VALUES ('aaa',0,'Istruttore','Nuoto'),('aaa',9,'Istruttore','SalaCardio'),('bbb',1,'Magazziniere','Manutentore'),('bbb',7,'Istruttore','Nuoto'),('bnccld',0,'Istruttore','SalaPesi'),('ccc',1,'Medico','SalaPesi'),('ddd',2,'Medico','Zumba'),('eee',3,'Istruttore','SalaPesi'),('eee',5,'Medico','SalaCardio'),('fff',6,'Istruttore','Box'),('fff',9,'Istruttore','Atletica');
/*!40000 ALTER TABLE `impiego` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integratore`
--

DROP TABLE IF EXISTS `integratore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integratore` (
  `NomeCommerciale` varchar(45) NOT NULL,
  `Sostanza` varchar(45) DEFAULT NULL,
  `NumeroPezzi` int(11) DEFAULT NULL,
  `QuantitàSostanzaPezzo` int(11) DEFAULT NULL,
  `Forma` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`NomeCommerciale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integratore`
--

LOCK TABLES `integratore` WRITE;
/*!40000 ALTER TABLE `integratore` DISABLE KEYS */;
INSERT INTO `integratore` VALUES ('Fyron Body','Magnesio',30,3,'Capsule'),('Polase','Potassio',30,9,'Bustine'),('Prozis ','Leucina',50,25,'Barrette'),('ScitecNutrition','Calcio',1,2350,'Polvere'),('Supradyn','Polifenolo',50,12,'Compresse'),('Sustenium','Creatina',22,8,'Bustine');
/*!40000 ALTER TABLE `integratore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interessi`
--

DROP TABLE IF EXISTS `interessi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interessi` (
  `UserName` varchar(45) NOT NULL,
  `Interessi` varchar(45) NOT NULL,
  PRIMARY KEY (`UserName`,`Interessi`),
  CONSTRAINT `FK_profilo10` FOREIGN KEY (`UserName`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interessi`
--

LOCK TABLES `interessi` WRITE;
/*!40000 ALTER TABLE `interessi` DISABLE KEYS */;
INSERT INTO `interessi` VALUES ('0aaa','Alimentazione'),('0aaa','Integratori'),('0aaa','Macchinari'),('0aaa','Nuoto'),('0bbb','Integratori'),('0bbb','Macchinari'),('0ccc','Integratori'),('0ccc','Nuoto'),('0ddd','Nuoto'),('0eee','Integratori'),('0fff','Alimentazione'),('0ggg','Alimentazione');
/*!40000 ALTER TABLE `interessi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iscrizione`
--

DROP TABLE IF EXISTS `iscrizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iscrizione` (
  `CodiceCliente` varchar(45) NOT NULL,
  `CodiceCorso` int(11) NOT NULL,
  PRIMARY KEY (`CodiceCliente`,`CodiceCorso`),
  KEY `FK1_cor1_idx` (`CodiceCorso`),
  CONSTRAINT `FK1_cli1` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK1_cor1` FOREIGN KEY (`CodiceCorso`) REFERENCES `corso` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iscrizione`
--

LOCK TABLES `iscrizione` WRITE;
/*!40000 ALTER TABLE `iscrizione` DISABLE KEYS */;
INSERT INTO `iscrizione` VALUES ('0iii',0),('0qqq',0),('0aaa',2),('0bbb',2),('0lll',5);
/*!40000 ALTER TABLE `iscrizione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `magazzino`
--

DROP TABLE IF EXISTS `magazzino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `magazzino` (
  `CodiceCentro` int(11) NOT NULL,
  `NomeIntegratore` varchar(45) NOT NULL,
  `DataScadenza` date NOT NULL,
  `Quantita` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceCentro`,`NomeIntegratore`,`DataScadenza`),
  KEY `FK4_integrat4_idx` (`NomeIntegratore`),
  CONSTRAINT `FK10_centro10` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK4_integrat4` FOREIGN KEY (`NomeIntegratore`) REFERENCES `integratore` (`NomeCommerciale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `magazzino`
--

LOCK TABLES `magazzino` WRITE;
/*!40000 ALTER TABLE `magazzino` DISABLE KEYS */;
INSERT INTO `magazzino` VALUES (0,'Fyron Body','2017-08-24',30),(0,'Polase','2017-08-03',10),(0,'Supradyn','2017-11-26',50),(0,'Supradyn','2017-12-24',20),(1,'Fyron Body','2017-11-26',35),(1,'Polase','2017-09-03',20),(1,'Supradyn','2017-08-24',30),(1,'Sustenium','2017-12-24',65),(2,'Fyron Body','2017-08-24',26),(2,'Polase','2017-10-30',30),(2,'Supradyn','2017-12-24',35),(2,'Sustenium','2017-08-24',45),(3,'Fyron Body','2017-08-03',35),(3,'Polase','2017-08-03',40),(3,'Supradyn','2017-08-24',25),(3,'Sustenium','2017-12-24',15),(4,'Fyron Body','2017-07-31',60),(4,'Fyron Body','2017-08-24',12),(4,'Polase','2017-08-03',10),(4,'Sustenium','2017-07-31',25),(5,'Fyron Body','2017-11-26',13),(5,'Polase','2017-11-26',10),(5,'Sustenium','2017-08-24',35),(5,'Sustenium','2017-12-24',15),(6,'Polase','2017-08-03',20),(6,'ScitecNutrition','2017-07-31',2),(6,'Supradyn','2017-08-24',45),(6,'Sustenium','2017-08-03',15),(7,'Polase','2017-11-26',30),(7,'ScitecNutrition','2017-08-03',55),(7,'Supradyn','2017-11-26',20),(7,'Sustenium','2017-12-24',25),(8,'Polase','2017-12-24',40),(8,'ScitecNutrition','2017-08-24',36),(8,'Supradyn','2017-07-31',30),(8,'Sustenium','2017-08-24',36),(9,'Polase','2017-08-24',10),(9,'ScitecNutrition','2017-08-03',25),(9,'Supradyn','2017-11-26',40),(9,'Sustenium','2017-11-26',20);
/*!40000 ALTER TABLE `magazzino` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modalita`
--

DROP TABLE IF EXISTS `modalita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modalita` (
  `CodiceModalita` int(11) NOT NULL,
  `Orario` varchar(45) DEFAULT NULL,
  `SpaziAllestibili` tinyint(4) DEFAULT NULL,
  `Tipologia` varchar(45) DEFAULT NULL,
  `CostoMensile` int(11) DEFAULT NULL,
  `Multisede` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`CodiceModalita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modalita`
--

LOCK TABLES `modalita` WRITE;
/*!40000 ALTER TABLE `modalita` DISABLE KEYS */;
INSERT INTO `modalita` VALUES (0,'08/24',1,'Platinum',60,1),(1,'08/12-14/22',0,'Gold',45,0),(2,'14/23',0,'Silver',25,0),(3,'08/14',0,'Silver',25,0),(4,'08/23',0,'Platinum',60,0),(5,'08/12',0,'Silver',30,0),(6,'08/20',1,'Gold',55,1),(7,'08/20',0,'Gold',50,1),(9,'08/24',0,'Platinum',60,1);
/*!40000 ALTER TABLE `modalita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitoraggio`
--

DROP TABLE IF EXISTS `monitoraggio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoraggio` (
  `CodiceScheda` int(11) NOT NULL,
  `CodiceEsercizio` varchar(45) NOT NULL,
  `Accesso` date NOT NULL,
  `GiornoSettimana` int(11) DEFAULT NULL,
  `SerieEffettive` int(11) DEFAULT NULL,
  `RipetizioniEffettive` int(11) DEFAULT NULL,
  `TempoEffettivo` int(11) DEFAULT NULL,
  `PesoEffettivo` int(11) DEFAULT NULL,
  `IntensitaEffettiva` int(11) DEFAULT NULL,
  `TempoRecuperoEffettivo` int(11) DEFAULT NULL,
  `Centro` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`,`CodiceEsercizio`,`Accesso`),
  KEY `FK_acc4_idx` (`Accesso`),
  CONSTRAINT `FK_mon1` FOREIGN KEY (`CodiceScheda`, `CodiceEsercizio`) REFERENCES `workoutroutine` (`CodiceScheda`, `CodiceEsercizio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitoraggio`
--

LOCK TABLES `monitoraggio` WRITE;
/*!40000 ALTER TABLE `monitoraggio` DISABLE KEYS */;
INSERT INTO `monitoraggio` VALUES (0,'AddPower','2017-06-03',6,3,20,30,40,NULL,1,0),(0,'AddStandard','2017-06-05',2,3,20,40,50,NULL,10,2),(0,'DorsoStandard','2017-06-07',1,3,20,50,40,NULL,3,3),(1,'AddPower','2017-06-03',5,3,20,30,60,NULL,10,0),(1,'EllitticaStandard','2017-06-03',2,1,NULL,35,NULL,3,1,2),(1,'PressaOk','2017-06-07',5,3,20,20,50,NULL,2,3),(2,'AddPower','2017-06-03',8,3,20,21,60,NULL,20,3),(2,'CorsaCardio','2017-06-03',5,1,NULL,20,NULL,1,2,3),(2,'Squat100','2017-06-07',9,3,20,23,50,NULL,1,3),(3,'CycletteStandard','2017-06-03',6,1,NULL,26,NULL,2,15,4),(3,'EllitticaStandard','2017-06-03',5,1,NULL,21,NULL,2,3,4),(3,'Squat100','2017-06-07',8,3,20,28,30,NULL,20,4),(4,'EllitticaStandard','2017-06-03',5,1,NULL,26,NULL,3,5,5),(4,'Petto1','2017-06-03',4,3,10,23,30,NULL,10,5),(4,'Squat100','2017-06-07',2,3,10,21,50,NULL,5,5),(5,'CycletteStandard','2017-06-03',5,1,NULL,50,NULL,2,30,6),(5,'Petto1','2017-06-03',2,3,20,60,20,NULL,2,6),(5,'Squat100','2017-06-07',3,3,20,30,20,NULL,1,6);
/*!40000 ALTER TABLE `monitoraggio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `numerocorsipersala`
--

DROP TABLE IF EXISTS `numerocorsipersala`;
/*!50001 DROP VIEW IF EXISTS `numerocorsipersala`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `numerocorsipersala` AS SELECT 
 1 AS `CodiceSala`,
 1 AS `NumeroCorsi`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordine` (
  `CodiceInterno` int(11) NOT NULL,
  `CodiceEsterno` int(11) NOT NULL,
  `CodiceFornitore` varchar(45) DEFAULT NULL,
  `CodiceCentro` int(11) DEFAULT NULL,
  `DataEvasione` date DEFAULT NULL,
  `Stato` varchar(45) DEFAULT NULL,
  `DataConsegna` date DEFAULT NULL,
  PRIMARY KEY (`CodiceInterno`,`CodiceEsterno`),
  KEY `FK1_forni1_idx` (`CodiceFornitore`),
  KEY `FK8_centro8_idx` (`CodiceCentro`),
  CONSTRAINT `FK1_forni1` FOREIGN KEY (`CodiceFornitore`) REFERENCES `fornitore` (`Nome`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK8_centro8` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (0,9,'Dimagra',0,'2017-01-01','Incompleto',NULL),(1,8,'Integrators',1,'2017-01-02','Evaso',NULL),(2,7,'PowerUp',2,'2017-01-02','Consegnato','2017-02-02'),(3,6,'PowerUp',3,'2017-02-04','Consegnato','2017-03-01'),(4,5,'Dimagra',4,'2017-06-08','Consegnato','2017-06-20'),(5,4,'Integrators',5,'2017-04-03','Consegnato','2017-04-20'),(6,3,'Vitamins',6,'2017-01-01','Evaso',NULL),(7,2,'Vitamins',7,'2017-01-02','Incompleto',NULL),(8,1,'Dimagra',8,'2017-02-03','Consegnato','2017-02-20'),(9,0,'Integrators',9,'2017-07-09','Consegnato','2017-02-21');
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagamento` (
  `CodiceContratto` varchar(45) NOT NULL,
  `NumeroRata` int(11) NOT NULL,
  `IstitutoFinanziario` varchar(45) DEFAULT NULL,
  `TassoInteresse` double DEFAULT NULL,
  `DataScadenza` date DEFAULT NULL,
  `Importo` int(11) DEFAULT NULL,
  `Stato` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceContratto`,`NumeroRata`),
  CONSTRAINT `FK5_contrat5` FOREIGN KEY (`CodiceContratto`) REFERENCES `contratto` (`CodiceCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
INSERT INTO `pagamento` VALUES ('0bbb',1,'Mediolanum',2.63,'2016-09-03',5,'Pagato'),('0bbb',2,'Mediolanum',2.63,'2016-10-03',5,'Pagato'),('0bbb',3,'Mediolanum',2.63,'2016-11-03',5,'Pagato'),('0bbb',4,'Mediolanum',2.63,'2016-12-03',5,'Pagato'),('0bbb',5,'Mediolanum',2.63,'2017-01-03',5,'Pagato'),('0bbb',6,'Mediolanum',2.63,'2017-02-03',5,'Pagato'),('0bbb',7,'Mediolanum',2.63,'2017-03-03',5,'Scaduto'),('0bbb',8,'Mediolanum',2.63,'2017-04-03',5,'Pagato'),('0bbb',9,'Mediolanum',2.63,'2017-05-03',5,'Pagato'),('0ccc',1,'SanPaolo',2,'2017-01-03',3,'Pagato'),('0ccc',2,'SanPaolo',2,'2017-01-03',3,'Pagato'),('0ccc',3,'SanPaolo',2,'2017-02-03',3,'Pagato'),('0ccc',4,'SanPaolo',2,'2017-03-03',3,'Pagato'),('0ccc',5,'SanPaolo',2,'2017-04-03',3,'Pagato'),('0ccc',6,'SanPaolo',2,'2017-05-03',3,'Pagato'),('0ccc',7,'SanPaolo',2,'2017-06-03',3,'Scaduto'),('0ccc',8,'SanPaolo',2,'2017-07-03',3,'Scaduto'),('0ccc',9,'SanPaolo',2,'2017-08-03',3,'NonAncoraDovuto'),('0ggg',1,'SanPaolo',2.37,'2017-03-03',2,'Pagato'),('0ggg',2,'SanPaolo',2.37,'2017-04-03',2,'Pagato'),('0ggg',3,'SanPaolo',2.37,'2017-05-03',2,'Pagato'),('0ggg',4,'SanPaolo',2.37,'2017-06-03',2,'Pagato'),('0ggg',5,'SanPaolo',2.37,'2017-07-03',2,'NonAncoraDovuto'),('0ggg',6,'SanPaolo',2.37,'2017-08-03',2,'NonAncoraDovuto'),('0ggg',7,'SanPaolo',2.37,'2017-09-03',2,'NonAncoraDovuto'),('0ggg',8,'SanPaolo',2.37,'2017-10-03',2,'NonAncoraDovuto'),('0ggg',9,'SanPaolo',2.37,'2017-11-03',2,'NonAncoraDovuto');
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partecipanti`
--

DROP TABLE IF EXISTS `partecipanti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partecipanti` (
  `Utente` varchar(45) NOT NULL,
  `CodiceSfida` int(11) NOT NULL,
  `SchedaAllenamento` int(11) DEFAULT NULL,
  `SchedaAlimentazione` int(11) DEFAULT NULL,
  `DataInizio` date DEFAULT NULL,
  `DataFine` date DEFAULT NULL,
  PRIMARY KEY (`Utente`,`CodiceSfida`),
  KEY `FK2_allen2_idx` (`SchedaAllenamento`),
  KEY `FK3_alim3_idx` (`SchedaAlimentazione`),
  KEY `FK1_sfida1_idx` (`CodiceSfida`),
  CONSTRAINT `FK1_sfida1` FOREIGN KEY (`CodiceSfida`) REFERENCES `sfida` (`CodiceSfida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_allen2` FOREIGN KEY (`SchedaAllenamento`) REFERENCES `schedaallenamento` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3_alim3` FOREIGN KEY (`SchedaAlimentazione`) REFERENCES `schedaalimentazione` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3_profilo3` FOREIGN KEY (`Utente`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partecipanti`
--

LOCK TABLES `partecipanti` WRITE;
/*!40000 ALTER TABLE `partecipanti` DISABLE KEYS */;
INSERT INTO `partecipanti` VALUES ('0aaa',0,NULL,0,'2017-06-08','2017-06-18'),('0bbb',0,NULL,1,'2017-06-08','2017-06-20'),('0bbb',1,NULL,1,'2017-09-09','2017-09-19'),('0ccc',1,NULL,2,'2017-09-09','2017-09-19'),('0ddd',1,NULL,3,'2017-09-09','2017-09-19'),('0eee',0,NULL,4,'2017-06-08','2017-06-18'),('0fff',0,NULL,5,'2017-06-08','2017-06-18'),('0fff',1,NULL,5,'2017-09-09','2017-09-22'),('0fff',2,NULL,5,'2017-07-11','2017-07-21'),('0hhh',2,NULL,7,'2017-07-11','2017-07-21'),('0lll',2,NULL,9,'2017-07-11','2017-07-21'),('0ppp',2,NULL,13,'2017-07-11','2017-07-20');
/*!40000 ALTER TABLE `partecipanti` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER BloccaPartecipante BEFORE INSERT ON Partecipanti FOR EACH ROW
BEGIN
	DECLARE Controlla INTEGER DEFAULT 0;
    SET Controlla =(SELECT COUNT(*)
					FROM Sfida S
					WHERE S.CodiceSfida = NEW.CodiceSfida
						AND S.DataFine <> NULL
					);
	IF Controlla <> 0
    THEN SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT="La Sfida è già finita, non puoi effettuare una nuova iscrizione";
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `piscina`
--

DROP TABLE IF EXISTS `piscina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `piscina` (
  `CodicePiscina` int(11) NOT NULL,
  `CodiceCentro` int(11) NOT NULL,
  `IE` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`CodicePiscina`),
  KEY `FK_CodCentro_idx` (`CodiceCentro`),
  CONSTRAINT `FK_CodCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piscina`
--

LOCK TABLES `piscina` WRITE;
/*!40000 ALTER TABLE `piscina` DISABLE KEYS */;
INSERT INTO `piscina` VALUES (0,0,1),(1,0,0),(2,1,0),(3,6,1),(4,7,1),(5,9,0),(6,2,1),(7,3,0),(8,6,1);
/*!40000 ALTER TABLE `piscina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `UserName` varchar(45) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Testo` text,
  `Area` varchar(45) DEFAULT NULL,
  `Thread` varchar(45) DEFAULT NULL,
  `Link` varchar(100) DEFAULT NULL,
  `Risposta` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`UserName`,`TimeStamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES ('0aaa','2017-06-06 21:59:59','Ciao mi chiamo a','Presentazioni','PrimoSaluto','www.smartfiteness.com/presentazioni/PrimoSaluto',0),('0bbb','2017-05-03 13:06:02','Ciao mi chiamo b','Workout','ConsiglioEs','www.smartfitness.com/WorkOut/ConsiglioEsercizio',0),('0ccc','2017-03-09 07:09:10','Ciao mi chiamo c','Macchinari','Usura','www.smartfitness.com/Macchinari/Usura',0),('0ddd','2017-02-09 03:30:00','Ciao mi chiamo d','Chiacchierata','Barzellette','www.smartfitness.com/Chiacchierata/Barzellette',0),('0eee','2017-06-07 21:59:59','Ti rispondo e','Presentazioni','PrimoSaluto','www.smartfiteness.com/presentazioni/PrimoSaluto',1),('0fff','2017-06-08 21:59:59','Ti rispondo f','Presentazioni','Presentazioni','www.smartfiteness.com/presentazioni/PrimoSaluto',1),('0ggg','2017-05-03 13:08:02','Ti rispondo a','Workout','ConsiglioEs','www.smartfitness.com/WorkOut/ConsiglioEsercizio',1),('0hhh','2017-05-03 13:09:02','Ti rispondo','Workout','ConsiglioEs','www.smartfitness.com/WorkOut/ConsiglioEsercizio',1),('0iii','2017-05-03 13:10:02','Ti rispondo','Workout','ConsiglioEs','www.smartfitness.com/WorkOut/ConsiglioEsercizio',1);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `potenziamento`
--

DROP TABLE IF EXISTS `potenziamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `potenziamento` (
  `CodiceContratto` varchar(45) NOT NULL,
  `MuscoliTarget` varchar(45) NOT NULL,
  `Livello` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceContratto`,`MuscoliTarget`),
  CONSTRAINT `FK3_contrat3` FOREIGN KEY (`CodiceContratto`) REFERENCES `contratto` (`CodiceCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `potenziamento`
--

LOCK TABLES `potenziamento` WRITE;
/*!40000 ALTER TABLE `potenziamento` DISABLE KEYS */;
INSERT INTO `potenziamento` VALUES ('0aaa','Addominali','Moderato'),('0aaa','Braccia','Moderato'),('0aaa','Dorso','Lieve'),('0aaa','Gambe','Elevato'),('0aaa','Petto','Lieve'),('0aaa','Spalle','Moderato'),('0bbb','Addominali','Lieve'),('0bbb','Braccia','Lieve'),('0bbb','Dorso','Elevato'),('0bbb','Gambe','Elevato'),('0bbb','Petto','Elevato'),('0bbb','Spalle','Moderato'),('0ccc','Addominali','Moderato'),('0ccc','Braccia','Lieve'),('0ccc','Dorso','Elevato'),('0ccc','Gambe','Elevato'),('0ccc','Petto','Elevato'),('0ccc','Spalle','Moderato'),('0ooo','Addominali','Moderato'),('0ooo','Braccia','Lieve'),('0ooo','Dorso','Elevato'),('0ooo','Gambe','Elevato'),('0ooo','Petto','Lieve'),('0ooo','Spalle','Elevato');
/*!40000 ALTER TABLE `potenziamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profilo`
--

DROP TABLE IF EXISTS `profilo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profilo` (
  `CodiceUtente` varchar(45) NOT NULL,
  `UserName` varchar(45) NOT NULL,
  `Password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceUtente`,`UserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profilo`
--

LOCK TABLES `profilo` WRITE;
/*!40000 ALTER TABLE `profilo` DISABLE KEYS */;
INSERT INTO `profilo` VALUES ('0aaa','social1','a'),('0bbb','social2','b'),('0ccc','social3','c'),('0ddd','social4','d'),('0eee','social5','e'),('0fff','social6','f'),('0ggg','social7','g'),('0hhh','social8','h'),('0iii','social9','i'),('0lll','social10','l'),('0mmm','social11','m'),('0nnn','social12','n'),('0ooo','social13','o'),('0ppp','social14','p'),('0qqq','social15','q');
/*!40000 ALTER TABLE `profilo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riepilogoordine`
--

DROP TABLE IF EXISTS `riepilogoordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `riepilogoordine` (
  `CodiceInterno` int(11) NOT NULL,
  `CodiceEsterno` int(11) NOT NULL,
  `NomeIntegratore` varchar(45) NOT NULL,
  `Quantita` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceInterno`,`CodiceEsterno`,`NomeIntegratore`),
  KEY `FK2_integra2_idx` (`NomeIntegratore`),
  CONSTRAINT `FK2_integra2` FOREIGN KEY (`NomeIntegratore`) REFERENCES `integratore` (`NomeCommerciale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Codice10` FOREIGN KEY (`CodiceInterno`, `CodiceEsterno`) REFERENCES `ordine` (`CodiceInterno`, `CodiceEsterno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riepilogoordine`
--

LOCK TABLES `riepilogoordine` WRITE;
/*!40000 ALTER TABLE `riepilogoordine` DISABLE KEYS */;
INSERT INTO `riepilogoordine` VALUES (0,9,'Fyron Body','5'),(1,8,'Polase','10'),(2,7,'ScitecNutrition','15'),(3,6,'Supradyn','20'),(4,5,'Prozis ','5'),(5,4,'Polase','10'),(6,3,'Fyron Body','15'),(7,2,'Prozis ','20'),(8,1,'Sustenium','30'),(9,0,'ScitecNutrition','10');
/*!40000 ALTER TABLE `riepilogoordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sala`
--

DROP TABLE IF EXISTS `sala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sala` (
  `CodiceSala` int(11) NOT NULL,
  `CodiceCentro` int(11) NOT NULL,
  `Responsabile` varchar(45) DEFAULT NULL,
  `TotaleCorsi` int(11) DEFAULT '0',
  PRIMARY KEY (`CodiceSala`),
  KEY `FK_CodiCentro_idx` (`CodiceCentro`),
  KEY `FK_Dip_idx` (`Responsabile`),
  CONSTRAINT `FK_CodiCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala`
--

LOCK TABLES `sala` WRITE;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
INSERT INTO `sala` VALUES (0,0,'bnccld',0),(1,0,'aaa',0),(2,1,'bbb',0),(3,1,'ccc',1),(4,2,'ddd',1),(5,5,'eee',1),(6,6,'fff',0),(7,9,'aaa',1),(8,7,'bbb',0),(9,9,'fff',1),(10,0,'bnccld',0),(11,0,'aaa',0),(12,1,'bbb',0),(13,1,'ccc',0),(14,2,'ddd',0),(15,2,'ddd',0),(16,2,'ddd',0),(17,3,'ggg',0),(18,3,'ggg',0),(19,3,'ggg',0),(20,4,'hhh',0),(21,4,'hhh',0),(22,4,'hhh',0),(23,4,'hhh',0),(24,5,'eee',0),(25,5,'eee',0),(26,5,'eee',0),(27,6,'fff',0),(28,6,'fff',0),(29,7,'bbb',0),(30,8,'iii',0),(31,8,'iii',0),(32,3,'ggg',0),(33,3,'ggg',0),(34,6,'fff',1),(35,6,'fff',0),(36,6,'fff',0),(37,6,'fff',0),(38,7,'bbb',0),(39,7,'bbb',0);
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedaalimentazione`
--

DROP TABLE IF EXISTS `schedaalimentazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedaalimentazione` (
  `CodiceScheda` int(11) NOT NULL,
  `CodFisCliente` varchar(45) DEFAULT NULL,
  `CodFisMedico` varchar(45) DEFAULT NULL,
  `DataInizio` date DEFAULT NULL,
  `CodiceDieta` int(11) DEFAULT NULL,
  `DataFine` date DEFAULT NULL,
  `IntervalloVisite` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedaalimentazione`
--

LOCK TABLES `schedaalimentazione` WRITE;
/*!40000 ALTER TABLE `schedaalimentazione` DISABLE KEYS */;
INSERT INTO `schedaalimentazione` VALUES (0,'0aaa','1','2017-07-01',0,'2017-08-01',2),(1,'0bbb','1','2017-07-01',1,'2017-08-01',3),(2,'0ccc','1','2017-07-01',2,'2017-08-01',2),(3,'0ddd','1','2017-07-01',3,'2017-08-01',3),(4,'0eee','1','2017-07-01',4,'2017-08-01',2),(5,'0fff','2','2017-07-01',5,'2017-08-01',1),(6,'0ggg','2','2017-07-01',6,'2017-08-01',2),(7,'0hhh','2','2017-07-01',7,'2017-08-01',3),(8,'0iii','2','2017-07-01',8,'2017-08-01',2),(9,'0lll','2','2017-07-01',9,'2017-08-01',1),(10,'0mmm','2','2017-07-01',10,'2017-08-01',2),(11,'0nnn','5','2017-07-01',11,'2017-08-01',3),(12,'0ooo','5','2017-07-01',12,'2017-08-01',2),(13,'0ppp','5','2017-07-01',13,'2017-08-01',1),(14,'0qqq','5','2017-07-01',14,'2017-08-01',2);
/*!40000 ALTER TABLE `schedaalimentazione` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER VerificaSettimana BEFORE INSERT ON SchedaAlimentazione FOR EACH ROW
 BEGIN
	DECLARE verifica INTEGER DEFAULT 0;
    
    SET verifica = ( SELECT COUNT(*)
					 FROM 
						SchedaAllenamento Sa
                     WHERE 
						Sa.DataFine IS NULL
                        AND Sa.CodFisCliente=NEW.CodFisCliente
                        AND Sa.DataInizio < NEW.DataInizio - INTERVAL 1 WEEK
					);
                    
	IF verifica <> 0
    THEN SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Non è ancora passata una settimana dall"inserimento della SchedaAllenamento, riprovare l"inserimento
                        della SchedaAlimentazione tra qualche giorno';
	ELSE 
    UPDATE SchedaAlimentazione Sa
	SET Sa.DataFine = CURRENT_DATE()
	WHERE
		Sa.CodiceCliente = NEW.CodFisCliente
		AND Sa.DataFine IS NULL;
	END IF;
	
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `schedaallenamento`
--

DROP TABLE IF EXISTS `schedaallenamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedaallenamento` (
  `CodiceScheda` int(11) NOT NULL,
  `CodiceIstruttore` varchar(45) DEFAULT NULL,
  `CodiceCliente` varchar(45) DEFAULT NULL,
  `DataInizio` date DEFAULT NULL,
  `DataFine` date DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`),
  KEY `FK4_cli4_idx` (`CodiceCliente`),
  KEY `FK5_dip5_idx` (`CodiceIstruttore`),
  CONSTRAINT `FK4_cli4` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK5_dip5` FOREIGN KEY (`CodiceIstruttore`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedaallenamento`
--

LOCK TABLES `schedaallenamento` WRITE;
/*!40000 ALTER TABLE `schedaallenamento` DISABLE KEYS */;
INSERT INTO `schedaallenamento` VALUES (0,'aaa','0aaa','2017-06-24','2017-07-24'),(1,'ddd','0bbb','2017-06-24','2017-07-24'),(2,'eee','0ccc','2017-06-24','2017-07-24'),(4,'eee','0eee','2017-06-24','2017-07-24'),(5,'fff','0fff','2017-06-24','2017-07-24'),(6,'bbb','0ggg','2017-06-24','2017-07-24'),(7,'eee','0hhh','2017-06-24','2017-07-24'),(8,'aaa','0iii','2017-06-24','2017-07-24'),(9,'eee','0lll','2017-06-24','2017-07-24'),(10,'aaa','0mmm','2017-06-24','2017-07-24'),(11,'eee','0nnn','2017-06-24','2017-07-24'),(12,'eee','0ooo','2017-06-24','2017-07-24'),(13,'bbb','0ppp','2017-06-24','2017-07-24'),(14,'aaa','0qqq','2017-06-24','2017-07-24');
/*!40000 ALTER TABLE `schedaallenamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sfida`
--

DROP TABLE IF EXISTS `sfida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sfida` (
  `CodiceSfida` int(11) NOT NULL,
  `Proponente` varchar(45) DEFAULT NULL,
  `DataLancio` date DEFAULT NULL,
  `DataInizio` date DEFAULT NULL,
  `DataFine` date DEFAULT NULL,
  `Scopo` varchar(45) DEFAULT NULL,
  `Thread` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceSfida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sfida`
--

LOCK TABLES `sfida` WRITE;
/*!40000 ALTER TABLE `sfida` DISABLE KEYS */;
INSERT INTO `sfida` VALUES (0,'0aaa','2017-06-06','2017-06-08','2017-06-18','Dimagrimento','Sfida0'),(1,'0bbb','2017-07-07','2017-09-09','2017-09-19','Addominali','Sfida1'),(2,'0fff','2017-07-09','2017-07-11','2017-07-21','Resistenza','Sfida3');
/*!40000 ALTER TABLE `sfida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sforzo`
--

DROP TABLE IF EXISTS `sforzo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sforzo` (
  `Utente` varchar(45) NOT NULL,
  `Data` date NOT NULL,
  `Sfida` int(11) NOT NULL,
  `Valutazione` int(11) DEFAULT NULL,
  PRIMARY KEY (`Utente`,`Data`,`Sfida`),
  CONSTRAINT `FK_partecip1` FOREIGN KEY (`Utente`) REFERENCES `partecipanti` (`Utente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sforzo`
--

LOCK TABLES `sforzo` WRITE;
/*!40000 ALTER TABLE `sforzo` DISABLE KEYS */;
INSERT INTO `sforzo` VALUES ('0aaa','2017-06-08',0,1),('0aaa','2017-06-09',0,2),('0aaa','2017-06-10',0,1),('0bbb','2017-06-08',0,2),('0bbb','2017-06-09',0,2),('0bbb','2017-06-10',0,1),('0bbb','2017-09-09',1,2),('0bbb','2017-09-10',1,2),('0bbb','2017-09-11',1,1),('0ccc','2017-09-09',1,3),('0ccc','2017-09-10',1,2),('0ccc','2017-09-11',1,1),('0ddd','2017-09-09',1,3),('0ddd','2017-09-10',1,2),('0ddd','2017-09-11',1,1),('0eee','2017-06-08',0,3),('0eee','2017-06-09',0,2),('0eee','2017-06-10',0,1),('0fff','2017-06-08',0,3),('0fff','2017-06-09',0,2),('0fff','2017-06-10',0,3),('0fff','2017-07-11',2,2),('0fff','2017-07-12',2,3),('0fff','2017-07-13',2,2),('0fff','2017-09-09',1,2),('0fff','2017-09-10',1,2),('0fff','2017-09-11',1,2),('0hhh','2017-07-11',2,1),('0hhh','2017-07-12',2,2),('0hhh','2017-07-13',2,3),('0lll','2017-07-11',2,2),('0lll','2017-07-12',2,1),('0lll','2017-07-13',2,2),('0ppp','2017-07-11',2,3),('0ppp','2017-07-12',2,2),('0ppp','2017-07-13',2,1);
/*!40000 ALTER TABLE `sforzo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER BloccaSforzo BEFORE INSERT ON Sforzo FOR EACH ROW 
BEGIN
	DECLARE Controlla INTEGER DEFAULT 0;
    SET Controlla = (SELECT COUNT(*)
					 FROM 
						Sfida S
					 WHERE 
							(S.CodiceSfida = NEW.Sfida
							AND S.DataFine <> NULL)
                            OR EXISTS ( SELECT *
										FROM Sforzo Sf
                                        WHERE 
											  Sf.Utente=NEW.Utente
											  AND S.CodiceSfida=Sf.Sfida=NEW.Sfida
                                              AND Sf.Data=NEW.Data
										)
					);
	IF Controlla<>0
    THEN SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='Impossibile aggiungere un report di sforzo, 
					   controllare che la sfida non sia finita o che non si abbia già inserito il report di oggi';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `spogliatoio`
--

DROP TABLE IF EXISTS `spogliatoio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spogliatoio` (
  `CodiceSpogliatoio` int(11) NOT NULL,
  `CodiceCentro` int(11) DEFAULT NULL,
  `Capienza` int(11) DEFAULT NULL,
  `X` int(11) DEFAULT NULL,
  `Y` int(11) DEFAULT NULL,
  `PostiLiberi` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceSpogliatoio`),
  KEY `FK_CodicCentro_idx` (`CodiceCentro`),
  CONSTRAINT `FK_CodicCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spogliatoio`
--

LOCK TABLES `spogliatoio` WRITE;
/*!40000 ALTER TABLE `spogliatoio` DISABLE KEYS */;
INSERT INTO `spogliatoio` VALUES (0,0,30,0,0,NULL),(1,0,25,0,0,NULL),(2,1,26,0,0,NULL),(3,1,24,0,0,NULL),(4,2,21,0,0,NULL),(5,3,27,0,0,NULL),(6,4,28,0,0,NULL),(7,5,29,0,0,NULL),(8,5,31,0,0,NULL),(9,6,32,0,0,NULL),(10,6,33,0,0,NULL),(11,7,50,0,0,NULL),(12,8,50,0,0,NULL),(13,9,60,0,0,NULL),(14,9,41,0,0,NULL),(15,7,26,0,0,NULL);
/*!40000 ALTER TABLE `spogliatoio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statofisico`
--

DROP TABLE IF EXISTS `statofisico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statofisico` (
  `CodiceScheda` int(11) NOT NULL,
  `CodiceFiscale` varchar(45) NOT NULL,
  `DataScheda` date DEFAULT NULL,
  `Altezza` int(11) DEFAULT NULL,
  `Peso` int(11) DEFAULT NULL,
  `PercentualeMassaMagra` int(100) DEFAULT NULL,
  `PercentualeMassaGrassa` int(100) DEFAULT NULL,
  `PercentualeAcquaTot` int(100) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`,`CodiceFiscale`),
  KEY `CodiceFiscale_idx` (`CodiceFiscale`),
  CONSTRAINT `CodiceFiscale` FOREIGN KEY (`CodiceFiscale`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statofisico`
--

LOCK TABLES `statofisico` WRITE;
/*!40000 ALTER TABLE `statofisico` DISABLE KEYS */;
INSERT INTO `statofisico` VALUES (0,'0aaa','2016-10-11',182,66,14,13,73),(1,'0bbb','2016-12-03',170,70,13,15,72),(2,'0ccc','2016-08-06',195,96,16,20,64),(3,'0ddd','2017-01-03',168,78,10,16,74),(4,'0eee','2016-10-23',175,75,16,12,72),(5,'0fff','2016-07-12',153,74,17,18,65),(6,'0ggg','2017-02-03',186,73,13,15,72),(7,'0hhh','2017-05-29',188,71,12,12,76),(8,'0iii','2017-06-14',192,72,10,10,80),(9,'0lll','2016-11-06',200,80,15,9,76),(10,'0mmm','2017-03-04',166,86,14,18,32),(11,'0nnn','2016-08-05',174,85,17,14,69),(12,'0ooo','2016-09-25',179,84,12,12,76),(13,'0ppp','2017-03-06',178,56,15,15,70),(14,'0qqq','2017-05-30',180,54,16,16,68);
/*!40000 ALTER TABLE `statofisico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggerimento`
--

DROP TABLE IF EXISTS `suggerimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suggerimento` (
  `Utente` varchar(45) NOT NULL,
  `Interesse` varchar(45) NOT NULL,
  `NonAmico` varchar(45) DEFAULT NULL,
  KEY `FK_profilo11_idx` (`NonAmico`),
  KEY `FK_interesse5_idx` (`Utente`,`Interesse`),
  CONSTRAINT `FK_interesse5` FOREIGN KEY (`Utente`, `Interesse`) REFERENCES `interessi` (`UserName`, `Interessi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_profilo11` FOREIGN KEY (`NonAmico`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggerimento`
--

LOCK TABLES `suggerimento` WRITE;
/*!40000 ALTER TABLE `suggerimento` DISABLE KEYS */;
INSERT INTO `suggerimento` VALUES ('0ccc','Integratori','0bbb'),('0fff','Alimentazione','0ggg'),('0aaa','Nuoto','0ccc'),('0ccc','Integratori','0eee'),('0aaa','Alimentazione ','0fff'),('0aaa','Alimentazione','0ggg');
/*!40000 ALTER TABLE `suggerimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transazione`
--

DROP TABLE IF EXISTS `transazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transazione` (
  `CodiceMagazzino` int(11) NOT NULL,
  `CodiceCliente` varchar(45) NOT NULL,
  `Data` date NOT NULL,
  `NomeIntegratore` varchar(45) DEFAULT NULL,
  `QuantitaAcquistata` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceMagazzino`,`CodiceCliente`,`Data`),
  KEY `FK7_clie7_idx` (`CodiceCliente`),
  KEY `FK1_integ1_idx` (`NomeIntegratore`),
  CONSTRAINT `FK1_integ1` FOREIGN KEY (`NomeIntegratore`) REFERENCES `integratore` (`NomeCommerciale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK6_centro6` FOREIGN KEY (`CodiceMagazzino`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK7_clie7` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transazione`
--

LOCK TABLES `transazione` WRITE;
/*!40000 ALTER TABLE `transazione` DISABLE KEYS */;
INSERT INTO `transazione` VALUES (0,'0aaa','2017-06-23','Polase','2'),(2,'0bbb','2017-07-10','Fyron Body','3'),(4,'0ccc','2017-06-25','Sustenium','3'),(5,'0ddd','2017-02-28','Sustenium','2'),(5,'0eee','2017-05-21','Polase','4');
/*!40000 ALTER TABLE `transazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnazione`
--

DROP TABLE IF EXISTS `turnazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turnazione` (
  `CodiceDipendente` varchar(45) NOT NULL,
  `Giorno` varchar(45) NOT NULL,
  `OrarioInizio` varchar(45) NOT NULL,
  `OrarioFine` varchar(45) NOT NULL,
  `CodiceCentro` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceDipendente`,`Giorno`,`OrarioInizio`,`OrarioFine`),
  CONSTRAINT `FK8_dipen8` FOREIGN KEY (`CodiceDipendente`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnazione`
--

LOCK TABLES `turnazione` WRITE;
/*!40000 ALTER TABLE `turnazione` DISABLE KEYS */;
INSERT INTO `turnazione` VALUES ('aaa','Giovedì','13','15',9),('aaa','Lunedì','20','22',9),('aaa','Martedì','9','13',9),('aaa','Venerdì','9','11',9),('bbb','Mercoldì','14','16',1),('bbb','Venerdì','17','19',1),('ddd','Martedì','11','13',2),('ddd','Venerdì','12','14',2),('eee','Lunedì','11','13',5),('eee','Martedì','10','14',5),('fff','Lunedì','14','16',2),('fff','Mercoldì','10','12',2);
/*!40000 ALTER TABLE `turnazione` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger BR_Turnazione before insert on turnazione
for each row
begin

declare errore int(11) default 0;
declare durataTurno int(11) default 0;

if new.OrarioInizio > 24 or new.OrarioFine > 24 then
	signal sqlstate '45000'
    set message_text = 'Orario inserito non valido';
end if;

if new.OrarioInizio < 0 or new.OrarioFine < 0 then
	signal sqlstate '45000'
    set message_text = 'Orario inserito non valido';
end if;



set @citta =(
				select
					c.Citta
				from
					centro c
				where
					c.Codice = new.CodiceCentro );

set errore = (
				select
					count(*)
				from
					turnazione t
                    inner join
                    centro c on t.CodiceCentro = c.Codice
				where
					t.CodiceDipendente =  new.CodiceDipendente
                    and t.Giorno = new.Giorno
                    and ((new.OrarioInizio between t.OrarioInizio and t.OrarioFine)
                    or (c.Citta = @citta)));
if errore = 0 then
	set durataTurno = (
					select
						sum(t.OrarioFine - t.OrarioInizio)
					from
						turnazione t
					where
						t.CodiceDipendente = new.CodiceDipendente
                        and t.Giorno = new.Giorno);
end if;
                    
if errore <> 0 then
	delete from turnazione
    where
		CodiceDipendente = new.CodiceDipendente
        and Giorno = new.Giorno
        and OrarioInizio = new.OrarioInizio
        and OrarioFine = new.OrarioFine;
	 signal sqlstate  '45000'
     set message_text = "Impossibile aggiungere il Turno";
else
	if durataTurno > 8 then
    	delete from turnazione
			where
				CodiceDipendente = new.CodiceDipendente
				and Giorno = new.Giorno
				and OrarioInizio = new.OrarioInizio
				and OrarioFine = new.OrarioFine;
		signal sqlstate '45000'
        set message_text = "Impossibile aggiungere il Turno";
	end if;
	
end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `votazione`
--

DROP TABLE IF EXISTS `votazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votazione` (
  `UtenteRisposta` varchar(45) NOT NULL,
  `TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UtenteValutazione` varchar(45) NOT NULL,
  `Valutazione` int(11) DEFAULT NULL,
  PRIMARY KEY (`UtenteRisposta`,`TIMESTAMP`,`UtenteValutazione`),
  CONSTRAINT `FK5_profil5` FOREIGN KEY (`UtenteRisposta`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_post1` FOREIGN KEY (`UtenteRisposta`) REFERENCES `post` (`UserName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votazione`
--

LOCK TABLES `votazione` WRITE;
/*!40000 ALTER TABLE `votazione` DISABLE KEYS */;
INSERT INTO `votazione` VALUES ('0eee','2017-06-07 21:59:59','0ccc',1),('0eee','2017-06-07 21:59:59','0fff',3),('0eee','2017-06-07 21:59:59','0iii',2),('0fff','2017-06-08 21:59:59','0ccc',5),('0fff','2017-06-08 21:59:59','0eee',2),('0fff','2017-06-08 21:59:59','0iii',4),('0ggg','2017-05-03 13:08:02','0bbb',3),('0ggg','2017-05-03 13:08:02','0eee',2),('0ggg','2017-05-03 13:08:02','0fff',5),('0hhh','2017-05-03 13:09:02','0aaa',4),('0hhh','2017-05-03 13:09:02','0fff',2),('0hhh','2017-05-03 13:09:02','0iii',1),('0iii','2017-05-03 13:10:02','0aaa',5),('0iii','2017-05-03 13:10:02','0ccc',3),('0iii','2017-05-03 13:10:02','0eee',4);
/*!40000 ALTER TABLE `votazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workoutroutine`
--

DROP TABLE IF EXISTS `workoutroutine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workoutroutine` (
  `CodiceScheda` int(11) NOT NULL,
  `CodiceEsercizio` varchar(45) NOT NULL,
  `GiornoSettimana` int(11) DEFAULT NULL,
  `Serie` int(11) DEFAULT NULL,
  `Ripetizioni` int(11) DEFAULT NULL,
  `Tempo` int(11) DEFAULT NULL,
  `Peso` int(11) DEFAULT NULL,
  `Intensita` int(11) DEFAULT NULL,
  `TempoRecupero` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`,`CodiceEsercizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workoutroutine`
--

LOCK TABLES `workoutroutine` WRITE;
/*!40000 ALTER TABLE `workoutroutine` DISABLE KEYS */;
INSERT INTO `workoutroutine` VALUES (0,'AddPower',1,3,20,30,40,NULL,1),(0,'AddStandard',3,3,20,30,50,NULL,2),(0,'DorsoStandard',5,3,20,30,40,NULL,1),(1,'AddPower',1,3,20,30,60,NULL,2),(1,'EllitticaStandard',2,1,NULL,30,NULL,3,1),(1,'PressaOk',4,3,25,30,100,NULL,2),(2,'AddPower',1,3,25,30,40,NULL,1),(2,'CorsaCardio',3,1,NULL,30,50,2,3),(2,'Squat100',5,3,10,30,70,NULL,2),(3,'CycletteStandard',1,1,NULL,30,NULL,1,1),(3,'EllitticaStandard',2,1,NULL,30,NULL,2,2),(3,'Squat100',4,3,10,30,80,NULL,3),(4,'EllitticaStandard',1,1,NULL,30,NULL,3,2),(4,'Petto1',3,3,20,30,50,NULL,1),(4,'Squat100',5,3,10,30,80,NULL,2),(5,'CycletteStandard',1,1,NULL,30,NULL,1,3),(5,'Petto1',4,2,20,30,30,NULL,2),(5,'Squat100',3,2,10,30,80,NULL,1);
/*!40000 ALTER TABLE `workoutroutine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'smartfitness'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `AggiornaTotaleCorsi` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `AggiornaTotaleCorsi` ON SCHEDULE EVERY 1 WEEK STARTS '2017-07-12 23:59:59' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	UPDATE Sala S
    SET S.TotaliCorsi=( SELECT COUNT(*)
						FROM Corso C
                        WHERE C.CodiceSala=S.CodiceSala
					   );
    
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `CancellaAccessi` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `CancellaAccessi` ON SCHEDULE EVERY 1 DAY STARTS '2017-07-12 23:59:59' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	DELETE A.*
	FROM Accesso A
	WHERE (A.Data < CURRENT_DATE - INTERVAL 3 MONTH);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `RankSfide` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `RankSfide` ON SCHEDULE EVERY 1 DAY STARTS '2017-07-06 17:48:25' ON COMPLETION NOT PRESERVE ENABLE DO begin

select
	if(@sfida = M.CodiceSfida,
		if(@durata = Durata,
			@podio,
            @podio := @podio + 1 + least(0, @durata := M.Durata)),
		@podio := 1 + least(0, @durata := M.Durata) + least(0, @sfida = M.CodiceSfida))
from
	(
	select
		p.CodiceSfida, p.Utente, datediff(p.DataFine, p.DataInizio) as Durata
	from
		partecipanti p
		natural join
		(
		select
			s.CodiceSfida
		from
			sfida s
			natural join
			partecipanti p
		where
			s.DataFine = current_date()
			and p.DataFine is not null
		group by
			p.CodiceSfida
		having
			count(p.Utente) >= 3 ) as D
		where
			p.DataFine is not null) as M,
	(select (@podio := 0)) as N
order by
	M.CodiceSfida, M.Durata ;

end */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `SfideIncomplete` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `SfideIncomplete` ON SCHEDULE EVERY 1 DAY STARTS '2017-07-06 17:48:26' ON COMPLETION NOT PRESERVE ENABLE DO begin

select
	p.CodiceSfida
from
	sfida s
    natural join
	partecipanti p
where
	p.DataFine is not null
    and s.DataFine = current_date()
group by
	p.Codicesfida
having
	count(p.Utente) < 3;
    
end */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'smartfitness'
--
/*!50003 DROP PROCEDURE IF EXISTS `CancellaDipendente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancellaDipendente`(IN _codFiscale VARCHAR(45))
BEGIN
DECLARE Contatore INT DEFAULT 0;
SET Contatore=( SELECT COUNT(*)
				FROM
					Dipendente D
				WHERE 
					D.CodiceFiscale=_codFiscale
				);
IF Contatore <> 0 
THEN
BEGIN
	/*DELETE D.*
	FROM Dipendente D
	WHERE D.CodFiscale=_codFiscale;*/
    
    -- Cancellazione di tutti i dati relativi ai corsi tenuti dal dipendente.
    DELETE I.*, C.*
	FROM
		Dipendente D1
		INNER JOIN
        Corso C ON C.Istruttore=D1.CodiceFiscale
        INNER JOIN 
        Iscizione I ON C.Codice=I.CodiceCorso
	WHERE 
		D1.CodiceFiscale=_codFiscale;
	
    -- Cancellazione del dipendente da tutta la parte social.
	DELETE P.*, I.*, A.*, Po.*,Vo.*,Ce.*, Su.*
    FROM 
		 Dipendente Di
         INNER JOIN
		 Profilo P ON  Di.CodiceFiscale=P.CodiceUtente
		 INNER JOIN
		 Interessi I ON P.UserName=I.UserName
         INNER JOIN
         Amicizia A ON I.UserName=A.Richiedente OR I.UserName=A.Destinatario
         INNER JOIN
         Post Po ON P.UserName=Po.UserName
         INNER JOIN
         Votazione Vo ON Po.UserName=UtenteValutazione OR Po.UserName=Po.UtenteRisposta
         INNER JOIN
         Cerchia Ce ON P.UserName=Ce.Utente OR P.UserName=Ce.Amico
         INNER JOIN
         Suggerimento Su ON P.UserName=Su.Utente OR P.UserName=NonAmico
	WHERE 
		Di.CodiceFiscale=_codFiscale;
	
    -- Cancellazione turni dipendente.
	DELETE T.*
    FROM Turnazione T
    WHERE T.CodiceDipendente=_codFiscale;
    
    -- Cancellazione impieghi dipendente
    DELETE I.*
    FROM Impego I
    WHERE I.CodiceFiscale=_codFiscale;
    
    -- Setto a Null gli attributi medico riferiti al dipendente.
    UPDATE SchedaAlimentazione SA
    SET SA.Medico = NULL
    WHERE SA.Medico=_codFiscale; 
    
    -- Setto a Null gli attributi responsabile riferiti al dipendente.
    UPDATE Sala S
    SET S.Responsabile= NULL
    WHERE S.Responsabile =_codFiscale;
    
    -- Setto a Null gli attributi CodiceConsulente riferiti al dipendente.
    UPDATE Contratto C
    SET C.CodiceConsulente = NULL
    WHERE C.CodiceConsulente=_codFiscale;
END;
ELSE
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT= 'Il dipendente selezionato non lavora per la azienda SmartFitness';
END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsAlimentazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsAlimentazione`(IN _CodiceScheda INT, IN _CodFisCliente VARCHAR(45), IN _CodFisMedico VARCHAR(45), IN _IntervalloVisite INT)
BEGIN
    
		INSERT INTO SchedaAlimentazione VALUES (_CodiceScheda, _CodFisCliente, _CodFisMedico, CURRENT_DATE, NULL,IntervalloVisite);

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsAllenamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsAllenamento`(
in _codiceScheda char(255), in _codiceIstruttore char(255), in _codiceCliente char(255), in _dataI date)
begin

update schedaallenamento sc
set sc.DataFine = current_date()
where
	sc.CodiceCliente = _codiceCliente
    and sc.DataFine = NULL;
    
insert into schedaallenamento values (_codiceScheda, _codiceIstruttore, _codiceCliente, _dataI, NULL);

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InserisciDieta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserisciDieta`(IN _calorie INT, IN _numeroPasti INT, IN _composizione TEXT)
BEGIN

SET @scheda = (
				SELECT
					sc.CodiceScheda
				FROM
					SchedaAlimentazione Sa
				WHERE
					Sa.CodFisCliente = _codiceCliente
                    AND Sa.DataFine = NULL );


INSERT INTO Dieta VALUES (@scheda, _calorie, _numeroPasti, _composizione);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsWorkOut` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsWorkOut`(
in _nomeEsercizio char(255), in _gg int(11), in _sr int(11), in _rep int(11), in _time int(11),
in _weight int(11), in _intesity int(11), in _tgap int(11), in _codiceCliente char(255))
begin

set @scheda = (
				select
					sc.CodiceScheda
				from
					schedaallenamento sc
				where
					sc.CodiceCliente = _codiceCliente
                    and sc.DataFine = NULL );

insert into workout values (@scheda, _nomeEsercizio, _gg, _sr, _rep, _time, _weight, _intesity, _tgap);

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReportModalita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReportModalita`(in _codFiscale varchar(255))
begin

declare numAccessi int(11) default 0;
declare numAccessiP int(11) default 0;
declare spaziAll bool default false;
declare numeroSale int(11) default 0;
declare numAccessipiu int(11) default 0;
declare numAccessipiuP int(11) default 0;

set @modalita = (
					select
						c.CodiceModalita
                    from
						contratto c
					where
						c.CodiceCliente = _codFiscale );
                        
set @tipologia = (
					select
						m.Tipologia
                    from
						modalita m
					where
						m.CodiceModalita = @modalita );
                        
select
	sum(a.MaxNumAccessi) into numAccessi
from
	accessibile a
where
	a.CodiceModalita = @modalita;

select
	sum(c1.MaxNumAccessi) into numAccessiP
from
	consente1 c1
where
	c1.CodiceModalita = @modalita;
    
set @centro = (
				select
					count(distinct a.CodiceCentro)
				from
					accessibile a
				where
					a.CodiceModalita = @modalita );
            
set @accessieffettivi = (
						select
							avg(count(*))
						from
							accesso a
						where
							a.CodiceCliente = _codFiscale
                            and a.Piscina = 0
						group by
							month(a.Data));

set @accessieffettiviP = (
						select
							avg(count(*))
						from
							accesso a
						where
							a.CodiceCliente = _codFiscale
                            and a.Piscina = 1
						group by
							month(a.Data));

set numeroSale = (
				select
					count(*)
				from
					consente1 c1
				where
					c1.CodiceModalita = @modalita );
    
select
	m.SpaziAllestibili into spaziAll
from
	modalita m
where
	m.CodiceModalita = @modalita;


if @tipologia = 'Silver' then
	set numAccessipiu = @accessieffettivi - 12;
    set numAccessipiuP = @accessieffetiviP;
	set numeroSale = numeroSale - 4*@centro;
else if @tipologia = 'Gold' then
	set numAccessipiu = @accessieffettivi - 16;
    set numAccessipiuP = @accessieffettiviP - 4;
    set numeroSale = numeroSale - 5*@centro;
else if @tipologia = 'Platinum' then
	set numAccessipiu = @accessieffetivi - 20;
    set numAccessipiuP = @accessieffetiviP - 8;
    set numeroSale = numeroSale - 6*@centro;
end if;
end if;
end if;

select
	numAccessipiu, numAccessipiu*4 as CostoAccessi,
    numAccessipiuP, numAccessipiuP*6 as CostoAccessiPiscina,
    numeroSale, spaziAll;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReportMonitoraggio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReportMonitoraggio`(IN _centro INT)
BEGIN
DECLARE TempoEccedente DOUBLE DEFAULT 0;
 
 SET TempoEccedente = (SELECT AVG(TempoRecuperoEffettivo - TempoRecupero) AS DifferenzaTempo
					   FROM 
							Monitoraggio M
                            INNER JOIN
                            Workout W ON M.CodiceScheda= W.CodiceScheda AND M.CodiceEsercizio=W.CodiceEsercizio
						WHERE 
							M.Centro=_centro
					);
-- Se la media del tempo di recupero supera i 5 minuti è possibile che la macchina sia spesso occupata e non permetta di utilizzarla.
 IF(TempoEccedente > 5 )
	THEN SELECT 'Il tempo d"attesa per utilizzare i macchinari del centro è eccessivo,
				i clienti potrebbero aver bisogno di una variazione della scheda di allenamento o di un numero maggiore di macchinari';
 ELSE 
 IF (TempoEccedente >=0 AND TempoEccedente <=5) 
	THEN SELECT 'Il tempo d"attesa per i utilizzare i macchinari è buono';
 ELSE
	SELECT 'Probabilmente i clienti non rispettano il tempo di ripresa assegnato tra un esercizio e l"altro';
END IF;
END IF;
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `numerocorsipersala`
--

/*!50001 DROP VIEW IF EXISTS `numerocorsipersala`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `numerocorsipersala` AS select `s`.`CodiceSala` AS `CodiceSala`,if((count(`c`.`Codice`) = NULL),0,count(`c`.`Codice`)) AS `NumeroCorsi` from (`sala` `s` left join `corso` `c` on((`s`.`CodiceSala` = `c`.`CodiceSala`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-09 12:09:29
