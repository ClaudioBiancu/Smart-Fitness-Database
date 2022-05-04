-- Inserimento di una scheda di alimentazione a una settimana dal cambiamento della scheda di allenamento.

DROP PROCEDURE IF EXISTS InsAlimentazione;
 
DELIMITER $$

	CREATE PROCEDURE InsAlimentazione
	(IN _CodiceScheda INT, IN _CodFisCliente VARCHAR(45), IN _CodFisMedico VARCHAR(45), IN _IntervalloVisite INT)
     BEGIN
    
		INSERT INTO SchedaAlimentazione VALUES (_CodiceScheda, _CodFisCliente, _CodFisMedico, CURRENT_DATE, NULL,IntervalloVisite);

 END $$
 DELIMITER ;
 
 DROP TRIGGER IF EXISTS VerificaSettimana;
 
 DELIMITER $$
 
 CREATE TRIGGER VerificaSettimana BEFORE INSERT ON SchedaAlimentazione FOR EACH ROW
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
	
 END $$
 DELIMITER ;


DROP PROCEDURE IF EXISTS InserisciDieta;

DELIMITER $$

CREATE PROCEDURE InserisciDieta(IN _calorie INT, IN _numeroPasti INT, IN _composizione TEXT)
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
	
END $$
DELIMITER ;
