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
/*!40000 ALTER TABLE `accessibile` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`CodiceCliente`,`CodiceCentro`,`Data`)
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
  PRIMARY KEY (`Richiedente`,`Destinatario`,`DataRichiesta`)
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
  `Tipologia` varchar(45) DEFAULT NULL,
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
  PRIMARY KEY (`CodiceArmadietto`,`CodiceSpogliatoio`)
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
  `Orario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Giorno`,`Corso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendario`
--

LOCK TABLES `calendario` WRITE;
/*!40000 ALTER TABLE `calendario` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendario` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `centro` VALUES (0,'Pisa','Via Diotisalvi 1',501234567,150,100,'8.00/20.00');
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
  `Interesee` varchar(45) NOT NULL,
  `Amico` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Utente`,`Interesee`)
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
  PRIMARY KEY (`CodiceModalita`,`CodicePiscina`)
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
  PRIMARY KEY (`CodiceModalita`,`CodiceSala`)
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
  `CodiceModalità` int(11) NOT NULL,
  `Scopo` varchar(45) NOT NULL,
  PRIMARY KEY (`CodiceCliente`),
  KEY `CodiceConsulente_idx` (`CodiceConsulente`),
  KEY `CodiceModalita_idx` (`CodiceModalità`),
  CONSTRAINT `CodiceCliente` FOREIGN KEY (`CodiceCliente`) REFERENCES `cliente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `CodiceConsulente` FOREIGN KEY (`CodiceConsulente`) REFERENCES `dipendente` (`CodiceFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `CodiceModalita` FOREIGN KEY (`CodiceModalità`) REFERENCES `modalita` (`CodiceModalita`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  PRIMARY KEY (`Codice`)
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
  `CodiceDieta` int(11) NOT NULL,
  `Calorie` varchar(45) DEFAULT NULL,
  `NumeroPasti` int(11) DEFAULT NULL,
  `ComposizionePasti` text,
  PRIMARY KEY (`CodiceDieta`)
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
  PRIMARY KEY (`Nome`)
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
  PRIMARY KEY (`NomeIntegratore`,`NomeFornitore`)
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
  `CodiceFiscale` int(11) NOT NULL,
  `CodiceCentro` int(11) NOT NULL,
  `Ruolo` varchar(45) DEFAULT NULL,
  `TipologiaAttivita` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodiceFiscale`,`CodiceCentro`),
  KEY `CodiceCentro_idx` (`CodiceCentro`)
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
  PRIMARY KEY (`UserName`,`Interessi`)
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
  PRIMARY KEY (`CodiceCliente`,`CodiceCorso`)
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
  PRIMARY KEY (`CodiceCentro`,`NomeIntegratore`)
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
  PRIMARY KEY (`CodiceScheda`,`CodiceEsercizio`,`Accesso`)
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
  PRIMARY KEY (`CodiceInterno`,`CodiceEsterno`)
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
  PRIMARY KEY (`CodiceContratto`,`NumeroRata`)
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
  PRIMARY KEY (`Utente`,`CodiceSfida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodicePiscina` int(11) NOT NULL,
  `CodiceCentro` int(11) NOT NULL,
  `IE` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`CodicePiscina`)
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
  PRIMARY KEY (`CodiceContratto`,`MuscoliTarget`)
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
  PRIMARY KEY (`CodiceUtente`,`UserName`)
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
  PRIMARY KEY (`CodiceInterno`,`CodiceEsterno`,`NomeIntegratore`)
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
  KEY `CodiceCentro_idx` (`CodiceCentro`),
  CONSTRAINT `CodiceCentro` FOREIGN KEY (`CodiceCentro`) REFERENCES `centro` (`CodiceCentro`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  PRIMARY KEY (`CodiceScheda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodiceScheda` int(11) NOT NULL,
  `CodiceIstruttore` varchar(45) DEFAULT NULL,
  `CodiceCliente` varchar(45) DEFAULT NULL,
  `DataInizio` date DEFAULT NULL,
  `DataFine` date DEFAULT NULL,
  PRIMARY KEY (`CodiceScheda`)
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
  PRIMARY KEY (`Utente`,`Data`,`Sfida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `CodiceSpogliatoio` int(11) NOT NULL,
  `Capienza` int(11) DEFAULT NULL,
  `X` int(11) DEFAULT NULL,
  `Y` int(11) DEFAULT NULL,
  `PostiLiberi` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceSpogliatoio`)
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
  PRIMARY KEY (`Utente`,`Interesse`)
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
  PRIMARY KEY (`CodiceMagazzino`,`CodiceCliente`,`Data`)
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
  `Orario` varchar(45) NOT NULL,
  `CodiceCentro` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodiceDipendente`,`Giorno`,`Orario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnazione`
--

LOCK TABLES `turnazione` WRITE;
/*!40000 ALTER TABLE `turnazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `turnazione` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`UtenteRisposta`,`TIMESTAMP`,`UtenteValutazione`)
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
  PRIMARY KEY (`CodiceScheda`,`CodiceEsercizio`)
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

--
-- Dumping routines for database 'smartfitness'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-22 10:31:49
