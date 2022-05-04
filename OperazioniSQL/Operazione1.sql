/*Inserimento di un nuovo cliente nel database con analisi dello stato fisico iniziale e registrazione del contratto con relativa modalità.
Inserimento di un nuovo cliente nel database con analisi dello stato fisico iniziale e registrazione del contratto con relativa modalità.
*/

DROP PROCEDURE IF EXISTS InserisciCliente;

DELIMITER $$

CREATE PROCEDURE InserisciCliente
(IN _codFiscale VARCHAR(50), IN _nome VARCHAR(50), IN _cognome VARCHAR(50),
IN _datanascita DATE,IN _indirizzo VARCHAR(50), IN _citta VARCHAR(50), IN _documento VARCHAR(50), IN _prefettura VARCHAR(50))
BEGIN
	INSERT INTO Cliente VALUES (_codFiscale, _nome, _cognome, _datanascita, _indirizzo, _citta, _documento, _prefettura);
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS InserisciModalità;

DELIMITER $$

CREATE PROCEDURE InserisciModalità(IN _codmod INT, IN _orario VARCHAR(50), IN _spaziallest BOOL, IN _tipo VARCHAR(50),
 IN costomen INT, IN _multisede BOOL)
 BEGIN
  INSERT INTO Modalita VALUES ( _codmod,  _orario , _spaziallest ,  _tipo , costomen , _multisede);
 
 END $$
 DELIMITER ;
 
DROP PROCEDURE IF EXISTS InserisciAccessibile;

DELIMITER $$

CREATE PROCEDURE InserisciAccessibile(IN _Mod INT, IN _Centro INT, IN _NumAcc INT)
BEGIN
	INSERT INTO Accessibile VALUES (_Mod, _Centro, _NumAcc);
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS InserisciConsente1;
DELIMITER $$
CREATE PROCEDURE InserisciConsente1(IN _Mod INT, IN _piscina INT, IN _NumAcc INT)
BEGIN
	INSERT INTO Consente1 VALUES(_Mod, _piscina, _NumAcc);
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS InserisciConsente2;
DELIMITER $$
CREATE PROCEDURE InserisciConsente2(IN _Mod INT, IN sala INT)
BEGIN
	INSERT INTO Consente2 VALUES(_Mod, sala);
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS InserisciPagamento;

DELIMITER $$

CREATE PROCEDURE InserisciPagamento
(IN CodiceContratto VARCHAR(50), IN NumeroRata INT, IN IstitutoFinanziario VARCHAR(50),
 IN TassoInteresse DOUBLE,IN DataScadenza DATE,IN Importo INT, IN Stato VARCHAR(50))
BEGIN
	INSERT INTO Pagamento VALUES (CodiceContratto ,  NumeroRata ,  IstitutoFinanziario ,
				TassoInteresse , DataScadenza , Importo,  Stato);
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS InserisciPotenziamento;

DELIMITER $$

CREATE PROCEDURE InserisciPotenziamento(IN Codcontratto VARCHAR(50), IN Muscoli VARCHAR(50), IN Livello VARCHAR(50))
BEGIN
	INSERT INTO Potenziamento VALUES (Codcontratto,Muscoli,Livello);
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS InserisciStatoFisico ;

DELIMITER $$

CREATE PROCEDURE InserisciStatoFisico( IN CodiceScheda INT, IN CodiceFiscale VARCHAR(50), IN DataScheda DATE,
 IN Altezza INT, IN Peso INT, IN PercentualeMassaMagra INT, IN PercentualeMassaGrassa INT, IN PercentualeAcquaTot INT)
BEGIN
	INSERT INTO Statofisico VALUES (CodiceScheda, CodiceFiscale, DataScheda, Altezza, Peso, PercentualeMassaMagra, PercentualeMassaGrassa, PercentualeAcquaTot);
END $$
DELIMITER ;

