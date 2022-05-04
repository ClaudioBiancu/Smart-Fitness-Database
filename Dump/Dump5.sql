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
  PRIMARY KEY (`CodiceModalita`,`CodiceCentro`),
  KEY `FK_CodiceCentro_idx` (`CodiceCentro`),
  CONSTRAINT `FK_CodiceCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_CodiceModalita` FOREIGN KEY (`CodiceModalita`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`CodiceCliente`,`CodiceCentro`,`Data`),
  KEY `FK_Spo_idx` (`Numero`,`CodiceSpogliatoio`),
  KEY `FK1_Centro1_idx` (`CodiceCentro`),
  CONSTRAINT `FK1_Centro1` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3_cli3` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Spo` FOREIGN KEY (`Numero`, `CodiceSpogliatoio`) REFERENCES `armadietto` (`CodiceArmadietto`, `CodiceSpogliatoio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `ConsumoEnergetico` int(11) DEFAULT '0',
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
/*!40000 ALTER TABLE `armadietto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendario`
--

DROP TABLE IF EXISTS `calendario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendario` (
  `Giorno` date NOT NULL,
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
  KEY `FK_ami2_idx` (`Amico`),
  KEY `FK5_inter5_idx` (`Interesse`),
  CONSTRAINT `FK_ami2` FOREIGN KEY (`Amico`) REFERENCES `amicizia` (`Richiedente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_inter7` FOREIGN KEY (`Utente`, `Interesse`) REFERENCES `interessi` (`UserName`, `Interessi`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`CodiceModalita`,`CodicePiscina`),
  KEY `FK_Pisc_idx` (`CodicePiscina`),
  CONSTRAINT `FK1_mod1` FOREIGN KEY (`CodiceModalita`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Pisc` FOREIGN KEY (`CodicePiscina`) REFERENCES `piscina` (`CodicePiscina`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodiceModalita` int(11) NOT NULL,
  `CodiceSala` int(11) NOT NULL,
  PRIMARY KEY (`CodiceModalita`,`CodiceSala`),
  KEY `FK2_sala2_idx` (`CodiceSala`),
  CONSTRAINT `FK2_mod2` FOREIGN KEY (`CodiceModalita`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_sala2` FOREIGN KEY (`CodiceSala`) REFERENCES `sala` (`CodiceSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodiceCliente` varchar(45) NOT NULL,
  `DataSottoscrizione` date DEFAULT NULL,
  `CodiceConsulente` varchar(45) DEFAULT NULL,
  `ModalitaPagamento` tinyint(4) DEFAULT NULL,
  `Durata` int(11) DEFAULT NULL,
  `Multisede` tinyint(4) DEFAULT NULL,
  `CodiceModalita` int(11) NOT NULL,
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
  `Scadenza` date DEFAULT NULL,
  PRIMARY KEY (`NomeCommerciale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `Quantita` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceCentro`,`NomeIntegratore`),
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
  PRIMARY KEY (`CodiceModalita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `TassoInteresse` int(11) DEFAULT NULL,
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
  `Livello` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceContratto`,`MuscoliTarget`),
  CONSTRAINT `FK3_contrat3` FOREIGN KEY (`CodiceContratto`) REFERENCES `contratto` (`CodiceCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodiceUtente` varchar(45) NOT NULL,
  `UserName` varchar(45) NOT NULL,
  `Password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceUtente`,`UserName`),
  CONSTRAINT `FK_clie10` FOREIGN KEY (`CodiceUtente`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_clie9` FOREIGN KEY (`CodiceUtente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodiceScheda` int(11) NOT NULL,
  `CodFisCliente` varchar(45) DEFAULT NULL,
  `CodFisMedico` varchar(45) DEFAULT NULL,
  `DataInizio` date DEFAULT NULL,
  `CodiceDieta` int(11) DEFAULT NULL,
  `DataFine` date DEFAULT NULL,
  `IntervalloVisite` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`),
  KEY `FK4_dip4_idx` (`CodFisMedico`),
  KEY `FK6_cli6_idx` (`CodFisCliente`),
  CONSTRAINT `FK4_dip4` FOREIGN KEY (`CodFisMedico`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK6_cli6` FOREIGN KEY (`CodFisCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedaalimentazione`
--

LOCK TABLES `schedaalimentazione` WRITE;
/*!40000 ALTER TABLE `schedaalimentazione` DISABLE KEYS */;
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
                        AND Sa.CodiceCliente=NEW.CodFisCliente
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
  PRIMARY KEY (`CodiceScheda`,`CodiceEsercizio`),
  KEY `FK1_es1_idx` (`CodiceEsercizio`),
  CONSTRAINT `FK1_es1` FOREIGN KEY (`CodiceEsercizio`) REFERENCES `esercizio` (`Nome`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK4_all4` FOREIGN KEY (`CodiceScheda`) REFERENCES `schedaallenamento` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!50106 DROP EVENT IF EXISTS `CancellaAccessi` */;
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

-- Dump completed on 2017-07-07 14:34:18
