
-- Il trigger non permette l'aggiunta di un partecipante a una sfida che è già finita.
DROP TRIGGER IF EXISTS BloccaPartecipante;

DELIMITER $$

CREATE TRIGGER BloccaPartecipante BEFORE INSERT ON Partecipanti FOR EACH ROW
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
    
END $$
DELIMITER ; 

DROP TRIGGER IF EXISTS BloccaSforzo;

DELIMITER $$ 

CREATE TRIGGER BloccaSforzo BEFORE INSERT ON Sforzo FOR EACH ROW 
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
END $$
DELIMITER ;
                            
    