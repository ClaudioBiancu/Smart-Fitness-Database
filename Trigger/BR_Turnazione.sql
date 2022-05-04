DROP TRIGGER IF EXISTS BR_Turnazione;

DELIMITER $$

CREATE  trigger BR_Turnazione before insert on turnazione
for each row
begin

declare errore int(11) default 0;
declare durataTurno int(11) default 0;

if new.OrarioInizio > 24 or new.OrarioFine > 24 then
	signal sqlstate '45000'
    set message_text = 'Orario inserito non valido';
end if;

if new.OrarioInizio < 0 or new.OrarioFine < 0 then
	signal sqlstate '45000'
    set message_text = 'Orario inserito non valido';
end if;



set @citta =(
				select
					c.Citta
				from
					centro c
				where
					c.Codice = new.CodiceCentro );

set errore = (
				select
					count(*)
				from
					turnazione t
                    inner join
                    centro c on t.CodiceCentro = c.CodiceCentro
				where
					t.CodiceDipendente =  new.CodiceDipendente
                    and t.Giorno = new.Giorno
                    and ((new.OrarioInizio between t.OrarioInizio and t.OrarioFine)
                    or (c.Citta = @citta)));
if errore = 0 then
	set durataTurno = (
					select
						sum(t.OrarioFine - t.OrarioInizio)
					from
						turnazione t
					where
						t.CodiceDipendente = new.CodiceDipendente
                        and t.Giorno = new.Giorno);
end if;
                    
if errore <> 0 then
	delete from turnazione
    where
		CodiceDipendente = new.CodiceDipendente
        and Giorno = new.Giorno
        and OrarioInizio = new.OrarioInizio
        and OrarioFine = new.OrarioFine;
	 signal sqlstate  '45000'
     set message_text = "Impossibile aggiungere il Turno";
else
	if durataTurno > 8 then
    	delete from turnazione
			where
				CodiceDipendente = new.CodiceDipendente
				and Giorno = new.Giorno
				and OrarioInizio = new.OrarioInizio
				and OrarioFine = new.OrarioFine;
		signal sqlstate '45000'
        set message_text = "Impossibile aggiungere il Turno";
	end if;
	
end if;

end $$

DELIMITER ;