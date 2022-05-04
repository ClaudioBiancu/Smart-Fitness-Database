delimiter $$

CREATE PROCEDURE InsAllenamento (
IN _codiceScheda CHAR(255), IN _codiceIstruttore CHAR(255), IN _codiceCliente CHAR(255), IN _dataI DATE)
BEGIN

UPDATE schedaallenamento sc
SET sc.DataFine = CURRENT_DATE()
WHERE
	sc.CodiceCliente = _codiceCliente
    AND sc.DataFine = NULL;
    
INSERT INTO schedaallenamento VALUES (_codiceScheda, _codiceIstruttore, _codiceCliente, _dataI, NULL);

END $$

CREATE PROCEDURE InsWorkOut (
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

END $$
