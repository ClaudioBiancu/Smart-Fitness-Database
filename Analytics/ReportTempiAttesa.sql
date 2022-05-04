-- Test Procedura
CALL TempiAttesa (1);

DROP PROCEDURE IF EXISTS TempiAttesa;

DELIMITER $$

CREATE PROCEDURE TempiAttesa(IN _centro INT)
BEGIN
DECLARE TempoEccedente DOUBLE DEFAULT 0;
 
 SET TempoEccedente = (SELECT AVG(TempoRecuperoEffettivo - TempoRecupero) AS DifferenzaTempo
					   FROM 
							Monitoraggio M
                INNER JOIN
                WorkoutRoutine W ON M.CodiceScheda= W.CodiceScheda AND M.CodiceEsercizio=W.CodiceEsercizio
						WHERE 
							M.Centro=_centro
					);
-- Se la media del tempo di recupero supera i 5 minuti è possibile che la macchina sia spesso occupata e non permetta di utilizzarla.
 IF(TempoEccedente > 5 )
	THEN SELECT 'Il tempo d"attesa per utilizzare i macchinari del centro è eccessivo,
				i clienti potrebbero aver bisogno di una variazione della scheda di allenamento o di un numero maggiore di macchinari';
 ELSE 
 IF (TempoEccedente >=0 AND TempoEccedente <=5) 
	THEN SELECT 'Il tempo d"attesa per utilizzare i macchinari è buono';
 ELSE
	SELECT 'Probabilmente i clienti non rispettano il tempo di ripresa assegnato tra un esercizio e l"altro';
END IF;
END IF;
 
END $$
DELIMITER ;
						
                        