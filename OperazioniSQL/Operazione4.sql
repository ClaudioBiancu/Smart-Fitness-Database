-- Operazione 4: Cancellazione di tutti gli accessi più vecchi di tre mesi.

DROP EVENT IF EXISTS CancellaAccessi;

DELIMITER $$

CREATE EVENT CancellaAccessi 
ON SCHEDULE EVERY 1 DAY
STARTS '2017-07-12 23:59:59' DO
BEGIN
		DELETE A.*
		FROM Accesso A
		WHERE (A.Data < CURRENT_DATE - INTERVAL 3 MONTH);
END $$ 
DELIMITER ;


DROP EVENT CancellaAccessi;