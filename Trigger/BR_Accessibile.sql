DROP TRIGGER IF EXISTS BR_Accessibile;

DELIMITER $$

CREATE TRIGGER BR_Accessibile BEFORE INSERT ON accessibile
FOR EACH ROW
begin

declare multisede bool default false;
declare quanteSedi integer default 0;
declare esiste integer default 0;

set esiste = ( select COUNT(*)
			   from accessibile a
               where  a.codicemodalita=NEW.codicemodalita
					  and a.codicecentro=NEW.codicecentro
			);
if esiste = 0
THEN
BEGIN
            
set multisede = (
				select
					m.Multisede
				from
					modalita m
				where
					m.CodiceModalita = new.CodiceModalita );

set quanteSedi = (
					select
						count(*)
                    from
						accessibile a
					where
						a.CodiceModalita = new.CodiceModalita );
                        
if multisede = true then
	if quanteSedi = 3 then
		signal sqlstate '45000'
        set message_text = 'Impossibile aggiungere un altro Centro';
	end if;
else
	if quanteSedi = 1 then
		signal sqlstate '45000'
        set message_text = 'Impossibile aggiungere un altro Centro';
	end if;
end if;
END;
ELSE
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='Il centro è già stato associato alla modalità';
END IF;
END $$
DELIMITER ;