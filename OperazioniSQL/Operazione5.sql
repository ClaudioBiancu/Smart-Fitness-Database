-- Operazione 5: Cancellazione dal database di un dipendente, con relativi riferimenti, dal database.

DROP PROCEDURE IF EXISTS CancellaDipendente;

DELIMITER $$

CREATE PROCEDURE CancellaDipendente(IN _codFiscale VARCHAR(45))
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
    
    -- Cancello infine il dipendente dalla tabella Dipendente.
    DELETE D.*
	FROM Dipendente D
	WHERE D.CodFiscale=_codFiscale;
END;
ELSE
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT= 'Il dipendente selezionato non lavora per la azienda SmartFitness';
END IF;


END $$
DELIMITER ;

