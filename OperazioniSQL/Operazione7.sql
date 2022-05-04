delimiter $$

DROP EVENT RankSfide$$

CREATE EVENT RankSfide ON SCHEDULE EVERY 1 DAY
DO
BEGIN

SELECT
	IF(@sfida = M.CodiceSfida,
		IF(@durata = Durata,
			@podio,
            @podio := @podio + 1 + LEAST(0, @durata := M.Durata)),
		@podio := 1 + LEAST(0, @durata := M.Durata) + LEAST(0, @sfida = M.CodiceSfida))
FROM
	(
	SELECT
		p.CodiceSfida, p.Utente, DATEDIFF(p.DataFine, p.DataInizio) AS Durata
	FROM
		partecipanti p
		NATURAL JOIN
		(
		SELECT
			s.CodiceSfida
		FROM
			sfida s
			NATURAL JOIN
			partecipanti p
		WHERE
			s.DataFine = CURRENT_DATE()
			AND p.DataFine IS NOT NULL
		GROUP BY
			p.CodiceSfida
		HAVING
			COUNT(p.Utente) >= 3 ) AS D
		WHERE
			p.DataFine IS NOT NULL) AS M,
	(SELECT (@podio := 0)) AS N
ORDER BY
	M.CodiceSfida, M.Durata ;

END $$

DROP EVENT SfideIncomplete$$

CREATE EVENT SfideIncomplete ON SCHEDULE EVERY 1 DAY
DO
BEGIN

SELECT
	p.CodiceSfida
FROM
	sfida s
    NATURAL JOIN
	partecipanti p
WHERE
	p.DataFine IS NOT NULL
    AND s.DataFine = CURRENT_DATE()
GROUP BY
	p.Codicesfida
HAVING
	COUNT(p.Utente) < 3;
    
END $$

