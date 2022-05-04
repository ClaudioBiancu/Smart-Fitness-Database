CREATE DATABASE  IF NOT EXISTS `smartfitness` /*!40100 DEFAULT CHARACTER SET UTF8 */;
USE `smartfitness`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: smartfitness
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES UTF8 */;
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
  `CodiceModalita` INT(11) NOT NULL,
  `CodiceCentro` INT(11) NOT NULL,
  `MaxNumeroAccessiCentro` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceModalita`,`CodiceCentro`),
  KEY `FK_CodiceCentro_idx` (`CodiceCentro`),
  CONSTRAINT `FK_CodiceCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_CodiceModalita` FOREIGN KEY (`CodiceModalita`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessibile`
--

LOCK TABLES `accessibile` WRITE;
/*!40000 ALTER TABLE `accessibile` DISABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER BR_Accessibile BEFORE INSERT ON accessibile
FOR EACH ROW
BEGIN

DECLARE multisede BOOL DEFAULT FALSE;
DECLARE quanteSedi INTEGER DEFAULT 0;

SET multisede = (
				SELECT
					m.Multisede
				FROM
					modalita m
				WHERE
					m.CodiceModalita = new.CodiceModalita );

SET quanteSedi = (
					SELECT
						COUNT(*)
                    FROM
						accessibile a
					WHERE
						a.CodiceModalita = new.CodiceModalita );
                        
IF multisede = TRUE THEN
	IF quanteSedi = 3 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Impossibile aggiungere un altro Centro';
	END IF;
ELSE
	IF quanteSedi = 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Impossibile aggiungere un altro Centro';
	END IF;
END IF;

END */;;
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
  `CodiceCliente` VARCHAR(45) NOT NULL,
  `CodiceCentro` INT(11) NOT NULL,
  `Data` DATE NOT NULL,
  `OrarioAccesso` INT(11) DEFAULT NULL,
  `OrarioUscita` INT(11) DEFAULT NULL,
  `CodiceSpogliatoio` INT(11) DEFAULT NULL,
  `Numero` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceCliente`,`CodiceCentro`,`Data`),
  KEY `FK_Spo_idx` (`Numero`,`CodiceSpogliatoio`),
  KEY `FK1_Centro1_idx` (`CodiceCentro`),
  CONSTRAINT `FK1_Centro1` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3_cli3` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Spo` FOREIGN KEY (`Numero`, `CodiceSpogliatoio`) REFERENCES `armadietto` (`CodiceArmadietto`, `CodiceSpogliatoio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accesso`
--

LOCK TABLES `accesso` WRITE;
/*!40000 ALTER TABLE `accesso` DISABLE KEYS */;
/*!40000 ALTER TABLE `accesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amicizia`
--

DROP TABLE IF EXISTS `amicizia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amicizia` (
  `Richiedente` VARCHAR(45) NOT NULL,
  `Destinatario` VARCHAR(45) NOT NULL,
  `DataRichiesta` DATE NOT NULL,
  `Stato` TINYINT(4) DEFAULT NULL,
  `DataAmicizia` DATE DEFAULT NULL,
  PRIMARY KEY (`Richiedente`,`Destinatario`,`DataRichiesta`),
  KEY `FK2_prof2_idx` (`Destinatario`),
  CONSTRAINT `FK1_prof1` FOREIGN KEY (`Richiedente`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_prof2` FOREIGN KEY (`Destinatario`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amicizia`
--

LOCK TABLES `amicizia` WRITE;
/*!40000 ALTER TABLE `amicizia` DISABLE KEYS */;
/*!40000 ALTER TABLE `amicizia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apparecchiatura`
--

DROP TABLE IF EXISTS `apparecchiatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apparecchiatura` (
  `CodiceIdentificativo` INT(11) NOT NULL,
  `NomeSala` INT(11) NOT NULL,
  `Tipologia` VARCHAR(45) NOT NULL,
  `ConsumoEnergetico` INT(11) DEFAULT '0',
  `LivelloUsura` INT(11) DEFAULT '0',
  PRIMARY KEY (`CodiceIdentificativo`),
  KEY `NomeSala_idx` (`NomeSala`),
  CONSTRAINT `NomeSala` FOREIGN KEY (`NomeSala`) REFERENCES `sala` (`CodiceSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apparecchiatura`
--

LOCK TABLES `apparecchiatura` WRITE;
/*!40000 ALTER TABLE `apparecchiatura` DISABLE KEYS */;
INSERT INTO `apparecchiatura` VALUES (0,0,'TapisRoulant',0,51);
/*!40000 ALTER TABLE `apparecchiatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armadietto`
--

DROP TABLE IF EXISTS `armadietto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armadietto` (
  `CodiceArmadietto` INT(11) NOT NULL,
  `CodiceSpogliatoio` INT(11) NOT NULL,
  `CombinazioneArmadietto` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceArmadietto`,`CodiceSpogliatoio`),
  KEY `FK_Spogliatoio_idx` (`CodiceSpogliatoio`),
  CONSTRAINT `FK_Spogliatoio` FOREIGN KEY (`CodiceSpogliatoio`) REFERENCES `spogliatoio` (`CodiceSpogliatoio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armadietto`
--

LOCK TABLES `armadietto` WRITE;
/*!40000 ALTER TABLE `armadietto` DISABLE KEYS */;
/*!40000 ALTER TABLE `armadietto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendario`
--

DROP TABLE IF EXISTS `calendario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendario` (
  `Giorno` DATE NOT NULL,
  `Corso` INT(11) NOT NULL,
  `OrarioInizio` INT(11) DEFAULT NULL,
  `OrarioFine` INT(11) DEFAULT NULL,
  PRIMARY KEY (`Giorno`,`Corso`),
  KEY `FK2_cor2_idx` (`Corso`),
  CONSTRAINT `FK2_cor2` FOREIGN KEY (`Corso`) REFERENCES `corso` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendario`
--

LOCK TABLES `calendario` WRITE;
/*!40000 ALTER TABLE `calendario` DISABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER BR_Calendario BEFORE INSERT ON Calendario
FOR EACH ROW
BEGIN

DECLARE hri INT(11) DEFAULT 0;
DECLARE hrf INT(11) DEFAULT 0;
DECLARE gg INT(11) DEFAULT 0;
DECLARE tch CHAR(255) DEFAULT '';
DECLARE corso CHAR(255) DEFAULT '';
DECLARE centro CHAR(255) DEFAULT '';
DECLARE trovato INT(11) DEFAULT 0;

SET gg = new.Giorno;

SET hri = new.OrarioInizio;

SET hrf = new.OrarioFine;

SET corso = new.Corso;

SET centro = (
			SELECT
				c.CodiceCentro
			FROM
				corso c
			WHERE
				c.Codice = corso );

SET tch = (
			SELECT
				c.Istruttore
			FROM
				corso c
			WHERE
				c.Codice = corso );

SET trovato = (
				SELECT
					COUNT(*)
                FROM
					turnazione t
				WHERE
					t.Dipendente = tch
                    AND t.Giorno = gg
                    AND hri BETWEEN t.OrarioInizio AND t.OrarioFine
                    AND hrf BETWEEN t.OrarioInizio AND t.OrarioFine );
                    
IF trovato = 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Impossibile inserire il calendario perchè turno del dipendente non presente';
END IF;

END */;;
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
  `CodiceCentro` INT(11) NOT NULL,
  `Citta` VARCHAR(45) DEFAULT NULL,
  `Indirizzo` VARCHAR(45) DEFAULT NULL,
  `NumeroTel` INT(15) DEFAULT NULL,
  `Dimensione` INT(11) DEFAULT NULL,
  `NumeroMaxClienti` INT(11) DEFAULT NULL,
  `OrarioApertura` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceCentro`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
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
  `Utente` VARCHAR(45) NOT NULL,
  `Interesse` VARCHAR(45) NOT NULL,
  `Amico` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`Utente`,`Interesse`),
  KEY `FK_ami2_idx` (`Amico`),
  KEY `FK5_inter5_idx` (`Interesse`),
  CONSTRAINT `FK_ami2` FOREIGN KEY (`Amico`) REFERENCES `amicizia` (`Richiedente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_inter7` FOREIGN KEY (`Utente`, `Interesse`) REFERENCES `interessi` (`UserName`, `Interessi`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerchia`
--

LOCK TABLES `cerchia` WRITE;
/*!40000 ALTER TABLE `cerchia` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerchia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `CodiceFiscale` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) DEFAULT NULL,
  `Cognome` VARCHAR(45) DEFAULT NULL,
  `DataNascita` DATE DEFAULT NULL,
  `Indirizzo` VARCHAR(45) DEFAULT NULL,
  `Città` VARCHAR(45) DEFAULT NULL,
  `DocumentoRiconoscimento` VARCHAR(45) DEFAULT NULL,
  `PrefetturaDocumento` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceFiscale`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consente1`
--

DROP TABLE IF EXISTS `consente1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consente1` (
  `CodiceModalita` INT(11) NOT NULL,
  `CodicePiscina` INT(11) NOT NULL,
  `MaxNumeroAccessi` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceModalita`,`CodicePiscina`),
  KEY `FK_Pisc_idx` (`CodicePiscina`),
  CONSTRAINT `FK1_mod1` FOREIGN KEY (`CodiceModalita`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Pisc` FOREIGN KEY (`CodicePiscina`) REFERENCES `piscina` (`CodicePiscina`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consente1`
--

LOCK TABLES `consente1` WRITE;
/*!40000 ALTER TABLE `consente1` DISABLE KEYS */;
/*!40000 ALTER TABLE `consente1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consente2`
--

DROP TABLE IF EXISTS `consente2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consente2` (
  `CodiceModalita` INT(11) NOT NULL,
  `CodiceSala` INT(11) NOT NULL,
  PRIMARY KEY (`CodiceModalita`,`CodiceSala`),
  KEY `FK2_sala2_idx` (`CodiceSala`),
  CONSTRAINT `FK2_mod2` FOREIGN KEY (`CodiceModalita`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_sala2` FOREIGN KEY (`CodiceSala`) REFERENCES `sala` (`CodiceSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consente2`
--

LOCK TABLES `consente2` WRITE;
/*!40000 ALTER TABLE `consente2` DISABLE KEYS */;
/*!40000 ALTER TABLE `consente2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratto`
--

DROP TABLE IF EXISTS `contratto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contratto` (
  `CodiceCliente` VARCHAR(45) NOT NULL,
  `DataSottoscrizione` DATE DEFAULT NULL,
  `CodiceConsulente` VARCHAR(45) DEFAULT NULL,
  `ModalitaPagamento` TINYINT(4) DEFAULT NULL,
  `Durata` INT(11) DEFAULT NULL,
  `Multisede` TINYINT(4) DEFAULT NULL,
  `CodiceModalita` INT(11) NOT NULL,
  `Scopo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodiceCliente`),
  KEY `CodiceConsulente_idx` (`CodiceConsulente`),
  KEY `CodiceModalita_idx` (`CodiceModalita`),
  CONSTRAINT `CodiceCliente` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `CodiceConsulente` FOREIGN KEY (`CodiceConsulente`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `CodiceModalita` FOREIGN KEY (`CodiceModalita`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratto`
--

LOCK TABLES `contratto` WRITE;
/*!40000 ALTER TABLE `contratto` DISABLE KEYS */;
/*!40000 ALTER TABLE `contratto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corso`
--

DROP TABLE IF EXISTS `corso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corso` (
  `Codice` INT(11) NOT NULL,
  `Disciplina` VARCHAR(45) DEFAULT NULL,
  `Livello` INT(11) DEFAULT NULL,
  `Istruttore` VARCHAR(45) DEFAULT NULL,
  `DataInizio` DATE DEFAULT NULL,
  `DataFine` DATE DEFAULT NULL,
  `CodiceSala` INT(11) DEFAULT NULL,
  `NumeroMaxPartecipanti` INT(11) DEFAULT NULL,
  PRIMARY KEY (`Codice`),
  KEY `FK_sala1_idx` (`CodiceSala`),
  KEY `FK1_dip1_idx` (`Istruttore`),
  CONSTRAINT `FK1_dip1` FOREIGN KEY (`Istruttore`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_sala1` FOREIGN KEY (`CodiceSala`) REFERENCES `sala` (`CodiceSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corso`
--

LOCK TABLES `corso` WRITE;
/*!40000 ALTER TABLE `corso` DISABLE KEYS */;
/*!40000 ALTER TABLE `corso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dieta`
--

DROP TABLE IF EXISTS `dieta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dieta` (
  `CodiceSchedaAlimentazione` INT(11) NOT NULL,
  `Calorie` VARCHAR(45) DEFAULT NULL,
  `NumeroPasti` INT(11) DEFAULT NULL,
  `ComposizionePasti` TEXT,
  PRIMARY KEY (`CodiceSchedaAlimentazione`),
  CONSTRAINT `FK1_schedaal1` FOREIGN KEY (`CodiceSchedaAlimentazione`) REFERENCES `schedaalimentazione` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dieta`
--

LOCK TABLES `dieta` WRITE;
/*!40000 ALTER TABLE `dieta` DISABLE KEYS */;
/*!40000 ALTER TABLE `dieta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dipendente`
--

DROP TABLE IF EXISTS `dipendente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dipendente` (
  `CodiceFiscale` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) DEFAULT NULL,
  `Cognome` VARCHAR(45) DEFAULT NULL,
  `DataNascita` DATE DEFAULT NULL,
  `Indirizzo` VARCHAR(45) DEFAULT NULL,
  `Città` VARCHAR(45) DEFAULT NULL,
  `DocumentoRiconoscimento` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceFiscale`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dipendente`
--

LOCK TABLES `dipendente` WRITE;
/*!40000 ALTER TABLE `dipendente` DISABLE KEYS */;
/*!40000 ALTER TABLE `dipendente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `esercizio`
--

DROP TABLE IF EXISTS `esercizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `esercizio` (
  `Nome` VARCHAR(45) NOT NULL,
  `DEOM` INT(11) DEFAULT NULL,
  `TipologiaEsercizio` VARCHAR(45) DEFAULT NULL,
  `TipologiaMacchina` VARCHAR(45) DEFAULT NULL,
  `RegolazioneMacchina` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`Nome`),
  KEY `FK1_tip1_idx` (`TipologiaMacchina`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `esercizio`
--

LOCK TABLES `esercizio` WRITE;
/*!40000 ALTER TABLE `esercizio` DISABLE KEYS */;
/*!40000 ALTER TABLE `esercizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornitore`
--

DROP TABLE IF EXISTS `fornitore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornitore` (
  `Nome` VARCHAR(45) NOT NULL,
  `FormaSocietaria` VARCHAR(45) DEFAULT NULL,
  `PartitaIva` INT(11) DEFAULT NULL,
  `Indirizzo` VARCHAR(45) DEFAULT NULL,
  `Citta` VARCHAR(45) DEFAULT NULL,
  `NumTelefono` INT(11) DEFAULT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornitore`
--

LOCK TABLES `fornitore` WRITE;
/*!40000 ALTER TABLE `fornitore` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornitore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornitura`
--

DROP TABLE IF EXISTS `fornitura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornitura` (
  `NomeIntegratore` VARCHAR(45) NOT NULL,
  `NomeFornitore` VARCHAR(45) NOT NULL,
  `Quantita` INT(11) DEFAULT NULL,
  PRIMARY KEY (`NomeIntegratore`,`NomeFornitore`),
  KEY `FK_fornitore3_idx` (`NomeFornitore`),
  CONSTRAINT `FK_fornitore3` FOREIGN KEY (`NomeFornitore`) REFERENCES `fornitore` (`Nome`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_integratore5` FOREIGN KEY (`NomeIntegratore`) REFERENCES `integratore` (`NomeCommerciale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornitura`
--

LOCK TABLES `fornitura` WRITE;
/*!40000 ALTER TABLE `fornitura` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornitura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impiego`
--

DROP TABLE IF EXISTS `impiego`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impiego` (
  `CodiceFiscale` VARCHAR(45) NOT NULL,
  `CodiceCentro` INT(11) NOT NULL,
  `Ruolo` VARCHAR(45) DEFAULT NULL,
  `TipologiaAttivita` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceFiscale`,`CodiceCentro`),
  KEY `CodiceCentro_idx` (`CodiceCentro`),
  CONSTRAINT `FK_CodiceCentr` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Dipendente` FOREIGN KEY (`CodiceFiscale`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impiego`
--

LOCK TABLES `impiego` WRITE;
/*!40000 ALTER TABLE `impiego` DISABLE KEYS */;
/*!40000 ALTER TABLE `impiego` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integratore`
--

DROP TABLE IF EXISTS `integratore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integratore` (
  `NomeCommerciale` VARCHAR(45) NOT NULL,
  `Sostanza` VARCHAR(45) DEFAULT NULL,
  `NumeroPezzi` INT(11) DEFAULT NULL,
  `QuantitàSostanzaPezzo` INT(11) DEFAULT NULL,
  `Forma` VARCHAR(45) DEFAULT NULL,
  `Scadenza` DATE DEFAULT NULL,
  PRIMARY KEY (`NomeCommerciale`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integratore`
--

LOCK TABLES `integratore` WRITE;
/*!40000 ALTER TABLE `integratore` DISABLE KEYS */;
/*!40000 ALTER TABLE `integratore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interessi`
--

DROP TABLE IF EXISTS `interessi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interessi` (
  `UserName` VARCHAR(45) NOT NULL,
  `Interessi` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UserName`,`Interessi`),
  CONSTRAINT `FK_profilo10` FOREIGN KEY (`UserName`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interessi`
--

LOCK TABLES `interessi` WRITE;
/*!40000 ALTER TABLE `interessi` DISABLE KEYS */;
/*!40000 ALTER TABLE `interessi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iscrizione`
--

DROP TABLE IF EXISTS `iscrizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iscrizione` (
  `CodiceCliente` VARCHAR(45) NOT NULL,
  `CodiceCorso` INT(11) NOT NULL,
  PRIMARY KEY (`CodiceCliente`,`CodiceCorso`),
  KEY `FK1_cor1_idx` (`CodiceCorso`),
  CONSTRAINT `FK1_cli1` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK1_cor1` FOREIGN KEY (`CodiceCorso`) REFERENCES `corso` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iscrizione`
--

LOCK TABLES `iscrizione` WRITE;
/*!40000 ALTER TABLE `iscrizione` DISABLE KEYS */;
/*!40000 ALTER TABLE `iscrizione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `magazzino`
--

DROP TABLE IF EXISTS `magazzino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `magazzino` (
  `CodiceCentro` INT(11) NOT NULL,
  `NomeIntegratore` VARCHAR(45) NOT NULL,
  `Quantita` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceCentro`,`NomeIntegratore`),
  KEY `FK4_integrat4_idx` (`NomeIntegratore`),
  CONSTRAINT `FK10_centro10` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK4_integrat4` FOREIGN KEY (`NomeIntegratore`) REFERENCES `integratore` (`NomeCommerciale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `magazzino`
--

LOCK TABLES `magazzino` WRITE;
/*!40000 ALTER TABLE `magazzino` DISABLE KEYS */;
/*!40000 ALTER TABLE `magazzino` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modalita`
--

DROP TABLE IF EXISTS `modalita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modalita` (
  `CodiceModalita` INT(11) NOT NULL,
  `Orario` VARCHAR(45) DEFAULT NULL,
  `SpaziAllestibili` TINYINT(4) DEFAULT NULL,
  `Tipologia` VARCHAR(45) DEFAULT NULL,
  `CostoMensile` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceModalita`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modalita`
--

LOCK TABLES `modalita` WRITE;
/*!40000 ALTER TABLE `modalita` DISABLE KEYS */;
/*!40000 ALTER TABLE `modalita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitoraggio`
--

DROP TABLE IF EXISTS `monitoraggio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoraggio` (
  `CodiceScheda` INT(11) NOT NULL,
  `CodiceEsercizio` VARCHAR(45) NOT NULL,
  `Accesso` DATE NOT NULL,
  `GiornoSettimana` INT(11) DEFAULT NULL,
  `SerieEffettive` INT(11) DEFAULT NULL,
  `RipetizioniEffettive` INT(11) DEFAULT NULL,
  `TempoEffettivo` INT(11) DEFAULT NULL,
  `PesoEffettivo` INT(11) DEFAULT NULL,
  `IntensitaEffettiva` INT(11) DEFAULT NULL,
  `TempoRecuperoEffettivo` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`,`CodiceEsercizio`,`Accesso`),
  KEY `FK_acc4_idx` (`Accesso`),
  CONSTRAINT `FK_mon1` FOREIGN KEY (`CodiceScheda`, `CodiceEsercizio`) REFERENCES `workoutroutine` (`CodiceScheda`, `CodiceEsercizio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitoraggio`
--

LOCK TABLES `monitoraggio` WRITE;
/*!40000 ALTER TABLE `monitoraggio` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitoraggio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordine` (
  `CodiceInterno` INT(11) NOT NULL,
  `CodiceEsterno` INT(11) NOT NULL,
  `CodiceFornitore` VARCHAR(45) DEFAULT NULL,
  `CodiceCentro` INT(11) DEFAULT NULL,
  `DataEvasione` DATE DEFAULT NULL,
  `Stato` VARCHAR(45) DEFAULT NULL,
  `DataConsegna` DATE DEFAULT NULL,
  PRIMARY KEY (`CodiceInterno`,`CodiceEsterno`),
  KEY `FK1_forni1_idx` (`CodiceFornitore`),
  KEY `FK8_centro8_idx` (`CodiceCentro`),
  CONSTRAINT `FK1_forni1` FOREIGN KEY (`CodiceFornitore`) REFERENCES `fornitore` (`Nome`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK8_centro8` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagamento` (
  `CodiceContratto` VARCHAR(45) NOT NULL,
  `NumeroRata` INT(11) NOT NULL,
  `IstitutoFinanziario` VARCHAR(45) DEFAULT NULL,
  `TassoInteresse` INT(11) DEFAULT NULL,
  `DataScadenza` DATE DEFAULT NULL,
  `Importo` INT(11) DEFAULT NULL,
  `Stato` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceContratto`,`NumeroRata`),
  CONSTRAINT `FK5_contrat5` FOREIGN KEY (`CodiceContratto`) REFERENCES `contratto` (`CodiceCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partecipanti`
--

DROP TABLE IF EXISTS `partecipanti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partecipanti` (
  `Utente` VARCHAR(45) NOT NULL,
  `CodiceSfida` INT(11) NOT NULL,
  `SchedaAllenamento` INT(11) DEFAULT NULL,
  `SchedaAlimentazione` INT(11) DEFAULT NULL,
  `DataInizio` DATE DEFAULT NULL,
  `DataFine` DATE DEFAULT NULL,
  PRIMARY KEY (`Utente`,`CodiceSfida`),
  KEY `FK2_allen2_idx` (`SchedaAllenamento`),
  KEY `FK3_alim3_idx` (`SchedaAlimentazione`),
  KEY `FK1_sfida1_idx` (`CodiceSfida`),
  CONSTRAINT `FK1_sfida1` FOREIGN KEY (`CodiceSfida`) REFERENCES `sfida` (`CodiceSfida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_allen2` FOREIGN KEY (`SchedaAllenamento`) REFERENCES `schedaallenamento` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3_alim3` FOREIGN KEY (`SchedaAlimentazione`) REFERENCES `schedaalimentazione` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3_profilo3` FOREIGN KEY (`Utente`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partecipanti`
--

LOCK TABLES `partecipanti` WRITE;
/*!40000 ALTER TABLE `partecipanti` DISABLE KEYS */;
/*!40000 ALTER TABLE `partecipanti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `piscina`
--

DROP TABLE IF EXISTS `piscina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `piscina` (
  `CodicePiscina` INT(11) NOT NULL,
  `CodiceCentro` INT(11) NOT NULL,
  `IE` TINYINT(4) DEFAULT NULL,
  PRIMARY KEY (`CodicePiscina`),
  KEY `FK_CodCentro_idx` (`CodiceCentro`),
  CONSTRAINT `FK_CodCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piscina`
--

LOCK TABLES `piscina` WRITE;
/*!40000 ALTER TABLE `piscina` DISABLE KEYS */;
/*!40000 ALTER TABLE `piscina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `UserName` VARCHAR(45) NOT NULL,
  `TimeStamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Testo` TEXT,
  `Area` VARCHAR(45) DEFAULT NULL,
  `Thread` VARCHAR(45) DEFAULT NULL,
  `Link` VARCHAR(100) DEFAULT NULL,
  `Risposta` TINYINT(4) DEFAULT NULL,
  PRIMARY KEY (`UserName`,`TimeStamp`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `potenziamento`
--

DROP TABLE IF EXISTS `potenziamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `potenziamento` (
  `CodiceContratto` VARCHAR(45) NOT NULL,
  `MuscoliTarget` VARCHAR(45) NOT NULL,
  `Livello` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceContratto`,`MuscoliTarget`),
  CONSTRAINT `FK3_contrat3` FOREIGN KEY (`CodiceContratto`) REFERENCES `contratto` (`CodiceCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `potenziamento`
--

LOCK TABLES `potenziamento` WRITE;
/*!40000 ALTER TABLE `potenziamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `potenziamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profilo`
--

DROP TABLE IF EXISTS `profilo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profilo` (
  `CodiceUtente` VARCHAR(45) NOT NULL,
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceUtente`,`UserName`),
  CONSTRAINT `FK_clie10` FOREIGN KEY (`CodiceUtente`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_clie9` FOREIGN KEY (`CodiceUtente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profilo`
--

LOCK TABLES `profilo` WRITE;
/*!40000 ALTER TABLE `profilo` DISABLE KEYS */;
/*!40000 ALTER TABLE `profilo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riepilogoordine`
--

DROP TABLE IF EXISTS `riepilogoordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `riepilogoordine` (
  `CodiceInterno` INT(11) NOT NULL,
  `CodiceEsterno` INT(11) NOT NULL,
  `NomeIntegratore` VARCHAR(45) NOT NULL,
  `Quantita` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceInterno`,`CodiceEsterno`,`NomeIntegratore`),
  KEY `FK2_integra2_idx` (`NomeIntegratore`),
  CONSTRAINT `FK2_integra2` FOREIGN KEY (`NomeIntegratore`) REFERENCES `integratore` (`NomeCommerciale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Codice10` FOREIGN KEY (`CodiceInterno`, `CodiceEsterno`) REFERENCES `ordine` (`CodiceInterno`, `CodiceEsterno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riepilogoordine`
--

LOCK TABLES `riepilogoordine` WRITE;
/*!40000 ALTER TABLE `riepilogoordine` DISABLE KEYS */;
/*!40000 ALTER TABLE `riepilogoordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sala`
--

DROP TABLE IF EXISTS `sala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sala` (
  `CodiceSala` INT(11) NOT NULL,
  `CodiceCentro` INT(11) NOT NULL,
  `Responsabile` VARCHAR(45) DEFAULT NULL,
  `TotaleCorsi` INT(11) DEFAULT '0',
  PRIMARY KEY (`CodiceSala`),
  KEY `FK_CodiCentro_idx` (`CodiceCentro`),
  KEY `FK_Dip_idx` (`Responsabile`),
  CONSTRAINT `FK_CodiCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala`
--

LOCK TABLES `sala` WRITE;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
INSERT INTO `sala` VALUES (0,0,'bnccld',0);
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedaalimentazione`
--

DROP TABLE IF EXISTS `schedaalimentazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedaalimentazione` (
  `CodiceScheda` INT(11) NOT NULL,
  `CodFisCliente` VARCHAR(45) DEFAULT NULL,
  `CodFisMedico` VARCHAR(45) DEFAULT NULL,
  `DataInizio` DATE DEFAULT NULL,
  `CodiceDieta` INT(11) DEFAULT NULL,
  `DataFine` DATE DEFAULT NULL,
  `IntervalloVisite` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`),
  KEY `FK4_dip4_idx` (`CodFisMedico`),
  KEY `FK6_cli6_idx` (`CodFisCliente`),
  CONSTRAINT `FK4_dip4` FOREIGN KEY (`CodFisMedico`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK6_cli6` FOREIGN KEY (`CodFisCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedaalimentazione`
--

LOCK TABLES `schedaalimentazione` WRITE;
/*!40000 ALTER TABLE `schedaalimentazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedaalimentazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedaallenamento`
--

DROP TABLE IF EXISTS `schedaallenamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedaallenamento` (
  `CodiceScheda` INT(11) NOT NULL,
  `CodiceIstruttore` VARCHAR(45) DEFAULT NULL,
  `CodiceCliente` VARCHAR(45) DEFAULT NULL,
  `DataInizio` DATE DEFAULT NULL,
  `DataFine` DATE DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`),
  KEY `FK4_cli4_idx` (`CodiceCliente`),
  KEY `FK5_dip5_idx` (`CodiceIstruttore`),
  CONSTRAINT `FK4_cli4` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK5_dip5` FOREIGN KEY (`CodiceIstruttore`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedaallenamento`
--

LOCK TABLES `schedaallenamento` WRITE;
/*!40000 ALTER TABLE `schedaallenamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedaallenamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sfida`
--

DROP TABLE IF EXISTS `sfida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sfida` (
  `CodiceSfida` INT(11) NOT NULL,
  `Proponente` VARCHAR(45) DEFAULT NULL,
  `DataLancio` DATE DEFAULT NULL,
  `DataInizio` DATE DEFAULT NULL,
  `DataFine` DATE DEFAULT NULL,
  `Scopo` VARCHAR(45) DEFAULT NULL,
  `Thread` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceSfida`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sfida`
--

LOCK TABLES `sfida` WRITE;
/*!40000 ALTER TABLE `sfida` DISABLE KEYS */;
/*!40000 ALTER TABLE `sfida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sforzo`
--

DROP TABLE IF EXISTS `sforzo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sforzo` (
  `Utente` VARCHAR(45) NOT NULL,
  `Data` DATE NOT NULL,
  `Sfida` INT(11) NOT NULL,
  `Valutazione` INT(11) DEFAULT NULL,
  PRIMARY KEY (`Utente`,`Data`,`Sfida`),
  CONSTRAINT `FK_partecip1` FOREIGN KEY (`Utente`) REFERENCES `partecipanti` (`Utente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sforzo`
--

LOCK TABLES `sforzo` WRITE;
/*!40000 ALTER TABLE `sforzo` DISABLE KEYS */;
/*!40000 ALTER TABLE `sforzo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spogliatoio`
--

DROP TABLE IF EXISTS `spogliatoio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spogliatoio` (
  `CodiceSpogliatoio` INT(11) NOT NULL,
  `CodiceCentro` INT(11) DEFAULT NULL,
  `Capienza` INT(11) DEFAULT NULL,
  `X` INT(11) DEFAULT NULL,
  `Y` INT(11) DEFAULT NULL,
  `PostiLiberi` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceSpogliatoio`),
  KEY `FK_CodicCentro_idx` (`CodiceCentro`),
  CONSTRAINT `FK_CodicCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spogliatoio`
--

LOCK TABLES `spogliatoio` WRITE;
/*!40000 ALTER TABLE `spogliatoio` DISABLE KEYS */;
/*!40000 ALTER TABLE `spogliatoio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statofisico`
--

DROP TABLE IF EXISTS `statofisico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statofisico` (
  `CodiceScheda` INT(11) NOT NULL,
  `CodiceFiscale` VARCHAR(45) NOT NULL,
  `DataScheda` DATE DEFAULT NULL,
  `Altezza` INT(11) DEFAULT NULL,
  `Peso` INT(11) DEFAULT NULL,
  `PercentualeMassaMagra` INT(100) DEFAULT NULL,
  `PercentualeMassaGrassa` INT(100) DEFAULT NULL,
  `PercentualeAcquaTot` INT(100) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`,`CodiceFiscale`),
  KEY `CodiceFiscale_idx` (`CodiceFiscale`),
  CONSTRAINT `CodiceFiscale` FOREIGN KEY (`CodiceFiscale`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statofisico`
--

LOCK TABLES `statofisico` WRITE;
/*!40000 ALTER TABLE `statofisico` DISABLE KEYS */;
/*!40000 ALTER TABLE `statofisico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggerimento`
--

DROP TABLE IF EXISTS `suggerimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suggerimento` (
  `Utente` VARCHAR(45) NOT NULL,
  `Interesse` VARCHAR(45) NOT NULL,
  `NonAmico` VARCHAR(45) DEFAULT NULL,
  KEY `FK_profilo11_idx` (`NonAmico`),
  KEY `FK_interesse5_idx` (`Utente`,`Interesse`),
  CONSTRAINT `FK_interesse5` FOREIGN KEY (`Utente`, `Interesse`) REFERENCES `interessi` (`UserName`, `Interessi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_profilo11` FOREIGN KEY (`NonAmico`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggerimento`
--

LOCK TABLES `suggerimento` WRITE;
/*!40000 ALTER TABLE `suggerimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `suggerimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transazione`
--

DROP TABLE IF EXISTS `transazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transazione` (
  `CodiceMagazzino` INT(11) NOT NULL,
  `CodiceCliente` VARCHAR(45) NOT NULL,
  `Data` DATE NOT NULL,
  `NomeIntegratore` VARCHAR(45) DEFAULT NULL,
  `QuantitaAcquistata` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceMagazzino`,`CodiceCliente`,`Data`),
  KEY `FK7_clie7_idx` (`CodiceCliente`),
  KEY `FK1_integ1_idx` (`NomeIntegratore`),
  CONSTRAINT `FK1_integ1` FOREIGN KEY (`NomeIntegratore`) REFERENCES `integratore` (`NomeCommerciale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK6_centro6` FOREIGN KEY (`CodiceMagazzino`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK7_clie7` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transazione`
--

LOCK TABLES `transazione` WRITE;
/*!40000 ALTER TABLE `transazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `transazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnazione`
--

DROP TABLE IF EXISTS `turnazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turnazione` (
  `CodiceDipendente` VARCHAR(45) NOT NULL,
  `Giorno` VARCHAR(45) NOT NULL,
  `OrarioInizio` VARCHAR(45) NOT NULL,
  `OrarioFine` VARCHAR(45) NOT NULL,
  `CodiceCentro` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceDipendente`,`Giorno`,`OrarioInizio`,`OrarioFine`),
  CONSTRAINT `FK8_dipen8` FOREIGN KEY (`CodiceDipendente`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnazione`
--

LOCK TABLES `turnazione` WRITE;
/*!40000 ALTER TABLE `turnazione` DISABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER BR_Turnazione BEFORE INSERT ON turnazione
FOR EACH ROW
BEGIN

DECLARE errore INT(11) DEFAULT 0;
DECLARE durataTurno INT(11) DEFAULT 0;

IF new.OrarioInizio > 24 OR new.OrarioFine > 24 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Orario inserito non valido';
END IF;

IF new.OrarioInizio < 0 OR new.OrarioFine < 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Orario inserito non valido';
END IF;



SET @citta =(
				SELECT
					c.Citta
				FROM
					centro c
				WHERE
					c.Codice = new.CodiceCentro );

SET errore = (
				SELECT
					COUNT(*)
				FROM
					turnazione t
                    INNER JOIN
                    centro c ON t.CodiceCentro = c.Codice
				WHERE
					t.CodiceDipendente =  new.CodiceDipendente
                    AND t.Giorno = new.Giorno
                    AND ((new.OrarioInizio BETWEEN t.OrarioInizio AND t.OrarioFine)
                    OR (c.Citta = @citta)));
IF errore = 0 THEN
	SET durataTurno = (
					SELECT
						SUM(t.OrarioFine - t.OrarioInizio)
					FROM
						turnazione t
					WHERE
						t.CodiceDipendente = new.CodiceDipendente
                        AND t.Giorno = new.Giorno);
END IF;
                    
IF errore <> 0 THEN
	DELETE FROM turnazione
    WHERE
		CodiceDipendente = new.CodiceDipendente
        AND Giorno = new.Giorno
        AND OrarioInizio = new.OrarioInizio
        AND OrarioFine = new.OrarioFine;
	 SIGNAL SQLSTATE  '45000'
     SET MESSAGE_TEXT = "Impossibile aggiungere il Turno";
ELSE
	IF durataTurno > 8 THEN
    	DELETE FROM turnazione
			WHERE
				CodiceDipendente = new.CodiceDipendente
				AND Giorno = new.Giorno
				AND OrarioInizio = new.OrarioInizio
				AND OrarioFine = new.OrarioFine;
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Impossibile aggiungere il Turno";
	END IF;
	
END IF;

END */;;
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
  `UtenteRisposta` VARCHAR(45) NOT NULL,
  `TIMESTAMP` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UtenteValutazione` VARCHAR(45) NOT NULL,
  `Valutazione` INT(11) DEFAULT NULL,
  PRIMARY KEY (`UtenteRisposta`,`TIMESTAMP`,`UtenteValutazione`),
  CONSTRAINT `FK5_profil5` FOREIGN KEY (`UtenteRisposta`) REFERENCES `profilo` (`CodiceUtente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_post1` FOREIGN KEY (`UtenteRisposta`) REFERENCES `post` (`UserName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votazione`
--

LOCK TABLES `votazione` WRITE;
/*!40000 ALTER TABLE `votazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `votazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workoutroutine`
--

DROP TABLE IF EXISTS `workoutroutine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workoutroutine` (
  `CodiceScheda` INT(11) NOT NULL,
  `CodiceEsercizio` VARCHAR(45) NOT NULL,
  `GiornoSettimana` INT(11) DEFAULT NULL,
  `Serie` INT(11) DEFAULT NULL,
  `Ripetizioni` INT(11) DEFAULT NULL,
  `Tempo` INT(11) DEFAULT NULL,
  `Peso` INT(11) DEFAULT NULL,
  `Intensita` INT(11) DEFAULT NULL,
  `TempoRecupero` INT(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`,`CodiceEsercizio`),
  KEY `FK1_es1_idx` (`CodiceEsercizio`),
  CONSTRAINT `FK1_es1` FOREIGN KEY (`CodiceEsercizio`) REFERENCES `esercizio` (`Nome`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK4_all4` FOREIGN KEY (`CodiceScheda`) REFERENCES `schedaallenamento` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workoutroutine`
--

LOCK TABLES `workoutroutine` WRITE;
/*!40000 ALTER TABLE `workoutroutine` DISABLE KEYS */;
/*!40000 ALTER TABLE `workoutroutine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'smartfitness'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `RankSfide` */;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `RankSfide` ON SCHEDULE EVERY 1 DAY STARTS '2017-07-06 17:48:25' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

SELECT
	IF(@sfida = M.CodiceSfida,
		IF(@durata = Durata,
			@podio,
            @podio := @podio + 1 + LEAST(0, @durata := M.Durata)),
		@podio := 1 + LEAST(0, @durata := M.Durata) + LEAST(0, @sfida = M.CodiceSfida))
FROM
	(
	SELECT
		p.CodiceSfida, p.Utente, DATEDIFF(p.DataFine, p.DataInizio) AS Durata
	FROM
		partecipanti p
		NATURAL JOIN
		(
		SELECT
			s.CodiceSfida
		FROM
			sfida s
			NATURAL JOIN
			partecipanti p
		WHERE
			s.DataFine = CURRENT_DATE()
			AND p.DataFine IS NOT NULL
		GROUP BY
			p.CodiceSfida
		HAVING
			COUNT(p.Utente) >= 3 ) AS D
		WHERE
			p.DataFine IS NOT NULL) AS M,
	(SELECT (@podio := 0)) AS N
ORDER BY
	M.CodiceSfida, M.Durata ;

END */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `SfideIncomplete` ON SCHEDULE EVERY 1 DAY STARTS '2017-07-06 17:48:26' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

SELECT
	p.CodiceSfida
FROM
	sfida s
    NATURAL JOIN
	partecipanti p
WHERE
	p.DataFine IS NOT NULL
    AND s.DataFine = CURRENT_DATE()
GROUP BY
	p.Codicesfida
HAVING
	COUNT(p.Utente) < 3;
    
END */ ;;
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
IN _codiceScheda CHAR(255), IN _codiceIstruttore CHAR(255), IN _codiceCliente CHAR(255), IN _dataI DATE)
BEGIN

UPDATE schedaallenamento sc
SET sc.DataFine = CURRENT_DATE()
WHERE
	sc.CodiceCliente = _codiceCliente
    AND sc.DataFine = NULL;
    
INSERT INTO schedaallenamento VALUES (_codiceScheda, _codiceIstruttore, _codiceCliente, _dataI, NULL);

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
IN _nomeEsercizio CHAR(255), IN _gg INT(11), IN _sr INT(11), IN _rep INT(11), IN _time INT(11),
IN _weight INT(11), IN _intesity INT(11), IN _tgap INT(11), IN _codiceCliente CHAR(255))
BEGIN

SET @scheda = (
				SELECT
					sc.CodiceScheda
				FROM
					schedaallenamento sc
				WHERE
					sc.CodiceCliente = _codiceCliente
                    AND sc.DataFine = NULL );

INSERT INTO workout VALUES (@scheda, _nomeEsercizio, _gg, _sr, _rep, _time, _weight, _intesity, _tgap);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-06 17:49:42
