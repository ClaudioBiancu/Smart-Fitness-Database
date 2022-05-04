/*Selezionare le apparecchiature con più bisogno di manutenzione (>50%), ordinandole in maniera decrescente per sale,
 in base al numero di corsi svolti nelle stesse.*/
 
 
-- Event per tenere aggiornata la ridondanza TotaleCorsi
DROP EVENT IF EXISTS AggiornaTotaleCorsi;

DELIMITER $$

CREATE EVENT AggiornaTotaleCorsi ON SCHEDULE EVERY 1 WEEK 
STARTS '2017-07-12 23:59:59' DO
BEGIN
	UPDATE Sala S
    SET S.TotaliCorsi=( SELECT COUNT(*)
						FROM Corso C
                        WHERE C.CodiceSala=S.CodiceSala
					   );
    
END $$
DELIMITER  ;
 
 
 -- Operazione con Ridondanza
 SELECT 
	A.CodiceIdentificativo, S.CodiceSala, S.TotaleCorsi
 FROM 
	  Apparecchiatura A
	  INNER JOIN
      Sala S ON A.NomeSala=S.CodiceSala
 WHERE
	 A.LivelloUsura > 50
ORDER BY S.TotaleCorsi DESC;

DROP EVENT IF EXISTS AggiornaTotaleCorsi;

DELIMITER $$

CREATE EVENT AggiornaTotaleCorsi ON SCHEDULE EVERY 1 WEEK 
STARTS '2017-07-12 23:59:59' DO
BEGIN
	UPDATE Sala S
    SET S.TotaliCorsi=( SELECT COUNT(*)
						FROM Corso C
                        WHERE C.CodiceSala=S.CodiceSala
					   );
    
END $$
DELIMITER  ;

-- Operazione senza Ridondanza
-- Conto i corsi che si tengono in ogni Sala
CREATE OR REPLACE VIEW NumeroCorsiPerSala AS
SELECT
	S.CodiceSala, IF(COUNT(C.Codice)=NULL,0,COUNT(C.Codice)) AS NumeroCorsi
FROM 
	Sala S
    LEFT OUTER JOIN
    Corso C ON S.CodiceSala= C.CodiceSala;


-- Seleziono le Apparecchiature con più bisogno di manutenzione.
SELECT A.CodiceIdentificativo
FROM 
	 Apparecchiatura A
	 INNER JOIN
	 NumeroCorsiPerSala NCPS ON A.NomeSala=NCPS.CodiceSala
WHERE 
	A.LivelloUsura > 50
ORDER BY NCPS.NumeroCorsi;
     
    
